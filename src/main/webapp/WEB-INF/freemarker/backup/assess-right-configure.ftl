
<div id="rightpanel" style="background-color: white" class="grid_9" >
        <script type="text/javascript">
			function validateForm()
			{
				var uploadType = document.getElementsByName('uploadFileRadio');
				
				var selected = -1

				for(var i=0; i < uploadType.length; i++){
				   if(uploadType[i].checked) {
				      selected = i; 
				   }
				}
				
				if (selected == -1)
				{
				  alert("Please select type of upload");
				  return false;
				}
				
				document.getElementById("uploadSubmitButton").disabled=true;
				document.getElementById("submitted").style.display = 'block';
				
				setTimeout(function(){document.getElementById('uploadSubmitButton').disabled=false;
				document.getElementById("submitted").style.display = 'none';},15000);
			}
		</script>
    
    
    	<div id="configprogress" style="border-bottom: 1px solid #ccc;padding-top: 10px;padding-bottom: 10px;padding-left: 2px">
    		<table>
    			<tr>
    				<td><a id="addcustomer" href="">Add customer</a></td>
    				<td>---></td>
    				<td><a id="adddesignation" href="">Add designations</a></td>
    				<td>---></td>
    				<td><a id="addassessmentarea" href="">Add assessment area</a></td>
    				<td>---></td>
    				<td><a id="addquestions" href="">Add questions</a></td>
    				<td>---></td>
    				<td><a id="addusers" href="">Add users</a></td>
    				<td>---></td>
    				<td><a id="addreviewers" href="">Add reviewers</a></td>
    				<td>---></td>
    				<td>Done</td>
    			</tr>
    		</table>
    	</div>
    	
    
		<div id="configcontainer" name="configcontainer">
	
			<form action="/UserFeedback/customer" id="add_customer" method="post">
				
				<table>
					<tr>
						<td><label for="customerName">Customer name</label></td>
						<td><input type="text" name="customerName" id="customerName" value=""><br></td>
					</tr>
					<tr>
						<td><label for="noOfUserNominatedReviewers">No. of self nominated reviewers</label></td>
						<td><input type="text" name="noOfUserNominatedReviewers" id="noOfUserNominatedReviewers" value=""><br></td>
					</tr>
					<tr>
						<td><label for="noOfAdminNominatedReviewers">No. of admin nominated reviewers</label></td>
						<td><input type="text" name="noOfAdminNominatedReviewers" id="noOfAdminNominatedReviewers" value=""><br></td>
					</tr>
				</table>	
			 	
				<input name="submit" type="submit" value="Submit">
			</form>
		</div>
		
        <h1>Assess Batch Upload Tool</h1>
        
        
        <form id="batchUploadForm" name="batchUploadForm" method="post" action="/UserFeedback/upload" enctype="multipart/form-data" onsubmit="return validateForm()">
        	<div>	
        	
        		<div>
	        		<div style="float:left;"><input type="radio" name="uploadFileRadio" value="ratingsUpload">Add ratings</div>
	        		<div style="float:left;margin-left:40px;"><a href="Upload-Awards.csv" download="AwardsUploadTemplate">Download Template File</a></div>
	        	</div>
	        	
	        	<div>
	        		<div style="float:left;"><input type="radio" name="uploadFileRadio" value="designationsUpload">Add designations</div>
	        		<div style="float:left;margin-left:40px;"><a href="Upload-Awards.csv" download="AwardsUploadTemplate">Download Template File</a></div>
	        	</div>
	        	
				<div>
					<div style="float:left;clear:both;margin-top:15px;"><input type="radio" name="uploadFileRadio" value="questionsUpload">Add review questions</div>
					<div style="float:left;margin-left:68px;margin-top:15px;"><a href="Upload-Offers.csv" download="OfferUploadTemplate">Download Template File</a></div>
				</div>
				
				
				<div>
					<div style="float:left;clear:both;margin-top:15px;"><input type="radio" name="uploadFileRadio" value="reviewersUpload">Add reviewers</div>
					<div style="float:left;margin-left:46px;margin-top:15px;"><a href="Manual_Tier_Adjustment_template-New.csv" download="TierAdjustMentTemplate">Download Template File</a></div>
				</div>
				
				<div>
					<div style="float:left;clear:both;margin-top:15px;"><input type="radio" name="uploadFileRadio" value="usersUpload">Add users</div>
					<div style="float:left;margin-left:46px;margin-top:15px;"><a href="Manual_Tier_Adjustment_template-New.csv" download="TierAdjustMentTemplate">Download Template File</a></div>
				</div>
				
				<div>
					<div style="float:left;clear:both;margin-top:15px;"><input type="radio" name="uploadFileRadio" value="orghierarchyUpload">Add org hierarchy</div>
					<div style="float:left;margin-left:46px;margin-top:15px;"><a href="Manual_Tier_Adjustment_template-New.csv" download="TierAdjustMentTemplate">Download Template File</a></div>
				</div>
				
				
	        	<div>
	        		<div style="float:left;"><input type="radio" name="uploadFileRadio" value="assessmentareaUpload">Add assessment area</div>
	        		<div style="float:left;margin-left:40px;"><a href="Upload-Awards.csv" download="AwardsUploadTemplate">Download Template File</a></div>
	        	</div>
				
				<div>
	        		<div style="float:left;"><input type="radio" name="uploadFileRadio" value="assessmentareaHierarchyUpload">Add assessment area hierarchy</div>
	        		<div style="float:left;margin-left:40px;"><a href="Upload-Awards.csv" download="AwardsUploadTemplate">Download Template File</a></div>
	        	</div>
				
				<div style="clear:both;float:left;padding-top:30px;">
	        
		            <input type="text" name="name"/>
		            <input id="uploadBox" type="file" name="file"/>
		            <input id="uploadSubmitButton" type="submit" value="submit"/>
	            </div>
	            <div id="submitted" style="padding-top:35px;float:left;margin-left:10px;display:none">
            		File submitted. Please wait for the response.
            	</div>
            	
            	<div style="clear:both;float:left;padding-top:25px;font-size:13px">
				*Please do not open downloaded template files with Excel. Excel removes formatting. Open these files with any text editor like notepad or text-wrangler.
				</div>
				<div style="clear:both;float:left;padding-top:10px;font-size:13px">
				*Please enter dates in either MM/dd/yyyy HH:mm:ss or MM/dd/yyyy format.
				</div>
				
            </div>
        </form>
        
 </div>   