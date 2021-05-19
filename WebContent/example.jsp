<%@ page language="java" import="dbgame.connDb,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
ArrayList<String[]> list = connDb.test();
%>
<!--
    THIS EXAMPLE WAS DOWNLOADED FROM https://echarts.apache.org/examples/zh/editor.html?c=bar-animation-delay
-->
<!DOCTYPE html>
<html style="height: 100%">
    <head>
        <meta charset="utf-8">
    </head>
    <body style="height: 100%; margin: 0">
        <div id="container" style="height: 100%"></div>

        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts@5/dist/echarts.min.js"></script>
        <!-- Uncomment this line if you want to dataTool extension
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts@5/dist/extension/dataTool.min.js"></script>
        -->
        <!-- Uncomment this line if you want to use gl extension
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts-gl@2/dist/echarts-gl.min.js"></script>
        -->
        <!-- Uncomment this line if you want to echarts-stat extension
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts-stat@latest/dist/ecStat.min.js"></script>
        -->
        <!-- Uncomment this line if you want to use map
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts@5/map/js/china.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts@5/map/js/world.js"></script>
        -->
        <!-- Uncomment these two lines if you want to use bmap extension
        <script type="text/javascript" src="https://api.map.baidu.com/api?v=2.0&ak=<Your Key Here>"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts@5/dist/extension/bmap.min.js"></script>
        -->

<script type="text/javascript">
var dom = document.getElementById("container");
var myChart = echarts.init(dom);
var app = {};

var option;

var xAxisData = [];
var data1 = [];
var data2 = [];
<%
for(String[] a:list){
	if(a[0].equals("0")){
		%>
		data1.push(<%=a[2]%>);
		xAxisData.push(<%=a[1]%>);
		<%
	}else if(a[0].equals("1")){
		%>
		data2.push(<%=a[2]%>);
		xAxisData.push(<%=a[1]%>);
		<%
	}
}
%>
/* for (var i = 0; i < 100; i++) {
    xAxisData.push('类目' + i);
    data1.push((Math.sin(i / 5) * (i / 5 -10) + i / 6) * 5);
    data2.push((Math.cos(i / 5) * (i / 5 -10) + i / 6) * 5);
}*/

option = {
    title: {
        text: '柱状图动画延迟'
    },
    legend: {
        data: ['bar', 'bar2']
    },
    toolbox: {
        // y: 'bottom',
        feature: {
            magicType: {
                type: ['stack', 'tiled']
            },
            dataView: {},
            saveAsImage: {
                pixelRatio: 2
            }
        }
    },
    tooltip: {},
    xAxis: {
        data: xAxisData,
        splitLine: {
            show: false
        }
    },
    yAxis: {
    },
    series: [{
        name: 'bar',
        type: 'bar',
        data: data1,
        emphasis: {
            focus: 'series'
        },
        animationDelay: function (idx) {
            return idx * 10;
        }
    }, {
        name: 'bar2',
        type: 'bar',
        data: data2,
        emphasis: {
            focus: 'series'
        },
        animationDelay: function (idx) {
            return idx * 10 + 100;
        }
    }],
    animationEasing: 'elasticOut',
    animationDelayUpdate: function (idx) {
        return idx * 5;
    }
};

if (option && typeof option === 'object') {
    myChart.setOption(option);
}

        </script>
    </body>
</html>
    