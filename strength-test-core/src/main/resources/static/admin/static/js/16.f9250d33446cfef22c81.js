webpackJsonp([16],{g67D:function(t,e,a){"use strict";Object.defineProperty(e,"__esModule",{value:!0});var n=a("mvHQ"),s=a.n(n),o={name:"StudentAccount",data:function(){var t=this;return{routerPath:this.$route.path,params:{pageSizeOpts:[10,20,50,100,500,1e3],startNum:1,currentPage:1,pageNum:1,pageSize:10,total:0},statusParamsList:[{id:"",value:"全部"},{id:1,value:"正常"},{id:2,value:"封禁"},{id:3,value:"异常"}],authParamsList:[{id:"",value:"全部"},{id:1,value:"没认证"},{id:2,value:"审核中"},{id:3,value:"已认证"}],sexList:[{id:1,value:"男性"},{id:2,value:"女性"},{id:3,value:"未知"}],statusList:[{id:1,value:"正常"},{id:2,value:"封禁"},{id:3,value:"异常"}],authList:[{id:1,value:"没认证"},{id:2,value:"审核中"},{id:3,value:"已认证"}],addAccountModel:!1,addLoading:!1,addAccountRules:{phone:[{required:!0,message:"手机号为必填项",trigger:"blur"}]},addAccount:{},updateAccountModel:!1,updateLoading:!1,updateAccountRules:{phone:[{required:!0,message:"手机号为必填项",trigger:"blur"}]},updateAccount:{},deleteAccount:{},roleList:[],accountList:[],accountColumns:[{type:"selection",width:60,align:"center"},{title:"序号",minWidth:100,align:"center",render:function(e,a){return e("span",a.index+(t.params.currentPage-1)*t.params.pageSize+t.params.startNum)}},{title:"姓名",key:"realname",minWidth:100,align:"center"},{title:"性别",key:"sex",minWidth:100,align:"center",render:function(e,a){var n="";return t.sexList.forEach(function(t){t.id==a.row.sex&&(n=t.value)}),e("span",n)}},{title:"年龄",key:"age",minWidth:100,align:"center"},{title:"生日",key:"birthday",minWidth:100,align:"center",render:function(t,e){return t("span",e.row.birthday.substr(0,10))}},{title:"手机号",key:"phone",minWidth:100,align:"center"},{title:"状态",key:"status",minWidth:100,align:"center",render:function(e,a){var n="";return t.statusList.forEach(function(t){t.id==a.row.status&&(n=t.value)}),e("span",n)}},{title:"创建时间",key:"createDate",minWidth:100,sortable:!0,align:"center"},{title:"最后登陆时间",key:"loginDate",minWidth:100,sortable:!0,align:"center"},{title:"操作",key:"action",minWidth:200,fixed:"right",align:"center",render:function(e,a){var n=e("Button",{props:{type:"primary",size:"small"},style:{margin:"2px"},on:{click:function(){t.update(a.row)}}},"编辑"),o=e("Button",{props:{type:"error",size:"small"},style:{margin:"2px"},on:{click:function(){t.delete(a.row)}}},"删除"),i=(e("Button",{props:{type:"primary",ghost:"",size:"small"},style:{margin:"2px"},on:{click:function(){var e=s()({currentPage:1,accountId:a.row.accountId});t.$router.push("/main/finance/"+e),setTimeout(function(){t.Hub.$emit("navroad",t.$router.currentRoute)},200)}}},"财务"),e("Button",{props:{type:"error",ghost:"",size:"small"},style:{margin:"2px"},on:{click:function(){var e=s()({currentPage:1,accountId:a.row.accountId});t.$router.push("/main/financeRecord/"+e),setTimeout(function(){t.Hub.$emit("navroad",t.$router.currentRoute)},200)}}},"财务记录"),e("Button",{props:{type:"info",ghost:"",size:"small"},style:{margin:"2px"},on:{click:function(){var e=s()({currentPage:1,accountId:a.row.accountId});t.$router.push("/main/receiptInfo/"+e),setTimeout(function(){t.Hub.$emit("navroad",t.$router.currentRoute)},200)}}},"收货信息"),e("Button",{props:{type:"info",ghost:"",size:"small"},style:{margin:"2px"},on:{click:function(){var e=s()({currentPage:1,accountId:a.row.accountId});t.$router.push("/main/assess/"+e),setTimeout(function(){t.Hub.$emit("navroad",t.$router.currentRoute)},200)}}},"测评"));e("div","");return t.business.getIsSuperAdmin()?e("div",[e("div",[n,o]),e("div",[]),e("div",[i])]):e("div",[e("div",[]),e("div",[i])])}}]}},methods:{search:function(){this.params.currentPage=1,this.params.pageNum=1,this.getList()},selectPage:function(t){this.params.currentPage=t,this.params.pageNum=(this.params.currentPage-1)*this.params.pageSize+this.params.startNum,this.getList()},onPageSizeChange:function(t){this.getList(t)},getAddBirthday:function(t){this.addAccount.birthday=t+" 00:00:00",console.log(this.addAccount.birthday)},getUpdateBirthday:function(t){this.updateAccount.birthday=t+" 00:00:00"},getParamsCreateDate:function(t){this.params.createDate=t+" 00:00:00"},getRoleList:function(){var t=this;this.params.pageSize=1e6,this.axiosbusiness.getList(this,{countUrl:"/role/count",listUrl:"/role/list",data:"roleList",success:function(){for(var e=t.roleList.length,a=0;a<e;a++)t.business.getIsUserAdmin()||"用户"==t.roleList[a].name||(t.roleList.splice(a,1),e--,a--);t.roleList[0]&&t.roleList[0].roleId&&(t.params.roleId=t.roleList[0].roleId,t.addAccount.roleId=t.roleList[0].roleId),t.getList(10)}},this.params)},getList:function(t){this.params.pageSize=t||this.params.pageSize,this.axiosbusiness.getList(this,{countUrl:"/account/count",listUrl:"/account/list",data:"accountList"},this.params)},add:function(t){this.addAccountModel=!0,this.addAccount={icon:"",sex:1,status:1,roleId:this.roleList[0].roleId}},addCancel:function(){this.addLoading||(this.addAccountModel=!1,this.$refs.addAccount.resetFields())},addSure:function(){this.axiosbusiness.add(this,{ref:"addAccount",url:"/account/add",requestObject:"addAccount",loading:"addLoading",showModel:"addAccountModel"})},update:function(t){this.updateAccountModel=!0,this.updateAccount.accountId=t.accountId,this.axiosbusiness.get(this,{url:"/account/load?accountId="+t.accountId,data:"updateAccount",success:function(){}})},updateCancel:function(){this.updateLoading||(this.updateAccountModel=!1,this.$refs.updateAccount.resetFields())},updateSure:function(){delete this.updateAccount.role,this.axiosbusiness.update(this,{ref:"updateAccount",url:"/account/update",requestObject:"updateAccount",loading:"updateLoading",showModel:"updateAccountModel"})},delete:function(t){this.deleteAccount={accountId:t.accountId},this.axiosbusiness.delete(this,{url:"/account/delete",requestObject:"deleteAccount"})},authExamine:function(t){var e=this,a="?accountId="+this.business.getAccount().accountId;a+="&targetAccountId="+t.accountId,this.$Modal.confirm({title:"审核认证",content:"审核通过吗？",okText:"审核通过",onOk:function(){a+="&auth=3",e.axiosbusiness.get(e,{url:"/account/authExamine"+a,success:function(){e.$Message.success("审核通过")}})},cancelText:"驳回",onCancel:function(){a+="&auth=1",e.axiosbusiness.get(e,{url:"/account/authExamine"+a,success:function(){e.$Message.info("驳回成功"),t.auth=1}})}})},updateInviteCode:function(t){var e=this,a="?accountId="+this.business.getAccount().accountId;a+="&targetAccountId="+t.accountId,this.$Modal.confirm({title:"更新邀请码",content:"确认更新邀请码吗？",onOk:function(){e.axiosbusiness.get(e,{url:"/account/updateInviteCode"+a,success:function(a){e.$Message.success("更新成功"),t.inviteCode=a.data.data[0].inviteCode}})},onCancel:function(){e.$Message.info("取消")}})},exportAccount:function(){var t=this.$refs.table.getSelection();t.length<=0?this.$Message.error("最少选一个"):(t.forEach(function(t){1==t.sex?t.sex="男性":2==t.sex?t.sex="女性":t.sex="未知",1==t.auth?t.auth="审核中":2==t.auth?t.auth="已认证":t.auth="没认证",2==t.status?t.status="封禁":3==t.status?t.status="异常":t.status="正常"}),this.$refs.table.exportCsv({filename:"用户数据",columns:this.accountColumns.filter(function(t,e){return e>=2}),data:t}))}},watch:{$route:function(t,e){this.routerPath=this.$route.path,this.getRoleList()}},created:function(){this.getRoleList()},mounted:function(){}},i={render:function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",{staticClass:"body-wrap"},[a("div",{staticClass:"body-btn-wrap"},[t.business.getIsSuperAdmin()?a("Button",{attrs:{type:"primary"},on:{click:t.add}},[t._v("增加用户")]):t._e(),t._v(" "),a("Button",{staticStyle:{margin:"0 20px"},attrs:{type:"info"},on:{click:t.exportAccount}},[t._v("账户导出")]),t._v(" "),a("div",{staticClass:"search-wrap"},[a("Input",{staticClass:"search-wrap-input",attrs:{placeholder:"真实姓名"},model:{value:t.params.realname,callback:function(e){t.$set(t.params,"realname",e)},expression:"params.realname"}}),t._v(" "),a("Select",{staticClass:"search-wrap-input",attrs:{transfer:"",placeholder:"状态，全部"},model:{value:t.params.status,callback:function(e){t.$set(t.params,"status",e)},expression:"params.status"}},t._l(t.statusParamsList,function(e){return a("Option",{key:e.id,attrs:{value:e.id}},[t._v(t._s(e.value))])})),t._v(" "),a("Button",{attrs:{type:"info"},on:{click:t.search}},[t._v("查询")])],1)],1),t._v(" "),a("Modal",{attrs:{title:"新增用户管理",closable:!1,"mask-closable":!1,width:"1000px"},model:{value:t.addAccountModel,callback:function(e){t.addAccountModel=e},expression:"addAccountModel"}},[a("Form",{ref:"addAccount",attrs:{model:t.addAccount,"label-width":100,"label-position":"right",rules:t.addAccountRules}},[a("FormItem",{attrs:{prop:"realname",label:"姓名:"}},[a("Input",{attrs:{type:"text",placeholder:"姓名"},model:{value:t.addAccount.realname,callback:function(e){t.$set(t.addAccount,"realname",e)},expression:"addAccount.realname"}})],1),t._v(" "),a("FormItem",{attrs:{prop:"sex",label:"性别:"}},[a("Select",{staticStyle:{width:"100px"},attrs:{transfer:"",size:"large"},model:{value:t.addAccount.sex,callback:function(e){t.$set(t.addAccount,"sex",e)},expression:"addAccount.sex"}},t._l(t.sexList,function(e){return a("Option",{key:e.id,attrs:{value:e.id}},[t._v(t._s(e.value))])}))],1),t._v(" "),a("FormItem",{attrs:{prop:"phone",label:"手机:"}},[a("Input",{attrs:{type:"text",placeholder:"手机"},model:{value:t.addAccount.phone,callback:function(e){t.$set(t.addAccount,"phone",e)},expression:"addAccount.phone"}})],1),t._v(" "),a("FormItem",{attrs:{label:"生日:"}},[a("DatePicker",{staticStyle:{width:"300px"},attrs:{type:"date",placeholder:"生日",format:"yyyy-MM-dd"},on:{"on-change":t.getAddBirthday}})],1),t._v(" "),a("FormItem",{attrs:{prop:"status",label:"状态:"}},[a("Select",{staticStyle:{width:"100px"},attrs:{transfer:"",size:"large"},model:{value:t.addAccount.status,callback:function(e){t.$set(t.addAccount,"status",e)},expression:"addAccount.status"}},t._l(t.statusList,function(e){return a("Option",{key:e.id,attrs:{value:e.id}},[t._v(t._s(e.value))])}))],1)],1),t._v(" "),a("div",{attrs:{slot:"footer"},slot:"footer"},[a("Button",{on:{click:t.addCancel}},[t._v("取消")]),t._v(" "),a("Button",{attrs:{type:"primary",loading:t.addLoading}},[t.addLoading?a("span",[t._v("Loading...")]):a("span",{on:{click:t.addSure}},[t._v("确定")])])],1)],1),t._v(" "),a("Modal",{attrs:{title:"修改用户管理",closable:!1,"mask-closable":!1,width:"1000px"},model:{value:t.updateAccountModel,callback:function(e){t.updateAccountModel=e},expression:"updateAccountModel"}},[a("Form",{ref:"updateAccount",attrs:{model:t.updateAccount,"label-width":100,"label-position":"right",rules:t.updateAccountRules}},[a("FormItem",{attrs:{prop:"realname",label:"姓名:"}},[a("Input",{attrs:{type:"text",placeholder:"姓名"},model:{value:t.updateAccount.realname,callback:function(e){t.$set(t.updateAccount,"realname",e)},expression:"updateAccount.realname"}})],1),t._v(" "),a("FormItem",{attrs:{prop:"sex",label:"性别:"}},[a("Select",{staticStyle:{width:"100px"},attrs:{transfer:"",size:"large"},model:{value:t.updateAccount.sex,callback:function(e){t.$set(t.updateAccount,"sex",e)},expression:"updateAccount.sex"}},t._l(t.sexList,function(e){return a("Option",{key:e.id,attrs:{value:e.id}},[t._v(t._s(e.value))])}))],1),t._v(" "),a("FormItem",{attrs:{prop:"phone",label:"手机:"}},[a("Input",{attrs:{type:"text",placeholder:"手机"},model:{value:t.updateAccount.phone,callback:function(e){t.$set(t.updateAccount,"phone",e)},expression:"updateAccount.phone"}})],1),t._v(" "),a("FormItem",{attrs:{label:"生日:"}},[a("DatePicker",{staticStyle:{width:"300px"},attrs:{type:"date",placeholder:"生日",format:"yyyy-MM-dd"},on:{"on-change":t.getUpdateBirthday},model:{value:t.updateAccount.birthday,callback:function(e){t.$set(t.updateAccount,"birthday",e)},expression:"updateAccount.birthday"}})],1),t._v(" "),a("FormItem",{attrs:{prop:"status",label:"状态:"}},[a("Select",{staticStyle:{width:"100px"},attrs:{transfer:"",size:"large"},model:{value:t.updateAccount.status,callback:function(e){t.$set(t.updateAccount,"status",e)},expression:"updateAccount.status"}},t._l(t.statusList,function(e){return a("Option",{key:e.id,attrs:{value:e.id}},[t._v(t._s(e.value))])}))],1)],1),t._v(" "),a("div",{attrs:{slot:"footer"},slot:"footer"},[a("Button",{on:{click:t.updateCancel}},[t._v("取消")]),t._v(" "),a("Button",{attrs:{type:"primary",loading:t.updateLoading}},[t.updateLoading?a("span",[t._v("Loading...")]):a("span",{on:{click:t.updateSure}},[t._v("确定")])])],1)],1),t._v(" "),a("Table",{ref:"table",attrs:{border:"",height:"500",columns:t.accountColumns,data:t.accountList,size:"small"}}),t._v(" "),a("div",{staticStyle:{display:"inline-block",float:"right","margin-top":"10px"}},[a("Page",{ref:"page",staticStyle:{"margin-right":"10px"},attrs:{"show-sizer":"","page-size-opts":t.params.pageSizeOpts,current:t.params.currentPage,total:t.params.total,pageSize:t.params.pageSize,"show-total":!0,"show-elevator":""},on:{"on-page-size-change":t.onPageSizeChange,"on-change":t.selectPage}})],1)],1)},staticRenderFns:[]},c=a("VU/8")(o,i,!1,null,null,null);e.default=c.exports}});
//# sourceMappingURL=16.f9250d33446cfef22c81.js.map