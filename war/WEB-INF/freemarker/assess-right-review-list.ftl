<!--QUESTIONS START HERE -->	
    <div id="rightpanel" style="background-color: white" class="grid_9" >
    	<div id="d1">d1</div>
    	<div id="d2">d2</div>
        <hr>
		<div id="searchformdiv" name="searchformdiv">

			<form action="reviews_search" id="reviews_search" method="post">
				<label for="status">Feedback Status</label>
				<select id="status" name="status" form="reviews_search">
				  <option value="0">All</option>
				  <option value="1">New</option>
				  <option value="2">Draft</option>
				  <option value="3">Submitted</option>
				</select>
				</br>
			
				<label for="revieweeDesignation">Reviewee designation</label>
				<select id="revieweeDesignation" name="revieweeDesignation" form="reviews_search">
				  <option value="0">All</option>
				  <option value="19">Developer</option>
				  <option value="21">Director</option>
				  <option value="20">Manager</option>
				  <option value="2">VP</option>
				</select>
				</br>
				<label for="reviewerDesignation">Reviewer designation</label>
				<select id="reviewerDesignation" name="reviewerDesignation" form="reviews_search">
				  <option value="0">All</option>
				  <option value="19">Developer</option>
				  <option value="21">Director</option>
				  <option value="20">Manager</option>
				  <option value="2">VP</option>
				</select>
				</br>
			 	<label for="revieweeName">Reviewee name</label>
			 	<input type="text" name="revieweeName" id="revieweeName" value=""><br>
  				
  				<label for="revieweeEmail">Reviewee email</label>
			 	<input type="text" name="revieweeEmail" id="revieweeEmail" value=""><br>
			 	
			 	
			 	
			 	
			 	
			 	<label for="reviewerName">Reviewer name</label>
			 	<input type="text" name="reviewerName" id="reviewerName" value=""><br>
  				
  				<label for="reviewerEmail">Reviewer email</label>
			 	<input type="text" name="reviewerEmail" id="reviewerEmail" value=""><br>
			 	
			 	
				

		  	<input id="search" name="search" type="submit" value="Submit">
		</form>
		</div>
		<hr>  
		<div id="tablerows">
		<table >
		  <#assign x = 1>  
		  
		  <tr>
		  	<td style="background-color: rgb(195, 195, 195); font-weight:bold" >S. No</td>
		  	<td style="background-color: rgb(195, 195, 195); font-weight:bold" >Reviewer name</td>
		  	<td style="background-color: rgb(195, 195, 195); font-weight:bold" >Reviewer designation</td>
		  	<td style="background-color: rgb(195, 195, 195); font-weight:bold" >Reviewer email</td>
		  	
		  	<td style="background-color: rgb(195, 195, 195); font-weight:bold" >Reviewee name</td>
		  	<td style="background-color: rgb(195, 195, 195); font-weight:bold" >Reviewee designation</td>
		  	<td style="background-color: rgb(195, 195, 195); font-weight:bold" >Reviewee email</td>
		  	
		  	<td style="background-color: rgb(195, 195, 195); font-weight:bold" >Status </td>
		  </tr>
		  
		  <#list myreviews.getData() as r>
		  
			   <tr>

			   		<td style="background-color: rgb(228, 232, 223)" >${x} : </td>
			   		
			   		<td style="background-color: rgb(153, 215, 234)" >${r.reviewerName}</td>
			        <td style="background-color: rgb(153, 215, 234)" >${r.reviewerDesignation}</td>
			        <td style="background-color: rgb(153, 215, 234)" >${r.reviewerEmail}</td>
			   		
			   		<td style="background-color: rgb(239, 228, 176)" >${r.revieweeName}</td>
			        <td style="background-color: rgb(239, 228, 176)" >${r.revieweeDesignation}</td>
			        <td style="background-color: rgb(239, 228, 176)" ><a href=${"questions?&feedbackId="+r.getCustomerReviewerId()}>${r.revieweeEmail}</a></td>
			        <td style="background-color: rgb(239, 228, 176)" >${r.feedbackStatus}</td>
			        
			        
			    </tr>
			    <#assign x = x+ 1>
		    </#list>
		    
		  </table>
		 </div> 
	
    </div>
    <!--QUESTIONS END HERE -->