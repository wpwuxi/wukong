<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>猫小贷H5后台管理</title>

<link rel="stylesheet" href="css/index.css" type="text/css"
	media="screen" />
<link rel="stylesheet" href="css/loaderstyle.css" type="text/css"
	media="screen" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/tendina.min.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/dateformat.js"></script>
</head>
<body>
	<!--顶部-->
	<div class="top">
		<div style="float: left">
			<span
				style="font-size: 20px; line-height: 45px; padding-left: 20px; color: #fff">猫小贷H5后台管理
				</h1>
			</span>
		</div>
		<div id="ad_setting" class="ad_setting">
			<a class="ad_setting_a" href="javascript:; ">${sessionScope.username}</a>
			<ul class="dropdown-menu-uu" style="display: none" id="ad_setting_ul">
				<li class="ad_setting_ul_li"><a href="/backmanager/user/logout"><i
						class="icon-signout glyph-icon"></i> <span class="font-bold">退出</span>
				</a></li>
			</ul>
			<img class="use_xl" src="images/right_menu.png" />
		</div>
	</div>
	<!--顶部结束-->
	<!--菜单-->
	<div class="left-menu">
		<ul id="menu">
			<li class="menu-list"><a style="cursor: pointer" class="firsta"><i
					class="glyph-icon xlcd"></i>数据中心<s class="sz"></s></a>
				<ul>
					<shiro:hasPermission name="user-entry">
						<li><a href="manage/user/query" target="menuFrame"><i
								class="glyph-icon icon-chevron-right1"></i>用户管理</a></li>
					</shiro:hasPermission>
					<shiro:hasPermission name="application-entry">
						<li><a id="lishiqushi" href="manage/application/query"
							target="menuFrame"><i class="glyph-icon icon-chevron-right1"></i>申请单管理</a></li>
					</shiro:hasPermission>
					<shiro:hasPermission name="backmanager-entry">
						<li><a id="goodsAnalyse" href="manage/backmanager/query"
							target="menuFrame"><i class="glyph-icon icon-chevron-right2"></i>放款管理</a></li>
					</shiro:hasPermission>
					<shiro:hasPermission name="settle-entry">
						<li><a href="manage/settle/query" target="menuFrame"><i
								class="glyph-icon icon-chevron-right2"></i>结算管理</a></li>
					</shiro:hasPermission>
				</ul></li>
		</ul>
	</div>

	<!--菜单右边的iframe页面-->
	<div id="right-content" class="right-content">
		<div class="content">
			<div id="page_content">
				<iframe id="menuFrame" name="menuFrame" src="manage/user/query"
					style="overflow: visible;" scrolling="yes" frameborder="no"
					width="100%" height="100%"></iframe>
			</div>
		</div>
	</div>
	<div class="loader">
		<div class="dot"></div>
		<div class="dot"></div>
		<div class="dot"></div>
		<div class="dot"></div>
		<div class="dot"></div>
	</div>
</body>
<script type="text/javascript">
	var frm = document.getElementById('menuFrame');
	$(frm).load(function() { //  等iframe加载完毕  
		$(".loader").hide();
	});
</script>
</html>