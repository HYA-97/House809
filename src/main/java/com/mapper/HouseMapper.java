package com.mapper;

import com.pojo.House;
import com.pojo.HouseExample;
import com.pojo.Uhouse;
import com.util.pageBean;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface HouseMapper {
    long countByExample(HouseExample example);

    int deleteByExample(HouseExample example);

    int deleteByPrimaryKey(String id);

    int insert(House record);

    int insertSelective(House record);

    List<House> selectByExample(HouseExample example);

    House selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") House record, @Param("example") HouseExample example);

    int updateByExample(@Param("record") House record, @Param("example") HouseExample example);

    int updateByPrimaryKeySelective(Uhouse house);

    int updateByPrimaryKey(House record);

    //四表联查
    List<Uhouse> selectUhouse(Integer userId);

    Uhouse getHouseById(String id);

    List<Uhouse> getHouseBySearch(pageBean page);
}