<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Enumeration"%>
<html>
<head>
<title>Azure AD Domain Request Form</title>
</head>
<body>
	<%
		String reqHid = request.getParameter("req_hid");
		if (reqHid != null && !reqHid.isEmpty() && reqHid.equalsIgnoreCase("yes")) {
			String azureADName = request.getParameter("azureadname");

			String url = "https://login.microsoftonline.com/" + azureADName + "/oauth2/authorize?client_id=b357b9d0-29d0-4081-84b5-29fac953b943&response_type=code&prompt=admin_consent";
			response.sendRedirect(url);
		} else {
			Enumeration<String> params = request.getParameterNames();
			Map<String, String> queryParams = new HashMap<>();
			while (params.hasMoreElements()) {
				String data = params.nextElement();
				queryParams.put(data, request.getParameter(data));
			}
			if (!queryParams.containsKey("error")) {
				String authToken = queryParams.get("code");
	%>
	<script>
		var pat = window.opener;
		if (pat) {
			pat.document.getElementById("auth_token").value = "<%=authToken%>";
			pat.document.getElementById("azure_details").submit();
		
			window.close();
		}
	</script>
	<%
		}
		}
	%>
</body>
</html>