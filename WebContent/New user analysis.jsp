<%@ page language="java" import="dbgame.connDb,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
ArrayList<String[]> list1 = connDb.f1_1();
ArrayList<String[]> list2 = connDb.f1_2();
ArrayList<String[]> list3 = connDb.f3_5();
ArrayList<String[]> list4 = connDb.f2_1();
ArrayList<String[]> list5 = connDb.f1_3();
ArrayList<String[]> list6 = connDb.f1_4();
ArrayList<String[]> list7 = connDb.f1_5();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ECharts 游戏玩家用户数据分析</title>
<link href="./css/stylesheet.css" type='text/css' rel="stylesheet"/>
<script src="./js/echarts.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts@5/dist/echarts.min.js"></script>
</head>
<body>
    <header>
        <div id="title">ECharts 游戏玩家用户数据分析</div>
        <!-- 搜索 -->
        <div class="search">
            <div class="search-icon">
                <svg t="1618811223121" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2127" width="16" height="16"><path d="M886.6 841.4L750.5 705.2c50.9-61 81.5-139.6 81.5-225.2 0-194.4-157.6-352-352-352S128 285.6 128 480s157.6 352 352 352c85.7 0 164.2-30.6 225.2-81.5l136.1 136.1c6.2 6.2 14.4 9.4 22.6 9.4s16.4-3.1 22.6-9.4c12.6-12.5 12.6-32.7 0.1-45.2zM683.7 683.7c-26.5 26.4-57.3 47.2-91.6 61.7-35.5 15-73.2 22.6-112.1 22.6-38.9 0-76.6-7.6-112.1-22.6-34.3-14.5-65.1-35.3-91.6-61.7-26.5-26.5-47.2-57.3-61.7-91.6-15-35.5-22.6-73.2-22.6-112.1 0-38.9 7.6-76.6 22.6-112.1 14.5-34.3 35.3-65.1 61.7-91.6 26.5-26.5 57.3-47.2 91.6-61.7 35.5-15 73.2-22.6 112.1-22.6 38.9 0 76.6 7.6 112.1 22.6 34.3 14.5 65.1 35.3 91.6 61.7 26.5 26.5 47.2 57.3 61.7 91.6 15 35.5 22.6 73.2 22.6 112.1 0 38.9-7.6 76.6-22.6 112.1-14.5 34.3-35.3 65.1-61.7 91.6z" fill="#838caf" p-id="2128"></path></svg>
            </div>
            <input type="text" placeholder="搜索用户">
        </div>
        <!-- 用户界面/登录 -->
        <div class="user">
            <svg t="1618813425873" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="4475" width="24" height="24"><path d="M512 112.185693c-110.405578 0-199.90733 89.501751-199.90733 199.90733 0 110.405931 89.501751 199.90733 199.90733 199.90733 110.405931 0 199.90733-89.501399 199.90733-199.90733s-89.501399-199.90733-199.90733-199.90733z m0 350.658299c-83.257591 0-150.750969-67.493379-150.750969-150.750969s67.493379-150.751322 150.750969-150.751322 150.750969 67.493731 150.750969 150.751322S595.257591 462.843992 512 462.843992zM512 578.880604c-210.313559 0-380.806659 170.4931-380.806659 380.806659 0 6.298841 0.160867 12.559935 0.464255 18.783634h74.12242a16.261276 16.261276 0 0 1-0.063147-1.374068c0-0.292452 0.008467-0.583141 0.023988-0.872418h-1.152171a313.687577 313.687577 0 0 1-0.378177-15.293608c0-171.22723 138.807689-310.034919 310.034919-310.034919 171.227936 0 310.035272 138.807689 310.035273 310.034919 0 5.127973-0.125589 10.226312-0.372533 15.293608h-0.989894c0.015169 0.288925 0.023283 0.579966 0.023283 0.872418a16.121929 16.121929 0 0 1-0.062794 1.374068h69.470343a386.180165 386.180165 0 0 0 0.4572-18.783634c0.000706-210.313559-170.492042-380.806659-380.806306-380.806659z" fill="#ffffff" p-id="4476"></path><path d="M881.943583 943.260182c0 19.446856-9.613891 35.211068-21.473562 35.211068H153.421847c-11.859672 0-21.473562-15.764212-21.473562-35.211068 0-19.446856 9.613891-35.211068 21.473562-35.211069H860.470021c11.859672 0 21.473562 15.764212 21.473562 35.211069z" fill="#ffffff" p-id="4477"></path></svg>
        </div>
    </header>
    <!-- 侧边栏 -->
	<aside>
        <div class="top">
            <!-- 搜索 -->
            <div class="search">
                <div class="search-icon">
                    <svg t="1618811223121" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2127" width="16" height="16"><path d="M886.6 841.4L750.5 705.2c50.9-61 81.5-139.6 81.5-225.2 0-194.4-157.6-352-352-352S128 285.6 128 480s157.6 352 352 352c85.7 0 164.2-30.6 225.2-81.5l136.1 136.1c6.2 6.2 14.4 9.4 22.6 9.4s16.4-3.1 22.6-9.4c12.6-12.5 12.6-32.7 0.1-45.2zM683.7 683.7c-26.5 26.4-57.3 47.2-91.6 61.7-35.5 15-73.2 22.6-112.1 22.6-38.9 0-76.6-7.6-112.1-22.6-34.3-14.5-65.1-35.3-91.6-61.7-26.5-26.5-47.2-57.3-61.7-91.6-15-35.5-22.6-73.2-22.6-112.1 0-38.9 7.6-76.6 22.6-112.1 14.5-34.3 35.3-65.1 61.7-91.6 26.5-26.5 57.3-47.2 91.6-61.7 35.5-15 73.2-22.6 112.1-22.6 38.9 0 76.6 7.6 112.1 22.6 34.3 14.5 65.1 35.3 91.6 61.7 26.5 26.5 47.2 57.3 61.7 91.6 15 35.5 22.6 73.2 22.6 112.1 0 38.9-7.6 76.6-22.6 112.1-14.5 34.3-35.3 65.1-61.7 91.6z" fill="#838caf" p-id="2128"></path></svg>
                </div>
                <input type="text" placeholder="搜索看板">
            </div>
        </div>
        <ul>
            <li><a href="">核心看板</a></li>
            <li  class="li-active">新增玩家分析</li>
            <li><a href="./Player activity analysis.jsp">玩家活跃度分析</a></li>
             <li><a href="./Player payment behavior analysis.jsp">玩家付费行为分析</a></li>
            <li><a href="./Player game habit analysis.jsp">玩家游戏习惯</a></li>
        </ul>
    </aside>
    <div id="container">
        <div class="top" style="font-size: large;line-height: 60px;text-indent: 20px;">新增玩家分析</div>
        <div class="chart-small">
			<div class="container">
				<span id="title1">新增玩家数</span><br>
				<span id="date">截止2021-05-06</span><br><br>
				<span id="data1"></span><br><br>	
				<span class="compare">较环比：</span>
				<span class="data" id="Ringgit1"></span>
				<span class="compare">较同比：</span>
				<span class="data" id="YoY1"></span>
			</div>
	</div>
	<div class="chart-small">
			<div class="container">
				<span id="title1">新增付费玩家数</span><br>
				<span id="date">截止2021-05-06</span><br><br>
				<span id="data2"></span><br><br>	
				<span class="compare">较环比：</span>
				<span class="data" id="Ringgit2"></span>
				<span class="compare">较同比：</span>
				<span class="data" id="YoY2"></span>
			</div>
	</div>
	<div class="chart-small">
			<div class="container">
				<span id="title1">总收入</span><br>
				<span id="date">截止2021-05-06</span><br><br>
				<span id="data3"></span><br><br>	
				<span class="compare">较环比：</span>
				<span class="data" id="Ringgit3"></span>
				<span class="compare">较同比：</span>
				<span class="data" id="YoY3"></span>
			</div>
	</div>
	<div class="chart-small">
			<div class="container">
				<span id="title1">平均在线时长</span><br>
				<span id="date">截止2021-05-06</span><br><br>
				<span id="data4"></span><br><br>	
				<span class="compare">较环比：</span>
				<span class="data" id="Ringgit4"></span>
				<span class="compare">较同比：</span>
				<span class="data" id="YoY4"></span>
			</div>
	</div>
      
        <div class="chart-large"  id="line1"></div>
        <div class="chart-large"  id="line2"></div>
        <footer style="width: 100%;height: 10px;"></footer>
    </div>
        
<script >
// 指定图表的配置项和数据
var data1 = <%=list1.get(0)[0]%>;
var data2 = <%=list2.get(0)[0]%>;
var data3 = <%=list3.get(0)[0]%>;
var data4 = <%=list4.get(0)[0]%>;
function toThousands(num) {
    return (num || 0).toString().replace(/(\d)(?=(?:\d{3})+$)/g, '$1,');
}
var setData = function(data, id, unit) {
//	数据、dom的id，单位
	var dom = document.getElementById(id);
	if(!unit) unit = '';
	if(data < 0) dom.className = 'red'
	dom.innerText = data + unit;
}
setData(toThousands(data1), "data1");
setData(3.5, "Ringgit1", "%");
setData(-9.0, "YoY1", "%");

setData(toThousands(data2), "data2");
setData(2.5, "Ringgit2", "%");
setData(-8.1, "YoY2", "%");

setData(toThousands(data3), "data3");
setData(2.7, "Ringgit3", "%");
setData(-7.3, "YoY3", "%");

setData(toThousands(data4), "data4");
setData(1.5, "Ringgit4", "%");
setData(-0.3, "YoY4", "%");
 

var data6_1 = [];
var data6_2 = [];
<%for(String[] a:list6){%>
        data6_1.push("<%=a[0]%>");
        data6_2.push(<%=a[1]%>);
<%}%>

var data7_1 = [];
var data7_2 = [];
<%for(String[] a:list7){%>
        data7_1.push("<%=a[0]%>");
        data7_2.push(<%=a[1]%>);
<%}%>

function toThousands(num) {
    return (num || 0).toString().replace(/(\d)(?=(?:\d{3})+$)/g, '$1,');
}
var setData = function(data, id, unit) {
//	数据、dom的id，单位
	var dom = document.getElementById(id);
	if(!unit) unit = '';
	if(data < 0) dom.className = 'red'
	dom.innerText = data + unit;
}
setData(toThousands(data1), "data1");
setData(3.5, "Ringgit1", "%");
setData(-9.0, "YoY1", "%");

setData(toThousands(data2), "data2");
setData(2.5, "Ringgit2", "%");
setData(-8.1, "YoY2", "%");

setData(toThousands(data3), "data3");
setData(2.7, "Ringgit3", "%");
setData(-7.3, "YoY3", "%");

setData(toThousands(data4), "data4");
setData(1.5, "Ringgit4", "%");
setData(-0.3, "YoY4", "%");


// 配置项无须改动
var defaultOption = function () {
	return {
	    title: {text: ''},
	    series: [],
	    dataset: { source: [] }, 
	    tooltip: {},
	    // 上面的项目需要自行配置
	    legend: {},
	    toolbox: {
	        show: true,
	        feature: {
	          dataView: {
	            readOnly: false
	          },
	          magicType: {
	            type: ["line", "bar"]
	          },
	          restore: {},
	          saveAsImage: {}
	        }
	    },
	    dataZoom: [
	        { type: 'slider', xAxisIndex: 0, start: 0, end: 100 },
	        { type: 'inside', xAxisIndex: 0, start: 0, end: 100 },
	        { type: 'slider', yAxisIndex: 0, start: 0, end: 100 },
	        { type: 'inside', yAxisIndex: 0, start: 0, end: 100 }
	    ],
	    xAxis: {type: 'category'},
	    yAxis: {},
	}
}
	// 多系列柱状图
	// 可以传入多个data
	// 标题，类别，x轴，数据
	// title,legend,category不可省略，data至少有一组
	var bar = function (title, legend, dimensions, data) {
	    // 初始化默认配置
	    var option = defaultOption;
	    // 配置title
	    option.title.text = title;
	    // 配置系列，name为类别
	    for (var index = 0; index < legend.length; index++) {
	        option.series.push({name: legend[index], type: 'bar', seriesLayoutBy: 'row'});
	    }
	    // 配置数据集dataset
	    for(var i = 2; i < arguments.length; i++){
	        option.dataset.source.push(arguments[i]);
	    }
	    // 配置toootip
	    option.tooltip = {
	        trigger: 'axis', 
	        axisPointer: { type: 'shadow' }
	    }
	    console.log(option)
	    return option;
	}

	// 折线图堆叠
	var line = function (title, legend, dimensions, data) {
	    // 初始化默认配置
	    var option = defaultOption();
	    console.log(option)
	    // 配置title
	    option.title.text = title;
	    // 配置系列，name为类别
	    for (var index = 0; index < legend.length; index++) {
	        option.series.push({name: legend[index], type: 'line', seriesLayoutBy: 'row'});
	    }
	    // 配置数据集dataset
	    for(var i = 2; i < arguments.length; i++){
	        option.dataset.source.push(arguments[i])
	    }
	    // 配置toootip
	    option.tooltip = {
	            trigger: 'axis',
	            showContent: true,
	        	triggerOn: "mousemove",
	            axisPointer: {
	                type: 'cross',
	                snap: true
	            }
	        }
	    console.log(option)
	    return option;
	}

	// 
	var dom1 = document.getElementById("line1");
	var myChart1 = echarts.init(dom1);
	var option1;
	option1 = line("每日新增玩家", ['每日新增玩家'], data6_1, data6_2)
	if (option1 && typeof option1 === 'object') {
	    myChart1.setOption(option1);
	}
	
	var dom2 = document.getElementById("line2");
	var myChart2 = echarts.init(dom2);
	var option2;
	option2 = line("每日新增付费玩家", ['每日新增付费玩家'], data7_1, data7_2)
	if (option2 && typeof option2 === 'object') {
	    myChart2.setOption(option2);
	}
</script>
<link href="./css/stylesheet.css" type='text/css' rel="stylesheet"/>
</body>
</html>