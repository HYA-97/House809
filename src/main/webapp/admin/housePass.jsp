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
                url:'/con5/selectPass',
                title:"用户信息",
                toolbar:"#ToolBar",  //指定工具栏
                pagination:true,
                pageList:[3,6,9,15,20],
                pageSize:3,
                //singleSelect:true,
                columns:[[
                    {field:"cb",checkbox:true},
                    {field:'id',title:'编号',width:100},
                    {field:'title',title:'名称',width:100},
                    {field:'price',title:'价格',width:100},
                    {field:'floorage',title:'面积',width:100},
                    {field:'pubdate',title:'时间',width:100},
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
                    },
                    {field:'p',title:'审核',width:100,
                        formatter: function(value,row,index){
                            var str="<a href='javascript:pass()'>取消审核</a>"
                            return str;
                        }
                    }
                ]]
            });
        });

        function pass() {
            var SelectRows = $("#dg").datagrid('getSelections');
            var id = SelectRows[0].id;
            $.post("/con5/update?ispass=0",{"id":id},function (i) {
                if(i==1){
                    $('#dg').datagrid("reload");
                    $.messager.alert('>>提示','审核成功'+id,'info');  //提示框
                }else {
                    $.messager.alert('>>提示',id+'审核失败！','info');  //提示框
                }
            })

        }
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
            location.href="/page/updateHouse.jsp"
        }


        function SaveDistrict(){

        }

        function UpdateDistrict(){
            $('#form2').form('submit',{
                url:"/con5/update",
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
            $.post("/con5/delOne",{"id":id},function (i) {
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
                    $.post("/con5/delBatch", {"ids":ids.toString()}, function (i) {
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
    <form method="post" action="/con5/addHouse" id="form1" name="form1">
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
    <form method="post" action="/con5/update" id="form2" name="form2">
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
