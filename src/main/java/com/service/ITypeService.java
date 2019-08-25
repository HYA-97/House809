package com.service;

import com.github.pagehelper.PageInfo;
import com.pojo.Type;
import com.util.pageBean;

import java.util.List;

public interface ITypeService {
    PageInfo<Type> selectStr(pageBean page);

    int addStreet(Type type);

    Type selectStrOne(Integer id);

    int updateStr(Type type);

    int delOne(Integer id);
    
    int delBatch(Integer[] ids);

    List<Type> selectALLs();
}
