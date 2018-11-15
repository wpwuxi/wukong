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
<link rel="stylesheet"
	href="${pageScope.basePath}/js/layui/css/layui.css">
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
			<h3 class="panel-title">结算管理</h3>
		</div>
		<div class="panel-body" style="margin: auto">
			<div class="panel panel-default">
				<div id="content" class="row-fluid panel-width90"
					style="margin: auto">
					<h5 class="bs-info">查询</h5>
					<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
					<form class="form-horizontal" role="form" id="query" action="query"
						method="get">
						<div class="form-group">
							<label for="userId" class="col-sm-2 control-label">代理人用户号</label>
							<div class="col-sm-2">
								<input type="text" class="form-control" id="agentUserId"
									value="${agentUserId}" name="agentUserId" placeholder="">
							</div>
							<label for="time1" class="col-sm-1 control-label">结算时间</label>
							<div class="col-sm-3">
								<input type="text" class="form-control"
									style="width: 35%; display: inline" id="createdTimeStart"
									name="createdTimeStart" value="${createdTimeStart}"
									placeholder="起始时间"> <span>&nbsp;—&nbsp;</span> <input
									type="text" class="form-control" value="${createdTimeEnd}"
									style="width: 35%; display: inline" id="createdTimeEnd"
									name="createdTimeEnd" placeholder="结束时间">
							</div>
							<label for="type" class="col-sm-1 control-label">状态</label>
							<div class="col-sm-1">
								<select class="form-control" id="settlementStatus"
									name="settlementStatus">
									<option value="">全部</option>
									<option value="0">初始化</option>
									<option value="1">银行结算中</option>
									<option value="2">结算成功</option>
									<option value="3">结算失败</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<!-- <label for="time3" class="col-sm-1 control-label"></label>
							<div class="col-sm-5"></div>
							<label class="col-sm-1 control-label"></label> -->
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
								<th>结算号</th>
								<th>结算金额</th>
								<th>代理用户号</th>
								<th>银行</th>
								<th>银行卡号</th>
								<th>开户人姓名</th>
								<th>创建时间</th>
								<th>更新时间</th>
								<th>状态</th>
								<th>操作</th>
							</tr>
						</thead>

						<tbody id="dataBody">
							<c:forEach var="settlement" items="${page.list}"
								varStatus="status">
								<span>${settlemen}</span>
								<tr>
									<td>${settlement.id}</td>
									<td>${settlement.amount}</td>
									<td>${settlement.agentUserId}</td>
									<td>${settlement.bankName}</td>
									<td>${settlement.bankAccountNo}</td>
									<td>${settlement.accountName}</td>
									<fmt:parseDate value="${settlement.createdTime}"
										var="parsed_createdTime" pattern="yyyyMMddHHmmss" />
									<td><fmt:formatDate value="${parsed_createdTime}"
											pattern="yyyy-MM-dd HH:mm:ss" /></td>
									<fmt:parseDate value="${settlement.lastUpdatedTime}"
										var="parsedEmpDate" pattern="yyyyMMddHHmmss" />
									<td><fmt:formatDate value="${parsedEmpDate}"
											pattern="yyyy-MM-dd HH:mm:ss" /></td>

									<c:if test="${settlement.status=='0'}">
										<td>初始化</td>
										<td>
										<shiro:hasPermission name="settle-update">
										<a onclick="settling('${settlement.id}')"
											style="cursor: pointer;">提交银行结算</a>
										</shiro:hasPermission>
										</td>
									</c:if>
									<c:if test="${settlement.status=='1'}">
										<td>银行结算中</td>
										<td>
										<shiro:hasPermission name="settle-update">
										<a onclick="success('${settlement.id}')"
											style="cursor: pointer;">结算成功</a>&nbsp;<a
											onclick="fail('${settlement.id}')" style="cursor: pointer;">结算失败</a>
										</shiro:hasPermission>	
										</td>
									</c:if>
									<c:if test="${settlement.status=='2'}">
										<td>结算成功</td>
										<td></td>
									</c:if>
									<c:if test="${settlement.status=='3'}">
										<td>结算失败</td><td></td>
									</c:if>

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
		var typemap = {
			"0" : "初始化",
			"1" : "银行结算中",
			"2" : "结算成功",
			"3" : "结算失败"
		}
		//日期范围
		layui.use('laydate', function() {
			var laydate = layui.laydate;
			laydate.render({
				elem : '#createdTimeStart',
				type : 'date'
			});
			laydate.render({
				elem : '#createdTimeEnd',
				type : 'date'
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

		var type = "${settlementStatus}";
		$("#settlementStatus option[value='" + type + "']").attr("selected",
				"selected");
		function settling(id) {
			sendAjax("updatestatus/settling", id);
		}
		function success(id) {
			sendAjax("updatestatus/success", id);
		}
		function fail(id) {
			sendAjax("updatestatus/fail", id);
		}
		function retry(id) {
			sendAjax("updatestatus/retry", id);
		}
		function sendAjax(action, id) {
			$.ajax({
				url : action,
				async : true,
				data : {
					settleId : id
				},
				type : "post",
				contentType : "application/x-www-form-urlencoded",
				success : function(result) {
					console.log(result);
					if (result.code == "0000") {
						layer.open({
							type : 0,
							content : "操作成功",//支持获取DOM元素
							scrollbar : true,
							yes : function(index) {//layer.msg('yes');    //点击确定回调
								layer.close(index);
								$("#query").submit();
							}
						});
					} else {
						layer.open({
							type : 0,
							content : result.msg,//支持获取DOM元素
							scrollbar : true,
							yes : function(index) {//layer.msg('yes');    //点击确定回调
								layer.close(index);
							}
						});
					}

				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					layer.open({
						content : "未知异常，请稍后重试",//支持获取DOM元素
						scrollbar : true
					});
				}
			});
		}
	</script>
</body>
</html>