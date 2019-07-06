webpackJsonp([12],{"1tyS":function(e,t,a){"use strict";Object.defineProperty(t,"__esModule",{value:!0});var r=a("mvHQ"),s=a.n(r),d={name:"MerCate",data:function(){var e=this;return{params:{pageSizeOpts:[10,20,50,100,500,1e3],startNum:1,currentPage:1,pageNum:1,pageSize:10,total:0},addMerCateModel:!1,addLoading:!1,addMerCateRules:{name:[{required:!0,message:"名称为必填项",trigger:"blur"}]},addMerCate:{},updateMerCateModel:!1,updateLoading:!1,updateMerCateRules:{name:[{required:!0,message:"名称为必填项",trigger:"blur"}]},updateMerCate:{},deleteMerCate:{},merCateList:[],merCateColumns:[{title:"序号",align:"center",render:function(t,a){return t("span",a.index+(e.params.currentPage-1)*e.params.pageSize+e.params.startNum)}},{title:"商品类型id",key:"merCateId",align:"center"},{title:"名称",key:"name",align:"center"},{title:"简介",key:"summary",align:"center",render:function(e,t){return e("span",null==t.row.summary?"":t.row.summary.length>=20?t.row.summary.substring(0,20)+"...":t.row.summary.substring(0))}},{title:"修改时间",key:"updateDate",sortable:!0,align:"center"},{title:"操作",key:"action",align:"center",render:function(t,a){var r=t("Button",{props:{type:"primary",size:"small"},style:{marginLeft:"10px"},on:{click:function(){e.update(a.row)}}},"编辑"),s=t("Button",{props:{type:"error",size:"small"},style:{marginLeft:"10px"},on:{click:function(){e.delete(a.row)}}},"删除");t("div","");return t("div",[r,s])}}]}},methods:{selectPage:function(e){this.params.currentPage=e,this.params.pageNum=(this.params.currentPage-1)*this.params.pageSize+this.params.startNum;var t=s()({currentPage:e,accountId:JSON.parse(this.$route.params.pathParams).accountId});this.$router.push(this.$route.path.substr(0,this.$route.path.indexOf(this.$route.params.pathParams))+t),this.getList()},onPageSizeChange:function(e){this.getList(e)},getList:function(e){this.params.pageSize=e||this.params.pageSize,this.params.accountId=JSON.parse(this.$route.params.pathParams).accountId,this.axiosbusiness.getList(this,{countUrl:"/merCate/count",listUrl:"/merCate/list",data:"merCateList"},this.params)},add:function(e){this.addMerCateModel=!0},addCancel:function(){this.addLoading||(this.addMerCateModel=!1,this.$refs.addMerCate.resetFields())},addSure:function(){this.axiosbusiness.add(this,{ref:"addMerCate",url:"/merCate/add",requestObject:"addMerCate",loading:"addLoading",showModel:"addMerCateModel"})},update:function(e){this.updateMerCateModel=!0,this.axiosbusiness.get(this,{url:"/merCate/load?merCateId="+e.merCateId,data:"updateMerCate"})},updateCancel:function(){this.updateLoading||(this.updateMerCateModel=!1,this.$refs.updateMerCate.resetFields())},updateSure:function(){this.axiosbusiness.update(this,{ref:"updateMerCate",url:"/merCate/update",requestObject:"updateMerCate",loading:"updateLoading",showModel:"updateMerCateModel"})},delete:function(e){this.deleteMerCate={merCateId:e.merCateId},this.axiosbusiness.delete(this,{url:"/merCate/delete",requestObject:"deleteMerCate"})}},watch:{$route:function(e,t){this.selectPage(JSON.parse(this.$route.params.pathParams).currentPage)}},created:function(){this.selectPage(JSON.parse(this.$route.params.pathParams).currentPage)},mounted:function(){}},i={render:function(){var e=this,t=e.$createElement,a=e._self._c||t;return a("div",{staticClass:"body-wrap"},[a("div",{staticClass:"body-btn-wrap"},[a("Button",{attrs:{type:"primary"},on:{click:e.add}},[e._v("增加商品类型")])],1),e._v(" "),a("Modal",{attrs:{title:"新增商品类型管理",closable:!1,"mask-closable":!1},model:{value:e.addMerCateModel,callback:function(t){e.addMerCateModel=t},expression:"addMerCateModel"}},[a("Form",{ref:"addMerCate",attrs:{model:e.addMerCate,"label-width":100,"label-position":"right",rules:e.addMerCateRules}},[a("FormItem",{attrs:{prop:"name",label:"名称:"}},[a("Input",{attrs:{type:"text",placeholder:"名称"},model:{value:e.addMerCate.name,callback:function(t){e.$set(e.addMerCate,"name",t)},expression:"addMerCate.name"}})],1),e._v(" "),a("FormItem",{attrs:{prop:"summary",label:"简介:"}},[a("Input",{attrs:{type:"textarea",autosize:{minRows:2,maxRows:5},placeholder:"简介"},model:{value:e.addMerCate.summary,callback:function(t){e.$set(e.addMerCate,"summary",t)},expression:"addMerCate.summary"}})],1)],1),e._v(" "),a("div",{attrs:{slot:"footer"},slot:"footer"},[a("Button",{on:{click:e.addCancel}},[e._v("取消")]),e._v(" "),a("Button",{attrs:{type:"primary",loading:e.addLoading}},[e.addLoading?a("span",[e._v("Loading...")]):a("span",{on:{click:e.addSure}},[e._v("确定")])])],1)],1),e._v(" "),a("Modal",{attrs:{title:"修改商品类型管理",closable:!1,"mask-closable":!1},model:{value:e.updateMerCateModel,callback:function(t){e.updateMerCateModel=t},expression:"updateMerCateModel"}},[a("Form",{ref:"updateMerCate",attrs:{model:e.updateMerCate,"label-width":100,"label-position":"right",rules:e.updateMerCateRules}},[a("FormItem",{attrs:{prop:"name",label:"名称:"}},[a("Input",{attrs:{type:"text",placeholder:"名称"},model:{value:e.updateMerCate.name,callback:function(t){e.$set(e.updateMerCate,"name",t)},expression:"updateMerCate.name"}})],1),e._v(" "),a("FormItem",{attrs:{prop:"summary",label:"简介:"}},[a("Input",{attrs:{type:"textarea",autosize:{minRows:2,maxRows:5},placeholder:"简介"},model:{value:e.updateMerCate.summary,callback:function(t){e.$set(e.updateMerCate,"summary",t)},expression:"updateMerCate.summary"}})],1)],1),e._v(" "),a("div",{attrs:{slot:"footer"},slot:"footer"},[a("Button",{on:{click:e.updateCancel}},[e._v("取消")]),e._v(" "),a("Button",{attrs:{type:"primary",loading:e.updateLoading}},[e.updateLoading?a("span",[e._v("Loading...")]):a("span",{on:{click:e.updateSure}},[e._v("确定")])])],1)],1),e._v(" "),a("Table",{ref:"table",attrs:{border:"",columns:e.merCateColumns,data:e.merCateList,size:"small"}}),e._v(" "),a("div",{staticStyle:{display:"inline-block",float:"right","margin-top":"10px"}},[a("Page",{ref:"page",staticStyle:{"margin-right":"10px"},attrs:{"show-sizer":"","page-size-opts":e.params.pageSizeOpts,current:e.params.currentPage,total:e.params.total,pageSize:e.params.pageSize,"show-total":!0,"show-elevator":""},on:{"on-page-size-change":e.onPageSizeChange,"on-change":e.selectPage}})],1)],1)},staticRenderFns:[]},n=a("VU/8")(d,i,!1,null,null,null);t.default=n.exports}});
//# sourceMappingURL=12.83416f3a0893879edbf7.js.map