package com.nieyue.business;


import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
import com.aliyuncs.exceptions.ClientException;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.nieyue.bean.*;
import com.nieyue.exception.CommonRollbackException;
import com.nieyue.mail.SendMailDemo;
import com.nieyue.service.*;
import com.nieyue.util.Arith;
import com.nieyue.util.MyDom4jUtil;
import org.springframework.context.annotation.Configuration;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.*;

/**
 * 支付业务
 */
@Configuration
public class PaymentBusiness {
    @Resource
    AccountService accountService;
    @Resource
    OrderService orderService;
    @Resource
    OrderDetailService orderDetailService;
    @Resource
    MerService merService;
    @Resource
    FinanceService financeService;
    @Resource
    FinanceRecordService financeRecordService;
    @Resource
    ConfigService configService;
    /**
     * 支付回调，订单进入冻结期
     * payType 支付方式，1支付宝，2微信,3百度钱包,4Paypal,5网银
     * accountId 下单人id外键
     * ids 订单id列表如:“101,3,44”
     */
    public String getPaymentNotify(
            Payment payment){
        boolean b=false;
        String orderIds=payment.getBusinessId();//存放订单id集合

        Long accountId=payment.getAccountId();//用户id
        Integer payType=payment.getType();//支付类型，1支付宝，2微信,3百度钱包,4Paypal,5网银,6ios内购,7余额
        Integer type=payment.getBusinessType();//类型，1购买商品，2账户提现，3退款，4诚信押金
        Double totalPrice=payment.getMoney();//订单总价

        String[] ids = orderIds.replace(" ","").split(",");
        List<Order> listorder=new ArrayList<>();//临时存储订单
        List<Mer> listmer=new ArrayList<>();//临时存储商品
        boolean isHaveStockNumber=true;//是否有库存，默认有
      /*  for (int i = 0; i < ids.length; i++) {
            *//**
             * 1.判读库存是否足够
             *//*
            Order order = orderService.load(new Long(ids[i]));
            if(order==null){
                //只要一个订单不存在.取消
                isHaveStockNumber=false;
                break;
            }
            listorder.add(i, order);//存入内存
            OrderDetail orderDetail = order.getOrderDetailList().get(0);
            Mer mer = merService.load(orderDetail.getMerId());
            listmer.add(i,mer);
            if(mer==null||mer.getStockNumber()-orderDetail.getNumber()<0){
                //只要一个不够订单取消
                isHaveStockNumber=false;
                break;
            }
        }*/
        //调退款接口
      /*  if(!isHaveStockNumber){
            //退款

            //订单取消
            for (int i = 0; i < ids.length; i++) {
                Order order = listorder.get(i);
                order.setStatus(6);//已取消
                order.setUpdateDate(new Date());
                order.setPaymentDate(new Date());
                b =orderService.update(order);
            }
            return "success";
        }*/

        //配置类
        List<Config> configlist = configService.simplelist(null);
        Config config = configlist.get(0);
        /**
         * 用户金额
         */
        Wrapper<Finance> wrapper2=new EntityWrapper<>();
        Map<String,Object> map2=new HashMap<>();
        map2.put("account_id", payment.getAccountId());
        wrapper2.allEq(MyDom4jUtil.getNoNullMap(map2));
        List<Finance> afl=financeService.simplelist(wrapper2);
        if(afl.size()>0){
            Finance af = afl.get(0);
            af.setUpdateDate(new Date());
            af.setConsume(Arith.add(af.getConsume(), totalPrice));//增加消费金额
            b=financeService.update(af);
        }
        //循环订单
        for (int i = 0; i < ids.length; i++) {
            /**
             * 订单进入待发货
             */
            //Order order = listorder.get(i);//从内存中取
            Order order = orderService.load(new Long(ids[i]));

            order.setStatus(3);//待发货
            order.setUpdateDate(new Date());
            order.setPaymentDate(new Date());
            b =orderService.update(order);
            //订单号由原来的订单号获取
            String orderNumber=order.getOrderNumber();
            //获取订单详情
            OrderDetail orderDetail = order.getOrderDetailList().get(0);

            //获取当前商品
            Mer mer = merService.load(orderDetail.getMerId());
            /**
             * 减库存
             */
            mer.setStockNumber(mer.getStockNumber()-orderDetail.getNumber());
            //增加销量
            mer.setSaleNumber(mer.getSaleNumber()+orderDetail.getNumber());
            merService.update(mer);
            //获取用户
            Account account = accountService.load(accountId);
            //获取商户
            Account merchantAccount=null;
            if(order.getMerchantAccountId()!=null){
                merchantAccount = accountService.load(order.getMerchantAccountId());
            }
            //获取推广户
            Account spreadAccount=null;
            if(order.getSpreadAccountId()!=null){
                spreadAccount = accountService.load(order.getSpreadAccountId());
            }

            /**
             * 用户财务记录，购买商品
             */
            FinanceRecord fr=new FinanceRecord();
            fr.setAccountId(accountId);
            fr.setMethod(payType);//支付类型，1支付宝，2微信,3百度钱包,4Paypal,5网银,6ios内购,7余额
            fr.setType(type);//类型，1购买商品，2提现记录，3退款记录，4诚信押金，5商品售出，6推广分成，7上级推广分成
            fr.setTransactionNumber(orderNumber);//交易单号与支付单号相同
            if(!StringUtils.isEmpty(account.getRealname())){
                fr.setRealname(account.getRealname());
            }else{
                fr.setRealname(account.getNickname());
            }
            fr.setRealMoney(orderDetail.getTotalPrice());
            fr.setStatus(2);//状态，默认1待处理，2成功，3已拒绝

            //不存在商户，就相同
            /*if(merchantAccount==null){
                fr.setRealMoney(orderDetail.getTotalPrice());
            }else{
                //实际金额=总金额-总金额*当前商品平台分成比例
                fr.setRealMoney(Arith.sub(orderDetail.getTotalPrice(),Arith.mul(orderDetail.getTotalPrice(), Arith.div(lm.getPlatformProportion(), 100))));
            }*/
            fr.setCreateDate(new Date());
            fr.setUpdateDate(new Date());
            b=financeRecordService.add(fr);//新增财务记录
            //如果存在商户
            if(merchantAccount!=null){
                /**
                 * 商户财务记录，进账记录
                 */
                FinanceRecord mafr=new FinanceRecord();
                mafr.setAccountId(merchantAccount.getAccountId());
                mafr.setMethod(payType);//支付类型，1支付宝，2微信,3百度钱包,4Paypal,5网银,6ios内购,7余额
                mafr.setType(5);//类型，1购买商品，2提现记录，3退款记录，4诚信押金，5商品售出，6推广分成，7上级推广分成
                mafr.setTransactionNumber(orderNumber);//交易单号与支付单号相同
                if(!StringUtils.isEmpty(merchantAccount.getRealname())){
                    mafr.setRealname(merchantAccount.getRealname());
                }else{
                    mafr.setRealname(merchantAccount.getNickname());
                }
                mafr.setRealMoney(orderDetail.getTotalPrice());
                mafr.setStatus(2);//状态，默认1待处理，2成功，3已拒绝
                //实际金额=总金额-总金额*当前商品平台分成比例
                //mafr.setRealMoney(Arith.sub(orderDetail.getTotalPrice(),Arith.mul(orderDetail.getTotalPrice(), Arith.div(lm.getPlatformProportion(), 100))));
                mafr.setCreateDate(new Date());
                mafr.setUpdateDate(new Date());
                b=financeRecordService.add(mafr);//新增财务记录
                /**
                 * 商户金额
                 */
                Wrapper<Finance> wrapper3=new EntityWrapper<>();
                Map<String,Object> map3=new HashMap<>();
                map3.put("account_id", merchantAccount.getAccountId());
                wrapper3.allEq(MyDom4jUtil.getNoNullMap(map3));
                List<Finance> mafl=financeService.simplelist(wrapper3);
                if(mafl.size()>0){
                    Finance maf = mafl.get(0);
                    //冻结金额=已有冻结金额+实际金额
                   // maf.setFrozen(Arith.add(maf.getMoney(),Arith.sub(orderDetail.getTotalPrice(),Arith.mul(orderDetail.getTotalPrice(), Arith.div(lm.getPlatformProportion(), 100)))));
                   //自身收益
                    maf.setSelfProfit(maf.getSelfProfit()+orderDetail.getTotalPrice());
                    //余额增加
                    maf.setMoney(maf.getMoney()+orderDetail.getTotalPrice());
                    maf.setUpdateDate(new Date());
                    b=financeService.update(maf);
                }
            }
            //如果存在推广户
            if(spreadAccount!=null){
                /**
                 * 推广户财务记录，进账记录
                 */
                FinanceRecord safr=new FinanceRecord();
                safr.setAccountId(spreadAccount.getAccountId());
                safr.setMethod(payType);//支付类型，1支付宝，2微信,3百度钱包,4Paypal,5网银,6ios内购,7余额
                safr.setType(6);//类型，1购买商品，2提现记录，3退款记录，4诚信押金，5商品售出，6推广分成，7上级推广分成
                safr.setTransactionNumber(orderNumber);//交易单号与支付单号相同
                if(!StringUtils.isEmpty(spreadAccount.getRealname())){
                    safr.setRealname(spreadAccount.getRealname());
                }else{
                    safr.setRealname(spreadAccount.getNickname());
                }
                safr.setStatus(2);//状态，默认1待处理，2成功，3已拒绝
                //实际金额=总金额*推广分成比例
                safr.setRealMoney(Arith.mul(orderDetail.getTotalPrice(), Arith.div(config.getSpreadProportion(), 100)));
                safr.setCreateDate(new Date());
                safr.setUpdateDate(new Date());
                b=financeRecordService.add(safr);//新增财务记录
                /**
                 * 推广户金额
                 */
                Wrapper<Finance> wrapper4=new EntityWrapper<>();
                Map<String,Object> map4=new HashMap<>();
                map4.put("account_id", spreadAccount.getAccountId());
                wrapper4.allEq(MyDom4jUtil.getNoNullMap(map4));
                List<Finance> safl=financeService.simplelist(wrapper4);
                if(safl.size()>0){
                    Finance saf = safl.get(0);
                    //冻结金额=已有冻结金额+实际金额
                    // saf.setFrozen(Arith.add(saf.getMoney(),Arith.sub(orderDetail.getTotalPrice(),Arith.mul(orderDetail.getTotalPrice(), Arith.div(lm.getPlatformProportion(), 100)))));
                    //合伙人总收益
                    saf.setPartnerProfit(saf.getPartnerProfit()+safr.getRealMoney());
                    //余额增加
                    saf.setMoney(saf.getMoney()+safr.getRealMoney());
                    saf.setUpdateDate(new Date());
                    b=financeService.update(saf);
                }
                //查询有无上上级
                Account masterSpreadAccount = accountService.load(spreadAccount.getMasterId());
                if(masterSpreadAccount!=null){
                    /**
                     * 上级推广户财务记录，进账记录
                     */
                    FinanceRecord safr2=new FinanceRecord();
                    safr2.setAccountId(masterSpreadAccount.getAccountId());
                    safr2.setMethod(payType);//支付类型，1支付宝，2微信,3百度钱包,4Paypal,5网银,6ios内购,7余额
                    safr2.setType(7);//类型，1购买商品，2提现记录，3退款记录，4诚信押金，5商品售出，6推广分成，7上级推广分成
                    safr2.setTransactionNumber(orderNumber);//交易单号与支付单号相同
                    if(!StringUtils.isEmpty(masterSpreadAccount.getRealname())){
                        safr2.setRealname(masterSpreadAccount.getRealname());
                    }else{
                        safr2.setRealname(masterSpreadAccount.getNickname());
                    }
                    safr2.setStatus(2);//状态，默认1待处理，2成功，3已拒绝
                    //实际金额=总金额*上级推广分成比例
                    safr2.setRealMoney(Arith.mul(orderDetail.getTotalPrice(), Arith.div(config.getMasterSpreadProportion(), 100)));
                    safr2.setCreateDate(new Date());
                    safr2.setUpdateDate(new Date());
                    b=financeRecordService.add(safr2);//新增财务记录
                    /**
                     * 上级推广户金额
                     */
                    Wrapper<Finance> wrapper5=new EntityWrapper<>();
                    Map<String,Object> map5=new HashMap<>();
                    map5.put("account_id", masterSpreadAccount.getAccountId());
                    wrapper5.allEq(MyDom4jUtil.getNoNullMap(map5));
                    List<Finance> safl2=financeService.simplelist(wrapper5);
                    if(safl2.size()>0){
                        Finance saf2 = safl2.get(0);
                        //冻结金额=已有冻结金额+实际金额
                        // saf.setFrozen(Arith.add(saf.getMoney(),Arith.sub(orderDetail.getTotalPrice(),Arith.mul(orderDetail.getTotalPrice(), Arith.div(lm.getPlatformProportion(), 100)))));
                        //合伙人总收益
                        saf2.setPartnerProfit(saf2.getPartnerProfit()+safr2.getRealMoney());
                        //余额增加
                        saf2.setMoney(saf2.getMoney()+safr2.getRealMoney());
                        saf2.setUpdateDate(new Date());
                        b=financeService.update(saf2);
                    }
                }
            }

        }

        return "success";
    }
}
