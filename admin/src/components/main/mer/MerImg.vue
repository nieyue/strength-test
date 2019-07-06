<!--商品图片管理 -->
<template>
    <div class="body-wrap">
    <div class="body-btn-wrap">
      <Button type='primary'  @click='add'>增加商品图片</Button>
    </div>
		 <!--新增 -->
     <Modal v-model="addMerImgModel"
           title="新增商品图片管理"
           :closable="false"
           :mask-closable="false"
    >
      <Form ref="addMerImg" :model="addMerImg" :label-width="100" label-position="right"  :rules="addMerImgRules">
         <FormItem prop="number" label="图片顺序:">
          <InputNumber :max="1000000000" :min="1"  :precision='0' v-model="addMerImg.number"></InputNumber>
        </FormItem>
        <FormItem prop="imgAddress" label="商品图片(上传或者填写):">
           <my-upload :defaultUpload="addMerImg.imgAddress" @uploadList="getAddImgAddress"></my-upload>
          <div>
            <Input type="text" v-model="addMerImg.imgAddress" placeholder="商品图片">
          </Input>
             <img :src="addMerImg.imgAddress"  style='width:200px;'alt="">
          </div>
        </FormItem>
      </Form>
      <div slot='footer'>
        <Button @click='addCancel'>取消</Button>
        <Button type='primary' :loading='addLoading'>
          <span v-if="!addLoading" @click='addSure'>确定</span>
          <span v-else>Loading...</span>
        </Button>
      </div>
    </Modal>
    <!--新增end -->
		 <!--修改 -->
     <Modal v-model="updateMerImgModel"
           title="修改商品图片管理"
           :closable="false"
           :mask-closable="false"
    >
      <Form ref="updateMerImg" :model="updateMerImg" :label-width="100" label-position="right"  :rules="updateMerImgRules">
       <FormItem prop="number" label="图片顺序:">
          <InputNumber :max="1000000000" :min="1"  :precision='0' v-model="updateMerImg.number"></InputNumber>
        </FormItem>
        <FormItem prop="imgAddress" label="商品图片(上传或者填写):">
           <my-upload :defaultUpload="updateMerImg.imgAddress" @uploadList="getUpdateImgAddress"></my-upload>
          <div>
            <Input type="text" v-model="updateMerImg.imgAddress" placeholder="商品图片">
          </Input>
             <img :src="updateMerImg.imgAddress"  style='width:200px;'alt="">
          </div>
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
      <Table border  :columns='merImgColumns' :data='merImgList' ref='table' size="small"></Table>
        <div style='display: inline-block;float: right; margin-top:10px;'>
        <Page style='margin-right:10px;' @on-page-size-change="onPageSizeChange" show-sizer :page-size-opts='params.pageSizeOpts' :current="params.currentPage" :total='params.total' :pageSize='params.pageSize' ref='page' :show-total='true'   @on-change='selectPage' show-elevator ></Page>
      </div>
    </div>
    
</template>
<script>
export default {
  name: 'MerImg',
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
			addMerImgModel:false,
			addLoading:false,
			addMerImgRules: {
                },
			addMerImg:{
                number:1,
                imgAddress:''
			},
			//修改参数
			updateMerImgModel:false,
			updateLoading:false,
			updateMerImgRules: {
                },
			updateMerImg:{},
      //删除参数
      deleteMerImg:{},
	    merImgList: [],
	    merImgColumns: [
        {
          title: '序号',
          align:'center',
          render: (h, params) => {
            return h('span', params.index
            +(this.params.currentPage-1)*this.params.pageSize+this.params.startNum);
          }
        },
        {
          title: '商品图片id',
          key: 'merImgId',
          align:'center'
        },
        {
        	title:'图片顺序',
            key:'number',
            align:'center'
        },
          {
        	title:'图片',
            key:'imgAddress',
            width:100,
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
          title:'创建时间',
          key:'createDate',
          sortable: true,
          align:'center'
        },
        {
          title:'更新时间',
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
              varhh1
              ,varhh2
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
        merId:JSON.parse(this.$route.params.pathParams).merId
     })
     //console.log(this.$route.path.substr(0,this.$route.path.indexOf(this.$route.params.pathParams)))
      this.$router.push(this.$route.path.substr(0,this.$route.path.indexOf(this.$route.params.pathParams))+pp);
      this.getList()
    },
       //获取增加的图片
    getAddImgAddress(data){
      this.addMerImg.imgAddress=data[0].url
    },
    //获取修改的图片
    getUpdateImgAddress(data){
      this.updateMerImg.imgAddress=data[0].url
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
    this.params.merId=JSON.parse(this.$route.params.pathParams).merId
     this.axiosbusiness.getList(this,{
       countUrl:'/merImg/count',
       listUrl:'/merImg/list',
       data:'merImgList'
     },this.params)
    },
  //增加
	 add (params) {
      this.addMerImgModel = true
    },
		//增加取消
		 addCancel () {
      if (!this.addLoading) {
        this.addMerImgModel = false
        this.$refs.addMerImg.resetFields()
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
   this.addMerImg.merId=JSON.parse(this.$route.params.pathParams).merId
    this.axiosbusiness.add(this,{
      ref:'addMerImg',
      url:'/merImg/add',
      requestObject:'addMerImg',
      loading:'addLoading',
      showModel:'addMerImgModel'
    })
    },
	 update (params) {
      this.updateMerImgModel = true
     //获取修改实体
      this.axiosbusiness.get(this,{
         url:'/merImg/load?merImgId='+params.merImgId,
         data:'updateMerImg',
       })
    },
		//修改取消
		 updateCancel () {
      if (!this.updateLoading) {
        this.updateMerImgModel = false
        this.$refs.updateMerImg.resetFields()
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
      ref:'updateMerImg',
      url:'/merImg/update',
      requestObject:'updateMerImg',
      loading:'updateLoading',
      showModel:'updateMerImgModel'
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
    this.deleteMerImg={
      "merImgId":params.merImgId
    };
    this.axiosbusiness.delete(this,{
      url:'/merImg/delete',
      requestObject:'deleteMerImg'
    })
    }
  },
  watch: {
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
