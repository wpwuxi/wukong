package com.wukong.background.backcommon.dao;

import java.util.Set;

import com.wukong.background.backcommon.bo.BackUser;

public interface BackUserDao {
    
    /**
     * 根据用户名查询用户
     * @param userName
     * @return
     */
    public BackUser getByUserName(String userName);
    
    /**
     * 根据用户名查询角色
     * @param userName
     * @return
     */
    public Set<String> getRoles(String userName);
    
    /**
     * 根据用户名查询权限
     * @param userName
     * @return
     */
    public Set<String> getPermissions(String userName);

}