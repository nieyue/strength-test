<!--文章管理 -->
<template>
    <div class="body-wrap">
    <div class="body-btn-wrap">
      <Button type='primary'  @click='add'>增加文章</Button>
    </div>
		 <!--新增 -->
     <Modal v-model="addArticleModel"
           title="新增文章管理"
           :closable="false"
           :mask-closable="false"
           width="1000px"
    >
      <Form ref="addArticle" :model="addArticle" :label-width="100"  label-position="right"  :rules="addArticleRules">
        <FormItem prop="articleCateId" label="文章类型:">
          <Select v-model="addArticle.articleCateId" size="large" style="width:100px">
              <Option v-for="item in articleCateList" :value="item.articleCateId" :key="item.articleCateId">{{ item.name }}</Option>
          </Select>
        </FormItem>
        <FormItem prop="title" label="标题:">
          <Input type="text" v-model="addArticle.title" placeholder="标题">
          </Input>
        </FormItem>
        <FormItem prop="subtitle" label="子标题:">
          <Input type="text" v-model="addArticle.subtitle" placeholder="子标题">
          </Input>
        </FormItem>
        <FormItem prop="resource" label="来源:">
          <Input type="text" v-model="addArticle.resource" placeholder="来源">
          </Input>
        </FormItem>
         <FormItem prop="imgAddress" label="封面(上传或者填写):">
            <my-upload :defaultUpload="addArticle.imgAddress" @uploadList="getAddImgAddress"></my-upload>
            <div>
              <Input type="text" v-model="addArticle.imgAddress" placeholder="封面">
            </Input>
              <img :src="addArticle.imgAddress"  style='width:300px;'alt="">
            </div>
        </FormItem>
        <FormItem prop="redirectUrl" label="跳转url:">
          <Input type="text" v-model="addArticle.redirectUrl" placeholder="跳转url">
          </Input>
        </FormItem>
        <FormItem prop="status" label="状态:">
          <Select v-model="addArticle.status" transfer size="large" style="width:100px">
              <Option v-for="item in statusList" :value="item.id" :key="item.id">{{ item.value }}</Option>
          </Select>
        </FormItem>
        <FormItem prop="content" label="内容:">
          <my-wangeditor  :content="addArticle.content" @getWangEditorContent="getAddEditor"></my-wangeditor>
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
     <Modal v-model="updateArticleModel"
           title="修改文章管理"
           :closable="false"
           :mask-closable="false"
           width="1000px"
    >
      <Form ref="updateArticle" :model="updateArticle" :label-width="100" label-position="right"  :rules="updateArticleRules">
        <FormItem prop="articleCateId" label="文章类型:">
          <Select v-model="updateArticle.articleCateId" size="large" style="width:100px">
              <Option v-for="item in articleCateList" :value="item.articleCateId" :key="item.articleCateId">{{ item.name }}</Option>
          </Select>
        </FormItem>
        <FormItem prop="title" label="标题:">
          <Input type="text" v-model="updateArticle.title" placeholder="标题">
          </Input>
        </FormItem>
          <FormItem prop="subtitle" label="子标题:">
          <Input type="text" v-model="updateArticle.subtitle" placeholder="子标题">
          </Input>
        </FormItem>
        <FormItem prop="resource" label="来源:">
          <Input type="text" v-model="updateArticle.resource" placeholder="来源">
          </Input>
        </FormItem>
        <FormItem prop="imgAddress" label="封面(上传或者填写):">
            <my-upload :defaultUpload="updateArticle.imgAddress" @uploadList="getUpdateImgAddress"></my-upload>
            <div>
              <Input type="text" v-model="updateArticle.imgAddress" placeholder="封面">
            </Input>
              <img :src="updateArticle.imgAddress"  style='width:300px;'alt="">
            </div>
        </FormItem>
        <FormItem prop="redirectUrl" label="跳转url:">
          <Input type="text" v-model="updateArticle.redirectUrl" placeholder="跳转url">
          </Input>
        </FormItem>
        <FormItem prop="status" label="状态:">
          <Select v-model="updateArticle.status" transfer size="large" style="width:100px">
              <Option v-for="item in statusList" :value="item.id" :key="item.id">{{ item.value }}</Option>
          </Select>
        </FormItem>
        <FormItem prop="content" label="内容:">
          <my-wangeditor  :content="updateArticle.content" @getWangEditorContent="getUpdateEditor"></my-wangeditor>
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
      <Table border height="600" :columns='articleColumns' :data='articleList' ref='table' size="small"></Table>
        <div style='display: inline-block;float: right; margin-top:10px;'>
        <Page style='margin-right:10px;' @on-page-size-change="onPageSizeChange" show-sizer :page-size-opts='params.pageSizeOpts' :current="params.currentPage" :total='params.total' :pageSize='params.pageSize' ref='page' :show-total='true'  @on-change='selectPage' show-elevator ></Page>
      </div>
    </div>
</template>
<script>
export default {
  name: 'Article',
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
      //状态
      statusList:[
        {id:1,value:'上架'},
        {id:2,value:'下架'},
        ],
			//增加参数
			addArticleModel:false,
			addLoading:false,
			addArticleRules: {
                title: [
                    {required: true, message: '名称为必填项', trigger: 'blur'}
                    ]
                },
			addArticle:{
    		   title:"",
    		   subtitle:"",
    		   imgAddress:"",
           redirectUrl:"",
    		   status:1,
    		   content:"",
    		   articleCateId:""
			},
			//修改参数
			updateArticleModel:false,
			updateLoading:false,
			updateArticleRules: {
                title: [
                    {required: true, message: '名称为必填项', trigger: 'blur'}
                    ]
                },
			updateArticle:{
      },
      //删除参数
      deleteArticle:{},
      //列表
	    articleCateList: [],
      articleList: [],
	    articleColumns: [
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
          title: '文章id',
          key: 'articleId',
          align:'center'
        },
        {
        	title:'文章名称',
        //	key:'title',
          align:'center',
          render:(h,params)=>{
            return h('span',params.row.title.substr(0,10));
          }
        },
        {
        	title:'文章子标题',
        //	key:'subtitle',
          align:'center',
          render:(h,params)=>{
            return h('span',params.row.subtitle.substr(0,10));
          }
        },
        {
        	title:'来源',
        	key:'resource',
          align:'center'
        },
         {
        	title:'封面',
        	key:'imgAddress',
          align:'center',
          render: (h, params) => {
            return h('img', {
              attrs: {
                src: params.row.imgAddress
              },
              style: {
                width: '45px'
              }
            })
          }
        },
        {
        	title:'跳转url',
        	key:'redirectUrl',
          align:'center'
        },
        {
        	title:'阅读数',
        	key:'readingNumber',
          align:'center'
        },
        {
        	title:'状态',
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
     })
      this.$router.push(this.$route.path.substr(0,this.$route.path.indexOf(this.$route.params.pathParams))+pp);
      this.getList()
    },
    //切换每页条数时的回调，返回切换后的每页条数
    onPageSizeChange(pageSize){
      this.getList(pageSize)
    },
     //获取增加的图片
    getAddImgAddress(data){
      this.addArticle.imgAddress=data[0].url
    },
    //获取修改的图片
    getUpdateImgAddress(data){
      this.updateArticle.imgAddress=data[0].url
    },
    //获取增加的编辑器内容
    getAddEditor(data){
      this.addArticle.content=data
    },
    //获取修改的编辑器内容
    getUpdateEditor(data){
      this.updateArticle.content=data
    },
  //获取列表
   getArticleCateList () {
     /**
     * 获取列表
     * $this  vue组件
     * p.countUrl 数量url
     * p.listUrl 列表url
     * p.data 返回列表
     */
     this.params.pageSize=1000000;
     this.axiosbusiness.getList(this,{
       countUrl:'/articleCate/count',
       listUrl:'/articleCate/list',
       data:'articleCateList',
       success:()=>{
           this.params.pageSize=10;
           this.selectPage(JSON.parse(this.$route.params.pathParams).currentPage)
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
     this.axiosbusiness.getList(this,{
       countUrl:'/article/count',
       listUrl:'/article/list',
       data:'articleList'
     },this.params)
    },
  //增加
	 add (params) {
      this.addArticleModel = true
      this.addArticle.content=' '
      this.addArticle.articleCateId=this.articleCateList.length>0?this.articleCateList[0].articleCateId:null
    },
		//增加取消
		 addCancel () {
      if (!this.addLoading) {
        this.addArticleModel = false
        this.$refs.addArticle.resetFields()
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
      ref:'addArticle',
      url:'/article/add',
      requestObject:'addArticle',
      loading:'addLoading',
      showModel:'addArticleModel'
    })
    },
	 update (params) {
      this.updateArticleModel = true
      this.updateArticle.articleId = params.articleId
      this.updateArticle.articleCateId = params.articleCateId
       //获取修改实体
      this.axiosbusiness.get(this,{
         url:'/article/load?articleId='+params.articleId,
         data:'updateArticle',
         })
    },
		//修改取消
		 updateCancel () {
      if (!this.updateLoading) {
        this.updateArticleModel = false
        this.$refs.updateArticle.resetFields()
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
      ref:'updateArticle',
      url:'/article/update',
      requestObject:'updateArticle',
      loading:'updateLoading',
      showModel:'updateArticleModel'
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
    this.deleteArticle={
      "articleId":params.articleId
    };
    this.axiosbusiness.delete(this,{
      url:'/article/delete',
      requestObject:'deleteArticle'
    })
    }
  },
  created () {
    this.getArticleCateList();
  },
  mounted () {

  }
}
</script>
