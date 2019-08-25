<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>区域管理</title>
    <link rel="stylesheet" type="text/css" href="easyUI/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="easyUI/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="easyUI/css/demo.css">
    <script src="js/jquery-1.8.3.js"></script>
    <!--jquery.easyui.min.js包含了easyUI中的所有插件-->
    <script src="js/jquery.easyui.min.js"></script>
    <style type="text/css">
        a{text-decoration:none;}
    </style>
    <script src="js/district.js"></script>
    <script src="js/streetBid.js"></script>
</head>
<body>
<!--显示所有区域-->
<table id="dg"></table>

<!--制作工具栏-->
<div id="ToolBar">
    <div style="height: 40px;">
        <a href="javascript:addDialog()" class="easyui-linkbutton"
           iconCls="icon-add" plain="true">添加</a> <a
            href="javascript:updateDialog()" class="easyui-linkbutton"
            iconCls="icon-edit" plain="true">修改</a> <a
            href="javascript:delBatch()" class="easyui-linkbutton"
            iconCls="icon-remove" plain="true">多项删除</a>
    </div>
</div>

<!--添加对话框-->
<div id="AddDialog" class="easyui-dialog" buttons="#AddDialogButtons"
     style="width: 280px; height: 250px; padding: 10px 20px;" closed="true">
    <form method="post" action="/con1/addDistrict" id="form1" name="form1">
        区域名称:<input type="text" name="name" id="name2">
        <%--<input type="submit" value="添加">--%>
    </form>
</div>
<!--添加对话框的按钮-->
<div id="AddDialogButtons">
    <a href="javascript:SaveDistrict()" class="easyui-linkbutton"
       iconCls="icon-ok">保存</a> <a href="javascript:CloseAddDialog('AddDialog')"
                                   class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
</div>

<!--修改对话框-->
<div id="updateDialog" class="easyui-dialog" buttons="#updateDialogButtons"
     style="width: 280px; height: 250px; padding: 10px 20px;" closed="true">
    <form method="post" action="/con1/update" id="form2" name="form2">
        <input type="hidden" name="id">
        区域名称:<input type="text" name="name" id="name3">
    </form>
</div>
<!--添加对话框的按钮-->
<div id="updateDialogButtons">
    <a href="javascript:UpdateDistrict()" class="easyui-linkbutton"
       iconCls="icon-ok">更新</a> <a href="javascript:CloseAddDialog('updateDialog')"
                                   class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
</div>






<!--添加对话框的按钮-->
<div id="streetB">
    <a href="javascript:UpdateDistrict()" class="easyui-linkbutton"
       iconCls="icon-ok">更新</a> <a href="javascript:CloseAddDialog('updateDialog')"
                                   class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
</div>

<div id="streets"class="easyui-dialog" buttons="#streetB"
     style="width: 280px; height: 250px; padding: 10px 20px;" closed="true">
<table id="ds"></table>

    <div id="tools">
        <div style="height: 40px;">
            <a href="javascript:addsDialog()" class="easyui-linkbutton"
               iconCls="icon-add" plain="true">添加</a> <a
                href="javascript:updatesDialog()" class="easyui-linkbutton"
                iconCls="icon-edit" plain="true">修改</a> <a
                href="javascript:delsBatch()" class="easyui-linkbutton"
                iconCls="icon-remove" plain="true">多项删除</a><a
                href="javascript:street()" class="easyui-linkbutton"
                iconCls="icon-remove" plain="true">所有信息</a>
        </div>
    </div>

<div id="AddsDialog" class="easyui-dialog" buttons="#AddDialogButton"
     style="width: 280px; height: 250px; padding: 10px 20px;" closed="true">
    <form method="post" action="/con2/addStreet" id="form5" name="form5">
        区域名称:<input type="text" name="name" id="name5">

    </form>
</div>
<!--添加对话框的按钮-->
<div id="AddsDialogButton">
    <a href="javascript:SaveDistrict()" class="easyui-linkbutton"
       iconCls="icon-ok">保存</a> <a href="javascript:CloseAddsDialog('AddsDialog')"
                                   class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
</div>


<!--修改对话框-->
<div id="updatesDialog" class="easyui-dialog" buttons="#updateDialogButton"
     style="width: 280px; height: 250px; padding: 10px 20px;" closed="true">
    <form method="post" action="/con2/update" id="form4" name="form4">
        <input type="hidden" name="id">
        区域名称:<input type="text" name="name" id="name4">
    </form>
</div>
<!--添加对话框的按钮-->
<div id="updatesDialogButton">
    <a href="javascript:UpdatesDistrict()" class="easyui-linkbutton"
       iconCls="icon-ok">更新</a> <a href="javascript:CloseAddsDialog('updatesDialog')"
                                   class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
</div>
<!--查看街道对话框-->
<div id="dsDialog" class="easyui-dialog" buttons="#AddDialogButtons"
     style="width: 400px; height: 300px; padding: 10px 20px;" closed="true"></div>

</div>
</body>
</html>
