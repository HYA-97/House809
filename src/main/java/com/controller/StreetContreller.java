package com.controller;

import com.github.pagehelper.PageInfo;
import com.pojo.Street;
import com.service.impl.StreetService;
import com.util.pageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
@Controller
@RequestMapping("/con2")
public class StreetContreller {
    @Autowired
    @Qualifier("street")
    private StreetService service;

    @RequestMapping("/selectAll")
    @ResponseBody
    public Map<String,Object> selectAll(pageBean page){
        PageInfo<Street> str = service.selectStr(page);
        Map<String,Object> map = new HashMap<>();
        map.put("rows",str.getList());
        map.put("total",str.getTotal());
        return map;
    }

    @RequestMapping("/selectStreet")
    @ResponseBody
    public Map<String,Object> selectStreet(pageBean page,Integer did){
        PageInfo<Street> str = service.selectBId(page,did);
        Map<String,Object> map = new HashMap<>();
        map.put("rows",str.getList());
        map.put("total",str.getTotal());
        return map;
    }


    @RequestMapping("/addStreet")
    @ResponseBody
    public int addStreet(Street street){
        int i = service.addStreet(street);
        return i;
    }

    @RequestMapping("/getOneStreet")
    @ResponseBody
    public Street selectOne(Integer id){
        Street street = service.selectStrOne(id);
        return street;
    }

    @RequestMapping("/getOneStreets")
    @ResponseBody
    public List<Street> selectOnes(Integer did){
        List<Street> list = service.selectOnes(did);
        return list;
    }

    @RequestMapping("/update")
    @ResponseBody
    public int update(Street street){
        int i = service.updateStr(street);
        return i;
    }

    @RequestMapping("/delOne")
    @ResponseBody
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
