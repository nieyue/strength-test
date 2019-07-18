<!--标准管理 -->
<template>
    <div class="body-wrap">
    <div class="body-btn-wrap">
      <Button type='primary'  @click='add'>增加标准</Button>
      <div class="search-wrap">
        <Select v-model="params.projectId"  transfer class="search-wrap-input" placeholder="项目，全部">
            <Option v-for="item in projectList" :value="item.projectId" :key="item.projectId">{{ item.name }}</Option>
        </Select>
        <InputNumber :max="200" :min="0"  :precision='0' v-model="params.age"  class="search-wrap-input" placeholder="年龄" ></InputNumber>
        <Select v-model="params.sex" transfer class="search-wrap-input"  placeholder="性别，全部">
            <Option v-for="item in sexParamsList" :value="item.id" :key="item.id">{{ item.value }}</Option>
        </Select>
        <Select v-model="params.rank" transfer class="search-wrap-input"  placeholder="等级，全部">
            <Option v-for="item in rankParamsList" :value="item.id" :key="item.id">{{ item.value }}</Option>
        </Select>
        <Button @click="search" type="info"  >查询</Button>
      </div>
    </div>
		 <!--新增 -->
     <Modal v-model="addStandardModel"
           title="新增标准管理"
           :closable="false"
           :mask-closable="false"
           width="1000px"
    >
      <Form ref="addStandard" :model="addStandard" :label-width="100"  label-position="right"  :rules="addStandardRules">
        <FormItem prop="projectId" label="项目:">
          <!-- <Select v-model="addStandard.projectId" size="large" style="width:100px">
              <Option v-for="item in projectList" :value="item.projectId" :key="item.projectId">{{ item.name }}</Option>
          </Select> -->
          <RadioGroup v-model="addStandard.projectId" type="button" >
              <Radio style="margin:5px;" :label="item.projectId" 
              v-for="item in projectList" :value="item.projectId" :key="item.projectId" >
                  {{item.name}}
              </Radio>
          </RadioGroup>
        </FormItem>
         <FormItem prop="age" label="年龄:">
          <InputNumber :max="200" :min="0"  :precision='0' v-model="addStandard.age"></InputNumber>
        </FormItem>
        <FormItem prop="sex" label="性别:">
          <!-- <Select v-model="addStandard.sex" transfer size="large" style="width:100px">
              <Option v-for="item in sexList" :value="item.id" :key="item.id">{{ item.value }}</Option>
          </Select> -->
          <RadioGroup v-model="addStandard.sex" type="button" >
              <Radio style="margin:5px;" :label="item.id" 
              v-for="item in sexList" :value="item.id" :key="item.id" >
                  {{item.value}}
              </Radio>
          </RadioGroup>
        </FormItem>
        <FormItem prop="rank" label="等级:">
         <!--  <Select v-model="addStandard.rank" transfer size="large" style="width:100px">
              <Option v-for="item in rankList" :value="item.id" :key="item.id">{{ item.value }}</Option>
          </Select> -->
          <RadioGroup v-model="addStandard.rank" type="button" >
              <Radio style="margin:5px;" :label="item.id" 
              v-for="item in rankList" :value="item.id" :key="item.id" >
                  {{item.value}}
              </Radio>
          </RadioGroup>
        </FormItem>
        <FormItem prop="low" label="低位:">
          <InputNumber :max="1000000000" :min="-9999999"  :precision='2'  v-model="addStandard.low"></InputNumber>
         <!--  <Input   v-model="addStandard.low"></Input> -->
        </FormItem>
        <FormItem prop="high" label="高位:">
          <InputNumber :max="1000000000" :min="-9999999"  :precision='2'  v-model="addStandard.high"></InputNumber>
           <!-- <Input   v-model="addStandard.high"></Input> -->
        </FormItem>
        <FormItem prop="item" label="项:">
          <Input type="text" v-model="addStandard.item" placeholder="项">
          </Input>
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
     <Modal v-model="updateStandardModel"
           title="修改标准管理"
           :closable="false"
           :mask-closable="false"
           width="1000px"
    >
      <Form ref="updateStandard" :model="updateStandard" :label-width="100" label-position="right"  :rules="updateStandardRules">
        <FormItem prop="projectId" label="项目:">
          <!-- <Select v-model="updateStandard.projectId" size="large" style="width:100px">
              <Option v-for="item in projectList" :value="item.projectId" :key="item.projectId">{{ item.name }}</Option>
          </Select> -->
          <RadioGroup v-model="updateStandard.projectId" type="button" >
              <Radio style="margin:5px;" :label="item.projectId" 
              v-for="item in projectList" :value="item.projectId" :key="item.projectId" >
                  {{item.name}}
              </Radio>
          </RadioGroup>
        </FormItem>
         <FormItem prop="age" label="年龄:">
          <InputNumber :max="200" :min="0"  :precision='0' v-model="updateStandard.age"></InputNumber>
        </FormItem>
          <FormItem prop="sex" label="性别:">
          <!-- <Select v-model="updateStandard.sex" transfer size="large" style="width:100px">
              <Option v-for="item in sexList" :value="item.id" :key="item.id">{{ item.value }}</Option>
          </Select> -->
          <RadioGroup v-model="updateStandard.sex" type="button" >
              <Radio style="margin:5px;" :label="item.id" 
              v-for="item in sexList" :value="item.id" :key="item.id" >
                  {{item.value}}
              </Radio>
          </RadioGroup>
        </FormItem>
        <FormItem prop="rank" label="等级:">
          <!-- <Select v-model="updateStandard.rank" transfer size="large" style="width:100px">
              <Option v-for="item in rankList" :value="item.id" :key="item.id">{{ item.value }}</Option>
          </Select> -->
          <RadioGroup v-model="updateStandard.rank" type="button" >
              <Radio style="margin:5px;" :label="item.id" 
              v-for="item in rankList" :value="item.id" :key="item.id" >
                  {{item.value}}
              </Radio>
          </RadioGroup>
        </FormItem>
        <FormItem prop="low" label="低位:">
          <InputNumber :max="1000000000" :min="-9999999"  :precision='2'  v-model="updateStandard.low"></InputNumber>
        </FormItem>
        <FormItem prop="high" label="高位:">
          <InputNumber :max="1000000000" :min="-9999999"  :precision='2' v-model="updateStandard.high"></InputNumber>
        </FormItem>
        <FormItem prop="item" label="项:">
          <Input type="text" v-model="updateStandard.item" placeholder="项">
          </Input>
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
      <Table border height="600" :columns='standardColumns' :data='standardList' ref='table' size="small"></Table>
        <div style='display: inline-block;float: right; margin-top:10px;'>
        <Page style='margin-right:10px;' @on-page-size-change="onPageSizeChange" show-sizer :page-size-opts='params.pageSizeOpts' :current="params.currentPage" :total='params.total' :pageSize='params.pageSize' ref='page' :show-total='true'  @on-change='selectPage' show-elevator ></Page>
      </div>
    </div>
</template>
<script>
export default {
  name: 'Standard',
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
			addStandardModel:false,
			addLoading:false,
			addStandardRules: {
                item: [
                    {required: true, message: '项为必填项', trigger: 'blur'}
                    ]
                },
			addStandard:{
           age:0,
           sex:3,
    		   rank:1,
    		   low:0,
           high:0,
           item:"",
           projectId:'',
			},
			//修改参数
			updateStandardModel:false,
			updateLoading:false,
			updateStandardRules: {
                item: [
                    {required: true, message: '项为必填项', trigger: 'blur'}
                    ]
                },
			updateStandard:{
      },
      //删除参数
      deleteStandard:{},
      //列表
	    projectList: [],
      standardList: [],
	    standardColumns: [
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
          title: '标准id',
          key: 'standardId',
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
        	title:'低高位',
        //	key:'title',
          align:'center',
          render:(h,params)=>{
            return h('span',params.row.low+'~'+params.row.high);
          }
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
           this.params.pageSize=10;
           this.selectPage(JSON.parse(this.$route.params.pathParams).currentPage)
           this.params.age?'':this.params.age=null;
           this.addStandard.projectId=this.projectList.length>0?this.projectList[0].projectId:null

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
       countUrl:'/standard/count',
       listUrl:'/standard/list',
       data:'standardList',
       success:()=>{
         this.params.age?'':this.params.age=null;
       }
     },this.params)
    },
  //增加
	 add (params) {
      this.addStandardModel = true
      
    },
		//增加取消
		 addCancel () {
      if (!this.addLoading) {
        this.addStandardModel = false
        this.$refs.addStandard.resetFields()
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
      ref:'addStandard',
      url:'/standard/add',
      requestObject:'addStandard',
      loading:'addLoading',
      showModel:'addStandardModel'
    })
    },
	 update (params) {
      this.updateStandardModel = true
      this.updateStandard.standardId = params.standardId
      this.updateStandard.projectId = params.projectId
       //获取修改实体
      this.axiosbusiness.get(this,{
         url:'/standard/load?standardId='+params.standardId,
         data:'updateStandard',
         })
    },
		//修改取消
		 updateCancel () {
      if (!this.updateLoading) {
        this.updateStandardModel = false
        this.$refs.updateStandard.resetFields()
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
    delete this.updateStandard.project
    this.axiosbusiness.update(this,{
      ref:'updateStandard',
      url:'/standard/update',
      requestObject:'updateStandard',
      loading:'updateLoading',
      showModel:'updateStandardModel'
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
    this.deleteStandard={
      "standardId":params.standardId
    };
    this.axiosbusiness.delete(this,{
      url:'/standard/delete',
      requestObject:'deleteStandard'
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
