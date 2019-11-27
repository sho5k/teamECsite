<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="./css/radish.css">
<link rel="stylesheet" type="text/css" href="./css/table.css">
<title>ログイン画面</title>
</head>
<body>
	<div class="header">
	<jsp:include page="header.jsp"/>
	</div>
	<div id="contents">
		<h1>ログイン画面</h1>
		<s:if test="userIdErrorList!=null && userIdErrorList.size()>0">
			<div class="error">
				<s:iterator value="userIdErrorList">
					<s:property /><br>
				</s:iterator>
			</div>
			<br>
		</s:if>
		<s:if test="passwordErrorList!=null && passwordErrorList.size()>0">
			<div class="error">
				<s:iterator value="passwordErrorList">
					<s:property /><br>
				</s:iterator>
			</div>
			<br>
		</s:if>
		<s:if test="loginErrorMessage!=null" >
			<div class="error">
				<s:property value="loginErrorMessage"/>
			</div>
			<br>
		</s:if>
		<s:form action="LoginAction">
			<table class="importConfirmTable">
				<tr>
					<th>ユーザーID</th>
					<s:if test="#session.keepUserId">
						<td><s:textfield name="userId" value="%{#session.userId}" placeholder="ユーザーID" class="txt"/></td>
					</s:if>
					<s:else>
						<td><s:textfield name="userId" placeholder="ユーザーID" class="txt" autocomplete="off"/></td>
					</s:else>
				</tr>
				<tr>
					<th>パスワード</th>
					<td><s:password name="password" placeholder="パスワード" class="txt"/></td>
				</tr>
			</table>
			<div class="keepId">
				<s:if test="#session.keepUserId==true">
					<s:checkbox name="keepUserId" checked="checked"/>
				</s:if>
				<s:else>
					<s:checkbox name="keepUserId"/>
				</s:else>
				<s:label value="ユーザーID保存"/><br>
			</div>
			<div class="submitBtnBox">
				<s:submit value="ログイン" class="submitBtn"/>
			</div>
		</s:form>
		<div class="submitBtnBox">
			<s:form action="CreateUserAction">
				<s:submit value="新規ユーザー登録" class="submitBtn"/>
			</s:form>
		</div>
		<s:form action="ResetPasswordAction">
			<div class="submitBtnBox">
				<s:submit value="パスワード再設定" class="submitBtn"/>
			</div>
		</s:form>
		</div>
</body>
</html>