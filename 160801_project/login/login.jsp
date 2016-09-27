<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<!-- CSS  -->
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link href="../css/materialize.css" type="text/css" rel="stylesheet" media="screen,projection"/>
  <link href="../css/style.css" type="text/css" rel="stylesheet" media="screen,projection"/>
<!--SCRIPT-->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script type="text/javascript" src="../js/materialize.min.js"></script>

  <style type="text/css">
	  .loginForm{
	  	margin: 10% auto auto auto;
	  	width:350px;
	  	border:1px solid white;
	  }
  </style>
</head>
<body class="no-pad-bot light-blue darken-4">
	<!-- form 안의 내용을 testlogOK 로 보낸다. -->
		<div class="loginForm grey lighten-5">
			<form role="form" action="loginOK.jsp" method="post">
				<div class="row">
					        <!-- <div id="status"></div> -->
					        <h2 class="col s10 offset-s1 header center grey-text text-darken-4"><a class="grey-text text-darken-4" href="index.jsp"><strong>one-tack!</strong></a></h2>
					  
					  		<div class="input-field col s10 offset-s1">
						        <input type="text" name="inputEmail" id="inputEmail" class="validate" placeholder="e-mail을 입력하세요" autocomplete = "off"  >
						        <label for="email">email을 입력하세요</label>
					        </div>
					        <div class="input-field col s10 offset-s1">
						        <input type="password" name="inputPassword" id="inputPassword" class="validate" placeholder="password를 입력하세요" autocomplete = "off" >
						        <label for="email">password 입력하세요</label>
					        </div>
				</div>
				<div class="row">        
					        <input type="submit" class="col s10 offset-s1 waves-effect waves btn green accent-4" value="로그인">
							<br />	<br />
							<input type="button" class="col s10 offset-s1 waves-effect waves btn red darken-1" value="Google 계정으로 로그인" onclick="login()"/>
							<br />  <br /> <br />
				</div> 
			</form>
		</div>
	
	<script type="text/javascript">
 
		function logout()
		{
		    gapi.auth.signOut();
		    location.reload();
		}
		function login() 
		{
		  var myParams = {
		    'clientid' : '599015806319-a7827td5uvieardnefvlm7n4h8vgaram.apps.googleusercontent.com',
		    'cookiepolicy' : 'single_host_origin',
		    'callback' : 'loginCallback',
		    'approvalprompt':'force',
		    'scope' : 'https://www.googleapis.com/auth/plus.login https://www.googleapis.com/auth/plus.profile.emails.read'
		  };
		  gapi.auth.signIn(myParams);
		}
		 
		function loginCallback(result)
		{
		    if(result['status']['signed_in'])
		    {
			 	var request = gapi.client.plus.people.get(
			 	        {
			 	            'userId': 'me'
			 	        });
			 	        request.execute(function (resp)
			 	        {
			 	            var email = '';
			 	            if(resp['emails'])
			 	            {
			 	                for(i = 0; i < resp['emails'].length; i++)
			 	                {
			 	                    if(resp['emails'][i]['type'] == 'account')
			 	                    {
			 	                        email = resp['emails'][i]['value'];
			 	                    }
			 	                }
			 	            }
			 	 
			 	            var str = "Name:" + resp['displayName'] + "<br>";
			 	            str += "Email:" + email + "<br>";
			 	            
			 	       		location.href = "googleLoginOk.jsp?email=" + email + "&name=" + resp['displayName'];
			 	        });
			 	        
			 	      
		    }
		 
		}
		function onLoadCallback()
		{
		    gapi.client.setApiKey('AIzaSyCdQ6IWMpc8UWDV-Aq48XgN957UiBOYsTo');
		    gapi.client.load('plus', 'v1',function(){});
		}
		 
		</script>
		
			<script type="text/javascript">
		      (function() {
		       var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
		       po.src = 'https://apis.google.com/js/client.js?onload=onLoadCallback';
		       var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
		     })();
		</script>

</body>
</html>