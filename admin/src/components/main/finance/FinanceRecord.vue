<!--财务记录管理 -->
<template>
    <div class="body-wrap">
      <Table border  :columns='financeRecordColumns' :data='financeRecordList' ref='table' size="small"></Table>
        <div style='display: inline-block;float: right; margin-top:10px;'>
        <Page style='margin-right:10px;' @on-page-size-change="onPageSizeChange" show-sizer :page-size-opts='params.pageSizeOpts' :current="params.currentPage" :total='params.total' :pageSize='params.pageSize' ref='page' :show-total='true'   @on-change='selectPage' show-elevator ></Page>
      </div>
    </div>
    
</template>
<script>
export default {
  name: 'FinanceRecord',
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
      //状态默认1待处理，2成功，3已拒绝
      statusList:[
        {id:1,value:'待处理'},
        {id:2,value:'成功'},
        {id:3,value:'已拒绝'}
      ],
	    financeRecordList: [],
	    financeRecordColumns: [
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
          title: '财务记录id',
          minWidth:100,
          key: 'financeRecordId',
          align:'center'
        },
        {
          title:'支付方式',
          minWidth:100,
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
          minWidth:100,
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
          minWidth:100,
            key:'transactionNumber',
            align:'center'
        },
        {
          title:'真实姓名',
          minWidth:100,
            key:'realname',
            align:'center'
        },
        {
          title:'账户',
          minWidth:100,
            key:'mark',
            align:'center'
        },
        {
          title:'实际金额',
          minWidth:100,
            key:'realMoney',
            align:'center'
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
          title:'修改时间',
          minWidth:100,
          key:'updateDate',
          sortable: true,
          align:'center'
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
     * p.list 返回列表
     */
     this.params.pageSize=pageSize||this.params.pageSize
    this.params.accountId=JSON.parse(this.$route.params.pathParams).accountId
     this.axiosbusiness.getList(this,{
       countUrl:'/financeRecord/count',
       listUrl:'/financeRecord/list',
       data:'financeRecordList'
     },this.params)
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
