<html>
<head>
  <title>Welcome to feedback questions !</title>
</head>
<body>
  
  
    <tr><h3>
    
        <td>Feedback Id - ${feedbackQuestions.getAppUserReviewerId()}</td> 
        <td>Reviewee Id - ${feedbackQuestions.getAppUserReviewerId()}</td> 
        <td>DesignationId - ${feedbackQuestions.getDesignationId()}</td>
    </h3></tr>
    
    
  <#list feedbackQuestions.getQuestionAnswers() as qa>
  
  
	   <tr>
			<h4>
		        <td>QId  a - ${qa.getQuestionId()}</td> 
		        <td>Q - ${qa.getQuestion()}</td>
		        <td>QTypeId - ${qa.getRefQuestionTypeId()}</td>
	
			</h4>
		</tr>
	    
	    <#if qa.getRefQuestionTypeId() = 1 >
	    	
			<#if qa.descriptiveAnswer?has_content >
				<textarea rows="4" cols="50" name="descriptive answer." value=${qa.descriptiveAnswer}></textarea>
				
				      
			<#else>
				<textarea rows="4" cols="50" name="descriptive answer." value="text"/></textarea>
				
				  
			</#if> 
			
	    <#else>
	    	<div>
		    <#list qa.getChoices() as ch>
				<input type="checkbox" name="choice" value=${ch.choiceId}>${ch.choiceAnswer}<br>
		    </#list>
		    </div>
	    </#if>
        
    </#list>
  
  
</body>
</html>