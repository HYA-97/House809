package com.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.UsersMapper;
import com.pojo.*;
import com.service.IUsersService;
import com.util.MD5Utils;
import com.util.pageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;
@Service("users")
public class UsersService implements IUsersService {
    @Autowired
    UsersMapper Umapper;

    @Override
    public int uName(String name) {
        UsersExample u = new UsersExample();
        UsersExample.Criteria c = u.createCriteria();
        c.andNameEqualTo(name);
        List<Users> list = Umapper.selectByExample(u);
        return list.size()==0?0:1;
    }

    @Override
    public Users login(Users user) {
        UsersExample u = new UsersExample();
        UsersExample.Criteria c = u.createCriteria();
        c.andNameEqualTo(user.getName());
        c.andPasswordEqualTo(MD5Utils.md5Encrypt(user.getPassword()));
        List<Users> us = Umapper.selectByExample(u);
        if(us.size()==0){
            return null;
        }else {
            return us.get(0);
        }

    }

    @Override
    public PageInfo<Users> selectStr(pageBean page) {
        PageHelper.startPage(page.getPage(),page.getRows());
        List<Users> list = Umapper.selectByExample(null);
        PageInfo<Users> pageInfo = new PageInfo(list);
        return pageInfo;
    }

    @Override
    public int addStreet(Users users) {
        users.setPassword(MD5Utils.md5Encrypt(users.getPassword()));
        users.setIsadmin(new Integer("0"));
        return Umapper.insert(users);
    }

    @Override
    public Users selectStrOne(Integer id) {
        return Umapper.selectByPrimaryKey(id);
    }

    @Override
    public int updateStr(Users users) {
        return Umapper.updateByPrimaryKey(users);
    }

    @Override
    public int delOne(Integer id) {

        return Umapper.deleteByPrimaryKey(id);
    }

    @Override
    public int delBatch(Integer[] ids) {
        UsersExample d = new UsersExample();
        UsersExample.Criteria c = d.createCriteria();
        c.andIdIn(Arrays.asList(ids));
        return Umapper.deleteByExample(d);
    }

    @Override
    public Users tel(String telephone) {
        UsersExample d = new UsersExample();
        UsersExample.Criteria c = d.createCriteria();
        c.andTelephoneEqualTo(telephone);
        List<Users> list = Umapper.selectByExample(d);
        if(list.size()==0){
            return null;
        }else {
            return list.get(0);
        }
    }
}
