<%@page import = "project.ConnectionProvider"%>
<%@page import = "java.sql.*" %>
<%
String email = request.getParameter("email");
String mobileNumber = request.getParameter("mobileNumber");
String securityQuestion = request.getParameter("securityQuestion");
String answer = request.getParameter("answer");
String newPassword = request.getParameter("newPassword"); 

int check=0;
Connection con = ConnectionProvider.getCon();
Statement st = null;
ResultSet rs = null;
con = ConnectionProvider.getCon();
try{
	st = con.createStatement();
	rs = st.executeQuery("select * from users where email='"+email+"' and mobileNumber='"+mobileNumber+"'and securityQuestion='"+securityQuestion+"' and answer='"+answer+"'");
	
    if(rs.next()) {
        check = 1;
        st.executeUpdate("update users set password='"+newPassword+"' where email='"+email+"'");
    }
    rs.close();

    response.sendRedirect(check == 0 ? "forgotPassword.jsp?msg=invalid" : "forgotPassword.jsp?msg=done");
} catch (Exception e){
	System.out.println(e.getMessage());} 
finally{
	if (rs != null){
		rs.close();
	}
	if(st != null){
		st.close();
	}
	if (con != null){
		con.close();
	}
}

%>