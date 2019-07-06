package com.nieyue.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.nieyue.bean.Mer;
import com.nieyue.bean.MerCate;
import com.nieyue.bean.MerImg;
import com.nieyue.service.MerCateService;
import com.nieyue.service.MerImgService;
import com.nieyue.service.MerService;
import com.nieyue.util.MyDom4jUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MerServiceImpl extends BaseServiceImpl<Mer,Long> implements MerService {
    @Autowired
    MerCateService merCateService;
    @Autowired
    MerImgService merImgService;
    @Transactional(propagation= Propagation.REQUIRED)
    @Override
    public boolean add(Mer mer) {
        mer.setSaleNumber(mer.getSaleNumber()==null?0:mer.getSaleNumber());//默认销量0
        mer.setStockNumber(mer.getStockNumber()==null?0:mer.getStockNumber());
        mer.setMerScore(mer.getMerScore()==null?5.0:mer.getMerScore());//默认评分5.0
        mer.setMerCommentNumber(mer.getMerCommentNumber()==null?0:mer.getMerCommentNumber());//默认评论数0
        mer.setStatus(mer.getStatus()==null?1:mer.getStatus());//默认上架
        return super.add(mer);
    }

    @Override
    public List<Mer> list(int pageNum, int pageSize, String orderName, String orderWay, Wrapper<Mer> wrapper) {
        List<Mer> merList = super.list(pageNum, pageSize, orderName, orderWay, wrapper);
        merList.forEach(e->{
            if(e!=null){
                if(e.getMerCateId()!=null){
                    e.setMerCate( merCateService.load(e.getMerCateId()));
                }
                Wrapper<MerImg> wrapper2=new EntityWrapper<>();
                Map<String,Object> map2=new HashMap<String,Object>();
                map2.put("mer_id", e.getMerId());
                wrapper2.allEq(MyDom4jUtil.getNoNullMap(map2));
                e.setMerImgList(merImgService.simplelist(wrapper2));
            }
        });
        return merList;
    }

    @Override
    public Mer load(Long merId) {
        Mer mer = super.load(merId);
        if(mer.getMerCateId()!=null){
            mer.setMerCate( merCateService.load(mer.getMerCateId()));
        }
        Wrapper<MerImg> wrapper2=new EntityWrapper<>();
        Map<String,Object> map2=new HashMap<String,Object>();
        map2.put("mer_id", merId);
        wrapper2.allEq(MyDom4jUtil.getNoNullMap(map2));
        mer.setMerImgList(merImgService.simplelist(wrapper2));
        return mer;
    }
}
