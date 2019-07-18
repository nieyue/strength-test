package com.nieyue.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.nieyue.bean.Assess;
import com.nieyue.bean.AssessProject;
import com.nieyue.bean.Standard;
import com.nieyue.exception.CommonRollbackException;
import com.nieyue.service.*;
import com.nieyue.util.MyDom4jUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.CommonDataSource;
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
        //查看是否已经测评
        Wrapper<AssessProject> wrapper=new EntityWrapper<>();
        Map<String,Object> map=new HashMap<String,Object>();
        map.put("assess_id", assessProject.getAssessId());
        map.put("project_id", assessProject.getProjectId());
        wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
        List<AssessProject> assessProjectList = super.simplelist(wrapper);
        if(assessProjectList.size()>0){
            throw new CommonRollbackException("此项今日已经创建过了");
        }
        Assess assess = assessService.load(assessProject.getAssessId());

        //单项测评
        Wrapper<Standard> wrapper2=new EntityWrapper<>();
        Map<String,Object> map2=new HashMap<String,Object>();
        map2.put("age", assess.getAge());
        map2.put("sex", assess.getSex());
        map2.put("project_id", assessProject.getProjectId());
        wrapper2.allEq(MyDom4jUtil.getNoNullMap(map2));
        List<Standard> sl = standardService.simplelist(wrapper2);
        Standard standard=new Standard();
        //最差的，不良
        standard.setRank(1);
        if(sl.size()>0){
            //存放临时的
            for (int i = 0; i < sl.size(); i++) {
                Standard s = sl.get(i);
                //大于等于的就是符合要求
                if(assessProject.getScore()>=s.getLow()){
                    //只留最高等级的
                    if(standard.getRank()<=s.getRank()){
                        standard=s;
                        assessProject.setItem(standard.getItem());
                    }
                }
            }
        }
        assessProject.setRank(standard.getRank());
        return super.add(assessProject);
    }

    @Transactional(propagation = Propagation.REQUIRED)
    @Override
    public boolean update(AssessProject assessProject) {
        //查看是否已经测评
        Wrapper<AssessProject> wrapper=new EntityWrapper<>();
        Map<String,Object> map=new HashMap<String,Object>();
        map.put("assess_id", assessProject.getAssessId());
        map.put("project_id", assessProject.getProjectId());
        wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
        List<AssessProject> assessProjectList = super.simplelist(wrapper);
        if(assessProjectList.size()>0){
            if(!assessProjectList.get(0).getAssessProjectId().equals(assessProject.getAssessProjectId())){
                throw new CommonRollbackException("此项今日已经创建过了");
            }
        }
        Assess assess = assessService.load(assessProject.getAssessId());
        //单项测评
        Wrapper<Standard> wrapper2=new EntityWrapper<>();
        Map<String,Object> map2=new HashMap<String,Object>();
        map2.put("age", assess.getAge());
        map2.put("sex", assess.getSex());
        map2.put("project_id", assessProject.getProjectId());
        wrapper2.allEq(MyDom4jUtil.getNoNullMap(map2));
        List<Standard> sl = standardService.simplelist(wrapper2);
        Standard standard=new Standard();
        //最差的，不良
        standard.setRank(1);
        if(sl.size()>0){
            //存放临时的
            for (int i = 0; i < sl.size(); i++) {
                Standard s = sl.get(i);
                //大于等于的就是符合要求
                if(assessProject.getScore()>=s.getLow()){
                    //只留最高等级的
                    if(standard.getRank()<=s.getRank()){
                        standard=s;
                        assessProject.setItem(standard.getItem());
                    }
                }
            }
        }
        assessProject.setRank(standard.getRank());
        return super.update(assessProject);
    }
}
