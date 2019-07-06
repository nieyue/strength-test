<!--商品管理 -->
<template>
    <div class="body-wrap">
    <div class="body-btn-wrap">
       <Button type='primary'  @click='add'>增加商品</Button>
       <div class="search-wrap">
          <div>
            <label for="">类型：</label>
            <RadioGroup v-model="params.type" type="button" >
                <Radio style="margin:5px;" :label="item.id" 
                v-for="item in typeParamsList" :value="item.id" :key="item.id" >
                    {{item.value}}
                </Radio>
            </RadioGroup>
          </div>
          <div>
            <label for="">推荐：</label>
            <RadioGroup v-model="params.recommend" type="button" >
                <Radio style="margin:5px;" :label="item.id" 
                v-for="item in recommendParamsList" :value="item.id" :key="item.id" >
                    {{item.value}}
                </Radio>
            </RadioGroup>
          </div>
          <div>
            <label for="">状态：</label>
            <RadioGroup v-model="params.status" type="button" >
                <Radio style="margin:5px;" :label="item.id" 
                v-for="item in statusParamsList" :value="item.id" :key="item.id" >
                    {{item.value}}
                </Radio>
            </RadioGroup>
          </div>
          <div>
          <Input v-model="params.name" class="search-wrap-input" placeholder="名称，模糊查询"></Input>
          <Input v-model="params.merCateId" class="search-wrap-input" placeholder="商品类型id"></Input>
          <Input v-model="params.sellerAccountId" class="search-wrap-input" placeholder="商户账户id"></Input>
          <Button @click="search" type="info"  >查询</Button>
          </div>
       </div>
    </div>
		 <!--新增 -->
     <Modal v-model="addMerModel"
           title="新增商品管理"
           :closable="false"
           :mask-closable="false"
           width="1000px"
    >
      <Form ref="addMer" :model="addMer" :label-width="100" label-position="right"  :rules="addMerRules">
        <FormItem prop="merCateId" label="商品类型:">
          <Select v-model="addMer.merCateId"  transfer size="large" style="width:100px">
              <Option v-for="item in merCateList" :value="item.merCateId" :key="item.merCateId">{{ item.name }}</Option>
          </Select>
        </FormItem>
        <FormItem prop="name" label="名称:">
          <Input type="text" v-model="addMer.name" placeholder="名称">
          </Input>
        </FormItem>
        <FormItem prop="summary" label="简介:">
          <Input type="textarea" v-model="addMer.summary" :autosize="{minRows: 2,maxRows: 5}"  placeholder="简介">
          </Input>
        </FormItem>
        <FormItem prop="imgAddress" label="封面(上传或者填写):">
            <my-upload :defaultUpload="addMer.imgAddress" @uploadList="getAddImgAddress"></my-upload>
            <div>
              <Input type="text" v-model="addMer.imgAddress" placeholder="封面">
            </Input>
              <img :src="addMer.imgAddress"  style='width:200px;'alt="">
            </div>
        </FormItem>
        <FormItem prop="recommend" label="推荐:">
          <Select v-model="addMer.recommend" transfer size="large" style="width:100px">
              <Option v-for="item in recommendList" :value="item.id" :key="item.id">{{ item.value }}</Option>
          </Select>
        </FormItem>
        <FormItem prop="oldUnitPrice" label="原始单价:">
          <InputNumber :max="1000000000" :min="0" @on-change="changeAddOldUnitPrice" :precision='2' v-model="addMer.oldUnitPrice"></InputNumber>元
        </FormItem>
        <FormItem prop="discount" label="折扣(0-1.00):">
          <InputNumber :max="1" :min="0" @on-change="changeAddDiscount"  :precision='2' v-model="addMer.discount"></InputNumber>
        </FormItem>
        <FormItem prop="unitPrice" label="单价:">
          <InputNumber :max="1000000000" :min="0"  :precision='2' :disabled="true" v-model="addMer.unitPrice"></InputNumber>元
        </FormItem>
        <FormItem prop="stockNumber" label="库存:">
          <InputNumber :max="1000000000" :min="0" :precision='0' v-model="addMer.stockNumber"></InputNumber>
        </FormItem>
         <FormItem prop="status" label="状态:">
          <Select v-model="addMer.status" transfer size="large" style="width:100px">
              <Option v-for="item in statusList" :value="item.id" :key="item.id">{{ item.value }}</Option>
          </Select>
        </FormItem>
        <FormItem prop="details" label="商品详情:">
          <my-wangeditor  :content="addMer.details" @getWangEditorContent="getAddDetails"></my-wangeditor>
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
     <Modal v-model="updateMerModel"
           title="修改商品管理"
           :closable="false"
           :mask-closable="false"
           width="1000px"
    >
      <Form ref="updateMer" :model="updateMer" :label-width="100" label-position="right"  :rules="updateMerRules">
        <FormItem prop="merCateId" label="商品类型:">
          <Select v-model="updateMer.merCateId"  transfer size="large" style="width:100px">
              <Option v-for="item in merCateList" :value="item.merCateId" :key="item.merCateId">{{ item.name }}</Option>
          </Select>
        </FormItem>
        <FormItem prop="name" label="名称:">
          <Input type="text" v-model="updateMer.name" placeholder="名称">
          </Input>
        </FormItem>
        <FormItem prop="summary" label="简介:">
          <Input type="textarea" v-model="updateMer.summary" :autosize="{minRows: 2,maxRows: 5}"  placeholder="简介">
          </Input>
        </FormItem>
        <FormItem prop="imgAddress" label="封面(上传或者填写):">
            <my-upload :defaultUpload="updateMer.imgAddress" @uploadList="getUpdateImgAddress"></my-upload>
            <div>
              <Input type="text" v-model="updateMer.imgAddress" placeholder="封面">
            </Input>
              <img :src="updateMer.imgAddress"  style='width:200px;'alt="">
            </div>
        </FormItem>
        <FormItem prop="recommend" label="推荐:">
          <Select v-model="updateMer.recommend" transfer size="large" style="width:100px">
              <Option v-for="item in recommendList" :value="item.id" :key="item.id">{{ item.value }}</Option>
          </Select>
        </FormItem>
        <FormItem prop="oldUnitPrice" label="原始单价:">
          <InputNumber :max="1000000000" :min="0" @on-change="changeUpdateOldUnitPrice" :precision='2' v-model="updateMer.oldUnitPrice"></InputNumber>元
        </FormItem>
        <FormItem prop="discount" label="折扣(0-1.00):">
          <InputNumber :max="1" :min="0" @on-change="changeUpdateDiscount"  :precision='2' v-model="updateMer.discount"></InputNumber>
        </FormItem>
        <FormItem prop="unitPrice" label="单价:">
          <InputNumber :max="1000000000" :min="0"  :precision='2' :disabled="true" v-model="updateMer.unitPrice"></InputNumber>元
        </FormItem>
        <FormItem prop="stockNumber" label="库存:">
          <InputNumber :max="1000000000" :min="0" :precision='0' v-model="updateMer.stockNumber"></InputNumber>
        </FormItem>
         <FormItem prop="status" label="状态:">
          <Select v-model="updateMer.status" transfer size="large" style="width:100px">
              <Option v-for="item in statusList" :value="item.id" :key="item.id">{{ item.value }}</Option>
          </Select>
        </FormItem>
        <FormItem prop="details" label="商品详情:">
          <my-wangeditor  :content="updateMer.details" @getWangEditorContent="getUpdateDetails"></my-wangeditor>
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
      <Table border height="500" :columns='merColumns' :data='merList' ref='table' size="small"></Table>
        <div style='display: inline-block;float: right; margin-top:10px;'>
        <Page style='margin-right:10px;'  @on-page-size-change="onPageSizeChange" show-sizer :page-size-opts='params.pageSizeOpts' :current="params.currentPage" :total='params.total' :pageSize='params.pageSize' ref='page' :show-total='true'   @on-change='selectPage' show-elevator ></Page>
      </div>
    </div>
</template>
<script>
export default {
  name: 'Mer',
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
          //类型，1普通商品，2降价商品，3预购商品
          typeParamsList:[
          {id:'',value:'全部'},
          {id:1,value:'普通商品'},
          {id:2,value:'降价商品'},
          {id:3,value:'预购商品'}
          ],
          //推荐，默认1不推，2封推，3推荐
          recommendParamsList:[
          {id:'',value:'全部'},
          {id:1,value:'不推'},
          {id:2,value:'封推'},
          {id:3,value:'推荐'}
          ],
        //状态0下架,默认1上架
        statusParamsList:[
          {id:'',value:'全部'},
          {id:1,value:'上架'},
          {id:2,value:'下架'}
          ],
          //类型，1普通商品，2降价商品，3预购商品
          typeList:[
          {id:1,value:'普通商品'},
          {id:2,value:'降价商品'},
          {id:3,value:'预购商品'}
          ],
          //推荐，默认1不推，2封推，3推荐
          recommendList:[
          {id:1,value:'不推'},
          {id:2,value:'封推'},
          {id:3,value:'推荐'}
          ],
      //状态
      statusList:[
          {id:1,value:'上架'},
          {id:2,value:'下架'}
        ],
			//增加参数
			addMerModel:false,
			addLoading:false,
			addMerRules: {
                name: [
                    {required: true, message: '商品名称为必填项', trigger: 'blur'}
                    ]
                },
			addMer:{
                
			},
			//修改参数
			updateMerModel:false,
			updateLoading:false,
			updateMerRules: {
                name: [
                    {required: true, message: '商品名称为必填项', trigger: 'blur'}
                    ]
                },
			updateMer:{
    		 "merId":1,
      },
      //删除参数
      deleteMer:{},
	    merCateList: [],
	    merList: [],
	    merColumns: [
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
          title: '商品id',
          minWidth:100,
          key: 'merId',
          align:'center'
        },
        {
        	title:'类型',
            key:'type',
             minWidth:100,
          align:'center',
          render: (h, params) => {
            let typevalue="";
            this.typeList.forEach(element => {
              if(element.id==params.row.type){
                typevalue=element.value;
              }
            });
             return  h('span',typevalue);
          }
        },
        {
        	title:'推荐',
            key:'recommend',
             minWidth:100,
          align:'center',
          render: (h, params) => {
            let recommendvalue="";
            this.recommendList.forEach(element => {
              if(element.id==params.row.recommend){
                recommendvalue=element.value;
              }
            });
             return  h('span',recommendvalue);
          }
        },
        {
          title:'商品名称',
          minWidth:100,
        	key:'name',
          align:'center'
        },
        {
        	title:'封面',
            key:'imgAddress',
            minWidth:100,
          align:'center',
          render: (h, params) => {
            return h('img', {
              attrs: {
                src: params.row.imgAddress
              },
              style: {
                width: '80px'
              }
            })
          }
        },
        {
        	title:'价格',
            minWidth:160,
          align:'center',
          render: (h, params) => {
            var div=[
               h('div',"原始单价:"+params.row.oldUnitPrice ),
               h('div',"折扣:"+params.row.discount ),
               h('div',"单价:"+params.row.unitPrice ),
            ];
            return h('div',{
              style:{
                textAlign:'left'
              }
            },div )
          }
        },
        {
        	title:'其他',
            minWidth:160,
          align:'center',
          render: (h, params) => {
            var div=[
               h('div',"库存:"+params.row.stockNumber ),
               h('div',"销量:"+params.row.saleNumber ),
               h('div',"评分:"+params.row.merScore ),
               h('div',"评论数:"+params.row.merCommentNumber ),
            ];
            return h('div',{
              style:{
                textAlign:'left'
              }
            },div )
          }
        },
        {
        	title:'状态',
            key:'status',
             minWidth:100,
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
          title:'修改时间',
          minWidth:100,
          key:'updateDate',
          sortable: true,
          align:'center'
        },
				{
          title: '操作',
          minWidth:200,
          key: 'action',
          align:'center',
          render: (h, params) => {
            var marginstyle="3px"
            var varhh1=  h('Button', {
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
            var varhh2=  h('Button', {
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
               var varhh10=  h('Button', {
                props: {
                  type: 'dashed',
                  size: 'small'
                },
                style: {
                  margin: marginstyle
                },
                on: {
                  click: () => {
                    let  pp=JSON.stringify({
                      currentPage:1,//当前页
                      merId:params.row.merId,
                    });
                     this.$router.push('/main/merImg/'+pp);
                     setTimeout(()=>{
                        this.Hub.$emit('navroad',this.$router.currentRoute); //Hub触发事件
                    },200)
                  }
                }
              }, '商品图片');
            	var s=h("div","");

			s=h("div",[
            h("div",[
                  varhh1,
                  varhh2
                ]),
             h("div",[
                  varhh10,
                ]),
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
     })
      this.$router.push(this.$route.path.substr(0,this.$route.path.indexOf(this.$route.params.pathParams))+pp);
      this.getList()
    },
    //增加中的原始价格
    changeAddOldUnitPrice(oldUnitPrice){
        this.addMer.unitPrice=oldUnitPrice*this.addMer.discount
    },
    //增加中的折扣
    changeAddDiscount(discount){
        this.addMer.unitPrice=discount*this.addMer.oldUnitPrice
    },
    //修改中的原始价格
    changeUpdateOldUnitPrice(oldUnitPrice){
        this.updateMer.unitPrice=oldUnitPrice*this.updateMer.discount
    },
    //修改中的折扣
    changeUpdateDiscount(discount){
        this.updateMer.unitPrice=discount*this.updateMer.oldUnitPrice
    },

    //获取增加的图片
    getAddImgAddress(data){
      this.addMer.imgAddress=data[0].url
    },
    //获取修改的图片
    getUpdateImgAddress(data){
      this.updateMer.imgAddress=data[0].url
    },
    //获取增加的编辑器内容
    getAddDetails(data){
      this.addMer.details=data
    },
    //获取修改的编辑器内容
    getUpdateDetails(data){
      this.updateMer.details=data
    },
    //切换每页条数时的回调，返回切换后的每页条数
    onPageSizeChange(pageSize){
      this.getList(pageSize)
    },
    //获取列表
   getMerCateList () {
     /**
     * 获取列表
     * $this  vue组件
     * p.countUrl 数量url
     * p.listUrl 列表url
     * p.data 返回列表
     */
    this.params.pageSize=1000000;
     this.axiosbusiness.getList(this,{
       countUrl:'/merCate/count',
       listUrl:'/merCate/list',
       data:'merCateList',
       success:()=>{
          
      //this.params.recommend=this.recommendParamsList[0].id;
     // this.params.status=this.statusList[0].id;
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
       countUrl:'/mer/count',
       listUrl:'/mer/list',
       data:'merList'
     },this.params)
    },
  //增加
	 add (params) {
      this.addMerModel = true
       //初始化
        this.addMer={
            merCateId:this.merCateList[0].merCateId,
            type:this.typeList[0].id,
            recommend:this.recommendList[0].id,
            status:this.statusList[0].id,  
            imgAddress:'',  
            details:' ',   
            status:1,
            oldUnitPrice:0,   
            discount:0,   
            unitPrice:0   
        };
    },
		//增加取消
		 addCancel () {
      if (!this.addLoading) {
        this.addMerModel = false
        this.$refs.addMer.resetFields()
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
      ref:'addMer',
      url:'/mer/add',
      requestObject:'addMer',
      loading:'addLoading',
      showModel:'addMerModel'
    })
    },
	 update (params) {
      this.updateMerModel = true
      //获取修改实体
      this.axiosbusiness.get(this,{
         url:'/mer/load?merId='+params.merId,
         data:'updateMer',
       })
    },
		//修改取消
		 updateCancel () {
      if (!this.updateLoading) {
        this.updateMerModel = false
        this.$refs.updateMer.resetFields()
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
    delete this.updateMer.merCate
    delete this.updateMer.merImgList
    this.axiosbusiness.update(this,{
      ref:'updateMer',
      url:'/mer/update',
      requestObject:'updateMer',
      loading:'updateLoading',
      showModel:'updateMerModel'
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
    this.deleteMer={
      "merId":params.merId
    };
    this.axiosbusiness.delete(this,{
      url:'/mer/delete',
      requestObject:'deleteMer'
    })
    }
  },
     watch: {
    //当前页面参数修改动态启动
      $route (to,from){
         this.getMerCateList();
      }
    }, 
  created () {
    this.getMerCateList();
  },
  mounted () {

  }
}
</script>
