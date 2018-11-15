package com.wukong.background.backcommon.service;

import java.util.Set;

import com.jisu.crawler.entity.loan.BackUser;

public interface BackUserService {
	Set<String> getRoles(String userName);

	Set<String> getPermissions(String userName);

	BackUser getByUserName(String userName);
}
