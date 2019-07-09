<!--项目管理 -->
<template>
    <div class="body-wrap">
    <div class="body-btn-wrap">
      <Button type='primary'  @click='add'>增加项目</Button>
      <!-- <Button type='error'  @click='deleteBatch'>批量删除</Button> -->
    </div>
		 <!--新增 -->
     <Modal v-model="addProjectModel"
           title="新增项目管理"
           :closable="false"
           :mask-closable="false"
    >
      <Form ref="addProject" :model="addProject" :label-width="100" label-position="right"  :rules="addProjectRules">
        <FormItem prop="name" label="名称:">
          <Input type="text" v-model="addProject.name" placeholder="名称">
          </Input>
        </FormItem>
        <FormItem prop="icon" label="图标(上传或者填写):">
           <my-upload :defaultUpload="addProject.icon" @uploadList="getAddIcon"></my-upload>
          <div>
            <Input type="text" v-model="addProject.icon" placeholder="图标">
          </Input>
             <img :src="addProject.icon"  style='width:200px;'alt="">
          </div>
        </FormItem>
        <FormItem prop="unit" label="单位:">
          <Input type="text" v-model="addProject.unit" placeholder="单位">
          </Input>
        </FormItem>
        <FormItem label="简介:" prop="summary">
            <Input v-model="addProject.summary" type="textarea" :autosize="{minRows: 2,maxRows: 5}" placeholder="输入简介。。"></Input>
        </FormItem>
      </Form>
      <div slot="footer">
        <Button @click='addCancel'>取消</Button>
        <Button type='primary' :loading='addLoading'>
          <span v-if="!addLoading" @click='addSure'>确定</span>
          <span v-else>Loading...</span>
        </Button>
      </div>
    </Modal>
    <!--新增end -->
		 <!--修改 -->
     <Modal v-model="updateProjectModel"
           title="修改项目管理"
           :closable="false"
           :mask-closable="false"
    >
      <Form ref="updateProject" :model="updateProject" :label-width="100" label-position="right"  :rules="updateProjectRules">
        <FormItem prop="name" label="名称:">
          <Input type="text" v-model="updateProject.name" placeholder="名称">
          </Input>
        </FormItem>
        <FormItem prop="icon" label="图标(上传或者填写):">
           <my-upload :defaultUpload="updateProject.icon" @uploadList="getUpdateIcon"></my-upload>
          <div>
            <Input type="text" v-model="updateProject.icon" placeholder="图标">
          </Input>
             <img :src="updateProject.icon"  style='width:200px;'alt="">
          </div>
        </FormItem>
         <FormItem prop="unit" label="单位:">
          <Input type="text" v-model="updateProject.unit" placeholder="单位">
          </Input>
        </FormItem>
        <FormItem label="简介:" prop="summary">
            <Input v-model="updateProject.summary" type="textarea" :autosize="{minRows: 2,maxRows: 5}" placeholder="输入简介。。"></Input>
        </FormItem>
      </Form>
      <div slot='footer'>
        <Button @click='updateCancel'>取消</Button>
        <Button type='primary' :loading='updateLoading'>
          <span v-if="!updateLoading" @click='updateSure'>确定</span>
          <span v-else>Loading...</span>
        </Button>
      </div>
    </Modal>
    <!--修改end -->
      <Table border :columns='projectColumns' :data='projectList' ref='table' size="small"></Table>
        <div style='display: inline-block;float: right; margin-top:10px;'>
        <Page style='margin-right:10px;' @on-page-size-change="onPageSizeChange" show-sizer :page-size-opts='params.pageSizeOpts' :current="params.currentPage" :total='params.total' :pageSize='params.pageSize' ref='page' :show-total='true'   @on-change='selectPage' show-elevator ></Page>
      </div>
    </div>
</template>
<script>
export default {
  name: 'Project',
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
			//增加参数
			addProjectModel:false,
			addLoading:false,
			addProjectRules: {
                name: [
                    {required: true, message: '名称为必填项', trigger: 'blur'}
                    ]
                },
			addProject:{
           "name":"",
           icon:'',
			},
			//修改参数
			updateProjectModel:false,
			updateLoading:false,
			updateProjectRules: {
                name: [
                    {required: true, message: '名称为必填项', trigger: 'blur'}
                    ]
                },
			updateProject:{
    		 "projectId":1,
    		 "name":""
      },
      //删除参数
      deleteProject:{},
	    projectList: [],
	    projectColumns: [
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
          title: '项目id',
          key: 'projectId',
          align:'center'
        },
        {
        	title:'名称',
        	key:'name',
          align:'center'
        },
        {
        	title:'图标',
        	key:'icon',
          align:'center',
          render:(h,params)=>{
            return h('img', {
              attrs: {
                src: params.row.icon
              },
              style: {
                width: '45px'
              }
            })
          }
        },
        {
        	title:'单位',
        	key:'unit',
          align:'center'
        },
        {
        	title:'简介',
        	key:'summary',
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
                  marginLeft: '10px'
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
                  marginLeft: '10px'
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
    //分页点击
    selectPage (currentPage) {
      this.params.currentPage=currentPage;
      this.params.pageNum = (this.params.currentPage-1)*this.params.pageSize+this.params.startNum;
      //构造path
     let pp=JSON.stringify({
       currentPage:currentPage,
       accountId:JSON.parse(this.$route.params.pathParams).accountId
     })
     //console.log(this.$route.path.substr(0,this.$route.path.indexOf(this.$route.params.pathParams)))
      this.$router.push(this.$route.path.substr(0,this.$route.path.indexOf(this.$route.params.pathParams))+pp);
      this.getList()
    },
    //获取增加的图标
    getAddIcon(data){
      this.addProject.icon=data[0].url
    },
    //获取修改的图标
    getUpdateIcon(data){
      this.updateProject.icon=data[0].url
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
     this.axiosbusiness.getList(this,{
       countUrl:'/project/count',
       listUrl:'/project/list',
       data:'projectList'
     },this.params)
    },
  //增加
	 add (params) {
      this.addProjectModel = true
      this.addProject.name = params.name
    },
		//增加取消
		 addCancel () {
       if (!this.addLoading) {
         this.addProjectModel = false
        this.$refs.addProject.resetFields()
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
      ref:'addProject',
      url:'/project/add',
      requestObject:'addProject',
      loading:'addLoading',
      showModel:'addProjectModel'
    })
    },
	 update (params) {
      this.updateProjectModel = true
      this.updateProject.name = params.name
      this.updateProject.icon = params.icon
      this.updateProject.unit = params.unit
      this.updateProject.summary = params.summary
      this.updateProject.projectId = params.projectId
    },
		//修改取消
		 updateCancel () {
      if (!this.updateLoading) {
        this.updateProjectModel = false
        this.$refs.updateProject.resetFields()
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
    this.axiosbusiness.update(this,{
      ref:'updateProject',
      url:'/project/update',
      requestObject:'updateProject',
      loading:'updateLoading',
      showModel:'updateProjectModel'
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
    this.deleteProject={
      "projectId":params.projectId
    };
    this.axiosbusiness.delete(this,{
      url:'/project/delete',
      requestObject:'deleteProject'
    })
    },
    //批量删除
    deleteBatch(){
      //获取删除对象数组
     // console.log(this.$refs.table.getSelection())
    }
  }, watch: {
    //当前页面参数修改动态启动
      $route (to,from){
        this.selectPage(JSON.parse(this.$route.params.pathParams).currentPage)
      }
    },
  created () {
    this.selectPage(JSON.parse(this.$route.params.pathParams).currentPage)
  },
  mounted () {

  }
}
</script>