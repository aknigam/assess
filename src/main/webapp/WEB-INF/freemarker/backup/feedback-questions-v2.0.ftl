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
    
    
    
<form action="savefeedback" id="feedback_form" method="post">

	<input type="text" hidden="true" name="curid" value=${feedbackQuestions.getAppUserReviewerId()} />

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
				<textarea id=${qa.getQuestionId()+"-"+qa.getRefQuestionTypeId()} form="feedback_form" rows="4" cols="50" name=${qa.getQuestionId()+"-"+qa.getRefQuestionTypeId()} value=${qa.descriptiveAnswer}>${qa.descriptiveAnswer}</textarea>
			<#else>
				<textarea id=${qa.getQuestionId()+"-"+qa.getRefQuestionTypeId()} form="feedback_form" rows="4" cols="50" name=${qa.getQuestionId()+"-"+qa.getRefQuestionTypeId()} value="text"/></textarea>
				
				  
			</#if> 
			
	    <#else>
	    	<div>
		    <#list qa.getChoices() as ch>
		    	<#if ch.choiceId = qa.multipleChoiceAnswerId >
					<input type="radio" name=${qa.getQuestionId()+"-"+qa.getRefQuestionTypeId()} value=${ch.choiceId} checked>${ch.choiceAnswer}<br>
				<#else>
					<input type="radio" name=${qa.getQuestionId()+"-"+qa.getRefQuestionTypeId()} value=${ch.choiceId}>${ch.choiceAnswer}<br>
				</#if>		
		    </#list>
		    </div>
	    </#if>
        
    </#list>
  
  <input type="submit" value="Submit">
</form>



</body>
</html>