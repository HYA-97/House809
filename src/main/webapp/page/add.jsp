<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>

    <title>注册</title>

<body>
<html lang="en">
<head>

    <title>regedit</title>
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
            <p class="block-heading">Sign In</p>
            <div class="block-body">
                <form action="/con/addUsers" method="post" onsubmit="return add()">
                    <label>昵称</label>
                    <span></span>
                    <input name="name" type="text" class="span12">
                    <label>密码</label>
                    <span></span>
                    <input name="password" type="password" class="span12">
                    <label>密码确认</label>
                    <span></span>
                    <input type="password" name="pwd" class="span12">
                    <label>电话</label>
                    <span></span>
                    <input type="text" name="telephone" class="span12">
                    <label></label>
                    <span></span>
                    <select name="isadmin" id="">
                        <option value="">--请选择用户类型--</option>
                        <option value="0">租客</option>
                        <option value="1">房东</option>
                    </select>
                    <input type="submit"class="btn btn-primary pull-right" value="注册">
                    <%--<a onclick="document.forms[0].submit()" class="btn btn-primary pull-right">Sign In</a>--%>
                    <label class="remember-me"><input type="checkbox"> Remember me</label>
                    <div class="clearfix"></div>
                </form>
            </div>
        </div>
        <p class="pull-right" style=""><a href="/page/login.jsp" target="blank">返回</a></p>
        <p><a href="reset-password.html">更多</a></p>
    </div>
</div>
</body>
<script src="../bootstrap/lib/bootstrap/js/bootstrap.js"></script>
<script src="../bootstrap/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

    $("input[name='name']").blur(function () {
        if(this.value.trim()==""){
            $('span:eq(2)').html('用户名不能为空').css("color","red")
        }else if(this.value.length>0){
            $.post("/con/uName?name="+this.value,function (i) {
                if(i==1){
                    $('span:eq(2)').html('用户已存在，请重新输入！').css("color","red")
                }else {
                    $('span:eq(2)').html('OK').css("color","green")
                }
            })

        }
    });

    $("input[name='password']").focus(function () {
        $('span:eq(3)').html("密码只能由符号、字母、数字组成").css("color","red")
    })
    $("input[name='password']").blur(function () {
        if(this.value.trim()==""){
            $('span:eq(3)').html('密码不能为空').css("color","red")
        }else if(this.value.length>=8&&this.value.length<=16){
            $('span:eq(3)').html('OK').css("color","green")
        }else {
            $('span:eq(3)').html('长度只能为8~16位数之间').css("color","red")
        }
    });

    $("input[name='pwd']").focus(function () {
        $('span:eq(4)').html("请再次输入密码").css("color","red")
    })
    $("input[name='pwd']").blur(function () {
        var password = $("input[name='password']").val()
        if(this.value.trim()==""){
            $('span:eq(4)').html('请再次输入密码！').css("color","red")
        }else if(this.value==password){
            $('span:eq(4)').html('OK').css("color","green")
        }else {
            $('span:eq(4)').html('密码验证错误，请重新输入密码').css("color","red")
        }
    });

    $("input[name='telephone']").focus(function () {
        $('span:eq(5)').html("密码的长度只能为11位,且只能由数字组成").css("color","red")
    })
    $("input[name='telephone']").blur(function () {
        if(this.value.trim()==""){
            $('span:eq(5)').html('电话号码不能为空').css("color","red")
        }else if(this.value.length==11){
            $('span:eq(5)').html('OK').css("color","green")
        }else {
            $('span:eq(5)').html('长度只能为11位').css("color","red")
        }
    });

    function add() {
        var name = $("input[name='name']").val()
        var password = $("input[name='password']").val()
        var pwd = $("input[name='pwd']").val()
        var telephone = $("input[name='telephone']").val()

        if(name.value.trim()==""){
            $('span:eq(2)').html('用户名不能为空').css("color","red")
            return false
        }else if(name.value.length>0){
            $.post("/con/uName?name="+name.value,function (i) {
                if(i==1){
                    $('span:eq(2)').html('用户已存在，请重新输入！').css("color","red")
                    return false;
                }else {
                    return true

                }
            })
        }

        if(password.length==0){
            $('span:eq(3)').html('密码不能为空').css("color","red")
            return false;
        }else {
            return true;
        }

        if(password!=pwd){
            $('span:eq(4)').html('请再次输入密码！').css("color","red")
            return false;
        }else {
            return true;
        }

        if(telephone.length==0){
            $('span:eq(5)').html('电话号码不能为空').css("color","red")
            return false;
        }else {
           return true;
        }
    }

</script>
</html>


