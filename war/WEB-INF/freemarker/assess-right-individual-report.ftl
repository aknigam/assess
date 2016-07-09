

<!--QUESTIONS START HERE -->	
    <div id="rightpanel" style="background-color: white" class="grid_9" >
        
        <h2>Portfolio a Summary</h2>
		<div id="tablerows-individual-report">
		
		  
		<#list report.getAssessmentAreaReports() as aar>
		  
			<div>
				<h2>${aar.getAssessmentAreaName()}</h2>
				<table>
					<tr>
						<td style="background-color: rgb(195, 195, 195); font-weight:bold" >Question</td>
		  				<td style="background-color: rgb(195, 195, 195); font-weight:bold" >Self rating</td>
		  				<td style="background-color: rgb(195, 195, 195); font-weight:bold" >Manager rating</td>
		  				<td style="background-color: rgb(195, 195, 195); font-weight:bold" >Peer rating</td>
		  				<td style="background-color: rgb(195, 195, 195); font-weight:bold" >Other rating</td>
		  				<td style="background-color: rgb(195, 195, 195); font-weight:bold" >Direct report's rating</td>
		  	
					</tr>
					
					<#list aar.getQuestionReports() as qr>
					
					<tr>
						<td>${qr.getQuestion()}</td>
						<td>${qr.getRank().getSelfRating()}</td>
						<td>${qr.getRank().getManagerRating()}</td>
						<td>${qr.getRank().getPeerRating()}</td>
						<td>${qr.getRank().getOtherRating()}</td>
						<td>0</td>
					</tr>
					
					</#list>
				</table>
			</div>
		</#list>	
		
		<div>
			
	
    </div>
    <!--QUESTIONS END HERE -->