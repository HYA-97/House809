package com.service;

import com.github.pagehelper.PageInfo;
import com.pojo.District;
import com.util.pageBean;

import java.util.List;

public interface IHouseServise {

    PageInfo<District> selectStr(pageBean page);

    int addStreet(District district);

    District selectStrOne(Integer id);

    int updateStr(District district);

    int delOne(Integer id);

    int delStr(Integer id);

    int delBatch(Integer[] ids);

    List<District> selectAll();
}
