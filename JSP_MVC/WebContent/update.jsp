<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>			 
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ page import="com.mvc.dto.MVCDto" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	MVCDto dto = (MVCDto)request.getAttribute("dto");
%>
<body>

	<h1>게시글 보기</h1>
		<form action="controller.jsp" method="post">
			<input type="hidden" name="command" value="update">
			<input type="hidden" name="seq"	value="<%=dto.getSeq() %>">
			<table border="1">
				<tr>
					<th>번호</th>
					<td><%=dto.getSeq() %></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td><%=dto.getWriter() %></td>
				</tr>
				<tr>
					<th>작성일</th>
					<td><%=dto.getRegdate() %></td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title" value="<%=dto.getTitle() %>" /></td>
				</tr>
				<tr>				
					<th>내용</th>
					<td><textarea rows="10" cols="60" name="content"><%=dto.getContent() %></textarea></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="수정" />
						<input type="button" value="삭제" onclick="location.href='controller.jsp?command=delete&seq=<%=dto.getSeq() %>'" />
						<input type="button" value="목록"	 onclick="location.href='contorller.jsp?command=list'" />
					</td>
				</tr>				
			</table>
		</form>
</body>
</html>







