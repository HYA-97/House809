package com.controller;

import com.sms.SmsUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/sms")
public class sms {
    @RequestMapping("/loginSms")
    @ResponseBody
    public Map<String,Object> sendCode(String tel, HttpSession session){
        //发送消息
        //产生四位的随机数  0.1234567
        String str=Math.random()+"";
        String code=str.substring(2,6);
        //定义发送消息的内容
        String msg="登入的验证码是:"+code;

        //为了后期获取验证码进行比对，所有将随机数存放到session里
        session.setAttribute("code",code);
        session.setMaxInactiveInterval(60);  //1分钟

        int temp= SmsUtil.sendMsg(tel,msg);  //发送消息

        Map<String,Object> map=new HashMap<String,Object>();
        map.put("result",temp);
        return map;
    }
}
