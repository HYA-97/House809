package com.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.HouseMapper;
import com.pojo.*;
import com.service.IhouseService;
import com.util.pageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

@Service("house")
public class HSerivce implements IhouseService {
    @Autowired
    HouseMapper Hmapper;
    @Override
    public void addHouse(House house) {
        Hmapper.insert(house);
    }

    @Override
    public PageInfo<Uhouse> selectALLById(pageBean page, Integer id) {
        PageHelper.startPage(page.getPage(),page.getRows());
        List<Uhouse> list = Hmapper.selectUhouse(id);
        PageInfo<Uhouse> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public int delHouse(String id) {
        return Hmapper.deleteByPrimaryKey(id);
    }

    @Override
    public int selectCount() {
        HouseExample h = new HouseExample();
        HouseExample.Criteria c = h.createCriteria();
        int count = (int) Hmapper.countByExample(h);
        pageBean page = new pageBean();
        int total = count%page.getRows()==0?(count/page.getRows()):(count/page.getRows()+1);
        return total;
    }

    @Override
    public Uhouse selectOne(String id) {
        return Hmapper.getHouseById(id);
    }

    @Override
    public void updateHouse(Uhouse house) {
        Hmapper.updateByPrimaryKeySelective(house);
    }

    @Override
    public int isDel(String id, int state) {
        Uhouse house = new Uhouse();
        house.setId(id);
        house.setIsdel(state);
        return Hmapper.updateByPrimaryKeySelective(house);
    }

    @Override
    public PageInfo<House> selectStr(pageBean page) {
        PageHelper.startPage(page.getPage(),page.getRows());
        List<House> list = Hmapper.selectByExample(null);
        PageInfo<House> pageInfo = new PageInfo(list);
        return pageInfo;
    }

    @Override
    public int addHouse2(House House) {
        return Hmapper.insert(House);
    }

    @Override
    public House selectStrOne(String id) {
        return Hmapper.selectByPrimaryKey(id);
    }

    @Override
    public int updateStr(Uhouse house) {
        return Hmapper.updateByPrimaryKeySelective(house);
    }

    @Override
    public int delOne(String id) {

        return Hmapper.deleteByPrimaryKey(id);
    }

    @Override
    public int delBatch(String[] ids) {
        HouseExample d = new HouseExample();
        HouseExample.Criteria c = d.createCriteria();
        c.andIdIn(Arrays.asList(ids));
        return Hmapper.deleteByExample(d);
    }

    @Override
    public PageInfo<House> selectIsPass(pageBean page, int i) {
        PageHelper.startPage(page.getPage(),page.getRows());
        HouseExample d = new HouseExample();
        HouseExample.Criteria c = d.createCriteria();
        c.andIspassEqualTo(i);
        List<House> list = Hmapper.selectByExample(d);
        PageInfo<House> pageInfo = new PageInfo(list);
        return pageInfo;
    }

    @Override
    public PageInfo<Uhouse> searchHouse(pageBean page) {
        PageHelper.startPage(page.getPage(),page.getRows());
        List<Uhouse> list = Hmapper.getHouseBySearch(page);
        return new PageInfo<>(list);
    }

}
