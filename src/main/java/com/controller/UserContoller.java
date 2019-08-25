package com.controller;

import com.github.pagehelper.PageInfo;
import com.pojo.Users;
import com.service.impl.UsersService;
import com.util.pageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/con")
public class UserContoller {
    @Autowired
    @Qualifier("users")
    UsersService service;

    @RequestMapping("/uName")
    @ResponseBody
    public int selectName(String name){
        int i = service.uName(name);
        return i;
    }

    @RequestMapping("/login")
    public String login(HttpSession session, Users user, HttpServletRequest req, HttpServletResponse resp){
        Users users = service.login(user);
        String str = "";
        if(users==null){
             str="login";
             session.setAttribute("user",user);
             session.setAttribute("msg","用户名密码匹配，请重新输入！");
        }else if(users.getIsadmin()==1) {
          str="redirect:../admin/admin.jsp";
        }else {
            str="redirect:/con5/PageSearch";
            session.setAttribute("users",users);
        }
        return str;
    }

    @RequestMapping("/toLog")
    public String toLog(){
        return "";
    }

    @RequestMapping("/selectAll")
    @ResponseBody
    public Map<String,Object> selectAll(pageBean page){
        PageInfo<Users> str = service.selectStr(page);
        Map<String,Object> map = new HashMap<>();
        map.put("rows",str.getList());
        map.put("total",str.getTotal());
        return map;
    }


    @RequestMapping("/addUsers")
    @ResponseBody
    public ModelAndView addStreet(ModelAndView mav,Users Users){
        int i = service.addStreet(Users);
        if(i==1){
            mav.setViewName("login");
        }else {
            mav.addObject("msg","注册失败，请重新注册！");
            mav.setViewName("add");
        }
        return mav;
    }

    @RequestMapping("/getOneUsers")
    @ResponseBody
    public Users selectOne(Integer id){
        Users Users = service.selectStrOne(id);
        return Users;
    }

    @RequestMapping("/update")
    @ResponseBody
    public int update(Users Users){
        int i = service.updateStr(Users);
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
