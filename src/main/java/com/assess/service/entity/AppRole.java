package com.assess.service.entity;

// Generated Jul 7, 2014 8:27:18 AM by Hibernate Tools 3.4.0.CR1

/**
 * AppRole generated by hbm2java
 */
public class AppRole implements java.io.Serializable {

	private Integer appRoleId;
	private String roleName;
	private String roleDescription;

	public AppRole() {
	}

	public AppRole(String roleName, String roleDescription) {
		this.roleName = roleName;
		this.roleDescription = roleDescription;
	}

	public Integer getAppRoleId() {
		return this.appRoleId;
	}

	public void setAppRoleId(Integer appRoleId) {
		this.appRoleId = appRoleId;
	}

	public String getRoleName() {
		return this.roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getRoleDescription() {
		return this.roleDescription;
	}

	public void setRoleDescription(String roleDescription) {
		this.roleDescription = roleDescription;
	}

}
