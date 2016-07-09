<!--QUESTIONS START HERE -->	
    <div style="background-color: white" class="grid_9" >
        
    <table>    
  	<div>Reviewer name: Anand nigam</div>
  	<div>Reviewer email: anigam@expedia.com</div>
  	<div>Reviewer Designation: Develpor</div>
  	</table>
  	<hr>
  	<tr>Reviewee name: Saurbh laloraya</tr>
  	<tr>Reviewee email: slaloraya@expedia.com</tr>
  	<tr>Reviewee Designation: Developer</tr>
  	<hr>
  	
    <tr>
        <td>Feedback Id - ${feedbackQuestions.getAppUserReviewerId()}</td> 
        <td>Reviewee Id - ${feedbackQuestions.getAppUserReviewerId()}</td> 
        <td>DesignationId - ${feedbackQuestions.getDesignationId()}</td>
    </tr>
    
		    
		    
		<form action="savefeedback" id="feedback_form" method="post">
		
			<input type="text" hidden="true" name="curid" value=${feedbackQuestions.getAppUserReviewerId()} />
		
		  <#list feedbackQuestions.getQuestionAnswers() as qa>
		  		<hr>
			   <tr>
					
				        <td>QId  a - ${qa.getQuestionId()}</td> 
				        <td>Q - ${qa.getQuestion()}</td>
				        <td>QTypeId - ${qa.getRefQuestionTypeId()}</td>
			
					
				</tr>
			    
			    <#if qa.getRefQuestionTypeId() = 1 >
			    	<div>
					<#if qa.descriptiveAnswer?has_content >
						<textarea id=${qa.getQuestionId()+"-"+qa.getRefQuestionTypeId()} form="feedback_form" rows="6" cols="80" name=${qa.getQuestionId()+"-"+qa.getRefQuestionTypeId()} value=${qa.descriptiveAnswer}>${qa.descriptiveAnswer}</textarea>
					<#else>
						<textarea id=${qa.getQuestionId()+"-"+qa.getRefQuestionTypeId()} form="feedback_form" rows="6" cols="80" name=${qa.getQuestionId()+"-"+qa.getRefQuestionTypeId()} value="text"/></textarea>
						
						  
					</#if> 
					</div>
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


        

	
    </div>
    <!--QUESTIONS END HERE -->
