package com.wukong.background.backcommon.service.impl;

import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wukong.background.backcommon.bo.BackUser;
import com.wukong.background.backcommon.dao.BackUserDao;
import com.wukong.background.backcommon.service.BackUserService;


@Service
public class BackUserServiceImpl implements BackUserService {

	@Autowired
	private BackUserDao backUserDao;
	
	@Override
	public Set<String> getRoles(String userName) {
		return backUserDao.getRoles(userName);
	}

	@Override
	public Set<String> getPermissions(String userName) {
		return backUserDao.getPermissions(userName);
	}

	@Override
	public BackUser getByUserName(String userName) {
		return backUserDao.getByUserName(userName);
	}

}
