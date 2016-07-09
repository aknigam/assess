package com.assess.controllor;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.assess.controllor.csv.AssessmentAreaHierarchyUploadCsvhandler;
import com.assess.controllor.csv.AssessmentAreaUploadCsvhandler;
import com.assess.controllor.csv.BaseCsvResponseBuilder;
import com.assess.controllor.csv.CustomerUploadCsvhandler;
import com.assess.controllor.csv.DesignationUploadCsvhandler;
import com.assess.controllor.csv.FeedbackReviewerUploadCsvhandler;
import com.assess.controllor.csv.OrgHierarchyUploadCsvhandler;
import com.assess.controllor.csv.QuestionUploadCsvhandler;
import com.assess.controllor.csv.RatingScaleUploadCsvhandler;
import com.assess.controllor.csv.UploadEntityEnum;
import com.assess.controllor.csv.UploadWSUtil;
import com.assess.controllor.csv.UserUploadCsvhandler;
import com.assess.controllor.csv.row.BaseCsvRow;
import com.assess.form.CustomerForm;
import com.assess.service.domain.ICustomerService;




/**
 * 
 * Steps of configuration:
 * 
 * 1. Add customer
 * 2. Add Designations
 * 3. Add assessment areas and sub assessment areas.
 * 3. Add Questions
 * 4. Add users
 * 5. Add org hierarchy
 * 
 * @author anigam
 *
 */
@Controller("com.assess.ConfigureByUploadControllor")
@RequestMapping("/UserFeedback")
public class ConfigureByUploadControllor
{
	@Autowired
	private UploadWSUtil uploadWSUtil;
	
	@Autowired
	private ICustomerService m_customerService;
	


    @RequestMapping(value = "/configure", method = RequestMethod.GET)
    public ModelAndView configure()
    {
    	ModelMap model = new ModelMap("step", 1);
		return new ModelAndView("assess-configure", model);
    }
    
    @RequestMapping(value = "/customer", method = RequestMethod.POST)
    public ModelAndView addOrUpdateCustomer(CustomerForm form)
    {
    	
    	m_customerService.addCustomer(form);
    	ModelMap model = new ModelMap("step", 2);
		return new ModelAndView("assess-configure", model);
    }
    
	

    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    public void batchUploadFromFile(@RequestParam("file")
    MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws Exception
    {
    	ModelMap model = null;
        if (file.isEmpty())
        {
        	model = new ModelMap();
//    		return new ModelAndView("assess-configure", model);
        }

        String operation = request.getParameter("uploadFileRadio");

        if (operation.equalsIgnoreCase("customerUpload"))
        {
        	uploadCustomersFromFlatFile(file, response);
        }
        if (operation.equalsIgnoreCase("designationsUpload"))
        {
        	uploadDesignationsFromFlatFile(file, response);
        }
        if (operation.equalsIgnoreCase("assessmentareaUpload"))
        {
        	uploadAssessmentAreaFromFlatFile(file, response);
        }
        if (operation.equalsIgnoreCase("assessmentareaHierarchyUpload"))
        {
        	uploadAssessmentAreaHierarchyFromFlatFile(file, response);
        }
        if (operation.equalsIgnoreCase("questionsUpload"))
        {
        	uploadQuestionsFromFlatFile(file, response);
        	model = new ModelMap("step", 2);
        }
        if(operation.equalsIgnoreCase("usersUpload"))
        {
        	uploadUsersFromFlatFile(file, response);
        }
        if(operation.equalsIgnoreCase("orghierarchyUpload"))
        {
        	uploadOrgHierarchyFromFlatFile(file, response);
        }
        if (operation.equalsIgnoreCase("reviewersUpload"))
        {
        	uploadReviewersFromFlatFile(file, response);
        }
        if (operation.equalsIgnoreCase("ratingsUpload"))
        {
        	uploadRatingsFromFlatFile(file, response);
        }
        
    }
    
    private void uploadRatingsFromFlatFile(MultipartFile file,
			HttpServletResponse response) throws Exception {





    	if (file.isEmpty())
    	{
    		return;
    	}

    	List<String> additionalResponseHeaders = new ArrayList<String>();

    	BaseCsvResponseBuilder<BaseCsvRow> builder = new RatingScaleUploadCsvhandler(
    			additionalResponseHeaders);

    	uploadWSUtil.processCSVRow( builder, file,response, UploadEntityEnum.RATING_SCALE);


    		
			
	
			
	}

	private void uploadAssessmentAreaHierarchyFromFlatFile(MultipartFile file,
			HttpServletResponse response) throws Exception {




    	if (file.isEmpty())
    	{
    		return;
    	}

    	List<String> additionalResponseHeaders = new ArrayList<String>();

    	BaseCsvResponseBuilder<BaseCsvRow> builder = new AssessmentAreaHierarchyUploadCsvhandler(
    			additionalResponseHeaders);

    	uploadWSUtil.processCSVRow( builder, file,response, UploadEntityEnum.ASSESSMENT_AREA_HIERARCHY);


    		
			
	
	}

	private void uploadAssessmentAreaFromFlatFile(MultipartFile file,
			HttpServletResponse response) throws Exception {


    	if (file.isEmpty())
    	{
    		return;
    	}

    	List<String> additionalResponseHeaders = new ArrayList<String>();
    	//	additionalResponseHeaders.add("Transaction ID");
    	//	additionalResponseHeaders.add("Upload status");

    	BaseCsvResponseBuilder<BaseCsvRow> builder = new AssessmentAreaUploadCsvhandler(
    			additionalResponseHeaders);

    	uploadWSUtil.processCSVRow( builder, file,response, UploadEntityEnum.ASSESSMENT_AREA);


    		
			
	}

	private void uploadCustomersFromFlatFile(MultipartFile file,
			HttpServletResponse response) throws Exception {




    	if (file.isEmpty())
    	{
    		return;
    	}

    	List<String> additionalResponseHeaders = new ArrayList<String>();
    	//	additionalResponseHeaders.add("Transaction ID");
    	//	additionalResponseHeaders.add("Upload status");

    	BaseCsvResponseBuilder<BaseCsvRow> builder = new CustomerUploadCsvhandler(
    			additionalResponseHeaders);

    	uploadWSUtil.processCSVRow( builder, file,response, UploadEntityEnum.CUSTOMER);


    		
	}



	private void uploadOrgHierarchyFromFlatFile(MultipartFile file,
    		HttpServletResponse response) throws Exception {



    	if (file.isEmpty())
    	{
    		return;
    	}

    	List<String> additionalResponseHeaders = new ArrayList<String>();
    	//	additionalResponseHeaders.add("Transaction ID");
    	//	additionalResponseHeaders.add("Upload status");

    	BaseCsvResponseBuilder<BaseCsvRow> builder = new OrgHierarchyUploadCsvhandler(
    			additionalResponseHeaders);

    	uploadWSUtil.processCSVRow( builder, file,response, UploadEntityEnum.ORG_HIERARCHY);


    }



	//	@RequestMapping(value = "/api/assess/uploadDesignations", method = RequestMethod.POST)
	public void uploadDesignationsFromFlatFile(//@RequestParam("file")
	MultipartFile file, HttpServletResponse response) throws Exception
	{

		if (file.isEmpty())
		{
			return;
		}

		List<String> additionalResponseHeaders = new ArrayList<String>();
//		additionalResponseHeaders.add("Transaction ID");
//		additionalResponseHeaders.add("Upload status");

		BaseCsvResponseBuilder<BaseCsvRow> builder = new DesignationUploadCsvhandler(
				additionalResponseHeaders);

		uploadWSUtil.processCSVRow( builder, file,response, UploadEntityEnum.DESIGNATION);

	}
	
//	@RequestMapping(value = "/api/assess/uploadUsers", method = RequestMethod.POST)
	public void uploadUsersFromFlatFile(//@RequestParam("file")
	MultipartFile file, HttpServletResponse response) throws Exception
	{

		if (file.isEmpty())
		{
			return;
		}

		List<String> additionalResponseHeaders = new ArrayList<String>();
//		additionalResponseHeaders.add("Transaction ID");
//		additionalResponseHeaders.add("Upload status");

		BaseCsvResponseBuilder<BaseCsvRow> builder = new UserUploadCsvhandler(
				additionalResponseHeaders);

		uploadWSUtil.processCSVRow( builder, file,response, UploadEntityEnum.USERS);

	}
	
//	@RequestMapping(value = "/api/assess/uploadReviewers", method = RequestMethod.POST)
	public void uploadReviewersFromFlatFile(//@RequestParam("file")
	MultipartFile file, HttpServletResponse response) throws Exception
	{

		if (file.isEmpty())
		{
			return;
		}

		List<String> additionalResponseHeaders = new ArrayList<String>();

		BaseCsvResponseBuilder<BaseCsvRow> builder = new FeedbackReviewerUploadCsvhandler(
				additionalResponseHeaders);

		uploadWSUtil.processCSVRow( builder, file,response, UploadEntityEnum.REVIEWER);

	}
	
//	@RequestMapping(value = "/api/assess/uploadQuestions", method = RequestMethod.POST)
	public void uploadQuestionsFromFlatFile(//@RequestParam("file")
	MultipartFile file, HttpServletResponse response) throws Exception
	{

		if (file.isEmpty())
		{
			return;
		}

		List<String> additionalResponseHeaders = new ArrayList<String>();

		BaseCsvResponseBuilder<BaseCsvRow> builder = new QuestionUploadCsvhandler(
				additionalResponseHeaders);

		uploadWSUtil.processCSVRow( builder, file,response, UploadEntityEnum.QUESTION);

	}
	
}
