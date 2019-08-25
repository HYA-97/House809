package com.service;

import com.github.pagehelper.PageInfo;
import com.pojo.House;
import com.pojo.Uhouse;
import com.util.pageBean;

public interface IhouseService {
    void addHouse(House house);

    PageInfo<Uhouse> selectALLById(pageBean page, Integer id);

    int delHouse(String id);

    int selectCount();

    Uhouse selectOne(String id);

    void updateHouse(Uhouse house);

    int isDel(String id, int state);

    PageInfo<House> selectStr(pageBean page);

    int addHouse2(House House);

    House selectStrOne(String id);

    int updateStr(Uhouse house);

    int delOne(String id);

    int delBatch(String[] ids);

    PageInfo<House> selectIsPass(pageBean page, int i);

    PageInfo<Uhouse> searchHouse(pageBean page);
}
