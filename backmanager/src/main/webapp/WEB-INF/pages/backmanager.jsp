<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title></title>
<%
	String path = request.getContextPath();
	// 获得本项目的地址(例如: http://localhost:8080/MyApp/)赋值给basePath变量 
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path;
	// 将 "项目路径basePath" 放入pageContext中，待以后用EL表达式读出。 
	pageContext.setAttribute("basePath", basePath);
%>
<link rel="stylesheet" href="${pageScope.basePath}/css/common.css">
<link rel="stylesheet" href="${pageScope.basePath}/js/layui/css/layui.css">
<link rel="stylesheet"
	href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script
	src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- ECharts单文件引入 -->
<script src="${pageScope.basePath}/js/echarts.js"></script>
<script src="${pageScope.basePath}/js/laydate.js"></script>
<script src="${pageScope.basePath}/js/layui/layui.js"></script>
<script src="${pageScope.basePath}/js/dateformat.js"></script>
</head>
<body>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">贷款管理</h3>
		</div>
		<div class="panel-body" style="margin: auto">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">关键指标</h3>
				</div>
				<div id="content" class="row-fluid panel-width90"
					style="margin: auto">
					<h5 class="bs-info">查询</h5>
					<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
					<form class="form-horizontal" role="form" id="query" action="query"
						method="get">
						<div class="form-group">
							<label for="time1" class="col-sm-1 control-label">创建时间</label>
							<div class="col-sm-5">
								<input type="text" class="form-control"
									style="width: 35%; display: inline" id="createdTimeStart"
									name="createdTimeStart" value="${createdTimeStart}"
									placeholder="起始时间"> <span>&nbsp;—&nbsp;</span> <input
									type="text" class="form-control" value="${createdTimeEnd}"
									style="width: 35%; display: inline" id="createdTimeEnd"
									name="createdTimeEnd" placeholder="结束时间">
							</div>
							<label for="userId" class="col-sm-1 control-label">用户号</label>
							<div class="col-sm-2">
								<input type="text" class="form-control" id="userId"
									value="${userId}" name="userId" placeholder="">
							</div>

							<label for="type" class="col-sm-1 control-label">类型</label>
							<div class="col-sm-2">
								<select class="form-control" id="type" name="type">
									<option value="">全部</option>
									<option value="01">已申请，待放款</option>
									<option value="02">已放款到银行卡</option>
									<option value="03">已放款到电子帐号，待提取</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="time3" class="col-sm-1 control-label">放款金额</label>
							<div class="col-sm-5">
								<input type="text" class="form-control"
									value="${applicateAmountMin}"
									style="width: 35%; display: inline" id="applicateAmountMin"
									name="applicateAmountMin" placeholder="最小"> <span>&nbsp;—&nbsp;</span>
								<input type="text" class="form-control"
									value="${applicateAmountMax}"
									style="width: 35%; display: inline" id="applicateAmountMax"
									name="applicateAmountMax" placeholder="最大">
							</div>
							<label for="backmanagerId" class="col-sm-1 control-label">借款记录号</label>
							<div class="col-sm-2">
								<input type="text" class="form-control" id="backmanagerId"
									value="${backmanagerId}" name="backmanagerId" placeholder="">
							</div>
							<label class="col-sm-1 control-label"></label>
							<div class="col-sm-2">
								<input type="submit" class="form-control"
									style="background-color: #009688; color: white" value="查询">
							</div>
						</div>
						<input type="hidden" name="currpage" value="1">
					</form>
					<h5 class="bs-info">详细数据</h5>
					<table class="table table-condensed">
						<thead>
							<tr class="active">
								<th>借款记录号</th>
								<th>用户号</th>
								<th>状态</th>
								<th>代理人佣金状态</th>
								<th>放款金额</th>
								<th>创建时间</th>
							</tr>
						</thead>
						<tbody id="dataBody">
							<c:forEach var="user" items="${page.list}" varStatus="status">
								<tr>
									<td>${user.backmanagerId}</td>
									<td>${user.userId}</td>
									<td>${user.statusDesc}</td>
									<td>${user.commissionStatusDesc}</td>
									<td>${user.amount}</td>
									<fmt:parseDate value="${user.createTime}" var="parsedEmpDate" pattern="yyyyMMddHHmmss" />
									<td><fmt:formatDate value="${parsedEmpDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div id="demo1" style="float: right"></div>

				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var test = "${page}";
		var pageSize = "${page.pageSize}";
		var orderlen = "${page.total}";
		var curr = "${page.pageNum}";
		console.log(test);
		console.log(pageSize);
		console.log(orderlen);
		console.log(curr);

		//日期范围
		layui.use('laydate', function() {
			var laydate = layui.laydate;
			laydate.render({
				elem : '#createdTimeStart',
				type: 'datetime'
			});
			laydate.render({
				elem : '#createdTimeEnd',
				type: 'datetime'
			});
		});
		//总页数大于页码总数
		layui.use([ 'laypage', 'layer' ], function() {
			var laypage = layui.laypage, layer = layui.layer;
			laypage.render({
				elem : 'demo1',
				limit : pageSize,
				count : orderlen,
				curr : curr,
				layout : [ 'count', 'prev', 'page', 'next', 'skip' ],
				jump : function(obj) {
					console.log(obj);
					if (obj.curr == curr) {
						return;
					}
					$("input[name='currpage']").val(obj.curr);
					$("#query").submit();
				}
			});
		});

		var type = "${type}";
		$("#type option[value='" + type + "']").attr("selected", "selected");
	</script>
</body>
</html>