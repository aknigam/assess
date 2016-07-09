package com.assess.service.domain.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.assess.service.dao.IAppUserDAO;
import com.assess.service.domain.IAppUserService;
import com.assess.service.entity.AppUser;
import com.assess.service.exception.UserNotFoundException;

@Component
public class AppUserService implements IAppUserService {

	@Autowired
	IAppUserDAO m_appUserDAO;
	
	@Override
	@Transactional
	public void addUsers(List<AppUser> appUsers) {

		m_appUserDAO.addAppUsers(appUsers);
	}

	@Override
	@Transactional
	public AppUser getUserByEmail(String userEmail) throws UserNotFoundException {
		return m_appUserDAO.getUserByEmail(userEmail);
	}

}
