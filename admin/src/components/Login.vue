<!--首页 -->
<template>
  <div>  
  <!--顶部-->
      <top-bar @islogin="getIslogin"></top-bar>
  <!--顶部 end -->
    <div class="login-wrap" style="background:url('./static/banner1.png') no-repeat;">
      <Form ref="account"  :label-width="0" class="login-account" :model="account" :rules="loginAccountRules">
        <FormItem prop="adminName" class="login-account-inputwrap">
            <Input type="text"  v-model="account.adminName" size="large" placeholder="输入手机号" class="login-account-input">
                <Icon type="ios-phone-portrait" slot="prefix"/>
            </Input>
        </FormItem>
        <FormItem prop="password" class="login-account-inputwrap">
          <Input type="password"  v-model="account.password" placeholder="密码" class="login-account-input" >
            <Icon type="ios-lock-outline" slot="prefix"/>
          </Input>
        </FormItem>
        <FormItem prop="verificationCode" class="login-account-inputwrap">
            <Input type="text"  v-model="account.verificationCode" size="large"  class="login-account-input50"  placeholder="验证码" @keyup.enter.native="login('account')"> 
                <Icon type="ios-image-outline" slot="prefix"/>
            </Input>
            <div class="login-account-input50">
                <img :src="verificationCode" @click="getVerificationCode()" style="height:50px;vertical-align:middle" />
            </div>
        </FormItem>
        <Button type="primary" long  class="login-account-inputwrap" >
          <span v-if="!loading" style="width:100%;display:inline-block;font-size:1.2rem;"  @click="login('account')">登录</span>
          <span v-else>Loading...</span>
        </Button>
      </Form>
    </div>

    <footer-bar></footer-bar>
  </div>
</template>
<script>
import TopBar from '@/components/common/TopBar'
import FooterBar from '@/components/common/FooterBar';
  export default {
    name: 'Login',
    components:{
      TopBar,
      FooterBar
    },
    created(){
    
    },
    data () {
      return {
        //登陆信息
        account: {
          adminName: '',
          password: '',
          verificationCode: '',
        },
        //是否登陆默认false
        islogin:false,
        //验证码
        verificationCode:'',
        // 点击登录之后等待登录结果而不是多次点击
        loading: false,
        loginAccountRules: {
          adminName: [
            { required: true, message: '请输入手机号', trigger: 'blur' }
          ],
          password: [
            { required: true, message: '请输入密码', trigger: 'blur' }
          ],
          verificationCode: [
            { required: true, message: '请输入验证码', trigger: 'blur' }
          ]
        }
      }
    },
    methods: {
      // aduiClick(p){
      //   this.$refs[p].click();
      // },
      //获取验证码
      getVerificationCode(){
        this.axios({
          method:"post",
          url:'/tool/getVerificationCode',
          withCredentials: true,  
          responseType:'blob'
          })
        .then((res)=>{
          var blob = new Blob([res.data], {type: "image/png"}); 
            //console.log(blob);  
          this.verificationCode=window.URL.createObjectURL(blob);

        }).catch((error)=>{
           // console.log(error);
            this.$Message.error("错误")
         });
      },
      //登陆
      login (name) {
        this.$refs[name].validate((valid) => {
        console.log('123')
          if (valid) {
            this.loading = true
            this.axios({
               method:"post",
               url:'/account/login',
               withCredentials: true,
               data: this.Qs.stringify(this.account)
            }).
            then(res => {
              console.log(res)
              this.loading = false
              if (res.data.code == 200) {
                this.$Message.success(res.data.msg)
                console.log(res.data.data[0])
               // sessionStorage.setItem("account",JSON.stringify(res.data.data[0]))
                sessionStorage.setItem("account",JSON.stringify(res.data.data[0].account))
                sessionStorage.setItem("role",JSON.stringify(res.data.data[0].role))
                sessionStorage.setItem("rolePermissionList",JSON.stringify(res.data.data[0].rolePermissionList))
                this.$router.push('/main/welcome/'+JSON.stringify(this.pathParams))
              
              } else {
                this.$Message.error(res.data.msg)
                this.loading = false
              }
            }).catch(res => {
              this.loading = false
              this.$Message.error('系统异常')
            })
          } else {
            this.$Message.error('用户名和密码是必填项')
          }
        })
      },
      //获取子组件传递上来的值
      getIslogin(islogin){
        this.islogin=islogin;
        if(islogin){
          this.$router.push("/main/welcome/"+JSON.stringify(this.pathParams))
        }else{
          //获取验证码
          this.getVerificationCode();
        }
      }
    }
  }
</script>
<style lang="less">
@import "Login.less";
</style>
