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
          path: 'project/:pathParams',
          name: '项目',
          component: resolve=>require(['@/components/main/project/Project'],resolve)
        },
        {
          path: 'standard/:pathParams',
          name: '标准',
          component: resolve=>require(['@/components/main/project/Standard'],resolve)
        },
        {
          path: 'assess/:pathParams',
          name: '评测',
          component: resolve=>require(['@/components/main/account/Assess'],resolve)
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
          path: 'account/selfAccount',
          name: '个人信息',
          component: resolve=>require(['@/components/main/account/SelfAccount'],resolve),
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
  ],
  scrollBehavior (to, from, savedPosition) {
    return { x: 0, y: 0 }
  }
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
