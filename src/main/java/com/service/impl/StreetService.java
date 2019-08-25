package com.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.StreetMapper;
import com.pojo.Street;
import com.pojo.StreetExample;
import com.service.IStreetService;
import com.util.pageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

@Service("street")
public class StreetService implements IStreetService {
    @Autowired
    StreetMapper Smapper;

    @Override
    public PageInfo<Street> selectStr(pageBean page) {
        PageHelper.startPage(page.getPage(),page.getRows());
        List<Street> list = Smapper.selectByExample(null);
        PageInfo<Street> pageInfo = new PageInfo(list);
        return pageInfo;
    }

    @Override
    public int addStreet(Street Street) {
        return Smapper.insert(Street);
    }

    @Override
    public Street selectStrOne(Integer id) {
        return Smapper.selectByPrimaryKey(id);
    }

    @Override
    public int updateStr(Street Street) {
        return Smapper.updateByPrimaryKey(Street);
    }

    @Override
    public int delOne(Integer id) {

        return Smapper.deleteByPrimaryKey(id);
    }

    @Override
    public int delBatch(Integer[] ids) {
        StreetExample d = new StreetExample();
        StreetExample.Criteria c = d.createCriteria();
        c.andIdIn(Arrays.asList(ids));
        return Smapper.deleteByExample(d);
    }

    @Override
    public PageInfo<Street> selectBId(pageBean page, Integer did) {
        PageHelper.startPage(page.getPage(),page.getRows());
        StreetExample s = new StreetExample();
        StreetExample.Criteria c = s.createCriteria();
        c.andDistrictIdEqualTo(did);
        List<Street> list = Smapper.selectByExample(s);
        PageInfo<Street> pageInfo = new PageInfo(list);
        return pageInfo;
    }

    @Override
    public List<Street> selectOnes(Integer did) {
        StreetExample s = new StreetExample();
        StreetExample.Criteria c = s.createCriteria();
        c.andDistrictIdEqualTo(did);
        List<Street> list = Smapper.selectByExample(s);
        return list;
    }
}
