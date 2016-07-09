package com.assess.service.dao;

import java.util.List;
import java.util.Map;

import com.assess.service.entity.AppUser;
import com.assess.service.exception.UserNotFoundException;

public interface IAppUserDAO
{

	void addAppUsers(List<AppUser> appUsers);

	AppUser getUserByEmail(String userEmail) throws UserNotFoundException;

	void updateHierarchy(Map<String, String> userManagers);

}
