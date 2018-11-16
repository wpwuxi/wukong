package com.wukong.background.backcommon.service;

import java.util.Set;

import com.wukong.background.backcommon.bo.BackUser;

public interface BackUserService {
	Set<String> getRoles(String userName);

	Set<String> getPermissions(String userName);

	BackUser getByUserName(String userName);
}
