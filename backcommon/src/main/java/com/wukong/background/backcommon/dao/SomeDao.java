package com.wukong.background.backcommon.dao;

import java.util.List;

import com.wukong.background.backcommon.bo.SomeDO;

public interface SomeDao {
	public int insert(SomeDO someDO);

	public int update(SomeDO someDO);

	public List<SomeDO> qry(SomeDO someDO);
}
