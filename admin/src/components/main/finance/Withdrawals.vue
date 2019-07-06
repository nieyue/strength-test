<!--提现管理 -->
<template>
    <div class="body-wrap">
      <div class="body-btn-wrap">
        <div class="search-wrap">
          <Select v-model="params.method"  transfer class="search-wrap-input" placeholder="支付类型，全部">
              <Option v-for="item in methodParamsList" :value="item.id" :key="item.id">{{ item.value }}</Option>
          </Select>
          <Input v-model="params.accountId" class="search-wrap-input" placeholder="账户Id"></Input>
          <Input v-model="params.transactionNumber" class="search-wrap-input" placeholder="交易单号"></Input>
          <Select v-model="params.status" transfer class="search-wrap-input"  placeholder="状态，全部">
              <Option v-for="item in statusParamsList" :value="item.id" :key="item.id">{{ item.value }}</Option>
          </Select>
          <Button @click="search" type="info"  >查询</Button>
        </div>
      </div>

       <!--修改 -->
     <Modal v-model="updateFinanceRecordModel"
           title="修改状态"
           :closable="false"
           :mask-closable="false"
    >
      <Form ref="updateFinanceRecord" :model="updateFinanceRecord" :label-width="100" label-position="right"  :rules="updateFinanceRecordRules">
        <FormItem prop="status" label="状态:">
          <Select v-model="updateFinanceRecord.status" transfer class="search-wrap-input">
              <Option v-for="item in statusList" :value="item.id" :key="item.id">{{ item.value }}</Option>
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
    
      <Table border  :columns='financeRecordColumns' :data='financeRecordList' ref='table' size="small"></Table>
        <div style='display: inline-block;float: right; margin-top:10px;'>
        <Page style='margin-right:10px;' @on-page-size-change="onPageSizeChange" show-sizer :page-size-opts='params.pageSizeOpts' :total='params.total' :pageSize='params.pageSize' ref='page' :show-total='true'   @on-change='selectPage' show-elevator ></Page>
      </div>
    </div>
    
</template>
<script>
export default {
  name: 'Withdrawals',
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
      //支付方式，1支付宝，2微信,3百度钱包,4Paypal,5网银,6ios内购,7余额
      methodList:[
        {id:1,value:'支付宝'},
        {id:2,value:'微信'},
        {id:3,value:'百度钱包'},
        {id:4,value:'Paypal'},
        {id:5,value:'网银'},
        {id:6,value:'ios内购'},
        {id:7,value:'余额'},
      ],
      /**
       *类型，1购买商品，2提现记录，3退款记录，4诚信押金，5商品售出，6推广分成，7上级推广分成
       * 
       */
      typeList:[
        {id:1,value:'购买商品'},
        {id:2,value:'提现记录'},
        {id:3,value:'退款记录'},
        {id:4,value:'诚信押金'},
        {id:5,value:'商品售出'},
        {id:6,value:'推广分成'},
        {id:7,value:'上级推广分成'},
      ],
      //状态
      statusList:[
        {id:1,value:'待处理'},
        {id:2,value:'成功'},
        {id:3,value:'已拒绝'}
      ],
      //查询支付方式
      methodParamsList:[
        {id:'',value:'全部'},
        {id:1,value:'支付宝'},
        {id:2,value:'微信'},
        {id:3,value:'百度钱包'},
        {id:4,value:'Paypal'},
        {id:5,value:'网银'},
        {id:6,value:'ios内购'},
        {id:7,value:'余额'},
      ],
      //查询状态
      statusParamsList:[
        {id:'',value:'全部'},
        {id:1,value:'待处理'},
        {id:2,value:'成功'},
        {id:3,value:'已拒绝'}
      ],
      	//修改参数
			updateFinanceRecordModel:false,
			updateLoading:false,
      updateFinanceRecord:{},
      updateFinanceRecordRules:{},
	    financeRecordList: [],
	    financeRecordColumns: [
        {
          title: '序号',
          align:'center',
          render: (h, params) => {
            return h('span', params.index
            +(this.params.currentPage-1)*this.params.pageSize+this.params.startNum);
          }
        },
        {
          title: '财务记录id',
          key: 'financeRecordId',
          align:'center'
        },
        {
          title: '账户id',
          key: 'accountId',
          align:'center'
        },
        {
        	title:'支付方式',
            key:'method',
            align:'center',
          render: (h, params) => {
            let methodvalue="";
            this.methodList.forEach(element => {
              if(element.id==params.row.method){
                methodvalue=element.value;
              }
            });
             return  h('span',methodvalue);
          }
        },
        {
        	title:'支付类型',
            key:'type',
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
        	title:'交易单号',
            key:'transactionNumber',
            align:'center'
        },
        {
          title:'真实姓名',
            key:'realname',
            align:'center'
        },
        {
          title:'账户',
            key:'mark',
            align:'center'
        },
        {
        	title:'金额',
            key:'realMoney',
            align:'center'
        },
       {
        	title:'状态',
            key:'status',
            align:'center',
          render: (h, params) => {
            let statusvalue="";
            let resulth;
            this.statusList.forEach(element => {
              if(element.id==params.row.status){
                statusvalue=element.value;
              }
            });
            resulth=h('span', statusvalue);
            if(statusvalue=='待处理'){
            resulth=h('span',
             [
               statusvalue,
                h('Button', {
                props: {
                  type: 'error',
                  size: 'small'
                },
                on: {
                  click: () => {
                    //this.update(params.row)
                    this.withdrawals(params.row)
                  }
                }
              }, '提现到账'),
              //   h('Button', {
              //   props: {
              //     type: 'primary',
              //     size: 'small'
              //   },
              //   style: {
              //     margin: '15px'
              //   },
              //   on: {
              //     click: () => {
              //       this.update(params.row)
              //     }
              //   }
              // }, '编辑')
             ]
             );

            }
             return  resulth;
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
        }
      ],
    }
  },
  methods: {
    //查询
    search(){
      if(!this.params.transactionNumber){
      delete this.params.transactionNumber
      }
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
   getList (pageSize) {
     /**
     * 获取列表
     * $this  vue组件
     * p.countUrl 数量url
     * p.listUrl 列表url
     * p.list 返回列表
     */
    this.params.type=2//提现的类型为2
    this.params.pageSize=pageSize||this.params.pageSize
     this.axiosbusiness.getList(this,{
       countUrl:'/financeRecord/count',
       listUrl:'/financeRecord/list',
       data:'financeRecordList'
     },this.params)
    },
    update (params) {
      this.updateFinanceRecordModel = true
     //获取修改实体
      this.axiosbusiness.get(this,{
         url:'/financeRecord/'+params.financeRecordId,
         data:'updateFinanceRecord',
       })
    },
		//修改取消
		 updateCancel () {
      if (!this.updateLoading) {
        this.updateFinanceRecordModel = false
        this.$refs.updateFinanceRecord.resetFields()
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
      ref:'updateFinanceRecord',
      url:'/financeRecord/update',
      requestObject:'updateFinanceRecord',
      loading:'updateLoading',
      showModel:'updateFinanceRecordModel'
    })
 
    },
    //提现到账
    withdrawals(params){
      this.axiosbusiness.get(this,{
         url:'/financeRecord/withdrawals?financeRecordId='+params.financeRecordId,
         data:'updateFinanceRecord',
         success:()=>{
           this.financeRecordList.forEach(e=>{
             if(e.financeRecordId==this.updateFinanceRecord.financeRecordId){
               this.financeRecordList.splice(this.financeRecordList.indexOf(e),1,this.updateFinanceRecord)
             }
           })
         }
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
