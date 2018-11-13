<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>			 
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ page import = "com.mvc.dto.MVCDto" %>
<%@ page import = "com.mvc.dao.MVCDao" %>
<%@ page import = "java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>

<%
	//view에서 요청한 내용을 담은 query
	String command = request.getParameter("command");

	MVCDao dao = new MVCDao();
	
	System.out.println("[command : " + command + "]");
	if(command.equals("list")){
		
		List<MVCDto> list = dao.selectAll();
		
		request.setAttribute("allList", list);
		pageContext.forward("list.jsp");
		
		// forward : request, response 유지되면서 페이지 전환
		// sendRedirect : 새로운 request, response
		
		
	} else if (command.equals("insertform")){
		
		response.sendRedirect("insert.jsp");
		
	} else if (command.equals("insert")){
		
		String writer = request.getParameter("writer");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		MVCDto dto = new MVCDto();
		
		dto.setWriter(writer);
		dto.setTitle(title);
		dto.setContent(content);
		
		int res = dao.insert(dto);
		
		if(res > 0) {
%>	
	<script type = "text/javascript">
		alert("글 작성 성공");
		location.href = "controller.jsp?command=list";
	</script>		

<%
		} else {
%>		

	<script type = "text/javascript">
		alert("글 작성 실패");
	</script>	

<%
		response.sendRedirect("controller.jsp?command=insertform");	
		
		}
	} else if (command.equals("detail")){
		
		int seq = Integer.parseInt(request.getParameter("seq"));
		
		MVCDto dto = dao.selectOne(seq);
		
		request.setAttribute("dto", dto);
		pageContext.forward("detail.jsp");
		
	} else if(command.equals("upadateform")){
		
		int seq = Integer.parseInt(request.getParameter("seq"));
		
		MVCDto dto = new MVCDto();
		
		request.setAttribute("dto", dto);
		pageContext.forward("update.jsp");
	
	} else if(command.equals("update")) {
		
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		int seq = Integer.parseInt(request.getParameter("seq"));
		
		MVCDto dto = new MVCDto();
		
		dto.setTitle(title);
		dto.setContent(content);
		dto.setSeq(seq);
		
		int res = dao.update(dto);
		
		if(res > 0) {

%>
	<script type="text/javascript">
		alert("글 수정 성공");
		location.href = "controller.jsp?command=detail&seq=" + <%=seq%>;
	</script>
<%
		} else {
%>
	<script type="text/javascript">
		alert("글 수정 실패");
		location.href = "controller.jsp?command=updateform&seq=" + <%=seq%>;
	</script>
<%
		}
	} else if(command.equals("delete")){
		String[] seqArr = new String[1];
		seqArr[0] = request.getParameter("seq");
		
		int res = dao.multiDelete(seqArr);
		if(res > 0){
%>

	<script type="text/javascript">
		alert("글 삭제 성공");
		location.href="controller.jsp?command=list";
	</script>

<%
		} else {
%>

	<script type="text/javascript">
		alert("글 삭제 실패");
		location.href="controller.jsp?command=detail&seq="+<%=seqArr[0]%>;
	</script>

<%			
		}
	}else if(command.equals("muldel")){
		String[] seq = request.getParameterValues("chk");
		int res = dao.multiDelete(seq);
		if(res > 0){
%>
		<script type="text/javascript">
			alert("글 삭제 성공");
			location.href="controller.jsp?command=list";
		</script>
<%			
		} else{
%>
		<script type="text/javascript">
			alert("글 삭제 실패");
			location.href="controller.jsp?command=list";
		</script>
<%			
		}
	}
%>

	

</body>
</html>