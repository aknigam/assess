package com.assess.service.entity;

// Generated Jul 7, 2014 8:27:18 AM by Hibernate Tools 3.4.0.CR1

/**
 * AppRoleAuth generated by hbm2java
 */
public class AppRoleAuth implements java.io.Serializable {

	private Integer appRoleAuthId;
	private int appAuthId;
	private int appRoleId;

	public AppRoleAuth() {
	}

	public AppRoleAuth(int appAuthId, int appRoleId) {
		this.appAuthId = appAuthId;
		this.appRoleId = appRoleId;
	}

	public Integer getAppRoleAuthId() {
		return this.appRoleAuthId;
	}

	public void setAppRoleAuthId(Integer appRoleAuthId) {
		this.appRoleAuthId = appRoleAuthId;
	}

	public int getAppAuthId() {
		return this.appAuthId;
	}

	public void setAppAuthId(int appAuthId) {
		this.appAuthId = appAuthId;
	}

	public int getAppRoleId() {
		return this.appRoleId;
	}

	public void setAppRoleId(int appRoleId) {
		this.appRoleId = appRoleId;
	}

}
