webpackJsonp([14],{lOmv:function(e,t,a){"use strict";Object.defineProperty(t,"__esModule",{value:!0});var i=a("mvHQ"),r=a.n(i),n={name:"FinanceRecord",data:function(){var e=this;return{params:{pageSizeOpts:[10,20,50,100,500,1e3],startNum:1,currentPage:1,pageNum:1,pageSize:10,total:0},methodList:[{id:1,value:"支付宝"},{id:2,value:"微信"},{id:3,value:"百度钱包"},{id:4,value:"Paypal"},{id:5,value:"网银"},{id:6,value:"ios内购"},{id:7,value:"余额"}],typeList:[{id:1,value:"购买商品"},{id:2,value:"提现记录"},{id:3,value:"退款记录"},{id:4,value:"诚信押金"},{id:5,value:"商品售出"},{id:6,value:"推广分成"},{id:7,value:"上级推广分成"}],statusList:[{id:1,value:"待处理"},{id:2,value:"成功"},{id:3,value:"已拒绝"}],financeRecordList:[],financeRecordColumns:[{title:"序号",minWidth:100,align:"center",render:function(t,a){return t("span",a.index+(e.params.currentPage-1)*e.params.pageSize+e.params.startNum)}},{title:"财务记录id",minWidth:100,key:"financeRecordId",align:"center"},{title:"支付方式",minWidth:100,key:"method",align:"center",render:function(t,a){var i="";return e.methodList.forEach(function(e){e.id==a.row.method&&(i=e.value)}),t("span",i)}},{title:"支付类型",minWidth:100,key:"type",align:"center",render:function(t,a){var i="";return e.typeList.forEach(function(e){e.id==a.row.type&&(i=e.value)}),t("span",i)}},{title:"交易单号",minWidth:100,key:"transactionNumber",align:"center"},{title:"真实姓名",minWidth:100,key:"realname",align:"center"},{title:"账户",minWidth:100,key:"mark",align:"center"},{title:"实际金额",minWidth:100,key:"realMoney",align:"center"},{title:"状态",minWidth:100,key:"status",align:"center",render:function(t,a){var i="";return e.statusList.forEach(function(e){e.id==a.row.status&&(i=e.value)}),t("span",i)}},{title:"创建时间",minWidth:100,key:"createDate",sortable:!0,align:"center"},{title:"修改时间",minWidth:100,key:"updateDate",sortable:!0,align:"center"}]}},methods:{selectPage:function(e){this.params.currentPage=e,this.params.pageNum=(this.params.currentPage-1)*this.params.pageSize+this.params.startNum;var t=r()({currentPage:e,accountId:JSON.parse(this.$route.params.pathParams).accountId});this.$router.push(this.$route.path.substr(0,this.$route.path.indexOf(this.$route.params.pathParams))+t),this.getList()},onPageSizeChange:function(e){this.getList(e)},getList:function(e){this.params.pageSize=e||this.params.pageSize,this.params.accountId=JSON.parse(this.$route.params.pathParams).accountId,this.axiosbusiness.getList(this,{countUrl:"/financeRecord/count",listUrl:"/financeRecord/list",data:"financeRecordList"},this.params)}},watch:{$route:function(e,t){this.selectPage(JSON.parse(this.$route.params.pathParams).currentPage)}},created:function(){this.selectPage(JSON.parse(this.$route.params.pathParams).currentPage)},mounted:function(){}},s={render:function(){var e=this,t=e.$createElement,a=e._self._c||t;return a("div",{staticClass:"body-wrap"},[a("Table",{ref:"table",attrs:{border:"",columns:e.financeRecordColumns,data:e.financeRecordList,size:"small"}}),e._v(" "),a("div",{staticStyle:{display:"inline-block",float:"right","margin-top":"10px"}},[a("Page",{ref:"page",staticStyle:{"margin-right":"10px"},attrs:{"show-sizer":"","page-size-opts":e.params.pageSizeOpts,current:e.params.currentPage,total:e.params.total,pageSize:e.params.pageSize,"show-total":!0,"show-elevator":""},on:{"on-page-size-change":e.onPageSizeChange,"on-change":e.selectPage}})],1)],1)},staticRenderFns:[]},u=a("VU/8")(n,s,!1,null,null,null);t.default=u.exports}});
//# sourceMappingURL=14.d64f2c8e80d16fd439be.js.map