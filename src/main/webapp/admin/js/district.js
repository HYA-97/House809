$(function(){
    //使用datagrid绑定数据库
    $('#dg').datagrid({
        url:'/con1/selectAll',
        title:"区域信息",
        toolbar:"#ToolBar",  //指定工具栏
        pagination:true,
        pageList:[3,6,9,15,20],
        pageSize:3,
        //singleSelect:true,
        columns:[[
            {field:"cb",checkbox:true},
            {field:'id',title:'编号',width:100},
            {field:'name',title:'区域名称',width:100},
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
            {field:'str',title:'街道',width:100,
                formatter: function(value,row,index){
                    var str="<a href='javascript:street2()'>查看街道</a>"
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

//点击添加，打开窗口
function street2(){
    //alert("我要添加区域");
    $('#streets').window('setTitle',"查看街道");
    $('#streets').window('open');
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
        $.post("/con1/getOneDistrict",{"id":SelectRows[0].id},function(data){
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
        url:"/con1/addDistrict",
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
        url:"/con1/update",
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
    $.post("/con1/delOne",{"id":id},function (i) {
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
            $.post("/con1/delBatch", {"ids":ids.toString()}, function (i) {
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