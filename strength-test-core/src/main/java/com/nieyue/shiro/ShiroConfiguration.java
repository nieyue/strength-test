package com.nieyue.shiro;

import com.nieyue.bean.Permission;
import com.nieyue.service.PermissionService;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.CookieRememberMeManager;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.apache.shiro.web.servlet.SimpleCookie;
import org.apache.shiro.web.session.mgt.DefaultWebSessionManager;
import org.crazycake.shiro.RedisCacheManager;
import org.crazycake.shiro.RedisManager;
import org.crazycake.shiro.RedisSessionDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import redis.clients.jedis.JedisPoolConfig;

import javax.servlet.Filter;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * @author: 聂跃
 * @description: shiro配置类
 * @date: 2017/10/24 10:10
 */
@Configuration
public class ShiroConfiguration {
    @Value("${server.servlet.session.cookie.name}")
    String sessioncookiename;
    @Value("${server.servlet.session.timeout}")
    Integer sessiontimeout;
    @Value("${server.servlet.session.cookie.domain}")
    String sessiondomain;
    @Value("${spring.redis.host}")
    String redishost;
    @Value("${spring.redis.password}")
    String redispassword;
    @Value("${spring.redis.port}")
    Integer redisport;
    @Value("${spring.redis.database}")
    Integer redisdatabase;
    @Value("${spring.redis.timeout}")
    Integer redistimeout;
    @Value("${spring.redis.lettuce.pool.min-idle}")
    Integer redispoolminidle;
    @Value("${spring.redis.lettuce.pool.max-idle}")
    Integer redispoolmaxidle;
    @Value("${spring.redis.lettuce.pool.max-active}")
    Integer redispoolmaxactive;
    //com.nieyue.shiro anon location静态资源
    @Value("${myPugin.shiro.anon.locations}")
    String shiroanonlocations;
    @Autowired
    private PermissionService permissionService;
   // private static final Logger logger = LoggerFactory.getLogger(ShiroConfiguration.class);

    /**
     * 初始化权限
     */
    public Map<String, String> loadFilterChainDefinitions(List<Permission> permissionList) {
        // 权限控制map.从数据库获取
        Map<String, String> filterChainDefinitionMap = new LinkedHashMap<String, String>();
         /* 过滤链定义，从上向下顺序执行，一般将 / ** 放在最为下边:这是一个坑呢，一不小心代码就不好使了;
          authc:所有url都必须认证通过才可以访问; anon:所有url都都可以匿名访问 */
        //静态资源开放
        /*filterChainDefinitionMap.put("/", "anon");
        filterChainDefinitionMap.put("/swagger-ui.html", "anon");
        filterChainDefinitionMap.put("/swagger-resources/**", "anon");
        filterChainDefinitionMap.put("/webjars/**", "anon");
        filterChainDefinitionMap.put("/v2/**", "anon");
        filterChainDefinitionMap.put("/home/**", "anon");
        filterChainDefinitionMap.put("/resources/**", "anon");*/
        String[] sl=shiroanonlocations.split("\\,");
        for (int i = 0; i < sl.length; i++) {
        	filterChainDefinitionMap.put(sl[i].trim(), "anon");
		}
        //动态权限
        for (Permission per : permissionList) {
            //公共的开放的
            if(per.getType().equals(1)){
                filterChainDefinitionMap.put(per.getRoute(), "anon");
            }
            //需要登录的，需要权限的
            if(per.getType().equals(2)){
                filterChainDefinitionMap.put(per.getRoute(),
                        "authc,perms["+per.getRoute()+"]");
            }
        }
        filterChainDefinitionMap.put("/**/", "authc,perms[nieyue]");//乱写，不允许通过
       // System.err.println(filterChainDefinitionMap);
        //filterChainDefinitionMap.put("/**", "authc,roles[超级管理员]");
        return filterChainDefinitionMap;
    }

    /**
     * Shiro的Web过滤器Factory 命名:shiroFilter
     */
    @Bean(name = "shiroFilter")
    public ShiroFilterFactoryBean shiroFilterFactoryBean(SecurityManager securityManager) {
        ShiroFilterFactoryBean shiroFilterFactoryBean = new ShiroFilterFactoryBean();
        //Shiro的核心安全接口,这个属性是必须的
        shiroFilterFactoryBean.setSecurityManager(securityManager);
        Map<String, Filter> filterMap = new LinkedHashMap<>();
        // 如果不设置默认会自动寻找Web工程根目录下的"/login.jsp"页面
        //shiroFilterFactoryBean.setLoginUrl("/test/unauth");
        // 登录成功后要跳转的链接
        //shiroFilterFactoryBean.setSuccessUrl("/test/sessionid");
        // 未授权界面;
       // shiroFilterFactoryBean.setUnauthorizedUrl("/test/unauth");
        filterMap.put("anon", new MyAnonymousFilter());//自定义匿名访问权限
        filterMap.put("authc", new MyAuthenticationFilter());//对没有登陆的，需要跳转的过滤
        filterMap.put("perms", new MyPermissionsAuthorizationFilter());//对权限过滤
        shiroFilterFactoryBean.setFilters(filterMap);
        /*定义shiro过滤链  Map结构
         * Map中key(xml中是指value值)的第一个'/'代表的路径是相对于HttpServletRequest.getContextPath()的值来的
         * anon：它对应的过滤器里面是空的,什么都没做,这里.do和.jsp后面的*表示参数,比方说login.jsp?main这种
         * authc：该过滤器下的页面必须验证后才能访问,它是Shiro内置的一个拦截器org.apache.com.nieyue.shiro.web.com.nieyue.filter.authc.FormAuthenticationFilter
         */
        Map<String, String> filterChainDefinitionMap = new LinkedHashMap<>();
        //初始化
        //从数据库获取
        List<Permission> permissionList = permissionService.list( 1, Integer.MAX_VALUE, null,null,null);
        filterChainDefinitionMap=loadFilterChainDefinitions(permissionList);
        shiroFilterFactoryBean.setFilterChainDefinitionMap(filterChainDefinitionMap);
        return shiroFilterFactoryBean;
    }

    /**
     * 不指定名字的话，自动创建一个方法名第一个字母小写的bean
     */
    @Bean
    public SecurityManager securityManager() {
        DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();
        securityManager.setRealm(accountRealm());
        // 自定义session管理 使用redis
        securityManager.setSessionManager(sessionManager());
        //缓存放入cache
        securityManager.setCacheManager(cacheManager());
        //注入记住我
        securityManager.setRememberMeManager(rememberMeManager());
        return securityManager;
    }

    /**
     * SimpleCookie的管理
     */
    @Bean
    public SimpleCookie simpleCookie1( ) {
        SimpleCookie sc=new SimpleCookie();
        sc.setName(sessioncookiename);
        sc.setMaxAge(sessiontimeout);
        sc.setDomain(sessiondomain);
        return sc;
    }
    @Bean
    public SimpleCookie simpleCookie2( ) {
        SimpleCookie sc=new SimpleCookie();
        sc.setName(CookieRememberMeManager.DEFAULT_REMEMBER_ME_COOKIE_NAME);
        //记住我比sessioncookie少30分钟，即提前30分钟失效
        sc.setMaxAge(sessiontimeout-1800);
        sc.setDomain(sessiondomain);
        return sc;
    }
    /**
     * rememberMe管理器
     */
    @Bean
    public CookieRememberMeManager rememberMeManager() {
        CookieRememberMeManager cookieRememberMeManager = new CookieRememberMeManager();
        cookieRememberMeManager.setCookie(simpleCookie2());
        return cookieRememberMeManager;
    }
    /**
     * com.nieyue.shiro session的管理
     */

    @Bean
    public DefaultWebSessionManager sessionManager() {
        DefaultWebSessionManager sessionManager = new DefaultWebSessionManager();
        sessionManager.setGlobalSessionTimeout(sessiontimeout*1000);    // 设置session超时
        sessionManager.setDeleteInvalidSessions(true);      // 删除无效session
        sessionManager.setSessionDAO(redisSessionDAO());
        sessionManager.setSessionIdCookie(simpleCookie1());
        return sessionManager;
    }
    /**
     * RedisSessionDAO com.nieyue.shiro sessionDao层的实现 通过redis
     * 使用的是shiro-redis开源插件
     */
    @Bean
    public RedisSessionDAO redisSessionDAO() {
        RedisSessionDAO redisSessionDAO = new RedisSessionDAO();
        redisSessionDAO.setRedisManager(redisManager());
        redisSessionDAO.setExpire(sessiontimeout);//过期时间
        return redisSessionDAO;
    }

    /**
     * cacheManager 缓存 redis实现
     * 使用的是shiro-redis开源插件
     * @return
     */
    @Bean
    public RedisCacheManager cacheManager() {
        RedisCacheManager redisCacheManager = new RedisCacheManager();
        redisCacheManager.setRedisManager(redisManager());
        return redisCacheManager;
    }

    /**
     * 配置shiro redisManager
     * 使用的是shiro-redis开源插件
     * @return
     */
    @Bean
    public RedisManager redisManager() {
        RedisManager redisManager = new RedisManager();
        redisManager.setHost(redishost);
        redisManager.setPassword(redispassword);
        redisManager.setPort(redisport);
        redisManager.setTimeout(redistimeout);
        redisManager.setDatabase(redisdatabase);
        JedisPoolConfig jpc=new JedisPoolConfig();
        jpc.setMinIdle(redispoolminidle);
        jpc.setMaxIdle(redispoolmaxidle);
        jpc.setMaxTotal(redispoolmaxactive);
        redisManager.setJedisPoolConfig(jpc);
        return redisManager;
    }
    /**
     * Shiro Realm 继承自AuthorizingRealm的自定义Realm,即指定Shiro验证用户登录的类为自定义的
     */
    @Bean
    public AccountRealm accountRealm() {
        AccountRealm accountRealm = new AccountRealm();
        return accountRealm;
    }

    /**
     * 凭证匹配器
     * （由于我们的密码校验交给Shiro的SimpleAuthenticationInfo进行处理了
     * 所以我们需要修改下doGetAuthenticationInfo中的代码;
     * ）
     * 可以扩展凭证匹配器，实现 输入密码错误次数后锁定等功能，下一次
     */
//    @Bean(name = "credentialsMatcher")
//    public HashedCredentialsMatcher hashedCredentialsMatcher() {
//        HashedCredentialsMatcher hashedCredentialsMatcher = new HashedCredentialsMatcher();
//        //散列算法:这里使用MD5算法;
//        hashedCredentialsMatcher.setHashAlgorithmName("md5");
//        //散列的次数，比如散列两次，相当于 md5(md5(""));
//        hashedCredentialsMatcher.setHashIterations(1);
//        //storedCredentialsHexEncoded默认是true，此时用的是密码加密用的是Hex编码；false时用Base64编码
//        hashedCredentialsMatcher.setStoredCredentialsHexEncoded(true);
//        return hashedCredentialsMatcher;
//    }

    /**
     * 开启Shiro的注解(如@RequiresRoles,@RequiresPermissions),需借助SpringAOP扫描使用Shiro注解的类,并在必要时进行安全逻辑验证
     * 配置以下两个bean(DefaultAdvisorAutoProxyCreator(可选)和AuthorizationAttributeSourceAdvisor)即可实现此功能
     */
//    @Bean
//    @DependsOn({"lifecycleBeanPostProcessor"})
//    public DefaultAdvisorAutoProxyCreator advisorAutoProxyCreator() {
//        DefaultAdvisorAutoProxyCreator advisorAutoProxyCreator = new DefaultAdvisorAutoProxyCreator();
//        advisorAutoProxyCreator.setProxyTargetClass(true);
//        return advisorAutoProxyCreator;
//    }
//
    /**
     *  开启shiro aop注解支持.
     *  使用代理方式;所以需要开启代码支持;
     * @return
     */
    @Bean
    public AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor() {
        AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor = new AuthorizationAttributeSourceAdvisor();
        authorizationAttributeSourceAdvisor.setSecurityManager(securityManager());
        return authorizationAttributeSourceAdvisor;
    }
}
