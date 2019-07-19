<!--测评管理 -->
<template>
    <div class="body-wrap">
    <div class="body-btn-wrap">
      <Button type='primary'  @click='add'>增加测评</Button>
      <div class="search-wrap">
        <InputNumber :max="200" :min="0"  :precision='0' v-model="params.age"  class="search-wrap-input" placeholder="年龄" ></InputNumber>
        <Select v-model="params.sex" transfer class="search-wrap-input"  placeholder="性别，全部">
            <Option v-for="item in sexParamsList" :value="item.id" :key="item.id">{{ item.value }}</Option>
        </Select>
       <!--  <Select v-model="params.rank" transfer class="search-wrap-input"  placeholder="等级，全部">
            <Option v-for="item in rankParamsList" :value="item.id" :key="item.id">{{ item.value }}</Option>
        </Select> -->
        <Button @click="search" type="info"  >查询</Button>
      </div>
    </div>
		 <!--新增 -->
     <Modal v-model="addAssessModel"
           title="新增测评管理"
           :closable="false"
           :mask-closable="false"
           width="1000px"
    >
      <Form ref="addAssess" :model="addAssess" :label-width="100"  label-position="right"  :rules="addAssessRules">
           <FormItem prop="createDate"  label="时间:">
             <span v-text="new Date().toLocaleDateString()"></span>
            <!-- <InputNumber :max="1000000000" :min="-9999999"  :precision='2'  v-model="addAssess.score"></InputNumber> -->
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
     <Modal v-model="updateAssessModel"
           title="修改测评管理"
           :closable="false"
           :mask-closable="false"
           width="1000px"
    >
      <Form ref="updateAssess" :model="updateAssess" :label-width="100" label-position="right"  :rules="updateAssessRules">
        <FormItem prop="createDate" label="时间:">
            <span v-text="updateAssess.createDate?updateAssess.createDate.substr(0,10):''"></span>
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
      <Table border height="600" :columns='assessColumns' :data='assessList' ref='table' size="small"></Table>
        <div style='display: inline-block;float: right; margin-top:10px;'>
        <Page style='margin-right:10px;' @on-page-size-change="onPageSizeChange" show-sizer :page-size-opts='params.pageSizeOpts' :current="params.currentPage" :total='params.total' :pageSize='params.pageSize' ref='page' :show-total='true'  @on-change='selectPage' show-elevator ></Page>
      </div>
    </div>
</template>
<script>
export default {
  name: 'Assess',
  data () {
    return {
        params:{
            pageSizeOpts:[10,20,50,100,500,1000],//每页条数切换的配置
            startNum:1,//初始化个数
            currentPage:1,//当前页
            pageNum:1,//获取的第几个开始
            pageSize:10,//每页的个数
            total:0//总数
        },
      //等级,1不良,2未达,3合格,4良好,5优秀
      rankList:[
        {id:1,value:'不良'},
        {id:2,value:'未达'},
        {id:3,value:'合格'},
        {id:4,value:'良好'},
        {id:5,value:'优秀'},
        ],
      //性别，为1男性，为2女性,默认为3未知
      sexList:[
        {id:1,value:'男性'},
        {id:2,value:'女性'},
        {id:3,value:'未知'},
        ],
        //等级,1不良,2未达,3合格,4良好,5优秀
      rankParamsList:[
        {id:'',value:'全部'},
        {id:1,value:'不良'},
        {id:2,value:'未达'},
        {id:3,value:'合格'},
        {id:4,value:'良好'},
        {id:5,value:'优秀'},
        ],
      //性别，为1男性，为2女性,默认为3未知
      sexParamsList:[
        {id:'',value:'全部'},
        {id:1,value:'男性'},
        {id:2,value:'女性'},
        {id:3,value:'未知'},
        ],
			//增加参数
			addAssessModel:false,
			addLoading:false,
			addAssessRules: {
                /*  score: [
                    {type:'number',required: true, message: '结果值为必填项', trigger: 'change'}
                    ]  */
                },
			addAssess:{
			},
			//修改参数
			updateAssessModel:false,
			updateLoading:false,
			updateAssessRules: {
                 /* score: [
                    {type:'number',required: true, message: '结果值为必填项', trigger: 'change'}
                    ]  */
                },
			updateAssess:{
      },
      //删除参数
      deleteAssess:{},
      //列表
        assessList: [],
	    assessColumns: [
        // {
        //   type: 'selection',
        //   width: 60,
        //   align: 'center' 
        // },
        {
          title: '序号',
          align:'center',
          render: (h, params) => {
            return h('span', params.index
            +(this.params.currentPage-1)*this.params.pageSize+this.params.startNum);
          }
        },
        {
          title: '测评id',
          key: 'assessId',
          align:'center'
        },
         {
        	title:'创建时间',
          key:'createDate',
          sortable: true,
          align:'center',
          render:(h,params)=>{
            return h("div",params.row.createDate.substr(0,10))
          }
        },
        {
        	title:'年龄',
        	key:'age',
          align:'center'
        },
         {
        	title:'性别',
          align:'center',
          render: (h, params) => {
            let sexvalue="";
            this.sexList.forEach(element => {
              if(element.id==params.row.sex){
                sexvalue=element.value;
              }
            });
             return  h('span',sexvalue);
          }
        },
       /*  {
        	title:'等级',
        	key:'rank',
          align:'center',
          render: (h, params) => {
            let rankvalue="";
            this.rankList.forEach(element => {
              if(element.id==params.row.rank){
                rankvalue=element.value;
              }
            });
             return  h('span',rankvalue);
          }
        },
        {
        	title:'总分',
        	key:'score',
          align:'center'
        }, */
       
        /* {
        	title:'修改时间',
          key:'updateDate',
          sortable: true,
          align:'center'
        }, */
		{
          title: '操作',
          key: 'action',
          align:'center',
          render: (h, params) => {
            var varhh1=  h('Button', {
                props: {
                  type: 'primary',
                  size: 'small'
                },
                style: {
                  margin: '5px'
                },
                on: {
                  click: () => {
                    this.update(params.row)
                  }
                }
              }, '编辑');
            var varhh2=  h('Button', {
                props: {
                  type: 'error',
                  size: 'small'
                },
                style: {
                  margin: '5px'
                },
                on: {
                  click: () => {
                    this.delete(params.row)
                  }
                }
              }, '删除');
              var varhh3=  h('Button', {
                props: {
                  type: 'error',
                  size: 'small'
                },
                style: {
                  margin: '5px'
                },
                on: {
                  click: () => {
                         let  pp=JSON.stringify({
                      currentPage:1,//当前页
                      assessId:params.row.assessId,
                    });
                    this.$router.push('/main/assessProject/'+pp);
                    setTimeout(()=>{
                        this.Hub.$emit('navroad',this.$router.currentRoute); //Hub触发事件
                    },200)
                  }
                }
              }, '单项测评');
              var vh2=  h('Button', {
                props: {
                  type: 'success',
                  size: 'small'
                },
                style: {
                  margin: '5px'
                },
                on: {
                  click: () => {
                         let  pp=JSON.stringify({
                      currentPage:1,//当前页
                      assessId:params.row.assessId,
                      accountId:params.row.accountId,
                      pageSize:2,
                      createDate:params.row.createDate.substr(0,10)+" 00:00:00",
                    });
                    open("/#/data/"+pp,"_blank")
                  }
                }
              }, '2次报告');
              var vh3=  h('Button', {
                props: {
                  type: 'success',
                  size: 'small'
                },
                style: {
                  margin: '5px'
                },
                on: {
                  click: () => {
                         let  pp=JSON.stringify({
                      currentPage:1,//当前页
                      assessId:params.row.assessId,
                      accountId:params.row.accountId,
                       pageSize:3,
                       createDate:params.row.createDate.substr(0,10)+" 00:00:00",
                    });
                    open("/#/data/"+pp,"_blank")
                  }
                }
              }, '3次报告');
              var vh7=  h('Button', {
                props: {
                  type: 'success',
                  size: 'small'
                },
                style: {
                  margin: '5px'
                },
                on: {
                  click: () => {
                         let  pp=JSON.stringify({
                      currentPage:1,//当前页
                      assessId:params.row.assessId,
                      accountId:params.row.accountId,
                       pageSize:7,
                       createDate:params.row.createDate.substr(0,10)+" 00:00:00",
                    });
                    open("/#/data/"+pp,"_blank")
                  }
                }
              }, '7次报告');
              var vh30=  h('Button', {
                props: {
                  type: 'success',
                  size: 'small'
                },
                style: {
                  margin: '5px'
                },
                on: {
                  click: () => {
                         let  pp=JSON.stringify({
                      currentPage:1,//当前页
                      assessId:params.row.assessId,
                      accountId:params.row.accountId,
                       pageSize:30,
                       createDate:params.row.createDate.substr(0,10)+" 00:00:00",
                    });
                    open("/#/data/"+pp,"_blank")
                  }
                }
              }, '30次报告');
            	var s=h("div","");
			s=h("div",[
              //varhh1,
              //varhh2,
              varhh3,
              vh2,
              vh3,
              vh7,
              vh30,
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
       //构造path
     let pp=JSON.stringify({
       currentPage:currentPage,
       accountId:JSON.parse(this.$route.params.pathParams).accountId,
     })
      this.$router.push(this.$route.path.substr(0,this.$route.path.indexOf(this.$route.params.pathParams))+pp);
      this.getList()
    },
    //切换每页条数时的回调，返回切换后的每页条数
    onPageSizeChange(pageSize){
      this.getList(pageSize)
    },
  //获取列表
   getList (pageSize) {
     /**
     * 获取列表
     * $this  vue组件
     * p.countUrl 数量url
     * p.listUrl 列表url
     * p.data 返回列表
     */
      this.params.pageSize=pageSize||this.params.pageSize
      this.params.accountId=JSON.parse(this.$route.params.pathParams).accountId
     this.axiosbusiness.getList(this,{
       countUrl:'/assess/count',
       listUrl:'/assess/list',
       data:'assessList',
       success:()=>{
         this.params.age?'':this.params.age=null;
       }
     },this.params)
    },
  //增加
	 add (params) {
      this.addAssessModel = true
    },
		//增加取消
		 addCancel () {
      if (!this.addLoading) {
        this.addAssessModel = false
        this.$refs.addAssess.resetFields()
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
    this.addAssess.accountId=JSON.parse(this.$route.params.pathParams).accountId
    this.axiosbusiness.add(this,{
      ref:'addAssess',
      url:'/assess/add',
      requestObject:'addAssess',
      loading:'addLoading',
      showModel:'addAssessModel'
    })
    },
	 update (params) {
      this.updateAssessModel = true
      this.updateAssess.assessId = params.assessId
       //获取修改实体
      this.axiosbusiness.get(this,{
         url:'/assess/load?assessId='+params.assessId,
         data:'updateAssess',
         })
    },
		//修改取消
		 updateCancel () {
      if (!this.updateLoading) {
        this.updateAssessModel = false
        this.$refs.updateAssess.resetFields()
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
    delete this.updateAssess.account
    this.axiosbusiness.update(this,{
      ref:'updateAssess',
      url:'/assess/update',
      requestObject:'updateAssess',
      loading:'updateLoading',
      showModel:'updateAssessModel'
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
    this.deleteAssess={
      "assessId":params.assessId
    };
    this.axiosbusiness.delete(this,{
      url:'/assess/delete',
      requestObject:'deleteAssess'
    })
    }
  },
  created () {
    this.selectPage(JSON.parse(this.$route.params.pathParams).currentPage)
    
  },
  mounted () {

  }
}
</script>
