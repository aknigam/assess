package com.assess.service.domain;

import java.util.List;

import com.assess.service.entity.AppUser;
import com.assess.service.exception.UserNotFoundException;

public interface IAppUserService {

	void addUsers(List<AppUser> appUsers);

	AppUser getUserByEmail(String revieweeEmail) throws UserNotFoundException;

}
