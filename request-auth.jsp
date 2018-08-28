<%@page import="com.microsoft.aad.adal4j.AuthenticationContext"%>
<%@page import="com.microsoft.aad.adal4j.AuthenticationResult"%>
<%@page import="org.json.*"%>
<%@page import="java.util.concurrent.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.URI"%>
<html>
<head>
<title>Users</title>
</head>
<body>
	<h1>Users</h1>
	<%
		String azureADName = request.getParameter("azureadname");
		String authToken = request.getParameter("authtoken");

		AuthenticationContext context;
        AuthenticationResult result;
        ExecutorService service = null;
        try {
            service = Executors.newFixedThreadPool(1);
            context = new AuthenticationContext("https://login.microsoftonline.com/"+azureADName, false, service);
            Future<AuthenticationResult> future = context.acquireTokenByAuthorizationCode(authToken,"https://graph.microsoft.com", "b357b9d0-29d0-4081-84b5-29fac953b943", new URI("http://localhost:8080/azure/domain.jsp"), null);
            result = future.get();
            URL url = new URL("https://graph.microsoft.com/v1.0/admindc1.onmicrosoft.com/users");
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Authorization", "Bearer " + result.getAccessToken());
	        conn.setRequestProperty("Accept","application/json");

	        int httpResponseCode = conn.getResponseCode();
	        if(httpResponseCode == 200) {
	            BufferedReader in = null;
	            String res = "";
	            try{
	                in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	                String inputLine;
	                res = "";
	                while ((inputLine = in.readLine()) != null) {
	                    res += inputLine;
	                }
	            } finally {
	                in.close();
	            }
	            //out.println(res);
	            /*JSONObject jsonObj = new JSONObject(res);
		        JSONArray jsonArray = new JSONArray((jsonObj.get("value")).toString());
		        for (int i=0;i<jsonArray.length() ;i++ ) {
		            JSONObject object = jsonArray.getJSONObject(i);
		            %>
		            <p><%=object.get("displayName")%></p>
		            <%
		        }*/
	        }
        } finally {
            service.shutdown();
        }

	%>
</body>
</html>