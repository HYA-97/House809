package com.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.*;
import com.pojo.*;
import com.service.IHouseServise;
import com.util.pageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

@Service("district")
public class HouseService implements IHouseServise {

    @Autowired
    StreetMapper Smapper;

    @Autowired
    DistrictMapper Dmapper;

    @Override
    public PageInfo<District> selectStr(pageBean page) {
        PageHelper.startPage(page.getPage(),page.getRows());
        List<District> list = Dmapper.selectByExample(null);
        PageInfo<District> pageInfo = new PageInfo(list);
        return pageInfo;
    }

    @Override
    public int addStreet(District district) {
        return Dmapper.insert(district);
    }

    @Override
    public District selectStrOne(Integer id) {
        return Dmapper.selectByPrimaryKey(id);
    }

    @Override
    public int updateStr(District district) {
        return Dmapper.updateByPrimaryKey(district);
    }

    @Override
    public int delOne(Integer id) {

        return Dmapper.deleteByPrimaryKey(id);
    }

    @Override
    public int delStr(Integer id) {
        StreetExample s = new StreetExample();
        StreetExample.Criteria c = s.createCriteria();
        c.andDistrictIdEqualTo(id);
        return Smapper.deleteByExample(s);
    }

    @Override
    public int delBatch(Integer[] ids) {
        DistrictExample d = new DistrictExample();
        DistrictExample.Criteria c = d.createCriteria();
        c.andIdIn(Arrays.asList(ids));
        return Dmapper.deleteByExample(d);
    }

    @Override
    public List<District> selectAll() {
        return Dmapper.selectByExample(null);
    }
}
