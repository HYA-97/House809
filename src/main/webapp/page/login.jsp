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
                <form action="/con/login" method="post" onsubmit="return toLog()">
                    <label>username</label>
                    <span></span>
                    <input name="name" type="text" class="span12" value="${user.name}">
                    <label>Password</label>
                    <span></span>
                    <input name="password" type="password" class="span12">
                    <input type="submit" class="btn btn-primary pull-right" value="登录">
                    <label class="remember-me"><input type="checkbox"> Remember me</label>
                    <div class="clearfix"></div>
                </form>
            </div>
        </div>
        <p class="pull-right" style=""><a href="/page/add.jsp">注册</a></p>
        <p><a href="/page/sms.jsp">短信验证码登录</a></p>
        <p><a href="reset-password.html">忘记密码?</a></p>
    </div>
</div>
</body>
<script src="../bootstrap/lib/bootstrap/js/bootstrap.js"></script>
<script src="../bootstrap/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

    $("input[name='name']").blur(function () {
        if(this.value.trim()==""){
            $('span:eq(2)').html('用户名不能为空').css("color","red")
        }else if(this.value.length>=0){
            $.post("/con/uName?name="+this.value,function (i) {
                if(i!=1){
                    $('span:eq(2)').html('用户不存在，请重新输入！').css("color","red")
                }else {
                    $('span:eq(2)').html('OK').css("color","green")
                }
            })

        }
    });

    function toLog(){
        var pwd = $("input[name='password']").val();
        var name = $("input[name='name']").val()
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


    /*$("input[name='password']").focus(function () {
        if($("p[id='message']").val()==${msg}){
            alert(${msg})
        }
    })*/

    /*$("input[name='password']").blur(function () {
        if(this.value.trim()==""){
            $('span:eq(3)').html('密码不能为空').css("color","red")
        }else if(this.value.length!=0){
            $('span:eq(3)').html('OK').css("color","green")
        }else {
            $('span:eq(3)').html('长度只能为6位').css("color","red")
        }
    });*/
</script>
</html>