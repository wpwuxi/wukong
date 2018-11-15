package com.wukong.background.backcommon.service;

import java.util.List;

import com.wukong.background.backcommon.bo.SomeBO;

public interface SomeService {
	void insert(SomeBO someBO) throws Exception;

	List<SomeBO> query(SomeBO someBO);
	
	void someUpdateAction(SomeBO someBO);
}
