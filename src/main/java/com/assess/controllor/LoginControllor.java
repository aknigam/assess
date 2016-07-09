package com.assess.controllor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.assess.controllor.model.HomePageModel;
import com.assess.service.domain.IAppUserService;
import com.assess.service.entity.AppUser;
import com.assess.service.exception.UserNotFoundException;


@Controller
@RequestMapping("/auth")
public class LoginControllor {

	@Autowired
	private IAppUserService m_appUserService; 
	
	
	@RequestMapping(value="/login",method = RequestMethod.POST)
	public ModelAndView loginGet(String username, HttpServletRequest request)
	{
		
		HttpSession session = request.getSession(true);
		AppUser appUser = null;
		if(session.getAttribute("userId")!= null)
		{
			appUser =  (AppUser) session.getAttribute("userId");
		}
		else
		{
		
			try
			{
				appUser = m_appUserService.getUserByEmail(username);
				session.setAttribute("userId", appUser);
			}
			catch (UserNotFoundException e)
			{
				System.out.println(e.getMessage());
				return new ModelAndView("login");
			}
			
		
		}
		HomePageModel hpm = new HomePageModel();
		
		hpm.setUsername(appUser.getName());
		hpm.setUserId(appUser.getAppUserId());
		hpm.setAppRoleId(appUser.getAppRoleId());
		
		ModelMap model = new ModelMap("userinfo", hpm);
		  
		// myreviews.ftl will be resolved
		return new ModelAndView("home", model);
	}
	
	@RequestMapping(value="/logout",method = RequestMethod.GET)
	public @ResponseBody ModelAndView logout( HttpServletRequest request)
	{
		
		HttpSession session = request.getSession(true);
		
		if(session.getAttribute("userId")!= null)
		{
			session.invalidate();
		}
		
		return new ModelAndView("login");
	}
	
	@RequestMapping(value="/ping",method = RequestMethod.GET)
	public @ResponseBody String ping(String ping, HttpServletRequest request)
	{
		
		HttpSession session = request.getSession();
		
		
		if(session.getAttribute("userId")!= null)
			return "TRUE"+ session.getAttribute("userId");
		else 
			return "FALSE";
		
	}
	
	/*
	
	@RequestMapping(value="/login",method = RequestMethod.GET)
	public void login(LoginForm form, HttpServletRequest request)
	{
		
		String username = form.getUsername();
//		String password = form.getPassword();
		
		AppUser appUser = m_appUserService.getUserByEmail(username);
		HttpSession session = request.getSession(true);
		
		session.setAttribute("userId", appUser.getAppUserId());
	}
	
	*/
	
}
