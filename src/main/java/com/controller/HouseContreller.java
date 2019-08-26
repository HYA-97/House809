package com.controller;

import com.github.pagehelper.PageInfo;
import com.pojo.House;
import com.pojo.Uhouse;
import com.pojo.Users;
import com.service.impl.HSerivce;
import com.util.pageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/con5")
public class HouseContreller {
     @Autowired
     @Qualifier("house")
     HSerivce serivce;
    @RequestMapping("/addHouse")
    public String addHouse(House house, @RequestParam(value="pfile",required = false) CommonsMultipartFile pfile, Model model){
        int total = serivce.selectCount();
        try {
            //第一步上传图片
            String path="E:\\Program Files (x86)\\nginx-1.14.2\\images/";  //存放文件的位置
            //生成唯一文件名
            String oldName=pfile.getOriginalFilename();
            String expname=oldName.substring(oldName.lastIndexOf("."));
            String filename=System.currentTimeMillis()+expname;
            File file=new File(path+filename);
            pfile.transferTo(file);  //上传，保存
            //第二步保存信息到数据库
            //设置主键
            house.setId(System.currentTimeMillis()+"");
            house.setIsdel(new Integer("0"));
            house.setIspass(new Integer("0"));
            //设置图片
            house.setPath(filename);
            serivce.addHouse(house);
            return "redirect:/con5/Uhouse?page="+total;  //跳转到管理页
        }catch (Exception e){
            e.printStackTrace();
            model.addAttribute("info","上传文件失败..");
        }
        return "redirect:con5/Uhouse?page="+total;
    }


    @RequestMapping("/Uhouse")
    public String selectUhosue(pageBean page, HttpSession session){
        Users us = (Users)session.getAttribute("users");
        PageInfo<Uhouse> pageInfo = serivce.selectALLById(page,us.getId());
        session.setAttribute("pageInfo",pageInfo);
        return "guanli";
    }

    @RequestMapping("/houseOne")
    public ModelAndView houseOne(HttpSession session,ModelAndView mav, Uhouse uh,pageBean page){
        Users us = (Users)session.getAttribute("users");
        PageInfo<Uhouse> pageInfo = serivce.selectALLById(page,us.getId());
        List<Uhouse> list = pageInfo.getList();
        mav.addObject("list",list);
        mav.addObject("house",uh);
        mav.setViewName("details");
        return mav;
    }

    @RequestMapping("/delhouse")
    public String delHouse(String id){
        int i = serivce.delHouse(id);
        return "redirect:/con5/Uhouse";
    }

    @RequestMapping("/Onehouse")
    public ModelAndView Onehouse(ModelAndView mav,String id){
        Uhouse house = serivce.selectOne(id);
        mav.addObject("h",house);
        mav.setViewName("updateHouse");
        return mav;
    }

    @RequestMapping("/updateHouse")
    public String updateHouse(String delimage,Uhouse house,@RequestParam("pfile") CommonsMultipartFile pfile){  //page只为接收页码
        try {
            //判断用户是否选择文件
            String oldName=pfile.getOriginalFilename();
            if(oldName.equals(""))  //没有选择文件
            {
                serivce.updateHouse(house);
            }else
            {
                //上传
                //第一步上传图片
                String path="E:\\Program Files (x86)\\nginx-1.14.2\\images/";  //存放文件的位置
                //生成唯一文件名
                String expname=oldName.substring(oldName.lastIndexOf("."));
                String filename=System.currentTimeMillis()+expname;
                File file=new File(path+filename);
                pfile.transferTo(file);  //上传，保存
                //更新数据库
                //设置更新图片路径
                house.setPath(filename);
                serivce.updateHouse(house);
                //删除旧图
                File delfile=new File(path+delimage);
                delfile.delete();
            }
            return "redirect:/con5/Uhouse";
        }catch (Exception e){
            e.printStackTrace();
        }
        return "error";
    }

    @RequestMapping("/isDel")
    public String isDel(String id){
        int i = serivce.isDel(id,1);
        return "redirect:/con5/Uhouse";
    }

    @RequestMapping("/selectAll")
    @ResponseBody
    public Map<String,Object> selectAll(pageBean page){
        PageInfo<House> str = serivce.selectStr(page);
        Map<String,Object> map = new HashMap<>();
        map.put("rows",str.getList());
        map.put("total",str.getTotal());
        return map;
    }

    @RequestMapping("/selectIsPass")
    @ResponseBody
    public Map<String,Object> selectIsPass(pageBean page){
        PageInfo<House> str = serivce.selectIsPass(page,0);
        Map<String,Object> map = new HashMap<>();
        map.put("rows",str.getList());
        map.put("total",str.getTotal());
        return map;
    }

    @RequestMapping("/selectPass")
    @ResponseBody
    public Map<String,Object> selectPass(pageBean page){
        PageInfo<House> str = serivce.selectIsPass(page,1);
        Map<String,Object> map = new HashMap<>();
        map.put("rows",str.getList());
        map.put("total",str.getTotal());
        return map;
    }


    @RequestMapping("/addHouse2")
    @ResponseBody
    public int addHouse2(House House){
        int i = serivce.addHouse2(House);
        return i;
    }

    @RequestMapping("/getOneHouse")
    @ResponseBody
    public House selectOne(String id){
        House House = serivce.selectStrOne(id);
        return House;
    }



    @RequestMapping("/update")
    @ResponseBody
    public int update(Uhouse house){
        int i = serivce.updateStr(house);
        return i;
    }

    @RequestMapping("/delOne")
    @ResponseBody
    public int delOne(String id){
        int i = serivce.delOne(id);
        return i;
    }

    @RequestMapping("/delBatch")
    @ResponseBody
    public int delBatch(String[] ids){
        int i = serivce.delBatch(ids);
//        int s = service.delStr(id);
        return i;
    }



    @RequestMapping("/PageSearch")
    public ModelAndView searchHouse(ModelAndView mav,pageBean page,HttpSession session){
        PageInfo<Uhouse> pageInfo = serivce.searchHouse(page);
        mav.addObject("page",page);
        mav.addObject("pageInfo",pageInfo);
        mav.setViewName("list");
        return mav;
    }
}
