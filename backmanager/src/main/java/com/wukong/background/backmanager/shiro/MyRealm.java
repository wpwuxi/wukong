package com.wukong.background.backmanager.shiro;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import com.wukong.background.backcommon.bo.BackUser;
import com.wukong.background.backcommon.service.BackUserService;

public class MyRealm extends AuthorizingRealm {

	@Autowired
	private BackUserService userService;

	/**
	 * 为登录用户授予权限和角色
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		String userName = (String) principals.getPrimaryPrincipal();
		SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
		authorizationInfo.setRoles(userService.getRoles(userName));
		authorizationInfo.setStringPermissions(userService.getPermissions(userName));
		return authorizationInfo;
	}

	/**
	 * 验证当前登录用户
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		String userName = (String) token.getPrincipal();
		BackUser user = userService.getByUserName(userName);

		// 使用md5加密
		// 当前realm对象的name
		String realmName = getName();
		// 盐值
		ByteSource credenttialsSalt = ByteSource.Util.bytes("hehe");
		// 封装用户信息，构建AuthenticationInfo对象并返回
		AuthenticationInfo authcInfo = new SimpleAuthenticationInfo(user.getUsername(), user.getPassword(), credenttialsSalt, realmName);
		return authcInfo;
		// 使用md5加密

		// 不加密
		/*
		 * if (user != null) { AuthenticationInfo authcInfo = new
		 * SimpleAuthenticationInfo(user.getUserName(), user.getPassword(),
		 * "xx"); return authcInfo; } else { return null; }
		 */
		// 不加密
	}
	
	public static void main(String[] args) {
		//md5
		String hashAlgorithName = "MD5";
        String password = "WuxI2018";
        int hashIterations = 1024;
        ByteSource credentialsSalt = ByteSource.Util.bytes("hehe");
        Object obj = new SimpleHash(hashAlgorithName, password, credentialsSalt, hashIterations);
        System.out.println(obj);
		
	}
}