$(function(){
    //使用datagrid绑定数据库
    var SelectRows = $("#dg").datagrid('getSelections');
    var did = SelectRows[0].id;
    $('#ds').datagrid({
        url:'/con2/selectStreet?did='+did,
        title:"街道信息",
        toolbar:"#Tools",  //指定工具栏
        pagination:true,
        pageList:[3,6,9,15,20],
        pageSize:3,
        //singleSelect:true,
        columns:[[
            {field:"cb",checkbox:true},
            {field:'id',title:'编号',width:100},
            {field:'name',title:'街道名称',width:100},
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
function addsDialog(){
    //alert("我要添加区域");
    $('#AddsDialog').window('setTitle',"添加区域");
    $('#AddsDialog').window('open');
}
//关闭对话框
function CloseAddsDialog(id){
    $('#'+id).window('close'); //关闭
}

function updatesDialog(){
    var SelectRows = $("#dg").datagrid('getSelections');  //返回数组
    if(SelectRows.length==1){
        $('#updatesDialog').window('setTitle',"编辑区域");
        $('#updatesDialog').window('open');
        $.post("/con2/getOneDistrict",{"id":SelectRows[0].id},function(data){
            $("#form2").form('load',data); //将对象还原表单
        },"json");
    }else{
        $.messager.alert('>>提示','你没有选择行或者选择多行，给我小心点!','warn');  //提示框
    }
}


function SavesDistrict(){

    $('#form1').form('submit',{
        url:"/con2/addStreet",
        success:function(data){  //data表示的字符串
            if(data==1){
                $.messager.alert('>>提示','添加成功！','info');  //提示框
                $('#AddsDialog').window('close'); //关闭
            }else{
                $.messager.alert('>>提示','添加失败！','error');
                $('#AddsDialog').window('close'); //关闭
            }
        }
    });
}

function UpdatesDistrict(){
    $('#form2').form('submit',{
        url:"/con2/update",
        success:function(i){  //data表示的字符串
            if(i==1){
                $.messager.alert('>>提示','修改成功！','info');  //提示框
                $('#updatesDialog').window('close'); //关闭
            }else{
                $.messager.alert('>>提示','修改失败！','error');
                $('#updatesDialog').window('close'); //关闭
            }
        }
    });
}
function delsOne() {
    var SelectRows = $("#dg").datagrid('getSelections');
    var id = SelectRows[0].id;
    $.post("/con2/delOne",{"id":id},function (i) {
        if(i==1){
            $('#ds').datagrid("reload");
            $.messager.alert('>>提示','成功删除'+id,'info');  //提示框
        }else {
            $.messager.alert('>>提示',id+'删除失败！','info');  //提示框
        }
    })

}

function delsBatch() {
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
            $.post("/con2/delBatch", {"ids":ids.toString()}, function (i) {
                if (i == SelectRows.length) {
                    $('#ds').datagrid("reload");
                    $.messager.alert('>>提示', '成功删除'+i+"条数据！", 'info');  //提示框
                } else {
                    $.messager.alert('>>提示', '删除失败！', 'info');  //提示框
                }
            });
        }


    }
}
