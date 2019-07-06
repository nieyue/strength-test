import Vue from 'vue'
import Router from 'vue-router'


Vue.use(Router)

const router= new Router({
  // export default new Router({
  //mode: 'history',
  routes: [
    {
      path: '/',
      name: '首页',
      redirect: "/login"
    },
 /*   {
      path: '/index',
      name: '首页',
      component: resolve=>require(['@/components/Index'],resolve)
    },*/
    {
      path: '/login',
      name: '登录',
      component: resolve=>require(['@/components/Login'],resolve)
    },
    
    {
      path: '/main',
      name: '主页',
      component: resolve=>require(['@/components/main/Main'],resolve),
      children:[
        {
          path: 'welcome/:pathParams',
          name: '欢迎页',
          component: resolve=>require(['@/components/main/config/Welcome'],resolve)
        },
        {
          path: 'config/:pathParams',
          name: '平台配置',
          component: resolve=>require(['@/components/main/config/Config'],resolve)
        },
        {
          path: 'articleCate/:pathParams',
          name: '文章类型',
          component: resolve=>require(['@/components/main/article/ArticleCate'],resolve)
        },
        {
          path: 'article/:pathParams',
          name: '文章',
          component: resolve=>require(['@/components/main/article/Article'],resolve)
        },
        {
          path: 'account/selfAccount',
          name: '个人信息',
          component: resolve=>require(['@/components/main/account/SelfAccount'],resolve),
        },
        {
          path: 'account/managerAccount',
          name: '管理员',
          component: resolve=>require(['@/components/main/account/ManagerAccount'],resolve),
        },
        {
          path: 'account/userAccount',
          name: '用户',
          component: resolve=>require(['@/components/main/account/UserAccount'],resolve),
        },
        {
          path: 'finance/:pathParams',
          name: '财务',
          component: resolve=>require(['@/components/main/finance/Finance'],resolve),
        },
        {
          path: 'financeRecord/:pathParams',
          name: '财务记录',
          component: resolve=>require(['@/components/main/finance/FinanceRecord'],resolve),
        },
        {
          path: 'withdrawals/:pathParams',
          name: '提现记录',
          component: resolve=>require(['@/components/main/finance/Withdrawals'],resolve),
        },
        {
          path: 'receiptInfo/:pathParams',
          name: '收货地址',
          component: resolve=>require(['@/components/main/receiptInfo/ReceiptInfo'],resolve),
        },
        {
          path: 'integral/:pathParams',
          name: '积分',
          component: resolve=>require(['@/components/main/account/Integral'],resolve),
        },
        {
          path: 'merCate/:pathParams',
          name: '商品类型',
          component: resolve=>require(['@/components/main/mer/MerCate'],resolve),
        },
        {
          path: 'mer/:pathParams',
          name: '商品',
          component: resolve=>require(['@/components/main/mer/Mer'],resolve),
        },
        {
          path: 'merImg/:pathParams',
          name: '商品图片',
          component: resolve=>require(['@/components/main/mer/MerImg'],resolve),
        },
        {
          path: 'order/:pathParams',
          name: '订单',
          component: resolve=>require(['@/components/main/order/Order'],resolve),
        },
         {
          path: 'role/:pathParams',
          name: '角色',
          component: resolve=>require(['@/components/main/rolePermission/Role'],resolve)
        },
        {
          path: 'permission',
          name: '权限',
          component: resolve=>require(['@/components/main/rolePermission/Permission'],resolve)
        },
        {
          path: 'rolePermission/:roleId',
          name: '角色权限',
          component: resolve=>require(['@/components/main/rolePermission/RolePermission'],resolve)
        },
       
        {
          path: 'system/druid',
          name: '数据库监控',
          component: resolve=>require(['@/components/main/system/Druid'],resolve)
        },
        {
          path: 'system/swagger',
          name: 'API接口管理（swagger）',
          component: resolve=>require(['@/components/main/system/Swagger'],resolve)
        }
      ]
    }
  ]
})
/* router.beforeEach((to, from, next) => {
  if(to.fullPath.indexOf("role")>0
    ||to.fullPath.indexOf("permission")>0
    ||to.fullPath.indexOf("rolePermission")>0){
      //判断是否超级管理员，是就显示账户管理
      if(sessionStorage.getItem("account")){
        let account=JSON.parse(sessionStorage.getItem("account"));
        if(account.role.name=="超级管理员"){
        next()
      }else{
        next(false)
      }
    }else{
      next()
    }

  }else{
    next()
  }

}) */
export default router
