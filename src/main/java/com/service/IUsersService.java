package com.service;

import com.github.pagehelper.PageInfo;
import com.pojo.Users;
import com.util.pageBean;

import java.util.List;

public interface IUsersService {
    int uName(String name);

    Users login(Users user);

    PageInfo<Users> selectStr(pageBean page);

    int addStreet(Users users);

    Users selectStrOne(Integer id);

    int updateStr(Users users);

    int delOne(Integer id);

    int delBatch(Integer[] ids);

    Users tel(String telephone);
}
