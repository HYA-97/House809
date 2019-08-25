package com.service;

import com.github.pagehelper.PageInfo;
import com.pojo.Street;
import com.util.pageBean;

import java.util.List;

public interface IStreetService {

    PageInfo<Street> selectStr(pageBean page);

    int addStreet(Street street);

    Street selectStrOne(Integer id);

    int updateStr(Street street);

    int delOne(Integer id);

    int delBatch(Integer[] ids);

    PageInfo<Street> selectBId(pageBean page, Integer did);

    List<Street> selectOnes(Integer did);
}
