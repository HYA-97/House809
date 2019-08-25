package com.controller;

import com.github.pagehelper.PageInfo;
import com.pojo.District;
import com.service.impl.HouseService;
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
@RequestMapping("/con1")
public class DistrictContreller {
    @Autowired
    @Qualifier("district")
    private HouseService service;

    @RequestMapping("/selectAll")
    @ResponseBody
    public Map<String,Object> selectAll(pageBean page){
        PageInfo<District> str = service.selectStr(page);
        Map<String,Object> map = new HashMap<>();
        map.put("rows",str.getList());
        map.put("total",str.getTotal());
        return map;
    }

    @RequestMapping("/selectAlls")
    @ResponseBody
    public List<District> selectAll(){
        List<District> list =service.selectAll();
        return list;
    }

    @RequestMapping("/addDistrict")
    @ResponseBody
    public int addStreet(District district){
        int i = service.addStreet(district);
        return i;
    }

    @RequestMapping("/getOneDistrict")
    @ResponseBody
    public District selectOne(Integer id){
        District district = service.selectStrOne(id);
        return district;
    }

    @RequestMapping("/update")
    @ResponseBody
    public int update(District district){
       int i = service.updateStr(district);
        return i;
    }

    @RequestMapping("/delOne")
    @ResponseBody
    @Transactional
    public int delOne(Integer id){
        int i = service.delOne(id);
        int s = service.delStr(id);
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
