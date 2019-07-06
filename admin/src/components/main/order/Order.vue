<!--订单管理 -->
<template>
    <div class="body-wrap">
        <div style="color:green;">
            备注：下单人id即为账户id
        </div>
      <div class="body-btn-wrap">
        <div class="search-wrap">
          <Select v-model="params.merType" transfer class="search-wrap-input"  placeholder="商品类型，全部">
              <Option v-for="item in merTypeParamsList" :value="item.id" :key="item.id">{{ item.value }}</Option>
          </Select>
          <Select v-model="params.type" transfer class="search-wrap-input"  placeholder="业务类型，全部">
              <Option v-for="item in typeParamsList" :value="item.id" :key="item.id">{{ item.value }}</Option>
          </Select>
          <Select v-model="params.payType" transfer class="search-wrap-input"  placeholder="支付类型，全部">
              <Option v-for="item in payTypeParamsList" :value="item.id" :key="item.id">{{ item.value }}</Option>
          </Select>
          <Input v-model="params.accountId" class="search-wrap-input" placeholder="下单人id"></Input>
          <Select v-model="params.status" transfer class="search-wrap-input"  placeholder="状态，全部">
              <Option v-for="item in statusParamsList" :value="item.id" :key="item.id">{{ item.value }}</Option>
          </Select>
          <Button @click="search" type="info"  >查询</Button>
        </div>
      </div>
      <Table border  :columns='orderColumns' :data='orderList' ref='table' size="small"></Table>
        <div style='display: inline-block;float: right; margin-top:10px;'>
        <Page style='margin-right:10px;' @on-page-size-change="onPageSizeChange" show-sizer :page-size-opts='params.pageSizeOpts' :current="params.currentPage" :total='params.total' :pageSize='params.pageSize' ref='page' :show-total='true'   @on-change='selectPage' show-elevator ></Page>
      </div>
    </div>
    
</template>
<script>
export default {
  name: 'Order',
  data () {
    return {
      routerPath:this.$route.path,
        params:{
            pageSizeOpts:[10,20,50,100,500,1000],//每页条数切换的配置
            startNum:1,//初始化个数
            currentPage:1,//当前页
            pageNum:1,//获取的第几个开始
            pageSize:10,//每页的个数
            total:0//总数
        },

       //商品类型，1普通商品，2降价商品，3预购商品
      merTypeParamsList:[
        {id:'',value:'全部'},
        {id:1,value:'普通商品'},
        {id:2,value:'降价商品'},
        {id:3,value:'预购商品'}
      ],
      //类型，1购买商品，2账户提现，3退款，4诚信押金
      typeParamsList:[
        {id:'',value:'全部'},
        {id:1,value:'购买商品'},
        {id:2,value:'账户提现'},
        {id:3,value:'退款'},
        {id:4,value:'诚信押金'}
      ],
      //方式，1支付宝，2微信,3百度钱包,4Paypal,5网银,6ios内购,7余额
      payTypeParamsList:[
        {id:'',value:'全部'},
        {id:1,value:'支付宝'},
        {id:2,value:'微信'},
        {id:3,value:'百度钱包'},
        {id:4,value:'Paypal'},
        {id:5,value:'网银'},
        {id:6,value:'ios内购'},
        {id:7,value:'余额'}
      ],
      //订单状态，2待支付，3待发货,4待收货，5待评价，6已取消，7已删除
      statusParamsList:[
        {id:'',value:'全部'},
        {id:2,value:'待支付'},
        {id:3,value:'待发货'},
        {id:4,value:'待收货'},
        {id:5,value:'待评价'},
        {id:6,value:'已取消'},
        {id:7,value:'已删除'}
      ],
      //商品类型，1普通商品，2降价商品，3预购商品
      merTypeList:[
        {id:1,value:'普通商品'},
        {id:2,value:'降价商品'},
        {id:3,value:'预购商品'}
      ],
      
      //类型，1购买商品，2账户提现，3退款，4诚信押金
      typeList:[
        {id:1,value:'购买商品'},
        {id:2,value:'账户提现'},
        {id:3,value:'退款'},
        {id:4,value:'诚信押金'}
      ],
      //方式，1支付宝，2微信,3百度钱包,4Paypal,5网银,6ios内购,7余额
      payTypeList:[
        {id:1,value:'支付宝'},
        {id:2,value:'微信'},
        {id:3,value:'百度钱包'},
        {id:4,value:'Paypal'},
        {id:5,value:'网银'},
        {id:6,value:'ios内购'},
        {id:7,value:'余额'}
      ],
      //订单状态，2待支付，3待发货,4待收货，5待评价，6已取消，7已删除
      statusList:[
        {id:2,value:'待支付'},
        {id:3,value:'待发货'},
        {id:4,value:'待收货'},
        {id:5,value:'待评价'},
        {id:6,value:'已取消'},
        {id:7,value:'已删除'}
      ],
	    orderList: [],
	    orderColumns: [
        {
          title: '序号',
          width:80,
          align:'center',
          render: (h, params) => {
            return h('span', params.index
            +(this.params.currentPage-1)*this.params.pageSize+this.params.startNum);
          }
        },
        {
          title: '订单id',
           width:100,
          key: 'orderId',
          align:'center'
        },
        {
          title: '订单号',
          width:100,
          key: 'orderNumber',
          align:'center'
        },
        {
          title: '下单人id',
          width:100,
          key: 'accountId',
          align:'center'
        },
        {
          title:'商品类型',
          width:100,
            align:'center',
          render: (h, params) => {
            let merTypevalue="";
            let resulth;
            this.merTypeList.forEach(element => {
              if(element.id==params.row.merType){
                merTypevalue=element.value;
              }
            });
                resulth=h('span',merTypevalue);   
             return  resulth;
          }
        },
        {
        	title:'业务类型',
          width:100,
            align:'center',
          render: (h, params) => {
            let typevalue="";
            let resulth;
            this.typeList.forEach(element => {
              if(element.id==params.row.type){
                typevalue=element.value;
              }
            });
                resulth=h('span', typevalue);   
             return  resulth;
          }
        },
        {
        	title:'支付类型',
          width:100,
            align:'center',
          render: (h, params) => {
            let payTypevalue="";
            let resulth;
            this.payTypeList.forEach(element => {
              if(element.id==params.row.payType){
                payTypevalue=element.value;
              }
            });
                resulth=h('span', payTypevalue);   
             return  resulth;
          }
        },
       {
        	title:'状态',
          width:100,
            align:'center',
          render: (h, params) => {
            let statusvalue="";
            let substatusvalue="";
            let resulth;
            this.statusList.forEach(element => {
              if(element.id==params.row.status){
                statusvalue=element.value;
              }
            });
                resulth=h('span', statusvalue);
             return  resulth;
          }
        },
        {
          title:'订单商品类型',
          width:100,
          align:'center',
          render: (h, params) => {
            let resulth;
             resulth=h('span', params.row.orderDetailList[0].merCateName);
             return  resulth;
          }
        },
        {
          title:'订单名称',
          width:100,
          align:'center',
          render: (h, params) => {
            let resulth;
             resulth=h('span', params.row.orderDetailList[0].name);
             return  resulth;
          }
        },
        {
          title:'订单封面',
          width:100,
          align:'center',
          render: (h, params) => {
             return h('img', {
              attrs: {
                src: params.row.orderDetailList[0].imgAddress
              },
              style: {
                width: '45px'
              }
            })
          }
        },
        {
          title:'单价',
          width:100,
          align:'center',
          render: (h, params) => {
            let resulth;
             resulth=h('span', params.row.orderDetailList[0].unitPrice);
             return  resulth;
          }
        },
        {
          title:'数量',
          width:100,
          align:'center',
          render: (h, params) => {
            let resulth;
             resulth=h('span', params.row.orderDetailList[0].number);
             return  resulth;
          }
        },
        {
            title:'总价',
            width:100,
          align:'center',
          render: (h, params) => {
              let resulth;
             resulth=h('span', params.row.orderDetailList[0].totalPrice);
             return  resulth;
          }
        },
        {
          title:'下单时间',
          width:100,
          key:'createDate',
          sortable: true,
          align:'center'
        },
          {
            title:'更新时间',
            key:'updateDate',
             width:100,
            sortable: true,
            align:'center'
          },
        {
          title:'支付时间',
          width:100,
          key:'paymentDate',
          sortable: true,
          align:'center'
        },
		{
          title: '操作',
          minWidth:200,
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
                    this.consignment(params.row)
                  }
                }
              }, '发货');
			var s=h("div",[
              varhh1,
            ]);
            if(params.row.status==3){
            return s;
            }else{
              return h("div","");
            }
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
     * p.list 返回列表
     */
    this.params.pageSize=pageSize||this.params.pageSize
     this.axiosbusiness.getList(this,{
       countUrl:'/order/count',
       listUrl:'/order/list',
       data:'orderList',
       success:()=>{
         
       }
       
     },this.params)
    },
     //发货
  consignment(order){
    order.status=4//订单状态，2待支付，3已支付,4已发货，5已收货，6已取消，7已删除
    let newOrder=order;
    delete newOrder.orderDetailList
     this.axios({
               method:"post",
               url:'/order/update',
               withCredentials: true,
               data: this.Qs.stringify(newOrder)
            }).
            then(res => {
              this.loading = false
              if (res.data.code === 200) {
                this.$Message.success(res.data.msg)
              } else {
                this.$Message.error(res.data.msg)
                this.loading = false
              }
            }).catch(res => {
              this.loading = false
              this.$Message.error('系统异常')
            }) 
  }
  },
   watch: {
      $route (to,from){
        this.params.currentPage=1;
        this.params.pageNum=1;
        this.routerPath=this.$route.path;
        this.getList();
      }
    },
  created () {
    this.getList();
  },
  mounted () {

  }
}
</script>
