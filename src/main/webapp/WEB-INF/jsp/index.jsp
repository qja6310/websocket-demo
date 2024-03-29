<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title></title>
<script type="text/javascript" src="<%=request.getContextPath() %>/assets/jquery-3.4.1.min.js"></script>
<script type="application/javascript">
		var url = "39.97.178.217:8888/";
      var socket ;
      //登录过后初始化socket连接
      function initSocket(userId) {
          if(typeof(WebSocket) == "undefined") {
              console.log("您的浏览器不支持WebSocket");
          }else {
              console.log("您的浏览器支持WebSocket/websocket");
          }
          //socket连接地址: 注意是ws协议
          socket = new WebSocket('ws:'+url+'websocket/'+userId);
          socket.onopen = function() {
              console.log("Socket 已打开");
          };
          //获得消息事件
          socket.onmessage = function(msg) {
              var histroy = $("#history").val();
              $("#history").val(histroy+"\r\n"+msg.data);
              console.log($(msg));
          };
          //关闭事件
          socket.onclose = function() {
              console.log("Socket已关闭");
          };
          //错误事件
          socket.onerror = function() {
              alert("Socket发生了错误");
          }
          /* $(window).unload(function(){
              socket.close();
          }); */
      }
      //点击按钮发送消息
      function send() {
          console.log("发送消息: "+$("#msg").val());
          socket.send($("#msg").val());
      }
      //登录
      function login() {
          $.ajax({
              url: "/login",
              data: $("#loginForm").serialize(),
              type: "POST",
              success: function (userId) {
                  if (userId){
                      console.log("登录成功!" + userId);
                      initSocket(userId);
                  }
              }
          });
      }

</script>
</head>
<body>
	<form id="loginForm">
		用户名: <input name="username"><br> 密&emsp;码: <input
			name="password"> <br> <input type="button" value="登录"
			onclick="login()" />
	</form>

	<textarea id="msg" placeholder="格式:@xxx#消息 , 或者@ALL#消息"
		style="width: 500px; height: 50px"></textarea>
	<input type="button" onclick="send()" value="发送消息">
	<br>
	<textarea id="history"
		style="width: 500px; height: 200px; max-lines: 10">
</textarea>
</body>
</html>
