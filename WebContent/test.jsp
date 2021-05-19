<%@ page language="java" import="dbgame.connDb,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// ArrayList<String[]> list = connDb.f3_1_3();
ArrayList<String[]> list =  connDb.f1_4();
%>    
<html>
<body>
<script type="text/javascript">
<%-- var data = <%=list.get(0)[0]%>
var elem = document.createElement("div");  
elem.innerHTML = data;  
document.body.appendChild(elem);  --%>

var data = [];
data[0] = [];
data[1] = [];
<%
	for(String[] a:list){
		 a[0] = (String)a[0];
		 System.out.println(a[0]);
%>
        data[0].push("<%=a[0]%>");
        data[1].push(<%=a[1]%>);
<%
	}
%>
</script>
</body>
</html>