<!--账户管理 -->
<template>
    <div class="body-wrap">
    <div class="body-btn-wrap">
      <Button type='primary'  @click='add'>增加账户</Button>
      <div class="search-wrap">
       <Select v-model="params.roleId"  transfer class="search-wrap-input" >
            <Option v-for="item in roleList" :value="item.roleId" :key="item.roleId">{{ item.name }}</Option>
        </Select> 
        <Select v-model="params.status" transfer class="search-wrap-input"  placeholder="状态，全部">
            <Option v-for="item in statusParamsList" :value="item.id" :key="item.id">{{ item.value }}</Option>
        </Select>
        <Button @click="search" type="info"  >查询</Button>
      </div>
    </div>
		 <!--新增 -->
     <Modal v-model="addAccountModel"
           title="新增账户管理"
           :closable="false"
           :mask-closable="false"
           width="1000px"
    >
      <Form ref="addAccount" :model="addAccount" :label-width="100"  label-position="right"  :rules="addAccountRules">
        <FormItem prop="phone" label="注册手机号:">
          <Input type="text" v-model="addAccount.phone" placeholder="注册手机号">
          </Input>
        </FormItem>
        <FormItem prop="password" label="密码:">
          <Input type="password" v-model="addAccount.password" placeholder="密码">
          </Input>
        </FormItem>
        <FormItem prop="realname" label="姓名:">
          <Input type="text" v-model="addAccount.realname" placeholder="姓名">
          </Input>
        </FormItem>
        <FormItem prop="status" label="状态:">
          <Select v-model="addAccount.status" transfer size="large" style="width:100px">
              <Option v-for="item in statusList" :value="item.id" :key="item.id">{{ item.value }}</Option>
          </Select>
        </FormItem>
        <FormItem prop="roleId" label="角色:">
          <Select v-model="addAccount.roleId"  transfer size="large" style="width:100px">
              <Option v-for="item in roleList" :value="item.roleId" :key="item.roleId">{{ item.name }}</Option>
          </Select>
        </FormItem>
      </Form>
      <div slot='footer'>
        <Button  @click='addCancel'>取消</Button>
        <Button type='primary' :loading='addLoading'>
          <span v-if="!addLoading" @click='addSure'>确定</span>
          <span v-else>Loading...</span>
        </Button>
      </div>
    </Modal>
    <!--新增end -->
		 <!--修改 -->
     <Modal v-model="updateAccountModel"
           title="修改账户管理"
           :closable="false"
           :mask-closable="false"
           width="1000px"
    >
      <Form ref="updateAccount" :model="updateAccount" :label-width="100" label-position="right"  :rules="updateAccountRules">
       <FormItem prop="phone" label="注册手机号:">
          <Input type="text" v-model="updateAccount.phone" placeholder="注册手机号">
          </Input>
        </FormItem>
        <!-- <FormItem prop="password" label="密码:">
          <Input type="password" v-model="updateAccount.password" placeholder="密码">
          </Input>
        </FormItem> -->
        <FormItem prop="realname" label="姓名:">
          <Input type="text" v-model="updateAccount.realname" placeholder="姓名">
          </Input>
        </FormItem>
        <FormItem prop="status" label="状态:">
          <Select v-model="updateAccount.status" transfer size="large" style="width:100px">
              <Option v-for="item in statusList" :value="item.id" :key="item.id">{{ item.value }}</Option>
          </Select>
        </FormItem>
        <FormItem prop="roleId" label="角色:">
          <Select v-model="updateAccount.roleId"  transfer size="large" style="width:100px">
              <Option v-for="item in roleList" :value="item.roleId" :key="item.roleId">{{ item.name }}</Option>
          </Select>
        </FormItem>
      </Form>
      <div slot='footer'>
        <Button  @click='updateCancel'>取消</Button>
        <Button type='primary' :loading='updateLoading'>
          <span v-if="!updateLoading" @click='updateSure'>确定</span>
          <span v-else>Loading...</span>
        </Button>
      </div>
    </Modal>
    <!--修改end -->
      <Table border height="500"  :columns='accountColumns' :data='accountList' ref='table' size="small"></Table>
        <div style='display: inline-block;float: right; margin-top:10px;'>
        <Page style='margin-right:10px;'  @on-page-size-change="onPageSizeChange" show-sizer :pageSize="params.pageSize" :page-size-opts="params.pageSizeOpts"  :current="params.currentPage" :total='params.total'  ref='page' :show-total='true'  @on-change='selectPage' show-elevator ></Page>
      </div>
    </div>
</template>
<script>
export default {
  name: 'ManagerAccount',
  data () {
    return {
        routerPath:this.$route.path,
        params:{
            pageSizeOpts:[10,20,50,100,500,1000],//每页条数切换的配置
            startNum:1,//初始化个数
            currentPage:1,//当前页
            pageNum:1,//获取的第几个开始
            pageSize:10,//每页的个数
            total:0//总数
        },
        //状态
        statusParamsList:[
          {id:'',value:'全部'},
          {id:1,value:'正常'},
          {id:2,value:'已禁用'},
         //{id:3,value:'异常'}
          ],
      //状态
      statusList:[
          {id:1,value:'正常'},
          {id:2,value:'已禁用'},
         // {id:3,value:'异常'}
        ],
			//增加参数
			addAccountModel:false,
			addLoading:false,
			addAccountRules: {
                phone: [
                    {required: true, message: '注册手机号为必填项', trigger: 'blur'}
                    ]
                },
			addAccount:{
        icon:'',
        status:1,
        identityCardsFrontImg:'',
        identityCardsBackImg:''
      },
			//修改参数
			updateAccountModel:false,
			updateLoading:false,
			updateAccountRules: {
                phone: [
                    {required: true, message: '注册手机号为必填项', trigger: 'blur'}
                    ]
                },
			updateAccount:{},
      //删除参数
      deleteAccount:{},
      //列表
	    roleList: [],
        accountList: [],
	    accountColumns: [
        {
          title: '序号',
           minWidth:100,
          align:'center',
          render: (h, params) => {
            return h('span', params.index
            +(this.params.currentPage-1)*this.params.pageSize+this.params.startNum);
          }
        },
        {
          title: '账户id',
          minWidth:100,
          key: 'accountId',
          align:'center'
        },
        {
          title:'注册手机号',
          minWidth:100,
            key:'phone',
          align:'center'
        },
       /*   {
        	title:'邀请码',
            minWidth:100,
          align:'center',
          render: (h, params) => {
             return  h('span',[params.row.inviteCode,
             h('Button', {
                        props: {
                          type: 'primary',
                          size: 'small'
                        },
                        on: {
                          click: () => {
                            this.updateInviteCode(params.row);
                          }
                        }
                      }, '更新')
             ]);
          }
        }, */
        {
          title:'姓名',
          minWidth:100,
            key:'realname',
          align:'center'
        },
         {
          title:'角色名',
          minWidth:100,
          align:'center',
          render: (h, params) => {
             return  h('span',params.row.role.name);
          }
        },
        {
          title:'状态',
          minWidth:100,
            key:'status',
          align:'center',
          render: (h, params) => {
            let statusvalue="";
            this.statusList.forEach(element => {
              if(element.id==params.row.status){
                statusvalue=element.value;
              }
            });
             return  h('span',statusvalue);
          }
        },
        {
          title:'创建时间',
          minWidth:100,
          key:'createDate',
          sortable: true,
          align:'center'
        },
        {
          title:'最后登陆时间',
          minWidth:100,
          key:'loginDate',
          sortable: true,
          align:'center'
        },
				{
          title: '操作',
          minWidth:200,
          key: 'action',
          align:'center',
          render: (h, params) => {
            var marginstyle="2px"
            var sn='正常'
            var scolor='success'
          //已禁用
          if(params.row.status==2){
           sn='已禁用'
           scolor='error'
            }

            var varhhchange=  h('Button', {
                props: {
                  type: scolor,
                  size: 'small'
                },
                style: {
                  margin: marginstyle
                },
                on: {
                  click: () => {
                    //如果是正常，变为禁用
                    if(params.row.status==1){
                      params.row.status=2
                      }else{
                      params.row.status=1

                      }
                      this.updateAccount=params.row
                    this.changeStatus(params.row)
                  }
                }
              }, sn);

            var varhh20=  h('Button', {
                props: {
                  type: 'primary',
                  size: 'small'
                },
                style: {
                  margin: marginstyle
                },
                on: {
                  click: () => {
                    
                    this.update(params.row)
                  }
                }
              }, '编辑');
            var varhh21=  h('Button', {
                props: {
                  type: 'error',
                  size: 'small'
                },
                style: {
                  margin: marginstyle
                },
                on: {
                  click: () => {
                    this.delete(params.row)
                  }
                }
              }, '删除');
            var varhhloginout=  h('Button', {
                props: {
                  type: 'error',
                  size: 'small'
                },
                style: {
                  margin: marginstyle
                },
                on: {
                  click: () => {
                    this.loginout(params.row)
                  }
                }
              }, '登录退出');
            	var s=h("div","");
			s=h("div",[
        h("div",[
          varhhchange,
         //  varhh20,
           ,varhh21
          
        ]),
        /*  h("div",[
            varhhloginout
        ]) */
            ]);
            return s;
          }
        }
      ],
    }
  },
  methods: {
    //查询
    search(){
      this.params.currentPage=1;
      this.params.pageNum =1;
      this.getList()
    },
    //分页点击
    selectPage (currentPage) {
      this.params.currentPage=currentPage;
      this.params.pageNum = (this.params.currentPage-1)*this.params.pageSize+this.params.startNum;
      this.getList()
    },
    //切换每页条数时的回调，返回切换后的每页条数
    onPageSizeChange(a){
      this.params.pageSize=a;
      this.selectPage(1)
    },
  //获取列表
   getRoleList () {
     /**
     * 获取列表
     * $this  vue组件
     * p.countUrl 数量url
     * p.listUrl 列表url
     * p.list 返回列表
     */
    this.params.pageSize=10000
     this.axiosbusiness.getList(this,{
       countUrl:'/role/count',
       listUrl:'/role/list',
       data:'roleList',
       success:()=>{
           
      
        let roleListLength=this.roleList.length;
        for(let i=0;i<roleListLength;i++){
      //路径为管理员账户
        if(this.routerPath=="/main/account/managerAccount"){
          if(this.roleList[i].name!='超级管理员'
          &&this.roleList[i].name!='普通管理员'){
           this.roleList.splice(i,1);
            roleListLength--;
            i--;
          }
       }
        }
        if(this.roleList[0] &&this.roleList[0].roleId){
          this.params.roleId=this.roleList[0].roleId;
        }

         this.getList(10);
       }
     },
    this.params)
    },
  //获取列表
   getList () {
     /**
     * 获取列表
     * $this  vue组件
     * p.countUrl 数量url
     * p.listUrl 列表url
     * p.list 返回列表
     */
     this.axiosbusiness.getList(this,{
       countUrl:'/account/count',
       listUrl:'/account/list',
       data:'accountList',
       success:()=>{
       }
     },this.params)
    },
  //增加
	 add (params) {
      this.addAccountModel = true
      //初始化
        this.addAccount={
            status:1,
            roleId:this.roleList[0].roleId,
        };
    },
		//增加取消
		 addCancel () {
      if (!this.addLoading) {
        this.addAccountModel = false
        this.$refs.addAccount.resetFields()
      }
    },
		//增加确定
    addSure () {
       /**
     * 增加
     * $this  vue组件
     * p.ref 验证
     * p.url 增加url
     * p.requestObject 请求参数对象
     * p.loading loading
     * p.showModel 界面模型显示隐藏
     */
    this.axiosbusiness.add(this,{
      ref:'addAccount',
      url:'/account/add',
      requestObject:'addAccount',
      loading:'addLoading',
      showModel:'addAccountModel'
    })
    },
	 update (params) {
      this.updateAccountModel = true
      this.updateAccount.accountId = params.accountId
     //获取修改实体
      this.axiosbusiness.get(this,{
          url:'/account/'+params.accountId,
         list:'updateAccount',
         success:()=>{
         }
       })
    },
		//修改取消
		 updateCancel () {
      if (!this.updateLoading) {
        this.updateAccountModel = false
        this.$refs.updateAccount.resetFields()
      }
    },
		//修改确定
    updateSure () {
      /**
     * 修改
     * $this  vue组件
     * p.ref 验证
     * p.url 修改url
     * p.requestObject 请求参数对象
     * p.loading loading
     * p.showModel 界面模型显示隐藏
     */
    delete this.updateAccount.role;
    this.axiosbusiness.update(this,{
      ref:'updateAccount',
      url:'/account/update',
      requestObject:'updateAccount',
      loading:'updateLoading',
      showModel:'updateAccountModel'
    })
 
    },
    //删除
    delete(params){
    /**
     * 删除
     * $this  vue组件
     * p.url 修改url
     * p.requestObject 请求参数对象
     */
    this.deleteAccount={
      "accountId":params.accountId
    };
    this.axiosbusiness.delete(this,{
      url:'/account/delete',
      requestObject:'deleteAccount'
    })
    },
  //登录退出
  loginout(params){
    this.loginoutAccount={
      "accountId":params.accountId
    };
    this.axiosbusiness.loginout(this,{
      url:'/account/loginout',
      requestObject:'loginoutAccount'
    })
  },
  //更新邀请码
    updateInviteCode(params){
      let p="?accountId="+this.business.getAccount().accountId;
        p+="&targetAccountId="+params.accountId;
      

       this.$Modal.confirm({
            title: '更新邀请码',
            content: "确认更新邀请码吗？",
            onOk: () => {
              this.axiosbusiness.get(this,{
                url:'/account/updateInviteCode'+p,
                success:(d)=>{
                   this.$Message.success('更新成功');
                   params.inviteCode=d.data.data[0].inviteCode
                }
              });
         },
      onCancel: () => {
         this.$Message.info('取消');
      }
       });
    },
  //启用禁用
  changeStatus(updateAccount){
    this.updateAccount=updateAccount
     delete this.updateAccount.role;
     this.axios({
               method:"post",
               url:'/account/update',
               withCredentials: true,
               data: this.Qs.stringify(this.updateAccount)
            }).
            then(res => {
              this.loading = false
              if (res.data.code === 200) {
                this.$Message.success(res.data.msg)
              } else {
                this.$Message.error(res.data.msg)
                this.loading = false
              }
            }).catch(res => {
              this.loading = false
              this.$Message.error('系统异常')
            })
  }
  },
watch: {
    $route (to, from) {
        this.routerPath=this.$route.path;
        this.getRoleList();
    }
},
  created () {
    this.getRoleList();
    
  },
  mounted () {

  } 
}
</script>
