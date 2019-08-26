<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>regedit</title>
    <meta charset="utf-8">
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <link rel="stylesheet" type="text/css" href="../bootstrap/lib/bootstrap/css/bootstrap.css">

    <link rel="stylesheet" type="text/css" href="../bootstrap/stylesheets/theme.css">
    <link rel="stylesheet" href="../bootstrap/lib/font-awesome/css/font-awesome.css">

    <script src="../bootstrap/lib/jquery-1.7.2.min.js" type="text/javascript"></script>

    <!-- Demo page code -->

    <style type="text/css">
        #line-chart {
            height:300px;
            width:800px;
            margin: 0px auto;
            margin-top: 1em;
        }
        .brand { font-family: georgia, serif; }
        .brand .first {
            color: #ccc;
            font-style: italic;
        }
        .brand .second {
            color: #fff;
            font-weight: bold;
        }
    </style>

    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <!-- Le fav and touch icons -->


    <!--[if lt IE 7 ]> <body class="ie ie6"> <![endif]-->
    <!--[if IE 7 ]> <body class="ie ie7 "> <![endif]-->
    <!--[if IE 8 ]> <body class="ie ie8 "> <![endif]-->
    <!--[if IE 9 ]> <body class="ie ie9 "> <![endif]-->
    <!--[if (gt IE 9)|!(IE)]><!-->
<body class="">
<script type="text/javascript">

</script>
<!--<![endif]-->

<div class="navbar">
    <div class="navbar-inner">
        <ul class="nav pull-right">

        </ul>
        <a class="brand" href="index.html"><span class="first">Your</span> <span class="second">Company</span></a>
    </div>
</div>






<div class="row-fluid">
    <div class="dialog">
        <div class="block">
            <p class="block-heading">Sign In</p><p align="center" id="message" style="margin-top:20px;color:red">${msg}</p>
            <div class="block-body">
                <form action="/con/login2" method="post" onsubmit="return toLog()">
                    <label>手机号码</label>
                    <span></span>
                    <input name="telephone" id="inputTel" type="text" class="span12" value="${userSms.name}">
                    <label>验证码</label>
                    <span></span>
                    <input name="code" type="text" class="span7"><input type="button" id="sendButton" class="btn-link" value="获取验证码"></br>
                    <input type="submit" class="btn btn-primary pull-right" value="登录">
                    <label class="remember-me"><input type="checkbox"> Remember me</label>
                    <div class="clearfix"></div>
                </form>
            </div>
        </div>
        <p class="pull-right" style=""><a href="/page/add.jsp">注册</a></p>
        <p><a href="/page/login.jsp">返回</a></p>
    </div>
</div>
</body>
<script src="../bootstrap/lib/bootstrap/js/bootstrap.js"></script>
<script src="../bootstrap/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

    $("input[name='telephone']").blur(function () {
        if(this.value.trim()==""){
            $('span:eq(2)').html('用户名不能为空').css("color","red")
        }else if(this.value.length>=0){
            $.post("/con/tel?telephone="+this.value,function (i) {
                if(i!=1){
                    $('span:eq(2)').html('用户不存在，请重新输入！').css("color","red")
                }else {
                    $('span:eq(2)').html('OK').css("color","green")
                }
            })

        }
    });

    function toLog(){
        var pwd = $("input[name='code']").val();
        var name = $("input[name='telephone']").val()
        if(pwd.trim()==""){
            // alert("密码不能为空！")
            $('span:eq(3)').html('密码不能为空').css("color","red")
            if(name.length==0){
                $('span:eq(2)').html('用户名不能为空').css("color","red")
            }
            return false;
        }else {
            $('span:eq(3)').html('OK').css("color","green")
            return true;
        }
    }

    var timeobj;
        //发送验证码
        $("#sendButton").click(function(){

            $.post("/sms/loginSms",{"tel":$("#inputTel").val()},function(data){
                alert(data.result);
                if(data.result>0) {
                    //安装定时
                    timeobj=setInterval("goback()",1000);
                    alert("发送验证码成功");
                }
                else
                    alert("发送失败");
            },"json");

        });


    //显示倒计时
    var time=60;
    function goback(){
        time--;
        if(time==0) {
            $("#sendButton").val("重新发送");
            time=60;
            clearInterval(timeobj); //消除定时
        }
        else {
            $("#sendButton").val(time);
        }
    }
</script>
</html>