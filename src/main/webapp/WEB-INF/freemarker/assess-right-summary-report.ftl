

<!--QUESTIONS START HERE -->	
    <div id="rightpanel" style="background-color: white" class="grid_9" >
        
        <h2>Detailed report</h2>
		<div id="tablerows-individual-report">
		
		  
		<#list report.getAssessmentAreaReports() as aar>
		  
			<div>
				<h1>${aar.getAssessmentAreaName()}</h1>
				<hr>
				
					
					<#list aar.getQuestionReports() as qr>
					<h2>${qr.getQuestion()}</h2>
					<table>
						
						<tr>
							<td style="background-color: rgb(195, 195, 195); font-weight:bold" >Self rating</td>
			  				<td>${qr.getRank().getSelfRating()}</td>
			  			</tr>
			  			<tr>
			  				<td style="background-color: rgb(195, 195, 195); font-weight:bold" >Manager rating</td>
			  				<td>${qr.getRank().getManagerRating()}</td>
			  				<tr>
			  				</tr>
			  				<td style="background-color: rgb(195, 195, 195); font-weight:bold" >Peer rating</td>
			  				<td>${qr.getRank().getPeerRating()}</td>
			  				<tr>
			  				</tr>
			  				<td style="background-color: rgb(195, 195, 195); font-weight:bold" >Other rating</td>
			  				<td>${qr.getRank().getOtherRating()}</td>
			  				<tr>
			  				</tr>
			  				<td style="background-color: rgb(195, 195, 195); font-weight:bold" >Direct report's rating</td>
			  				<td>0</td>
			  				</tr>
			  	
						</tr>
					</table>
					
					
					</#list>
			</div>
		</#list>	
		
		</div>
			
	
    </div>
    <!--QUESTIONS END HERE -->