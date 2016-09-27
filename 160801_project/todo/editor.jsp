<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>one-tack!</title>
<script src="//cdn.ckeditor.com/4.5.10/basic/ckeditor.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script>
       $(function(){
         	CKEDITOR.replace('cardContents');	
        });
</script>
</head>
<body>
	<p name="cardContents"> </p>
</body>
</html>