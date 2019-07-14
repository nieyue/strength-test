<!--单项测评管理 -->
<template>
    <div class="body-wrap">
    <div class="body-btn-wrap">
      <Button type='primary'  @click='add'>增加单项测评</Button>
      <div class="search-wrap">
        <Select v-model="params.projectId"  transfer class="search-wrap-input" placeholder="项目，全部">
            <Option v-for="item in projectList" :value="item.projectId" :key="item.projectId">{{ item.name }}</Option>
        </Select>
        <Select v-model="params.rank" transfer class="search-wrap-input"  placeholder="等级，全部">
            <Option v-for="item in rankParamsList" :value="item.id" :key="item.id">{{ item.value }}</Option>
        </Select>
        <Button @click="search" type="info"  >查询</Button>
      </div>
    </div>
		 <!--新增 -->
     <Modal v-model="addAssessProjectModel"
           title="新增单项测评管理"
           :closable="false"
           :mask-closable="false"
           width="1000px"
    >
      <Form ref="addAssessProject" :model="addAssessProject" :label-width="100"  label-position="right"  :rules="addAssessProjectRules">
          <!-- <template >
              <div  v-for="(item,index) in addProjectList" :value="item.projectId" :key="item.projectId">
                  <div>{{item.name}}</div>
                  <FormItem prop="score" label="分数:">
                    <InputNumber :max="1000000000" :min="-9999999"  :precision='2'  v-model="item.score"></InputNumber>
                  </FormItem>
              </div>
          </template> -->
        <FormItem prop="projectId" label="项目:">
          <RadioGroup v-model="addAssessProject.projectId" type="button" @click="addUnitClick(item)" >
              <Radio style="margin:5px;" :label="item.projectId" 
              v-for="item in projectList" :value="item.projectId" :key="item.projectId" >
                  {{item.name}}
              </Radio>
          </RadioGroup>
        </FormItem>
        <FormItem prop="score" label="结果值:">
            <InputNumber :max="1000000000" :min="-9999999"  :precision='2'  v-model="addAssessProject.score"></InputNumber>
             {{addUnit}}
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
     <Modal v-model="updateAssessProjectModel"
           title="修改单项测评管理"
           :closable="false"
           :mask-closable="false"
           width="1000px"
    >
      <Form ref="updateAssessProject" :model="updateAssessProject" :label-width="100" label-position="right"  :rules="updateAssessProjectRules">
        <!-- <template >
              <div  v-for="item in updateProjectList" :value="item.projectId" :key="item.projectId">
                  <div>{{item.name}}</div>
                  <FormItem prop="score" label="分数:">
                    <InputNumber :max="1000000000" :min="-9999999"  :precision='2'  v-model="item.score"></InputNumber>
                  </FormItem>
              </div>
          </template> -->
          <FormItem prop="projectId" label="项目:">
          <RadioGroup v-model="updateAssessProject.projectId" type="button" >
              <Radio style="margin:5px;" :label="item.projectId" @click="updateUnitClick(item)"
              v-for="item in projectList" :value="item.projectId" :key="item.projectId" >
                  {{item.name}}
              </Radio>
          </RadioGroup>
        </FormItem>
        <FormItem prop="score" label="结果值:">
            <InputNumber :max="1000000000" :min="-9999999"  :precision='2'  v-model="updateAssessProject.score"></InputNumber>
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
      <Table border height="600" :columns='assessProjectColumns' :data='assessProjectList' ref='table' size="small"></Table>
        <div style='display: inline-block;float: right; margin-top:10px;'>
        <Page style='margin-right:10px;' @on-page-size-change="onPageSizeChange" show-sizer :page-size-opts='params.pageSizeOpts' :current="params.currentPage" :total='params.total' :pageSize='params.pageSize' ref='page' :show-total='true'  @on-change='selectPage' show-elevator ></Page>
      </div>
    </div>
</template>
<script>
export default {
  name: 'AssessProject',
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
        //等级,1不良,2未达,3合格,4良好,5优秀
      rankParamsList:[
        {id:'',value:'全部'},
        {id:1,value:'不良'},
        {id:2,value:'未达'},
        {id:3,value:'合格'},
        {id:4,value:'良好'},
        {id:5,value:'优秀'},
        ],
			//增加参数
			addAssessProjectModel:false,
			addLoading:false,
			addAssessProjectRules: {
                 score: [
                    {type:'number',required: true, message: '分数为必填项', trigger: 'change'}
                    ] 
                },
			addAssessProject:{
                score:0
			},
			//修改参数
			updateAssessProjectModel:false,
			updateLoading:false,
			updateAssessProjectRules: {
                 score: [
                    {type:'number',required: true, message: '分数为必填项', trigger: 'change'}
                    ] 
                },
			updateAssessProject:{
      },
      //删除参数
      deleteAssessProject:{},
      //列表
      addUnit:'',
      updateUnit:'',
	    addProjectList: [],
	    updateProjectList: [],
	    projectList: [],
        assessProjectList: [],
	    assessProjectColumns: [
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
          title: '单项测评id',
          key: 'assessProjectId',
          align:'center'
        },
        {
        	title:'项目',
          align:'center',
          render:(h,params)=>{
            return h('div',params.row.project.name)
          }
        },
        {
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
        	title:'结果值',
        	key:'score',
          align:'center'
        },
        {
        	title:'项',
        	key:'item',
          align:'center'
        },
        {
        	title:'创建时间',
          key:'createDate',
          sortable: true,
          align:'center'
        },
        {
        	title:'修改时间',
          key:'updateDate',
          sortable: true,
          align:'center'
        },
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
            	var s=h("div","");
			s=h("div",[
              varhh1,
              varhh2
            ]);
            return s;
          }
        }
      ],
    }
  },
  methods: {
    addUnitClick(item){
      console.log(item)
      this.addUnit=item.unit
    },
    updateUnitClick(item){
      this.updateUnit=item.unit
    },
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
       assessId:JSON.parse(this.$route.params.pathParams).assessId,
     })
      this.$router.push(this.$route.path.substr(0,this.$route.path.indexOf(this.$route.params.pathParams))+pp);
      this.getList()
    },
    //切换每页条数时的回调，返回切换后的每页条数
    onPageSizeChange(pageSize){
      this.getList(pageSize)
    },
  //获取列表
   getProjectList () {
     /**
     * 获取列表
     * $this  vue组件
     * p.countUrl 数量url
     * p.listUrl 列表url
     * p.data 返回列表
     */
     this.params.pageSize=1000000;
     this.axiosbusiness.getList(this,{
       countUrl:'/project/count',
       listUrl:'/project/list',
       data:'projectList',
       success:()=>{
           this.addProjectList=JSON.parse(JSON.stringify(this.projectList))
           this.updateProjectList=JSON.parse(JSON.stringify(this.projectList))
           this.params.pageSize=10;
           this.selectPage(JSON.parse(this.$route.params.pathParams).currentPage)
           this.params.age?'':this.params.age=null;
       }
     },
    this.params)
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
      this.params.assessId=JSON.parse(this.$route.params.pathParams).assessId
     this.axiosbusiness.getList(this,{
       countUrl:'/assessProject/count',
       listUrl:'/assessProject/list',
       data:'assessProjectList',
       success:()=>{
         this.params.age?'':this.params.age=null;
       }
     },this.params)
    },
  //增加
	 add (params) {
      this.addAssessProjectModel = true
      this.addAssessProject.projectId=this.projectList.length>0?this.projectList[0].projectId:null
      this.addUnit=this.projectList.length>0?this.projectList[0].unit:null
    },
		//增加取消
		 addCancel () {
      if (!this.addLoading) {
        this.addAssessProjectModel = false
        this.$refs.addAssessProject.resetFields()
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
    this.addAssessProject.assessId=JSON.parse(this.$route.params.pathParams).assessId
    this.axiosbusiness.add(this,{
      ref:'addAssessProject',
      url:'/assessProject/add',
      requestObject:'addAssessProject',
      loading:'addLoading',
      showModel:'addAssessProjectModel'
    })
    },
	 update (params) {
      this.updateAssessProjectModel = true
      this.updateAssessProject.assessProjectId = params.assessProjectId
      this.updateAssessProject.projectId = params.projectId
       //获取修改实体
      this.axiosbusiness.get(this,{
         url:'/assessProject/load?assessProjectId='+params.assessProjectId,
         data:'updateAssessProject',
         })
    },
		//修改取消
		 updateCancel () {
      if (!this.updateLoading) {
        this.updateAssessProjectModel = false
        this.$refs.updateAssessProject.resetFields()
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
    delete this.updateAssessProject.project
    delete this.updateAssessProject.assess
    this.axiosbusiness.update(this,{
      ref:'updateAssessProject',
      url:'/assessProject/update',
      requestObject:'updateAssessProject',
      loading:'updateLoading',
      showModel:'updateAssessProjectModel'
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
    this.deleteAssessProject={
      "assessProjectId":params.assessProjectId
    };
    this.axiosbusiness.delete(this,{
      url:'/assessProject/delete',
      requestObject:'deleteAssessProject'
    })
    }
  },
  created () {
    this.getProjectList();
    
  },
  mounted () {

  }
}
</script>
