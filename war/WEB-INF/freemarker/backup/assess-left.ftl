

<div id="leftpanel" style="background-color: whit; border: 0px solid green"
	class="grid_3">
	
		<#if userinfo.getUserId() = 1 >
			<div>
				<a id="Configure" href="/UserFeedback/configure">Configure</a>
			</div>
		</#if>
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
			<a id="a2" href=${"/UserFeedback/frequencyreportjson?&userId="+userinfo.getUserId()}>Show frequency report</a>
		</div>
		<hr>
		<#if userinfo.getAppRoleId() = 2 >
		<div>
			<a id="a2" href=${"/UserFeedback/questionsself?&userId="+userinfo.getUserId()}>Self review</a>
		</div>
		</#if>
		

</div>

