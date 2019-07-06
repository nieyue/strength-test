package com.nieyue.service.impl;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.nieyue.bean.*;
import com.nieyue.exception.CommonRollbackException;
import com.nieyue.service.*;
import com.nieyue.util.Arith;
import com.nieyue.util.SnowflakeIdWorker;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

@Service
public class CartMerServiceImpl extends BaseServiceImpl<CartMer,Long> implements CartMerService {
    @Autowired
    MerService merService;
    @Autowired
    AccountService accountService;
    @Autowired
    OrderService orderService;
    @Autowired
    OrderDetailService orderDetailService;
    @Autowired
    ReceiptInfoService receiptInfoService;
    @Autowired
    OrderReceiptInfoService orderReceiptInfoService;
    @Autowired
    ConfigService configService;
    @Override
    public List<CartMer> list(int pageNum, int pageSize, String orderName, String orderWay, Wrapper<CartMer> wrapper) {
        List<CartMer> cartMerList = super.list(pageNum, pageSize, orderName, orderWay, wrapper);
        cartMerList.forEach(cartMer->{
            if(cartMer.getMerId()!=null){
                cartMer.setMer( merService.load(cartMer.getMerId()));
            }
        });
        return cartMerList;
    }

    @Override
    public CartMer load(Long cartMerId) {
        CartMer cartMer = super.load(cartMerId);
        if(cartMer.getMerId()!=null){
            cartMer.setMer( merService.load(cartMer.getMerId()));
        }
        return cartMer;
    }
    @Transactional(propagation= Propagation.REQUIRED)
    @Override
    public boolean add(CartMer cartMer) {
        boolean b=false;
        Long merId=cartMer.getMerId();
        if(ObjectUtils.isEmpty(merId)){
            throw new CommonRollbackException("请选择商品");
        }
        Mer mer=merService.load(merId);
        if(ObjectUtils.isEmpty(mer)){
            throw new CommonRollbackException("请选择商品");
        }
        if(mer.getStatus()==2){
            throw new CommonRollbackException("商品"+mer.getName()+"已下架");
        }

        Account account = accountService.load(cartMer.getSpreadAccountId());
        if(account==null){
            cartMer.setSpreadAccountId(null);
        }
        return super.add(cartMer);
    }

    @Transactional(propagation= Propagation.REQUIRED)
    @Override
    public boolean batchCartMerTurnOrder(String cartMerList, Long couponId, Long receiptInfoId, Long accountId) {
        boolean dm=false;
        ReceiptInfo receiptInfo = receiptInfoService.load(receiptInfoId);
        if(ObjectUtils.isEmpty(receiptInfo)){
            throw new CommonRollbackException("缺少收货地址");
        }
        JSONArray jsonarray = JSONArray.fromObject(cartMerList);
        List<CartMer> list=new ArrayList<>();
        for (Iterator iterator = jsonarray.iterator(); iterator.hasNext();) {
            JSONObject json = (JSONObject) iterator.next();
            list.add((CartMer)json.toBean(json, CartMer.class));
        }
        for (int i = 0; i < list.size(); i++) {
            CartMer e = list.get(i);
            if(e.getNumber()==null||e.getNumber()<=0){
                throw new CommonRollbackException("商品数至少一个");
            }
            Mer mer = merService.load(e.getMerId());
            if(mer==null){
                throw new CommonRollbackException("商品不存在");
            }
            if(mer.getStatus()==2){
                throw new CommonRollbackException("商品"+mer.getName()+"已下架");
            }

            e.setMer(mer);
            //订单
            Order order = new Order();
            order.setAccountId(accountId);
            order.setCreateDate(new Date());
            order.setOrderNumber(SnowflakeIdWorker.getId().toString());
            order.setPayType(null);
            //订单状态，2待支付，3已支付,4已发货，5已收货，6已取消，7已删除
            order.setStatus(2);
            //类型，1购买商品，2账户提现，3退款，4诚信押金
            order.setType(1);
            //商品类型，1普通商品，2降价商品，3预购商品
            order.setMerType(mer.getType());
            //商户id
            if(e.getMer().getMerchantAccountId()!=null){
                Account merchantAccount = accountService.load(e.getMer().getMerchantAccountId());
                if(merchantAccount.getAccountId()!=null
                       // &&merchantAccount.getRoleName().equals("商户")
                ){
                    order.setMerchantAccountId(merchantAccount.getAccountId());
                }
            }
            //推广账户id 且不能使自己
            if(e.getSpreadAccountId()!=null && !e.getSpreadAccountId().equals(accountId)){
                Account spreadAccount = accountService.load(e.getSpreadAccountId());
                if(spreadAccount.getAccountId()!=null
                       // &&spreadAccount.getRoleName().equals("推广户")
                ){
                    order.setSpreadAccountId(spreadAccount.getAccountId());
                }
            }
            dm = orderService.add(order);
            if(!dm){
                throw new CommonRollbackException("订单异常");
            }
            //订单详情
            OrderDetail orderDetail=new OrderDetail();
            orderDetail.setCreateDate(new Date());
            orderDetail.setImgAddress(e.getMer().getImgAddress());
            orderDetail.setMerCateName(e.getMer().getMerCate().getName());
            orderDetail.setMerId(e.getMerId());
            orderDetail.setName(e.getMer().getName());
            orderDetail.setNumber(e.getNumber());
            orderDetail.setOrderId(order.getOrderId());
            orderDetail.setUnitPrice(e.getMer().getUnitPrice());
            orderDetail.setUpdateDate(new Date());
            Double tp=Arith.mul(e.getNumber(), e.getMer().getUnitPrice());
           /* if(coupon!=null){
                orderDetail.setCouponId(couponId);
                tp= Arith.mul(tp, coupon.getDiscount());
            }*/
            orderDetail.setTotalPrice(tp);
            dm=orderDetailService.add(orderDetail);
            if(!dm){
                throw new CommonRollbackException("订单异常");
            }
            //库存不足
            if(mer.getStockNumber()-orderDetail.getNumber()<0){
                throw new CommonRollbackException("商品名："+mer.getName()+"库存不足");
            }
            //收货地址
            OrderReceiptInfo orderReceiptInfo=new OrderReceiptInfo();
            orderReceiptInfo.setAccountId(accountId);
            orderReceiptInfo.setAddress(receiptInfo.getAddress());
            orderReceiptInfo.setArea(receiptInfo.getArea());
            orderReceiptInfo.setCity(receiptInfo.getCity());
            orderReceiptInfo.setCountry(receiptInfo.getCountry());
            orderReceiptInfo.setCreateDate(new Date());
            orderReceiptInfo.setIsDefault(receiptInfo.getIsDefault());
            orderReceiptInfo.setName(receiptInfo.getName());
            orderReceiptInfo.setOrderId(order.getOrderId());
            orderReceiptInfo.setPhone(receiptInfo.getPhone());
            orderReceiptInfo.setPostcode(receiptInfo.getPostcode());
            orderReceiptInfo.setProvince(receiptInfo.getProvince());
            orderReceiptInfo.setTelephone(receiptInfo.getTelephone());
            orderReceiptInfo.setTelephoneArea(receiptInfo.getTelephoneArea());
            orderReceiptInfo.setTelephoneExtension(receiptInfo.getTelephoneExtension());
            orderReceiptInfo.setUpdateDate(new Date());

            orderReceiptInfoService.add(orderReceiptInfo);
            dm=super.delete(e.getCartMerId());
            if(!dm){
                throw new CommonRollbackException("订单异常");
            }
        }
        return dm;
    }
}
