package com.wukong.background.backcommon.bo;

import org.apache.commons.lang3.builder.ToStringBuilder;

public class CommonObject {
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
	}
}
