package com.nieyue.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.nieyue.bean.Order;
import com.nieyue.bean.OrderDetail;
import com.nieyue.service.OrderDetailService;
import com.nieyue.service.OrderService;
import com.nieyue.util.MyDom4jUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class OrderServiceImpl extends BaseServiceImpl<Order,Long> implements OrderService {
    @Autowired
    OrderDetailService orderDetailService;
    @Override
    public Order load(Long orderId) {
        Wrapper<OrderDetail> wrapper=new EntityWrapper<>();
        Map<String,Object> map=new HashMap<>();
        map.put("order_id", orderId);
        wrapper.allEq(MyDom4jUtil.getNoNullMap(map));
        Order order = super.load(orderId);
        order.setOrderDetailList(orderDetailService.simplelist(wrapper));
        return order;
    }

    @Override
    public List<Order> list(int pageNum, int pageSize, String orderName, String orderWay, Wrapper<Order> wrapper) {
        List<Order> orderList = super.list(pageNum, pageSize, orderName, orderWay, wrapper);
        orderList.forEach(e->{
            Wrapper<OrderDetail> wrapper2=new EntityWrapper<>();
            Map<String,Object> map2=new HashMap<>();
            map2.put("order_id", e.getOrderId());
            wrapper2.allEq(MyDom4jUtil.getNoNullMap(map2));
            e.setOrderDetailList(orderDetailService.simplelist(wrapper2));
        });

        return orderList;
    }
}
