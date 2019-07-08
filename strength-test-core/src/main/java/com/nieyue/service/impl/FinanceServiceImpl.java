package com.nieyue.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.nieyue.bean.Account;
import com.nieyue.bean.Config;
import com.nieyue.bean.Finance;
import com.nieyue.business.OrderBusiness;
import com.nieyue.exception.AccountIsNotExistException;
import com.nieyue.exception.CommonRollbackException;
import com.nieyue.exception.FinanceMoneyNotEnoughException;
import com.nieyue.exception.PayException;
import com.nieyue.service.AccountService;
import com.nieyue.service.ConfigService;
import com.nieyue.service.FinanceService;
import com.nieyue.util.Arith;
import com.nieyue.util.MyDom4jUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class FinanceServiceImpl extends BaseServiceImpl<Finance,Long> implements FinanceService {
    @Autowired
    AccountService accountService;
    @Autowired
    OrderBusiness orderBusiness;
   // @Autowired
   // FinanceRecordService financeRecordService;
    @Autowired
    ConfigService configService;
    //管理员充值
    @Transactional(propagation= Propagation.REQUIRED)
    @Override
    public Finance rechargeFinance(Long accountId, Integer method, Double money) {
        if(money<=0){
            throw new CommonRollbackException("金额必须大于0");	//账户不存在
        }
        Account a = accountService.load(accountId);
        if(a==null){
            throw new AccountIsNotExistException();	//账户不存在
        }
		/*if(a.getAuth()==null||a.getAuth()==0){//没认证
			throw new AccountNotAuthException();//账户未认证
		}*/
		/*if(a.getAuth()==1){//审核中
			throw new AccountAuthAuditException();//账户审核中
		}*/
        //财务增加
        Wrapper<Finance> wrapper=new EntityWrapper<>();
        Map<String,Object> map=new HashMap<>();
        map.put("account_id", accountId);
        wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
        List<Finance> fl = super.list(1, 1, null, null, wrapper);
        if(fl.size()<=0){
            throw new PayException();
        }
        Finance finance = fl.get(0);
        finance.setUpdateDate(new Date());
        finance.setMoney(Arith.add(finance.getMoney(),money));
        finance.setRecharge(Arith.add(finance.getRecharge(),money));
        boolean b = super.update(finance);
        if(!b){
            throw new PayException();
        }
        return finance;
    }
    //提现
    @Transactional(propagation= Propagation.REQUIRED)
    @Override
    public Finance withdrawals(Long accountId, Integer method, String realname,String accountName,Double money) {
        Account a = accountService.load(accountId);

        if(a==null){
            throw new AccountIsNotExistException();	//账户不存在
        }
       /* if(a.getAuth()==null||a.getAuth()==1){//没认证
            throw new AccountNotAuthException();//账户未认证
        }
        if(a.getAuth()==2){//审核中
            throw new AccountAuthAuditException();//账户审核中
        }*/
        Wrapper<Finance> wrapper=new EntityWrapper<>();
        Map<String,Object> map=new HashMap<>();
        map.put("account_id", accountId);
        wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
        List<Finance> fl = super.simplelist(wrapper);
        boolean b=false;
        if(fl.size()!=1){
            throw new CommonRollbackException("财务异常");
        }
        Finance f = fl.get(0);
        if(f.getMoney()-money<0){
            throw new FinanceMoneyNotEnoughException();//余额不足
        }
        List<Config> configList = configService.simplelist(null);
        if(configList.size()>0){
            Config config = configList.get(0);
            /*if(money<config.getMinWithdrawals()){
                throw new CommonRollbackException("提现最低额度"+config.getMinWithdrawals().toString());//余额不足
            }*/
        }
        f.setMoney(Arith.sub(f.getMoney(), money));//减
        f.setWithdrawals(Arith.add(f.getWithdrawals(), money));
        b= super.update(f);
        if(!b){
            throw new PayException();
        }
       /* FinanceRecord fr=new FinanceRecord();
        fr.setAccountId(a.getAccountId());
        fr.setRealname(realname);
        fr.setMark(accountName);//备注中放标记
        fr.setMethod(method);//方式，1支付宝，2微信,3百度钱包,4Paypal,5网银,6ios内购,7余额
        fr.setRealMoney(money);//实际金额
        String transactionNumber = SnowflakeIdWorker.getId().toString();
        fr.setTransactionNumber(transactionNumber);
        fr.setType(2);//2是账户提现
        fr.setStatus(1);//提现待处理，后台显示操作成功
        fr.setCreateDate(new Date());
        fr.setUpdateDate(new Date());
        b = financeRecordService.add(fr);
        if(!b){
            throw new PayException();
        }*/
        return f;
    }
}
