package com.nieyue.service;

import com.nieyue.bean.CartMer;

/**
 * 购物车商品逻辑层接口
 * @author yy
 *
 */
public interface CartMerService extends BaseService<CartMer, Long>{
    /** 购物车商品批量转未支付订单商品 */
    boolean batchCartMerTurnOrder(String cartMerList,Long couponId,Long receiptInfoId,Long accountId);
}
