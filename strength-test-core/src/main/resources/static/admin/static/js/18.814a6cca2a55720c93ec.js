webpackJsonp([18],{"9KgE":function(e,t,a){"use strict";Object.defineProperty(t,"__esModule",{value:!0});var i=a("mvHQ"),r=a.n(i),l={name:"ArticleCate",data:function(){var e=this;return{params:{pageSizeOpts:[10,20,50,100,500,1e3],startNum:1,currentPage:1,pageNum:1,pageSize:10,total:0},addArticleCateModel:!1,addLoading:!1,addArticleCateRules:{name:[{required:!0,message:"分类名称为必填项",trigger:"blur"}]},addArticleCate:{name:""},updateArticleCateModel:!1,updateLoading:!1,updateArticleCateRules:{name:[{required:!0,message:"分类名称为必填项",trigger:"blur"}]},updateArticleCate:{articleCateId:1,name:""},deleteArticleCate:{},articleCateList:[],articleCateColumns:[{title:"序号",align:"center",render:function(t,a){return t("span",a.index+(e.params.currentPage-1)*e.params.pageSize+e.params.startNum)}},{title:"文章分类id",key:"articleCateId",align:"center"},{title:"文章分类名称",key:"name",align:"center"},{title:"修改时间",key:"updateDate",sortable:!0,align:"center"},{title:"操作",key:"action",align:"center",render:function(t,a){var i=t("Button",{props:{type:"primary",size:"small"},style:{marginLeft:"10px"},on:{click:function(){e.update(a.row)}}},"编辑"),r=t("Button",{props:{type:"error",size:"small"},style:{marginLeft:"10px"},on:{click:function(){e.delete(a.row)}}},"删除");t("div","");return t("div",[i,r])}}]}},methods:{selectPage:function(e){this.params.currentPage=e,this.params.pageNum=(this.params.currentPage-1)*this.params.pageSize+this.params.startNum;var t=r()({currentPage:e,accountId:JSON.parse(this.$route.params.pathParams).accountId});this.$router.push(this.$route.path.substr(0,this.$route.path.indexOf(this.$route.params.pathParams))+t),this.getList()},onPageSizeChange:function(e){this.getList(e)},getList:function(e){this.params.pageSize=e||this.params.pageSize,this.axiosbusiness.getList(this,{countUrl:"/articleCate/count",listUrl:"/articleCate/list",data:"articleCateList"},this.params)},add:function(e){this.addArticleCateModel=!0,this.addArticleCate.name=e.name},addCancel:function(){this.addLoading||(this.addArticleCateModel=!1,this.$refs.addArticleCate.resetFields())},addSure:function(){this.axiosbusiness.add(this,{ref:"addArticleCate",url:"/articleCate/add",requestObject:"addArticleCate",loading:"addLoading",showModel:"addArticleCateModel"})},update:function(e){this.updateArticleCateModel=!0,this.updateArticleCate.name=e.name,this.updateArticleCate.articleCateId=e.articleCateId},updateCancel:function(){this.updateLoading||(this.updateArticleCateModel=!1,this.$refs.updateArticleCate.resetFields())},updateSure:function(){this.axiosbusiness.update(this,{ref:"updateArticleCate",url:"/articleCate/update",requestObject:"updateArticleCate",loading:"updateLoading",showModel:"updateArticleCateModel"})},delete:function(e){this.deleteArticleCate={articleCateId:e.articleCateId},this.axiosbusiness.delete(this,{url:"/articleCate/delete",requestObject:"deleteArticleCate"})},deleteBatch:function(){}},watch:{$route:function(e,t){this.selectPage(JSON.parse(this.$route.params.pathParams).currentPage)}},created:function(){this.selectPage(JSON.parse(this.$route.params.pathParams).currentPage)},mounted:function(){}},s={render:function(){var e=this,t=e.$createElement,a=e._self._c||t;return a("div",{staticClass:"body-wrap"},[a("div",{staticClass:"body-btn-wrap"},[a("Button",{attrs:{type:"primary"},on:{click:e.add}},[e._v("增加文章分类")])],1),e._v(" "),a("Modal",{attrs:{title:"新增文章分类管理",closable:!1,"mask-closable":!1},model:{value:e.addArticleCateModel,callback:function(t){e.addArticleCateModel=t},expression:"addArticleCateModel"}},[a("Form",{ref:"addArticleCate",attrs:{model:e.addArticleCate,"label-width":100,"label-position":"right",rules:e.addArticleCateRules}},[a("FormItem",{attrs:{prop:"name",label:"分类名称:"}},[a("Input",{attrs:{type:"text",placeholder:"分类名称"},model:{value:e.addArticleCate.name,callback:function(t){e.$set(e.addArticleCate,"name",t)},expression:"addArticleCate.name"}})],1)],1),e._v(" "),a("div",{attrs:{slot:"footer"},slot:"footer"},[a("Button",{on:{click:e.addCancel}},[e._v("取消")]),e._v(" "),a("Button",{attrs:{type:"primary",loading:e.addLoading}},[e.addLoading?a("span",[e._v("Loading...")]):a("span",{on:{click:e.addSure}},[e._v("确定")])])],1)],1),e._v(" "),a("Modal",{attrs:{title:"修改文章分类管理",closable:!1,"mask-closable":!1},model:{value:e.updateArticleCateModel,callback:function(t){e.updateArticleCateModel=t},expression:"updateArticleCateModel"}},[a("Form",{ref:"updateArticleCate",attrs:{model:e.updateArticleCate,"label-width":100,"label-position":"right",rules:e.updateArticleCateRules}},[a("FormItem",{attrs:{prop:"name",label:"分类名称:"}},[a("Input",{attrs:{type:"text",placeholder:"分类名称"},model:{value:e.updateArticleCate.name,callback:function(t){e.$set(e.updateArticleCate,"name",t)},expression:"updateArticleCate.name"}})],1)],1),e._v(" "),a("div",{attrs:{slot:"footer"},slot:"footer"},[a("Button",{on:{click:e.updateCancel}},[e._v("取消")]),e._v(" "),a("Button",{attrs:{type:"primary",loading:e.updateLoading}},[e.updateLoading?a("span",[e._v("Loading...")]):a("span",{on:{click:e.updateSure}},[e._v("确定")])])],1)],1),e._v(" "),a("Table",{ref:"table",attrs:{border:"",columns:e.articleCateColumns,data:e.articleCateList,size:"small"}}),e._v(" "),a("div",{staticStyle:{display:"inline-block",float:"right","margin-top":"10px"}},[a("Page",{ref:"page",staticStyle:{"margin-right":"10px"},attrs:{"show-sizer":"","page-size-opts":e.params.pageSizeOpts,current:e.params.currentPage,total:e.params.total,pageSize:e.params.pageSize,"show-total":!0,"show-elevator":""},on:{"on-page-size-change":e.onPageSizeChange,"on-change":e.selectPage}})],1)],1)},staticRenderFns:[]},d=a("VU/8")(l,s,!1,null,null,null);t.default=d.exports}});
//# sourceMappingURL=18.814a6cca2a55720c93ec.js.map