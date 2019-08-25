package com.controller;

import com.github.pagehelper.PageInfo;
import com.pojo.Type;
import com.service.impl.TypeService;
import com.util.pageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
@Controller
@RequestMapping("/con3")
public class TypeContreller {
    @Autowired
    @Qualifier("type")
    private TypeService service;

    @RequestMapping("/selectAll")
    @ResponseBody
    public Map<String,Object> selectAll(pageBean page){
        PageInfo<Type> str = service.selectStr(page);
        Map<String,Object> map = new HashMap<>();
        map.put("rows",str.getList());
        map.put("total",str.getTotal());
        return map;
    }

    @RequestMapping("/selectAlls")
    @ResponseBody
    public List<Type> selectAll(){
        List<Type> list = service.selectALLs();
        return list;
    }

    @RequestMapping("/addType")
    @ResponseBody
    public int addStreet(Type type){
        int i = service.addStreet(type);
        return i;
    }

    @RequestMapping("/getOneType")
    @ResponseBody
    public Type selectOne(Integer id){
        Type type = service.selectStrOne(id);
        return type;
    }

    @RequestMapping("/update")
    @ResponseBody
    public int update(Type type){
        int i = service.updateStr(type);
        return i;
    }

    @RequestMapping("/delOne")
    @ResponseBody
    @Transactional
    public int delOne(Integer id){
        int i = service.delOne(id);
        return i;
    }

    @RequestMapping("/delBatch")
    @ResponseBody
    public int delBatch(Integer[] ids){
        int i = service.delBatch(ids);
//        int s = service.delStr(id);
        return i;
    }
}
