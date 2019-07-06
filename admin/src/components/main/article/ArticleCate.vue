<!--文章分类管理 -->
<template>
    <div class="body-wrap">
    <div class="body-btn-wrap">
      <Button type='primary'  @click='add'>增加文章分类</Button>
      <!-- <Button type='error'  @click='deleteBatch'>批量删除</Button> -->
    </div>
		 <!--新增 -->
     <Modal v-model="addArticleCateModel"
           title="新增文章分类管理"
           :closable="false"
           :mask-closable="false"
    >
      <Form ref="addArticleCate" :model="addArticleCate" :label-width="100" label-position="right"  :rules="addArticleCateRules">
        <FormItem prop="name" label="分类名称:">
          <Input type="text" v-model="addArticleCate.name" placeholder="分类名称">
          </Input>
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
     <Modal v-model="updateArticleCateModel"
           title="修改文章分类管理"
           :closable="false"
           :mask-closable="false"
    >
      <Form ref="updateArticleCate" :model="updateArticleCate" :label-width="100" label-position="right"  :rules="updateArticleCateRules">
        <FormItem prop="name" label="分类名称:">
          <Input type="text" v-model="updateArticleCate.name" placeholder="分类名称">
          </Input>
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
      <Table border :columns='articleCateColumns' :data='articleCateList' ref='table' size="small"></Table>
        <div style='display: inline-block;float: right; margin-top:10px;'>
        <Page style='margin-right:10px;' @on-page-size-change="onPageSizeChange" show-sizer :page-size-opts='params.pageSizeOpts' :current="params.currentPage" :total='params.total' :pageSize='params.pageSize' ref='page' :show-total='true'   @on-change='selectPage' show-elevator ></Page>
      </div>
    </div>
</template>
<script>
export default {
  name: 'ArticleCate',
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
			addArticleCateModel:false,
			addLoading:false,
			addArticleCateRules: {
                name: [
                    {required: true, message: '分类名称为必填项', trigger: 'blur'}
                    ]
                },
			addArticleCate:{
    		   "name":""
			},
			//修改参数
			updateArticleCateModel:false,
			updateLoading:false,
			updateArticleCateRules: {
                name: [
                    {required: true, message: '分类名称为必填项', trigger: 'blur'}
                    ]
                },
			updateArticleCate:{
    		 "articleCateId":1,
    		 "name":""
      },
      //删除参数
      deleteArticleCate:{},
	    articleCateList: [],
	    articleCateColumns: [
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
          title: '文章分类id',
          key: 'articleCateId',
          align:'center'
        },
        {
        	title:'文章分类名称',
        	key:'name',
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
       countUrl:'/articleCate/count',
       listUrl:'/articleCate/list',
       data:'articleCateList'
     },this.params)
    },
  //增加
	 add (params) {
      this.addArticleCateModel = true
      this.addArticleCate.name = params.name
    },
		//增加取消
		 addCancel () {
       if (!this.addLoading) {
         this.addArticleCateModel = false
        this.$refs.addArticleCate.resetFields()
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
      ref:'addArticleCate',
      url:'/articleCate/add',
      requestObject:'addArticleCate',
      loading:'addLoading',
      showModel:'addArticleCateModel'
    })
    },
	 update (params) {
      this.updateArticleCateModel = true
      this.updateArticleCate.name = params.name
      this.updateArticleCate.articleCateId = params.articleCateId
    },
		//修改取消
		 updateCancel () {
      if (!this.updateLoading) {
        this.updateArticleCateModel = false
        this.$refs.updateArticleCate.resetFields()
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
      ref:'updateArticleCate',
      url:'/articleCate/update',
      requestObject:'updateArticleCate',
      loading:'updateLoading',
      showModel:'updateArticleCateModel'
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
    this.deleteArticleCate={
      "articleCateId":params.articleCateId
    };
    this.axiosbusiness.delete(this,{
      url:'/articleCate/delete',
      requestObject:'deleteArticleCate'
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