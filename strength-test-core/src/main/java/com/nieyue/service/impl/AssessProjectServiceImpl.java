package com.nieyue.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.nieyue.bean.Assess;
import com.nieyue.bean.AssessProject;
import com.nieyue.bean.Standard;
import com.nieyue.service.*;
import com.nieyue.util.MyDom4jUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AssessProjectServiceImpl extends BaseServiceImpl<AssessProject,Long> implements AssessProjectService {
    @Autowired
    private ProjectService projectService;
    @Autowired
    private AccountService accountService;
    @Autowired
    private StandardService standardService;
    @Autowired
    private AssessService assessService;
    @Transactional(propagation = Propagation.REQUIRED)
    @Override
    public boolean add(AssessProject assessProject) {
        Assess assess = assessService.load(assessProject.getAssessId());
        //单项测评
        Wrapper<Standard> wrapper=new EntityWrapper<>();
        Map<String,Object> map=new HashMap<String,Object>();
        map.put("age", assess.getAge());
        map.put("sex", assess.getSex());
        map.put("project_id", assessProject.getProjectId());
        wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
        List<Standard> sl = standardService.simplelist(wrapper);
        Standard standard=new Standard();
        //最差的，不良
        standard.setRank(1);
        if(sl.size()>0){
            //存放临时的
            for (int i = 0; i < sl.size(); i++) {
                Standard s = sl.get(i);
                if(assessProject.getScore()>=s.getLow()){
                    //只要是大于等于的就是符合要求
                    standard=s;
                    assessProject.setItem(standard.getItem());
                }
            }
        }
        assessProject.setRank(standard.getRank());
        return super.add(assessProject);
    }

    @Transactional(propagation = Propagation.REQUIRED)
    @Override
    public boolean update(AssessProject assessProject) {
        Assess assess = assessService.load(assessProject.getAssessId());
        //单项测评
        Wrapper<Standard> wrapper=new EntityWrapper<>();
        Map<String,Object> map=new HashMap<String,Object>();
        map.put("age", assess.getAge());
        map.put("sex", assess.getSex());
        map.put("project_id", assessProject.getProjectId());
        wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
        List<Standard> sl = standardService.simplelist(wrapper);
        Standard standard=new Standard();
        //最差的，不良
        standard.setRank(1);
        if(sl.size()>0){
            //存放临时的
            for (int i = 0; i < sl.size(); i++) {
                Standard s = sl.get(i);
                if(assessProject.getScore()>=s.getLow()){
                    //只要是大于等于的就是符合要求
                    standard=s;
                    assessProject.setItem(standard.getItem());
                }
            }
        }
        assessProject.setRank(standard.getRank());
        return super.update(assessProject);
    }
}
