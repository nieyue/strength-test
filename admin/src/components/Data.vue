<!--欢迎页管理 -->
<template>
    <div style="max-width:1200px;margin:auto;" id='dataList'>
        <div style="width:100%;height:20px;"></div>

        <div style="height:100px;display:inline-block;background-color:red;color:#fff;font-weight:bold;padding:0 50px;padding-top:12px; ">
            <div style="display:inline-block;font-size:2rem;" v-text="config.platformName"></div>
            <div></div>
            <div style="display:inline-block;font-size:1.6rem;">少儿体能运动测评</div>
        </div>
        
        <div style="width:100%;height:20px;"></div>

        <div style="height:50px;background-color:#ececec;line-height:50px;font-size:1.6rem;">
            <div style="display:inline-block;width:25%;margin-left:5%">
                <span>姓名:</span>
                <span v-text="assess.account.realname"></span>    
            </div>
            <div style="display:inline-block;width:20%;">
                <span>性别:</span>
                <span v-for="item in sexList" v-if="item.id==assess.sex" v-text="item.value"></span>
            </div>
            <div style="display:inline-block;width:20%;">
                <span>年龄:</span>
                <span ><span v-text="assess.age"></span>岁</span>
            </div>
            <div style="display:inline-block;width:25%;">
                <span>生日:</span>
                <span  v-text="assess.account.birthday?assess.account.birthday.substr(0,10):''"></span>
            </div>
        </div>

        <div style="width:100%;height:20px;"></div>
        
         <div style="background-color:#ececec;">
             <div style="height:50px;display:inline-block;background-color:red;color:#fff;font-weight:bold;font-size:2rem;padding:0 50px;padding-top:5px;">体质概况</div>
             <div style="font-size:1.2rem;text-indent:2rem;padding:0 2rem;">反映了体质测试各项指标的原始成绩、单项评级与合格标准，并能从雷达图中观察近两次体检结果的综合对比。</div>
        </div>   
        <div style="position:relative;left:0;top:0;background-color:#ececec;">
         <my-echarts :options="radarOptions" :config="{style:'width:1200px;height:500px;margin:auto;'}"></my-echarts>
           
            <div v-for="item in assess.assessProjectList" :style="{left:item.position?item.position.left:0,top:item.position?item.position.top:0}" style="padding:5px 0;display:inline-block;background-color:#fff;border:1px solid #f8f8f8;box-shadow:0 0 5px #fff;position:absolute;width:230px;border-radius:5px;">
                <div style="display:inline-block;width:22%;text-align:center;">
                    <img style="width:38px;height:38px;" :src="item.project.icon" alt="">
                    <div style="font-weight:bold;" v-text="item.project.name"></div>
                </div>
                <div style="display:inline-block;height:68px;width:1px;background-color:#ececec;"></div>
                <div style="display:inline-block;width:68%;">
                    <div style="position:absolute;right:3px;top:3px;color:#b3711c;"v-for="item1 in rankList" v-if="item1.id==item.rank" v-text="item1.value"></div>
                    <div style="color:#b3711c;font-size:1.2rem;text-indent:2rem;" ><span v-text="item.score"></span>&nbsp;<span v-text="item.project.unit"></span></div>
                    <div>
                        <span>合格标准:</span>
                        <span>
                            <span v-text="item.standard?item.standard.low:''"></span>
                            <span >~</span>
                            <span v-text="item.standard?item.standard.high:''"></span>
                        </span>
                    </div>
                    <div>
                        <span>测量方式:</span>
                        <span v-text="item.standard?item.standard.item:''"></span>
                    </div>
                    <div class="triangle-right">
                    </div>
                </div>
            </div>
        </div>

<div style="width:100%;height:20px;"></div>
        <div style="background-color:#ececec;">
             <div style="height:50px;display:inline-block;background-color:red;color:#fff;font-weight:bold;font-size:2rem;padding:0 50px;padding-top:5px;">评级概况</div>
             <div style="font-size:1.2rem;text-indent:2rem;padding:0 2rem;">反映了孩子参与体质测试项目评级（不良、未达、合格、良好、优秀）的比例、并从两次对比中可以观察到测试评级比例的变化情况。</div>
             <div>
                <my-echarts :options="pieOptions" :config="{style:'width:500px;height:500px;display:inline-block;'}"></my-echarts>
                <my-echarts :options="pieOptions2" :config="{style:'width:500px;height:500px;display:inline-block;'}"></my-echarts>
             </div>
        </div> 
        
<div style="width:100%;height:20px;"></div>
        <div style="background-color:#ececec;">
             <div style="height:50px;display:inline-block;background-color:red;color:#fff;font-weight:bold;font-size:2rem;padding:0 50px;padding-top:5px;">体检记录</div>
        </div> 

        <div style="width:100%;height:20px;"></div>
          
    </div>
</template>
<script>
import html2canvas from 'html2canvas'
export default {
  name: 'Data',
  data () {
    return {
        params:{
            startNum:1,//初始化个数
            currentPage:1,//当前页
            pageNum:1,//获取的第几个开始
            pageSize:2,//每页的个数
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
        //性别
        sexList:[
        {id:1,value:'男性'},
        {id:2,value:'女性'},
        {id:3,value:'未知'}
        ],
        configList:[],
        config:{},
        assessId:JSON.parse(this.$route.params.pathParams).assessId,
        assess:{account:{}},
        //数据配置
        radarOptions:{},
        pieOptions:{},
        pieOptions2:{},
        //图表数据
        radarData:{
            dateList:[],//日期
            assessProjectList:[],//数据
        }
    }
  },
  methods: {
      //获取
      getConfig(){
         //获取
          this.axiosbusiness.getList(this,{
            countUrl:'/config/count',
            listUrl:'/config/list',
            data:'configList',
            success:()=>{
             this.config=this.configList[0]
             this.getAssess()
            }
            },this.params)
      },
      //获取测评
      getAssess(){
         /* //获取修改实体
      this.axiosbusiness.get(this,{
         url:'/assess/load?assessId='+this.assessId,
         data:'assess',
         success:()=>{
             console.log(this.assess)
         }
         }) */ 
          //获取
          this.axiosbusiness.getList(this,{
            countUrl:'/assess/count',
            listUrl:'/assess/data',
            data:'assessList',
            success:()=>{
             this.assess=this.assessList[0]
             this.assessList.forEach(e=>{
                 //雷达图时间
                this.radarData.dateList.push(this.utils.getDate(e.createDate))
                //雷达图数据
                var apl=[]
                e.assessProjectList.forEach(element=>{
                    if(element.project.name=='身高'){
                        //7
                       apl[7]= element.rank
                }else if(element.project.name=='体重'){
                    //6
                    apl[6]= element.rank
                }else if(element.project.name=='平衡力'){
                    //5
                    apl[5]= element.rank
                }else if(element.project.name=='综合肺活'){
                    //4
                    apl[4]= element.rank
                }else if(element.project.name=='上肢力量'){
                    //3
                    apl[3]= element.rank
                }else if(element.project.name=='下肢力量'){
                    //2
                    apl[2]= element.rank
                }else if(element.project.name=='柔韧性'){
                    //1
                    apl[1]= element.rank
                }else if(element.project.name=='灵敏性'){
                    //0
                    apl[0]= element.rank
                }

                })
                this.radarData.assessProjectList.push({name:this.utils.getDate(e.createDate),value:apl})
             })

            //添加下图形位置
            this.assess.assessProjectList.forEach(element => {
                element.position={}
                if(element.project.name=='身高'){
                    element.position.left='21%'
                    element.position.top='5%'
                }else if(element.project.name=='体重'){
                    element.position.left='60%'
                    element.position.top='5%'
                }else if(element.project.name=='平衡力'){
                    element.position.left='69%'
                    element.position.top='26%'
                }else if(element.project.name=='综合肺活'){
                    element.position.left='70%'
                    element.position.top='56%'
                }else if(element.project.name=='上肢力量'){
                    element.position.left='62%'
                    element.position.top='77%'
                }else if(element.project.name=='下肢力量'){
                    element.position.left='19%'
                    element.position.top='77%'
                }else if(element.project.name=='柔韧性'){
                    element.position.left='11%'
                    element.position.top='56%'
                }else if(element.project.name=='灵敏性'){
                    element.position.left='11%'
                    element.position.top='26%'
                }

                
                
            });    
            console.log(this.assess)
            }
            },this.params) 

      },

      //初始化雷达
    initRadarData(radarData){
    this.radarOptions={
         title: {
            text: ''
        },
        tooltip: {
           // trigger: 'axis'
        },
        legend: {
            x:'center',
            bottom:'0px',
            data: radarData.dateList
        },
        radar: {
            // shape: 'circle',
           // show:false,
            radius:180,
             /* name: {
                textStyle: {
                    color: '#333',
                    backgroundColor: '#fff',
                    borderColor: '#ececec',
                    borderWidth: 2,
                    borderRadius: 3,
                    padding: [3, 5]
            },
                formatter:[
                    '{icon|}',
                    '大师傅|似的sdfdsf2 ',
                    '大师傅|似的sdfdsf3',
                ].join('\n'), 
                rich:{
                    icon:{
                        height: 30,
                        align: 'left',
                        backgroundColor:{
                            image:'http://localhost:8080/uploaderPath/img/20190709/1562672715989.png'
                        }
                    }
                }
            },   */
            indicator: [
                 { name: '灵敏性',max:'5'},
                { name: '柔韧性',max:'5'},
                { name: '下肢力量',max:'5'},
                { name: '上肢力量',max:'5'},
                { name: '综合肺活',max:'5'},
                { name: '平衡力',max:'5'},
                { name: '体重',max:'5'},
                { name: '身高',max:'5'},
                /*  { name: '灵敏性',max:'100'},
                { name: '柔韧性',max:'100'},
                { name: '下肢力量',max:'50'},
                { name: '上肢力量',max:'500'},
                { name: '综合肺活',max:'5000'},
                { name: '平衡力',max:'100'},
                { name: '体重',max:'200'},
                { name: '身高',max:'300'}, */
            ],
            startAngle: 158
        },
        
       /*   splitLine: {//雷达线
                    show: true,
                    lineStyle: {
                        color: '#306eff',
                        width: 22,
                    }
        }, */
        series: [{
            name: '',
            type: 'radar',
            itemStyle:{normal:{areaStyle:{type:'default'}}},
             //areaStyle: {normal: {}},
            data : radarData.assessProjectList
          /*   [
                {
                    name : this.utils.getDate(new Date(new Date().getTime()-24*60*60*1000).getTime()),
                    value : [3, 2, 3, 0, 3, 4,4,1],
                },
                {
                    name : this.utils.getDate(new Date().getTime()),
                    value : [3, 2, 4, 0, 4, 5,5,2],
                }
            ] */
        }]
        }

        setTimeout(()=>{
          html2canvas(document.getElementById('dataList'),{
              useCORS:true,
              proxy: this.axios.defaults.baseURL,
              logging: false
          })
        .then(function(canvas) {
        // document.body.appendChild(canvas);
            var context = canvas.getContext('2d');

        // var img = new Image();
            var img = document.createElement("img");
            img.src = canvas.toDataURL("image/jpg")
            img.crossOrigin = 'Anonymous'
            img.id = 'poster'

            document.body.appendChild(img);

    /* let saveUrl = canvas.toDataURL('image/png')
    let a = document.createElement('a')
    document.body.appendChild(a)
    a.href = saveUrl
    a.download = '这是图片标题'
    a.click() */
    });
 
      },1000)
    },
    initPieData(){
        this.pieOptions = {
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b}: {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                left: 50,
                top: 20,
                bottom: 20,
                data:['直达','营销广告','搜索引擎','邮件营销','联盟广告','视频广告','百度','谷歌','必应','其他']
            },
            series: [
                {
                    name:'访问来源',
                    type:'pie',
                    selectedMode: 'single',
                    radius: [0, '30%'],

                    label: {
                        normal: {
                            position: 'inner'
                        }
                    },
                    labelLine: {
                        normal: {
                            show: false
                        }
                    },
                /* data:[
                        {value:335, name:'直达', selected:true},
                        {value:679, name:'营销广告'},
                        {value:1548, name:'搜索引擎'}
                    ]*/
                },
                {
                    name:'访问来源',
                    type:'pie',
                    radius: ['40%', '55%'],
                    label: {
                        normal: {
                            formatter: ' {d}%  ',
                            backgroundColor: '#eee',
                            borderWidth: 1,
                        
                        }
                    },
                    data:[
                        {value:335, name:'直达'},
                        {value:310, name:'邮件营销'},
                        {value:234, name:'联盟广告'},
                        {value:135, name:'视频广告'},
                        {value:1048, name:'百度'},
                        {value:251, name:'谷歌'},
                        {value:147, name:'必应'},
                        {value:102, name:'其他'}
                    ]
                }
            ]
        };
    },
    initData(){
    this.options={
       /*  title: {
            text: ''
        }, */
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            bottom:0,
            data:['按阅读计费','按位置计费']
        },
        toolbox: {
            feature: {
                dataView: {readOnly: false},
                magicType: {type: ['line', 'bar','stack','tiled']},
                restore: {},
                saveAsImage: {}
            }
        },
        xAxis: {
            type: 'category',
            boundaryGap:  false,
        //data: list.createDates  
        data:echartsData.dateList 
        },
        yAxis: [
            {
                type: 'value',
                // scale: true,
                name: '数量'
                ,min: 0,
                boundaryGap: [0.2, 0.2]
            }
        ],
        series: [
            {
                name:'按阅读计费',
                type:'line',
                data: echartsData.readingNumbers
            },
            {
                name:'按位置计费',
                type:'line',
                data: echartsData.positionNumbers
            },
            ]
        }
    }
  },
  created () {
      this.getConfig()
      this.initRadarData(this.radarData)
      //this.initData(this.echartsData)
      this.initPieData()
      
  },
  mounted () {

  }
}
</script>

<style >
    .triangle-right{
        /* border-top:10px solid transparent;
        border-bottom:10px solid transparent;
        border-left:10px solid #fff; */
        position:absolute;
        right:-10px;
        top:50%;
        margin-top:-10px;
        }
        .triangle-left{
            /* border-top:10px solid transparent;
            border-bottom:10px solid transparent;
            border-right:10px solid #fff; */
            position:absolute;
            left:-10px;
            top:50%;
            margin-top:-10px;
        }
</style>

