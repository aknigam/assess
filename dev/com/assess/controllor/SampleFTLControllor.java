package com.assess.controllor;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.assess.controllor.model.SampleDataList;

@Controller
@RequestMapping("/sample/ftl")
public class SampleFTLControllor {

	
	@RequestMapping(method = RequestMethod.GET)
	public String getUsers(Model model)
	{
		model.addAttribute("username", "Anand Kumar Nigam");
		return "sample";
	}
	
	@RequestMapping(value = "/email",method = RequestMethod.GET)
	public String getUserEmail(Model model)
	{
		model.addAttribute("username", new SampleDataList.SampleData("a", "b"));
		return "sample-email";
	}
	
	@RequestMapping(value = "/list",method = RequestMethod.GET)
	public ModelAndView getUserEmailList()
	{
		
		SampleDataList list = new SampleDataList();
		
		
		List<SampleDataList.SampleData> data = new ArrayList<SampleDataList.SampleData>();
		data.add(new SampleDataList.SampleData("a","e1"));
		data.add(new SampleDataList.SampleData("b","e2"));
		
		list.setData(data);
		
		ModelMap model = new ModelMap("joblist", list);
		  
		return new ModelAndView("sample-list", model);
//		List<String> list = new ArrayList<String>();
//		list.add("anand");
//		list.add("priya");
//		model.addAttribute("samples", list);
//		model.addAttribute("username", "Anand Kumar Nigam");
//		return "sample";
	}
	
	
	
}
