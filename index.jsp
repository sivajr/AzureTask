<!DOCTYPE html>
<html>
<head>
<title>Azure AD Test</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" />
</head>
<body>
	<form action="request-auth.jsp" method="post" id="azure_details">
		<input type="hidden" value="" name="authtoken" id="auth_token" />
		<div
			style="border-radius: 5px; width: 520px; margin: 100px auto; box-shadow: 0 2px 5px 7px rgba(80, 80, 80, 0.1); padding: 20px;">
			<h4 align="center">Azure AD Domain Details</h4>
			<div style="padding: 5px 0;">
				<div class="row">
					<div class="col-12">
						<label>AD Domain Name</label> <input type="text"
							class="form-control" name="azureadname" onblur="javascript:loadDomainUser()"
							id="azureadname" />
					</div>
				</div>
			</div>
			<div style="padding: 5px 0;" id="auth_btn">
				<div class="row">
					<div class="col-12">
						<input type="button" class="btn btn-block btn-primary"
							value="Authorize" onclick="javascript:authorize_azure_ad()" />
					</div>
				</div>
			</div>
		</div>
	</form>
	<script>
		function authorize_azure_ad() {
			document.getElementById("auth_btn").style.display = "none";
			var azureADName = document.getElementById("azureadname").value;
			map = window.open("domain.jsp?req_hid=yes&azureadname=" + azureADName, "Azure AD Authorization",
					"status=0,title=0,height=600,width=800,scrollbars=1");

			if (map) {
				console.log("Auth Opened");
			} else {
				alert('You must allow popups for this map to work.');
			}
		}
		function loadDomainUser() {
			document.getElementById("filluser").value = document.getElementById("azureadname").value;
		}
	</script>
</body>
</html>