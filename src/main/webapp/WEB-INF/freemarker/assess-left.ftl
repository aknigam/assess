

<div id="leftpanel" class="grid_2">
	
		<div id="left-container" style="padding-left:10px; padding-top:10px; ">
			<div>
				<a id="Configure" href="/UserFeedback/configure">Configure</a>
			</div>
			<hr>
			<div>
				<tr><td><a href=${"/UserFeedback/reviews?&userId="+userinfo.getUserId()}>my reviews</a></td></tr>
			</div>
			<hr>
			<div>
				<a id="a1" href=${"/UserFeedback/individualsummaryjson?&userId="+userinfo.getUserId()}>Show individual report</a>
			</div>
			<hr>
			<div>
				<a id="a2" href=${"/UserFeedback/frequencyreportjson?&userId="+userinfo.getUserId()}>Show frequency report</a>
			</div>
			<hr>
			<div>
				<a id="a3" href=${"/UserFeedback/individualsummaryjson?&userId="+userinfo.getUserId()}>Show summary report</a>
			</div>
			<hr>
			
			<div>
				<a id="a2" href=${"/UserFeedback/questionsself?&userId="+userinfo.getUserId()}>Self review</a>
			</div>
			
			<hr>
			
			<div>
				<a id="a2" href=${"/UserFeedback/questionsself?&userId="+userinfo.getUserId()}>Nominate reviewers</a>
			</div>
		</div>
		
		

</div>

