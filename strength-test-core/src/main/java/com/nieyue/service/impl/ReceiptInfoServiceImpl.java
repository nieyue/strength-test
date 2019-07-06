package com.nieyue.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.nieyue.bean.ReceiptInfo;
import com.nieyue.service.ReceiptInfoService;
import com.nieyue.util.MyDom4jUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ReceiptInfoServiceImpl extends BaseServiceImpl<ReceiptInfo,Long> implements ReceiptInfoService {

    @Transactional(propagation= Propagation.REQUIRED)
    @Override
    public boolean update(ReceiptInfo receiptInfo) {
        receiptInfo.setUpdateDate(new Date());
        boolean b = super.update(receiptInfo);
        //默认，1是,2不是
        if(b&&receiptInfo.getIsDefault()==1){
            Wrapper<ReceiptInfo> wrapper=new EntityWrapper<>();
            Map<String,Object> map=new HashMap<String,Object>();
            map.put("account_id", receiptInfo.getAccountId());
            wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
            List<ReceiptInfo> list = super.list( 1, Integer.MAX_VALUE, null,null,wrapper);
            if(list.size()>0){
                list.forEach(e->{
                      //不是当前的全部设置为 不是
                    if(!e.getReceiptInfoId().equals(receiptInfo.getReceiptInfoId())){
                        e.setIsDefault(2);
                        super.update(e);
                    }
                });
            }
        }
        return b;
    }

    @Override
    public boolean add(ReceiptInfo receiptInfo) {
        receiptInfo.setCreateDate(new Date());
        receiptInfo.setUpdateDate(new Date());
        if(receiptInfo.getIsDefault()==null||receiptInfo.getIsDefault().equals("")){
            receiptInfo.setIsDefault(2);
        }
        boolean b = super.add(receiptInfo);
        //默认，1是,2不是
        if(b&&receiptInfo.getIsDefault()==1){
            Wrapper<ReceiptInfo> wrapper=new EntityWrapper<>();
            Map<String,Object> map=new HashMap<String,Object>();
            map.put("account_id", receiptInfo.getAccountId());
            wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
            List<ReceiptInfo> list =  super.list( 1, Integer.MAX_VALUE, null,null,wrapper);
            if(list.size()>0){
                list.forEach(e->{
                    if(!e.getReceiptInfoId().equals(receiptInfo.getReceiptInfoId())){
                        e.setIsDefault(2);
                        super.update(e);
                    }
                });
            }
        }
        return b;
    }
}
