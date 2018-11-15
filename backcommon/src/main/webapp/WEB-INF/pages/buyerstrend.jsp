<%@ page language="java" contentType="text/html; charset=utf8"
	pageEncoding="utf8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf8">
<title>Insert title here</title>
<link rel="stylesheet" href="/backcommon/css/common.css">
<link rel="stylesheet" href="/backcommon/js/layui/css/layui.css">
<link rel="stylesheet"
	href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script
	src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- ECharts单文件引入 -->
<script src="/backcommon/js/echarts.js"></script>
<script src="/backcommon/js/laydate.js"></script>
<script src="/backcommon/js/layui/layui.js"></script>
<script src="/backcommon/js/dateformat.js"></script>
<style type="text/css">
a {
	margin-left: 8px;
}

input {
	margin-left: 8px;
}

.current_a {
	background-color: #9cc3e4;
}

.mtd {
	max-width: 80px;
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
}

.piediv {
	position: absolute;
	z-index: 26;
	transition: none;
	padding: 10px;
}
</style>
</head>
<body>
	<div class="panel panel-default">
		<c:if test="${not empty error}">
			<div class="alert alert-danger" role="alert">${error}</div>
		</c:if>
		<div class="panel-heading">
			<h3 class="panel-title">用户分析</h3>
			<span>时间</span><a href="" id="today">今天</a><a href="" id="day7">7天</a><a
				href="" id="day14">14天</a><a href="" id="day30">30天</a> <input
				type="text" id="daycustom" value="${daySection}">
		</div>
		<div class="panel-body panel-width80">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">关键指标</h3>
				</div>
				<div id="content" class="row-fluid panel-width90"
					style="margin: auto">
					<div style="width: 100%;">
						<div style="width: 45%; height: 260px; float: left; margin: 20px">
							<div id="main" style="height: 100%"></div>
						</div>
						<div style="width: 45%; height: 260px; float: right; margin: 20px">
							<div id="mainon"
								style="height: 100%; border-left: 1px solid #cccccc"></div>
						</div>
						<div style="clear: both"></div>
					</div>
					<div style="width: 100%; height: 500px;">
						<div
							style="position: relative; width: 90%; height: 500px; margin: auto; border-top: 1px solid #cccccc">
							<span>Top &nbsp;10 &nbsp;地域分布</span>
							<div id="main2"
								style="left: 10px; top: 10px; width: 200px; height: 200px;"
								class="piediv"></div>
							<div id="main10"
								style="left: 250px; top: 10px; width: 85px; height: 85px;"
								class="piediv"></div>
							<div id="main8"
								style="left: 350px; top: 20px; width: 100px; height: 100px;"
								class="piediv"></div>
							<div id="main11"
								style="left: 480px; top: 80px; width: 80px; height: 80px;"
								class="piediv"></div>
							<div id="main3"
								style="left: 580px; top: 30px; width: 160px; height: 160px;"
								class="piediv"></div>
							<div id="main9"
								style="left: 750px; top: 20px; width: 85px; height: 85px;"
								class="piediv"></div>
							<div id="main4"
								style="left: 230px; top: 120px; width: 160px; height: 160px;"
								class="piediv"></div>
							<div id="main6"
								style="left: 400px; top: 190px; width: 110px; height: 110px;"
								class="piediv"></div>
							<div id="main7"
								style="left: 530px; top: 200px; width: 100px; height: 100px;"
								class="piediv"></div>
							<div id="main5"
								style="left: 650px; top: 170px; width: 130px; height: 130px;"
								class="piediv"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		//初始化查询bar
		var today = new Date().Format("yyyyMMdd");
		var day7 = new Date().Format("yyyyMMdd", {
			day : -6
		});
		var day14 = new Date().Format("yyyyMMdd", {
			day : -13
		});
		var day30 = new Date().Format("yyyyMMdd", {
			day : -29
		});
		var owner_id = "${sessionScope.owner_id}";
		var url = "/backcommon/pdd/manage/order/analysis?mallId=" + owner_id;

		$("#today").attr("href",
				url + "&days=1&startTime=" + today + "&endTime=" + today)
		$("#day7").attr("href",
				url + "&days=7&startTime=" + day7 + "&endTime=" + today)
		$("#day14").attr("href",
				url + "&days=14&startTime=" + day14 + "&endTime=" + today)
		$("#day30").attr("href",
				url + "&days=30&startTime=" + day30 + "&endTime=" + today)

		var orders = '${orders}';
		console.log(orders);
		var xinkehu_xiaofei_rate = '${xinkehu_xiaofei_rate}';
		var xxr = parseFloat(xinkehu_xiaofei_rate);
		console.log(xxr);
		console.log(100-xxr);
		var xinkehu_rate = '${xinkehu_rate}';
		var xr = parseFloat(xinkehu_rate);
		console.log(xr);
		var province_order_rate = '${province_order_rate}';
		var province_order_rate_json = JSON.parse(province_order_rate);
		console.log(province_order_rate_json);
		var days = '${days}';
		if (days === "1") {
			$("#today").addClass("current_a");
		} else if (days === "7") {
			$("#day7").addClass("current_a");
		} else if (days === "14") {
			$("#day14").addClass("current_a");
		} else if (days === "30") {
			$("#day30").addClass("current_a");
		}
		// 基于准备好的dom，初始化echarts实例
		var myChart = echarts.init(document.getElementById('main'));
		var myCharton = echarts.init(document.getElementById('mainon'));

		// 指定图表的配置项和数据
		option = {
			title : {
				subtext : '回头客消费占比'

			},
			tooltip : {
				trigger : 'item',
				formatter: "{b} : {d}%"
			},
			legend : {
				data : [ '新客户', '回头客' ],
				x : 'center'
			},
			color : [ '#1f46c7', '#39c7bb' ],
			calculable : true,
			series : [ {
				name : '访问来源',
				type : 'pie',
				radius : '55%',
				center : [ '50%', '60%' ],
				// roseType:true,
				data : [ {
					value : xxr,
					name : '新客户'
				}, {
					value : 100 - xxr,
					name : '回头客'
				} ]
			} ]
		};
		var optionon = {
			title : {
				subtext : '新老用户比例'

			},
			tooltip : {
				trigger : 'item',
				formatter: "{b} : {d}%"
			},
			legend : {
				data : [ '新用户', '老用户' ],
				x : 'center'
			},
			color : [ '#c7585c', '#7a74c7' ],
			calculable : true,
			series : [ {
				name : '访问来源',
				type : 'pie',
				radius : '55%',
				center : [ '50%', '60%' ],
				// roseType:true,
				data : [ {
					value : xr,
					name : '新用户'
				}, {
					value : 100 - xr,
					name : '老用户'
				} ]
			} ]
		};

		function getOption(optionParam) {
			var optionBase = {
				aria : {
					show : true
				},
				color : [ optionParam.color ],

				series : [ {
					type : 'pie',
					avoidLabelOverlap : false,
					// center: optionParam.position,
					// radius: optionParam.radius,
					data : [ {
						value : optionParam.value,
						name : optionParam.name,
						selected : true,
						label : {
							show : true,
							position : 'center',
							formatter : "{b}\n{c}%",
							fontSize : '13',
							color : '#FDFDFD'
						}
					} ]
				} ]
			};
			return optionBase;
		}
		//日期范围
		layui.use('laydate', function() {
			var laydate = layui.laydate;
			laydate.render({
				elem : '#daycustom',
				range : true,
				min: -30,
	            max: 0,
				done : function(value, date, endDate) {
					var dates = value.split(" - ");
					var startTime = dates[0].replace(new RegExp("-", "g"), "");
					var endTime = dates[1].replace(new RegExp("-", "g"), "");
					window.location.href = url + "&startTime=" + startTime
							+ "&endTime=" + endTime;
				}
			});
		});
		// 使用刚指定的配置项和数据显示图表。
		myChart.setOption(option);
		myCharton.setOption(optionon);
		var colors=["#3089C7","#CC7FA4","#74CCC1","#CCC972","#CC2327","#848F8C","#6388CC","#47CC6C","#CCAC65","#2928CC"];
		for ( var iterable_element in province_order_rate_json) {
			var temp = province_order_rate_json[iterable_element]
			var optionParam = {
				name : temp.area,
				value : temp.value,
				color : colors[iterable_element]
			};
			var goodvid = parseInt(iterable_element)+2;
			console.log(goodvid);
			var myChart = echarts.init(document.getElementById('main'+goodvid));
			myChart.setOption(getOption(optionParam));
		}
		
	</script>
</body>


</html>