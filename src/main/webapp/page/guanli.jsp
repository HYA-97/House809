<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<!-- saved from url=(0050)http://localhost:8080/HouseRent/manage!list.action -->
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD>
<TITLE>青鸟租房 - 用户管理</TITLE>
<META content="text/html; charset=utf-8" http-equiv=Content-Type><LINK 
rel=stylesheet type=text/css href="../css/style.css">

<META name=GENERATOR ></HEAD>
<BODY>
<DIV id=header class=wrap>
<DIV id=logo><a href="javascript:location.href='/con5/PageSearch'"><IMG src="../images/logo.gif"></a></DIV>
<DIV class=search><span style="color:red; font-size: 24px;">欢迎:${users.name}</span><LABEL class="ui-green searchs"><a href="/page/fabu.jsp" title="">发布房屋信息</a></LABEL>
<LABEL class=ui-green><INPUT onclick='document.location="/page/login.jsp"' value="退       出" type=button name=search></LABEL>
</DIV></DIV>
<DIV class="main wrap">
<DIV id=houseArea>
<TABLE class=house-list>
  <TBODY>
  <c:forEach items="${pageInfo.list}" var="h">
    <TR>
      <TD class=house-thumb><SPAN><A href="/con5/houseOne?id=${h.id}" target="_blank"><img src="http://localhost:81/${h.path}" width="100" height="75" alt=""></A></SPAN></TD>
      <TD>
        <DL>
          <DT><A href="/con5/houseOne?id=${h.id}" target="_blank">${h.title}</A></DT>
          <DD>${h.dname}->${h.sname},${h.floorage}平米<BR>联系方式：${h.contact}<br>类型:${h.tname} <br>时间:<fmt:formatDate value="${h.pubdate}" pattern="yyyy-MM-dd"></fmt:formatDate></DD></DL></TD>
      <TD class=house-type><LABEL class=ui-green><INPUT onclick=location.href="/con5/Onehouse?id=${h.id}" value="修    改" type=button name=search ></LABEL></TD>
      <TD class=house-price><LABEL class=ui-green><INPUT value="删    除" type=button name="search" onclick="todel(${h.id})"></LABEL></TD>
    </TR>
  </c:forEach>
  </TBODY></TABLE></DIV>
<DIV class=pager>
<UL>
  <c:forEach begin="1" end="${pageInfo.pages}" step="1" var="i">
    <LI class=current><A id=widget_338868862
                         href="/con5/Uhouse?page=${i}"
                         parseContent="true" showError="true" targets="houseArea"
                         ajaxAfterValidation="false" validate="false"
                         dojoType="struts:BindAnchor">${i}</A>
    </LI>
  </c:forEach></UL><SPAN class=total>1/2页</SPAN> </DIV></DIV>
<DIV id=footer class=wrap>
<DL>
  <DT>青鸟租房 © 2018 北大青鸟 京ICP证1000001号</DT>
  <DD>关于我们 · 联系方式 · 意见反馈 · 帮助中心</DD></DL></DIV></BODY>
<script>
     function todel(id) {
       if(confirm("你确定删除吗？")){
         location.href="/con5/isDel?id="+id;
       }
     }
</script>
</HTML>
