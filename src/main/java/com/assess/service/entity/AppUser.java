package com.assess.service.entity;

// Generated Jul 7, 2014 8:27:18 AM by Hibernate Tools 3.4.0.CR1

/**
 * AppUser generated by hbm2java
 */
public class AppUser implements java.io.Serializable {

	private Integer appUserId;
	private Integer managerId;
	private int appRoleId;
	private int designationId;
	private int customerId;
	private String name;
	private String email;
	private boolean isEmployee;
	private String userPassword;
	private Integer employeeId;
	
	private Designation m_designation;
	
	private AppUser m_manager;

	public AppUser() {
	}

	public AppUser(int appRoleId, int designationId, int customerId,
			String name, String email, boolean isEmployee, String userPassword) {
		this.appRoleId = appRoleId;
		this.designationId = designationId;
		this.customerId = customerId;
		this.name = name;
		this.email = email;
		this.isEmployee = isEmployee;
		this.userPassword = userPassword;
	}

	public AppUser(String managerEmail, int appRoleId, int designationId,
			int customerId, String name, String email, boolean isEmployee,
			String userPassword, Integer employeeId) {
		this.managerId = managerId;
		m_manager = new AppUser(managerEmail);
		this.appRoleId = appRoleId;
		this.designationId = designationId;
		this.customerId = customerId;
		this.name = name;
		this.email = email;
		this.isEmployee = isEmployee;
		this.userPassword = userPassword;
		this.employeeId = employeeId;
	}

	public AppUser(int appUserid) {
		this.appUserId = appUserid;
	}

	public AppUser(String email)
	{
		this.email = email;
	}

	public Integer getAppUserId() {
		return this.appUserId;
	}

	public void setAppUserId(Integer appUserId) {
		this.appUserId = appUserId;
	}

	public Integer getManagerId() {
		return this.managerId;
	}

	public void setManagerId(Integer managerId) {
		this.managerId = managerId;
	}

	public int getAppRoleId() {
		return this.appRoleId;
	}

	public void setAppRoleId(int appRoleId) {
		this.appRoleId = appRoleId;
	}

	public int getDesignationId() {
		return this.designationId;
	}

	public void setDesignationId(int designationId) {
		this.designationId = designationId;
	}

	public int getCustomerId() {
		return this.customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public boolean isIsEmployee() {
		return this.isEmployee;
	}

	public void setIsEmployee(boolean isEmployee) {
		this.isEmployee = isEmployee;
	}

	public String getUserPassword() {
		return this.userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	public Integer getEmployeeId() {
		return this.employeeId;
	}

	public void setEmployeeId(Integer employeeId) {
		this.employeeId = employeeId;
	}

	public void setDesignation(Designation designation) {
		m_designation = designation;
		
	}

	public Designation getDesignation() {
		return m_designation;
	}

	public AppUser getManager()
	{
		return m_manager;
	}

	public void setManager(AppUser manager)
	{
		m_manager = manager;
	}

}
