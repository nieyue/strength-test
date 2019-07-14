package com.nieyue.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.nieyue.bean.Account;
import com.nieyue.bean.Assess;
import com.nieyue.bean.AssessProject;
import com.nieyue.exception.CommonRollbackException;
import com.nieyue.service.AccountService;
import com.nieyue.service.AssessProjectService;
import com.nieyue.service.AssessService;
import com.nieyue.util.Arith;
import com.nieyue.util.DateUtil;
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
public class AssessServiceImpl extends BaseServiceImpl<Assess,Long> implements AssessService {
    @Autowired
    private AccountService accountService;
    @Autowired
    private AssessProjectService assessProjectService;

    @Transactional(propagation = Propagation.REQUIRED)
    @Override
    public boolean add(Assess assess) {
        Wrapper<Assess> wrapper=new EntityWrapper<>();
        Map<String,Object> map=new HashMap<String,Object>();
        map.put("account_id", assess.getAccountId());
        map.put("account_id", assess.getAccountId());
        wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
        wrapper.and(" DATE(create_date) = {0}", DateUtil.getCurrentTimeDay());
        List<Assess> assessList = super.simplelist(wrapper);
        if(assessList.size()>0){
            throw new CommonRollbackException("今日已经创建过了");
        }
        Account account = accountService.load(assess.getAccountId());
        assess.setAge(account.getAge());
        assess.setSex(account.getSex());
        assess.setScore(0.0);
        assess.setRank(1);//最低
        return super.add(assess);
    }

    @Transactional(propagation = Propagation.REQUIRED)
    @Override
    public boolean update(Assess assess) {
        Wrapper<AssessProject> wrapper=new EntityWrapper<>();
        Map<String,Object> map=new HashMap<String,Object>();
        map.put("assess_id", assess.getAssessId());
        wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
        List<AssessProject> apl = assessProjectService.simplelist(wrapper);
        if(apl.size()>0){
            int ranks=0;
            AssessProject ap;
            for (int i = 0; i < apl.size(); i++) {
                    ap=apl.get(i);
                assess.setScore(Arith.add(assess.getScore(),ap.getScore()));
                ranks+=ap.getRank();
            }
            assess.setRank(ranks/apl.size());
        }
        return super.update(assess);
    }
}
