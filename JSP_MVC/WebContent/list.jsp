<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>			 
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ page import = "java.util.List" %>
<%@ page import = "com.mvc.dto.MVCDto" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src = "http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

function allchk(bool) { 
	var chk = document.getElementsByName("chk");
	
	for(var i = 1; i < chk.length; i++){
		chk[i].checked = bool;	
	}
}
	
	$(function() {
		$("#muldelform").submit(function() {
			if($("#muldelform input:checked").length == 0) {
				alert("하나 이상 체크해 주세요!");
				
				return false;
			}
		});
	});
	


</script>
</head>

<% List<MVCDto> list = (List<MVCDto>)request.getAttribute("allList"); %>

<body>

	<h1>글 목록</h1>
	
	<form action="controller.jsp" method = "post" id = "muldelform">
		<input type = "hidden" name = "command" value = "muldel" />
			<table border = "1">
				<col width = "30px">
				<col width = "50px">
				<col width = "100px">
				<col width = "300px">
				<col width = "100px">
			<tr>
				<th><input type = "checkbox" name = "all" onclick = "allchk(this.checked)" /></th>
				<th>번   호</th>
				<th>작성자</th>
				<th>제   목</th>
				<th>작성일</th>
			</tr>

<%
		if(list.size() == 0){
%>
		
		<tr>
			<td colspan = "5">-------글이 존재하지 않아요ㅅㅂ--------</td>
		</tr>
<%
		} else {
			for(MVCDto dto : list){
%>		
		<tr>
			<td><input type = "checkbox" name = "chk" value = "<%= dto.getSeq() %>" /></td>
			<td><%= dto.getSeq() %></td>
			<td><%= dto.getWriter() %></td>	
			<td><a href = "controller.jsp?command=detail&seq=<%= dto.getSeq() %>"><%= dto.getTitle() %></a></td>
			<td><%= dto.getRegdate() %></td>
		</tr>	
			
<%
			}
		}	
%>
		<tr>
			<td colspan = "5">
				<input type = "submit" value = "삭제" />
				<input type = "button" value = "글쓰기" 
				 onclick = "location.href='controller.jsp?command=insertform'" />
			</td>
		</tr>		
	</table>
</form>

</body>
</html>






















