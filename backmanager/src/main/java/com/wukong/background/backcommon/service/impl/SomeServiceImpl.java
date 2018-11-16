package com.wukong.background.backcommon.service.impl;

import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wukong.background.backcommon.bo.SomeBO;
import com.wukong.background.backcommon.bo.SomeDO;
import com.wukong.background.backcommon.dao.SomeDao;
import com.wukong.background.backcommon.service.SomeService;

@Service
public class SomeServiceImpl implements SomeService {

	@Autowired
	private SomeDao dao;
	
	@Override
	public void insert(SomeBO someBO) throws Exception {
		SomeDO someDO = new SomeDO();
		BeanUtils.copyProperties(someBO, someDO);
		int count = dao.insert(someDO);
		if(count != 1) {
			throw new Exception();
		}
	}

	@Override
	public List<SomeBO> query(SomeBO someBO) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void someUpdateAction(SomeBO someBO) {
		// TODO Auto-generated method stub

	}

}
