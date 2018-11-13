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
<%
	MVCDto dto = (MVCDto)request.getAttribute("dto");
%>

<style type="text/css">
	#updateform{
		display: none;
	}
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

<script type="text/javascript">

	function updateFormView() {
		$("#detailform").hide();
		$("#updateform").show();
	}

	function detailFormView() {
		$("#updateform").hide();
		$("#detailform").show();
	}
</script>

<title><%=dto.getWriter() %>님의 글</title>
</head>
<body>

	<div id="detailform">
	<h1>글 보기</h1>
	<table border="1">
		<tr>
			<th>번호</th>
			<td><%=dto.getSeq() %></td>
		</tr>
		<tr>
			<th>작성자 : </th>
			<td><%=dto.getWriter() %></td>
		</tr>
		<tr>
			<th>제목 : </th>	
			<td><%=dto.getTitle() %></td>
		</tr>
		<tr>
			<th>내용 : </th>
			<td>
				<textarea rows="10" cols="60" readonly="readonly"><%=dto.getContent() %></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<button onclick="updateFormView();">수정</button>
				<button onclick="location.href='controller.jsp?command=list'">목록</button>
			</td>
		</tr>
				 
	</table>
	</div>

	<div id ="updateform">
		<h1>글 수정</h1>
		
		<form action="controller.jsp?command=update" method="post">
			<input type="hidden" name="seq" value="<%=dto.getSeq() %>" />
		
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
				<th>작성자</th>
				<td><%=dto.getWriter() %></td>
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
					<input type="submit" value="수정완료" />
					<input type="button" value="취소" onclick="detailFormView();" />
				</td>
			</tr>						
		</table>
	  </form>
	</div>

</body>
</html>













