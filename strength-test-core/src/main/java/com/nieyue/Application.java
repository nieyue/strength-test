package com.nieyue;

import com.fasterxml.classmate.TypeResolver;
import com.nieyue.bean.Account;
import com.nieyue.bean.Assess;
import com.nieyue.service.AccountService;
import com.nieyue.service.PermissionService;
import com.nieyue.util.DateUtil;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.boot.web.server.ErrorPage;
import org.springframework.boot.web.server.WebServerFactoryCustomizer;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.boot.web.servlet.server.ConfigurableServletWebServerFactory;
import org.springframework.context.ApplicationListener;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpStatus;
import org.springframework.scheduling.annotation.EnableScheduling;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.schema.AlternateTypeRule;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

@SpringBootApplication
//@EnableRedisHttpSession
//@Import({DynamicDataSourceRegister.class})
@ServletComponentScan
@EnableSwagger2
@MapperScan("com/nieyue/dao")
@EnableScheduling
public class Application implements ApplicationListener<ApplicationReadyEvent> {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
    @Bean
    public Docket createRestApi(){
        //解决重复递归问题
        TypeResolver typeResolver=new TypeResolver();
        AlternateTypeRule typeRule1=new AlternateTypeRule(typeResolver.resolve(Assess.class),typeResolver.resolve(Object.class));
        String name="体能测试";
        return new Docket(DocumentationType.SWAGGER_2)
                .apiInfo(
                        new ApiInfoBuilder()
                                .title(name+"平台接口文档")
                                .description(name+"平台接口文档1.0版本")
                                .version("1.0")
                                .build())
                .alternateTypeRules(typeRule1)
                .select()
                .apis(RequestHandlerSelectors.basePackage("com.nieyue.controller"))
                .paths(PathSelectors.any())
                .build();
    }
    @Bean
    public WebServerFactoryCustomizer<ConfigurableServletWebServerFactory> containerCustomizer() {

        return new WebServerFactoryCustomizer<ConfigurableServletWebServerFactory>() {
            @Override
            public void customize(ConfigurableServletWebServerFactory   container) {
                ErrorPage error401Page = new ErrorPage(HttpStatus.UNAUTHORIZED, "/home/401.html");
                ErrorPage error404Page = new ErrorPage(HttpStatus.NOT_FOUND, "/home/404.html");
                ErrorPage error406Page = new ErrorPage(HttpStatus.NOT_ACCEPTABLE, "/home/404.html");
                ErrorPage error500Page = new ErrorPage(HttpStatus.INTERNAL_SERVER_ERROR, "/home/404.html");

                container.addErrorPages( error401Page);
                container.addErrorPages( error404Page);
                container.addErrorPages( error406Page);
                container.addErrorPages( error500Page);
            }
        };
    }

    @Autowired
    PermissionService permissionService;
    @Autowired
    AccountService accountService;

    /**
     * 容器初始化
     * @param event
     */
    @Override
    public void onApplicationEvent(ApplicationReadyEvent event) {

        //初始化权限列表
        permissionService.initPermission();
        //设定年龄定时器
        ScheduledExecutorService scheduledThreadPool = Executors.newScheduledThreadPool(3);
        scheduledThreadPool.scheduleWithFixedDelay(new Runnable() {
            @Override
            public void run() {
                int pageNum=1;
                int pageSize=100;
                while (true){
                    List<Account> list = accountService.list(pageNum, pageSize, null, null, null);
                    if(list.size()>0){
                        for (int i = 0; i < list.size(); i++) {
                            Account account = list.get(i);
                            int age = DateUtil.getAgeByBirth(account.getBirthday());
                            if(!account.getAge().equals(age)){
                                account.setAge(age);
                                accountService.update(account);
                            }
                        }
                        pageNum=pageSize+pageNum;
                    }else{
                        break;
                    }
                }

            }
        },1000,5000, TimeUnit.MILLISECONDS);
    }
}
