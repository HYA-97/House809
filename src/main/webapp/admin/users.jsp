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
    <script language="JavaScript">
        $(function(){
            //使用datagrid绑定数据库
            $('#dg').datagrid({
                url:'/con/selectAll',
                title:"用户信息",
                toolbar:"#ToolBar",  //指定工具栏
                pagination:true,
                pageList:[3,6,9,15,20],
                pageSize:3,
                //singleSelect:true,
                columns:[[
                    {field:"cb",checkbox:true},
                    {field:'id',title:'编号',width:100},
                    {field:'name',title:'昵称',width:100},
                    {field:'telephone',title:'电话',width:100},
                    {field:'s',title:'删除',width:100,
                        formatter: function(value,row,index){
                            var str="<a href='javascript:delOne()'>删除</a>"
                            return str;
                        }
                    },
                    {field:'u',title:'修改',width:100,
                        formatter: function(value,row,index){
                            var str="<a href='javascript:updateDialog()'>修改</a>"
                            return str;
                        }
                    }
                ]]
            });
        });

        //点击添加，打开窗口
        function addDialog(){
            //alert("我要添加区域");
            $('#AddDialog').window('setTitle',"添加区域");
            $('#AddDialog').window('open');
        }
        //关闭对话框
        function CloseAddDialog(id){
            $('#'+id).window('close'); //关闭
        }

        //显示修改的对话框
        function updateDialog(){
            //判断用户选择
            //1.获取dagagrid的选中行
            var SelectRows = $("#dg").datagrid('getSelections');  //返回数组
            if(SelectRows.length==1){
                $('#updateDialog').window('setTitle',"编辑区域");
                $('#updateDialog').window('open');

                //获取当前行的数据:获取主键，查询数据库获取单行数据
                //如果当显示的数据在dagagrid中存在，无需查询数据库，如果当显示的数据在datagrid中不全，需要查询数据库获单条
                //发异步请求查询数据库
                $.post("/con/getOneUsers",{"id":SelectRows[0].id},function(data){
                    $("#form2").form('load',data); //将对象还原表单
                },"json");
                //将信息还原到表单中.
                //$("#form1").form('load',json对象);
                //$("#form2").form('load',{"name":"默认值"});  //name表示表单对象名称
                //$("#form2").form('load',SelectRows[0]);  //{"id":1001,"name":"东城"}
            }else{
                $.messager.alert('>>提示','你没有选择行或者选择多行，给我小心点!','warn');  //提示框
            }
        }


        function SaveDistrict(){
            //1.获取数据，发送异步请求实现添加
            //$.post("addDistrict",给服务器传参,function(data){},"json");
            /* $.post("addDistrict",{"name":$("#name2").val()},function(data){
                 alert(data);
             },"json");*/

            //2.使用easuyi插件以异步方式提交表单
            $('#form1').form('submit',{
                url:"/con/addUsers",
                success:function(data){  //data表示的字符串
                    //将返回的json字符串转化为json对象
                    // data=$.parseJSON(data);
                    if(data==1){
                        $.messager.alert('>>提示','添加成功！','info');  //提示框
                        $('#AddDialog').window('close'); //关闭
                    }else{
                        $.messager.alert('>>提示','添加失败！','error');
                        $('#AddDialog').window('close'); //关闭
                    }
                }
            });
        }

        function UpdateDistrict(){
            $('#form2').form('submit',{
                url:"/con/update",
                success:function(i){  //data表示的字符串
                    //将返回的json字符串转化为json对象
                    // data=$.parseJSON(data);
                    if(i==1){
                        $.messager.alert('>>提示','修改成功！','info');  //提示框
                        $('#updateDialog').window('close'); //关闭
                    }else{
                        $.messager.alert('>>提示','修改失败！','error');
                        $('#updateDialog').window('close'); //关闭
                    }
                }
            });
        }
        function delOne() {
            var SelectRows = $("#dg").datagrid('getSelections');
            var id = SelectRows[0].id;
            $.post("/con/delOne",{"id":id},function (i) {
                if(i==1){
                    $('#dg').datagrid("reload");
                    $.messager.alert('>>提示','成功删除'+id,'info');  //提示框
                }else {
                    $.messager.alert('>>提示',id+'删除失败！','info');  //提示框
                }
            })

        }

        function delBatch() {
            var ids = new Array();
            var SelectRows = $("#dg").datagrid('getSelections');
            if(SelectRows.length==0){
                $.messager.alert('>>提示','你没有选择行或者选择多行，给我小心点!','info');
            }else {
                for (var i=0; i<SelectRows.length; i++) {
                    var id = SelectRows[i].id;
                    ids.push(id)
                }
                if(ids.length>0){
                    $.post("/con/delBatch", {"ids":ids.toString()}, function (i) {
                        if (i == SelectRows.length) {
                            $('#dg').datagrid("reload");
                            $.messager.alert('>>提示', '成功删除'+i+"条数据！", 'info');  //提示框
                        } else {
                            $.messager.alert('>>提示', '删除失败！', 'info');  //提示框
                        }
                    });
                }


            }
        }

    </script>
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
    <form method="post" action="/con/addUsers" id="form1" name="form1">
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
    <form method="post" action="/con/update" id="form2" name="form2">
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
</body>
</html>
