<!--欢迎页管理 -->
<template>
    <div style="max-width:1200px;margin:auto;" id='dataList'>
        <div style="width:100%;height:20px;"></div>

        <div style="height:100px;display:inline-block;background-color:red;color:#fff;font-weight:bold;padding:0 50px;padding-top:12px; ">
            <div style="display:inline-block;font-size:2rem;">LTX-GIVEMEFIVE</div>
            <div></div>
            <div style="display:inline-block;font-size:1.6rem;">少儿体能运动测评</div>
        </div>
        
        <div style="width:100%;height:20px;"></div>

        <div style="height:50px;background-color:#ececec;line-height:50px;font-size:1.6rem;">
            <div style="display:inline-block;width:25%;margin-left:5%">
                <span>姓名:</span>
                <span>王大锤</span>    
            </div>
            <div style="display:inline-block;width:20%;">
                <span>性别:</span>
                <span>男</span>
            </div>
            <div style="display:inline-block;width:20%;">
                <span>年龄:</span>
                <span>5岁</span>
            </div>
            <div style="display:inline-block;width:25%;">
                <span>生日</span>
                <span>2013-05-11</span>
            </div>
        </div>

        <div style="width:100%;height:20px;"></div>
        
         <div style="background-color:#ececec;">
             <div style="height:50px;display:inline-block;background-color:red;color:#fff;font-weight:bold;font-size:2rem;padding:0 50px;padding-top:5px;">体质概况</div>
             <div style="font-size:1.2rem;text-indent:2rem;padding:0 2rem;">反映了体质测试各项指标的原始成绩、单项评级与合格标准，并能从雷达图中观察近两次体检结果的综合对比。</div>
        </div>   
        <div style="position:relative;left:0;top:0;background-color:#ececec;">
         <my-echarts :options="options" :config="{style:'width:1200px;height:500px;margin:auto;'}"></my-echarts>
           
            <div style="left:21%;top:5%;padding:5px 0;display:inline-block;background-color:#fff;border:1px solid #f8f8f8;box-shadow:0 0 5px #fff;position:absolute;width:230px;border-radius:5px;">
                <div style="display:inline-block;width:30%;text-align:center;">
                    <img style="width:38px;" src="http://localhost:8080/uploaderPath/img/20190709/1562672687811.png" alt="">
                    <div style="font-weight:bold;">身高</div>
                </div>
                <div style="display:inline-block;height:68px;width:1px;background-color:#ececec;"></div>
                <div style="display:inline-block;width:60%;">
                    <div style="position:absolute;right:3px;top:3px;color:#b3711c;">合格</div>
                    <div style="color:#b3711c;font-size:1.2rem;text-indent:2rem;">98cm</div>
                    <div>
                        <span>合格标准:</span>
                        <span>>=97.6cm</span>
                    </div>
                    <div>
                        <span>测量方式:</span>
                        <span>尺量</span>
                    </div>
                    <div class="triangle-right"></div>
                </div>
            </div>
            
             <div style="left:60%;top:5%;padding:5px 0;display:inline-block;background-color:#fff;border:1px solid #f8f8f8;box-shadow:0 0 5px #fff;position:absolute;width:230px;border-radius:5px;">
                <div style="display:inline-block;width:30%;text-align:center;">
                    <img style="width:38px;" src="http://localhost:8080/uploaderPath/img/20190709/1562672687811.png" alt="">
                    <div style="font-weight:bold;">体重</div>
                </div>
                <div style="display:inline-block;height:68px;width:1px;background-color:#ececec;"></div>
                <div style="display:inline-block;width:60%;">
                    <div style="position:absolute;right:3px;top:3px;color:#b3711c;">合格</div>
                    <div style="color:#b3711c;font-size:1.2rem;text-indent:2rem;">98cm</div>
                    <div>
                        <span>合格标准:</span>
                        <span>>=97.6cm</span>
                    </div>
                    <div>
                        <span>测量方式:</span>
                        <span>尺量</span>
                    </div>
                    <div class="triangle-left" ></div>
                </div>
            </div>

             <div style="left:69%;top:26%;padding:5px 0;display:inline-block;background-color:#fff;border:1px solid #f8f8f8;box-shadow:0 0 5px #fff;position:absolute;width:230px;border-radius:5px;">
                <div style="display:inline-block;width:30%;text-align:center;">
                    <img style="width:38px;" src="http://localhost:8080/uploaderPath/img/20190709/1562672687811.png" alt="">
                    <div style="font-weight:bold;">平衡力</div>
                </div>
                <div style="display:inline-block;height:68px;width:1px;background-color:#ececec;"></div>
                <div style="display:inline-block;width:60%;">
                    <div style="position:absolute;right:3px;top:3px;color:#b3711c;">合格</div>
                    <div style="color:#b3711c;font-size:1.2rem;text-indent:2rem;">98cm</div>
                    <div>
                        <span>合格标准:</span>
                        <span>>=97.6cm</span>
                    </div>
                    <div>
                        <span>测量方式:</span>
                        <span>尺量</span>
                    </div>
                    <div class="triangle-left" ></div>
                </div>
            </div>

            <div style="left:70%;top:56%;padding:5px 0;display:inline-block;background-color:#fff;border:1px solid #f8f8f8;box-shadow:0 0 5px #fff;position:absolute;width:230px;border-radius:5px;">
                <div style="display:inline-block;width:30%;text-align:center;">
                    <img style="width:38px;" src="http://localhost:8080/uploaderPath/img/20190709/1562672687811.png" alt="">
                    <div style="font-weight:bold;">综合肺活</div>
                </div>
                <div style="display:inline-block;height:68px;width:1px;background-color:#ececec;"></div>
                <div style="display:inline-block;width:60%;">
                    <div style="position:absolute;right:3px;top:3px;color:#b3711c;">合格</div>
                    <div style="color:#b3711c;font-size:1.2rem;text-indent:2rem;">98cm</div>
                    <div>
                        <span>合格标准:</span>
                        <span>>=97.6cm</span>
                    </div>
                    <div>
                        <span>测量方式:</span>
                        <span>尺量</span>
                    </div>
                    <div class="triangle-left" ></div>
                </div>
            </div>

            <div style="left:62%;top:77%;padding:5px 0;display:inline-block;background-color:#fff;border:1px solid #f8f8f8;box-shadow:0 0 5px #fff;position:absolute;width:230px;border-radius:5px;">
                <div style="display:inline-block;width:30%;text-align:center;">
                    <img style="width:38px;" src="http://localhost:8080/uploaderPath/img/20190709/1562672687811.png" alt="">
                    <div style="font-weight:bold;">上肢力量</div>
                </div>
                <div style="display:inline-block;height:68px;width:1px;background-color:#ececec;"></div>
                <div style="display:inline-block;width:60%;">
                    <div style="position:absolute;right:3px;top:3px;color:#b3711c;">合格</div>
                    <div style="color:#b3711c;font-size:1.2rem;text-indent:2rem;">98cm</div>
                    <div>
                        <span>合格标准:</span>
                        <span>>=97.6cm</span>
                    </div>
                    <div>
                        <span>测量方式:</span>
                        <span>尺量</span>
                    </div>
                    <div class="triangle-left" ></div>
                </div>
            </div>

            <div style="left:19%;top:77%;padding:5px 0;display:inline-block;background-color:#fff;border:1px solid #f8f8f8;box-shadow:0 0 5px #fff;position:absolute;width:230px;border-radius:5px;">
                <div style="display:inline-block;width:30%;text-align:center;">
                    <img style="width:38px;" src="http://localhost:8080/uploaderPath/img/20190709/1562672687811.png" alt="">
                    <div style="font-weight:bold;">下肢力量</div>
                </div>
                <div style="display:inline-block;height:68px;width:1px;background-color:#ececec;"></div>
                <div style="display:inline-block;width:60%;">
                    <div style="position:absolute;right:3px;top:3px;color:#b3711c;">合格</div>
                    <div style="color:#b3711c;font-size:1.2rem;text-indent:2rem;">98cm</div>
                    <div>
                        <span>合格标准:</span>
                        <span>>=97.6cm</span>
                    </div>
                    <div>
                        <span>测量方式:</span>
                        <span>尺量</span>
                    </div>
                    <div class="triangle-right" ></div>
                </div>
            </div>

            <div style="left:11%;top:56%;padding:5px 0;display:inline-block;background-color:#fff;border:1px solid #f8f8f8;box-shadow:0 0 5px #fff;position:absolute;width:230px;border-radius:5px;">
                <div style="display:inline-block;width:30%;text-align:center;">
                    <img style="width:38px;" src="http://localhost:8080/uploaderPath/img/20190709/1562672687811.png" alt="">
                    <div style="font-weight:bold;">柔韧性</div>
                </div>
                <div style="display:inline-block;height:68px;width:1px;background-color:#ececec;"></div>
                <div style="display:inline-block;width:60%;">
                    <div style="position:absolute;right:3px;top:3px;color:#b3711c;">合格</div>
                    <div style="color:#b3711c;font-size:1.2rem;text-indent:2rem;">98cm</div>
                    <div>
                        <span>合格标准:</span>
                        <span>>=97.6cm</span>
                    </div>
                    <div>
                        <span>测量方式:</span>
                        <span>尺量</span>
                    </div>
                    <div class="triangle-right" ></div>
                </div>
            </div>
            
            <div style="left:11%;top:26%;padding:5px 0;display:inline-block;background-color:#fff;border:1px solid #f8f8f8;box-shadow:0 0 5px #fff;position:absolute;width:230px;border-radius:5px;">
                <div style="display:inline-block;width:30%;text-align:center;">
                    <img style="width:38px;" src="http://localhost:8080/uploaderPath/img/20190709/1562672687811.png" alt="">
                    <div style="font-weight:bold;">灵敏性</div>
                </div>
                <div style="display:inline-block;height:68px;width:1px;background-color:#ececec;"></div>
                <div style="display:inline-block;width:60%;">
                    <div style="position:absolute;right:3px;top:3px;color:#b3711c;">合格</div>
                    <div style="color:#b3711c;font-size:1.2rem;text-indent:2rem;">98cm</div>
                    <div>
                        <span>合格标准:</span>
                        <span>>=97.6cm</span>
                    </div>
                    <div>
                        <span>测量方式:</span>
                        <span>尺量</span>
                    </div>
                    <div class="triangle-right" ></div>
                </div>
            </div>
        </div>

<div style="width:100%;height:20px;"></div>
        <div style="background-color:#ececec;">
             <div style="height:50px;display:inline-block;background-color:red;color:#fff;font-weight:bold;font-size:2rem;padding:0 50px;padding-top:5px;">评级概况</div>
             <div style="font-size:1.2rem;text-indent:2rem;padding:0 2rem;">反映了孩子参与体质测试项目评级（不良、未达、合格、良好、优秀）的比例、并从两次对比中可以观察到测试评级比例的变化情况。</div>
        </div> 
<div style="width:100%;height:20px;"></div>
        <div style="background-color:#ececec;">
             <div style="height:50px;display:inline-block;background-color:red;color:#fff;font-weight:bold;font-size:2rem;padding:0 50px;padding-top:5px;">体检记录</div>
        </div> 

        <div style="width:100%;height:20px;"></div>
        <my-echarts :options="options" :config="{style:'width:750px;height:500px;margin:auto;'}"></my-echarts>
          
    </div>
</template>
<script>
export default {
  name: 'Data',
  data () {
    return {
        //数据配置
        options:{},
        //图表数据
        echartsData:{
            dateList:[],
            readingNumbers:[],
            positionNumbers:[],
        }
    }
  },
  methods: {
      //初始化雷达
    initRadarData(echartsData){
    this.options={
         title: {
            text: ''
        },
        tooltip: {
           // trigger: 'axis'
        },
        legend: {
            x:'center',
            bottom:'0px',
            data: [new Date(new Date().getTime()-24*60*60*1000).getTime(), new Date().getTime()]
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
                 { name: '灵敏性',max:'100'},
                { name: '柔韧性',max:'100'},
                { name: '下肢力量',max:'50'},
                { name: '上肢力量',max:'500'},
                { name: '综合肺活',max:'5000'},
                { name: '平衡力',max:'100'},
                { name: '体重',max:'200'},
                { name: '身高',max:'300'},
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
            data : [
                {
                    value : [21, -12, 33, 233, 444, 45,23,98],
                    name : new Date(new Date().getTime()-24*60*60*1000).getTime()
                },
                {
                    value : [12, 6, 25, 255, 777, 66,15,122],
                    name : new Date().getTime()
                }
            ]
        }]
        }

        setTimeout(()=>{
          html2canvas(document.getElementById('dataList'),{
              useCORS:true,
              logging: false
          })
.then(function(canvas) {
   // document.body.appendChild(canvas);
    var context = canvas.getContext('2d');

    var img = new Image();
    img.src = canvas.toDataURL("image/jpg")
    img.crossOrigin = 'anonymous'
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
      /* var head=document.querySelector('head');
      var meta=document.createElement('meta');
      meta.setAttribute("name","viewport")
      meta.setAttribute("content","width=device-width,initial-scale=1.0")
      head.append(meta); */
      this.initRadarData(this.echartsData)
      //this.initData(this.echartsData)
      
  },
  mounted () {

  }
}
</script>

<style >
    .triangle-right{
        width:0;
        height:0;
        border-top:10px solid transparent;
        border-bottom:10px solid transparent;
        border-left:10px solid #fff;
        position:absolute;
        right:-10px;
        top:50%;
        margin-top:-10px;
        }
        .triangle-left{
            width:0;
            height:0;
            border-top:10px solid transparent;
            border-bottom:10px solid transparent;
            border-right:10px solid #fff;
            position:absolute;
            left:-10px;
            top:50%;
            margin-top:-10px;
        }
</style>

