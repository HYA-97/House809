package com.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.TypeMapper;
import com.pojo.Type;
import com.pojo.TypeExample;
import com.service.ITypeService;
import com.util.pageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;
@Service("type")
public class TypeService implements ITypeService {
    @Autowired
    TypeMapper Tmapper;
    
    @Override
    public PageInfo<Type> selectStr(pageBean page) {
        PageHelper.startPage(page.getPage(),page.getRows());
        List<Type> list = Tmapper.selectByExample(null);
        PageInfo<Type> pageInfo = new PageInfo(list);
        return pageInfo;
    }

    @Override
    public int addStreet(Type Type) {
        return Tmapper.insert(Type);
    }

    @Override
    public Type selectStrOne(Integer id) {
        return Tmapper.selectByPrimaryKey(id);
    }

    @Override
    public int updateStr(Type Type) {
        return Tmapper.updateByPrimaryKey(Type);
    }

    @Override
    public int delOne(Integer id) {
        return Tmapper.deleteByPrimaryKey(id);
    }
    
    @Override
    public int delBatch(Integer[] ids) {
        TypeExample d = new TypeExample();
        TypeExample.Criteria c = d.createCriteria();
        c.andIdIn(Arrays.asList(ids));
        return Tmapper.deleteByExample(d);
    }

    @Override
    public List<Type> selectALLs() {
        return Tmapper.selectByExample(null);
    }
}
