<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>assess</title>

<link rel="stylesheet" href="http://960.gs/css/960.css" />
<link rel="stylesheet" href="http://960.gs/css/demo.css" />

<link rel="stylesheet" href="/Users/anigam/Downloads/jquery-ui-1.11.0/jquery-ui.min.css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>


<script>

   $(document).ready(function() {
   
   		$('#my-reviews').click(function(event) {
   			event.preventDefault();
   			alert('my-reviews')
       		$('#rightpanel').show();
		});
   
   		function getQuestions()
   		{
   			alert('questionslink');
			$('#questionslink').click(function(event) {
				alert('questionslink')
	   			event.preventDefault();
	   			var url = $('#questionslink').attr('href');
	   			alert(href);
	       		
	       		var requestData =  {feedbackId: $(this).text() };
	       		
	       		alert(requestData);
	       		event.preventDefault();
	       		return "false"
			});  
		} 
   
     $('#reviews_search').submit(function(event) {
       event.preventDefault();
       alert('wfefer')
       
       
       var url = "/UserFeedback/reviews_search_json";
       var formValues = $(this).serialize();
       $.post(url,formValues,
         function(data) {
         	handleSearcResults(data);
		 });
		});
		
	});
	
	function handleSearcResults(data)
	{
		var html = '';
		
		html += '<table >';
		html += '		  <tr>';
		html += '		  	<td style="background-color: rgb(195, 195, 195); font-weight:bold" >S. No</td>';
		html += '		  	<td style="background-color: rgb(195, 195, 195); font-weight:bold" >Reviewer name</td>';
		html += '		  	<td style="background-color: rgb(195, 195, 195); font-weight:bold" >Reviewer designation</td>';
		html += '		  	<td style="background-color: rgb(195, 195, 195); font-weight:bold" >Reviewer email</td>';
		html += '		  	<td style="background-color: rgb(195, 195, 195); font-weight:bold" >Reviewee name</td>';
		html += '		  	<td style="background-color: rgb(195, 195, 195); font-weight:bold" >Reviewee designation</td>';
		html += '		  	<td style="background-color: rgb(195, 195, 195); font-weight:bold" >Reviewee email</td>';
		html += '		  	<td style="background-color: rgb(195, 195, 195); font-weight:bold" >Status </td>';
		html += '		  </tr>';
		
		var rownum = 0;
         $.each(data.data, function(entryIndex, entry) {
           
            html += '<tr>';
            html += '<td style="background-color: rgb(153, 215, 234)" >'+ rownum+'</td>';
   			html += '<td style="background-color: rgb(153, 215, 234)" >'+ entry.reviewerName+'</td>';
	        html += '<td style="background-color: rgb(153, 215, 234)" >'+entry.reviewerDesignation+'</td>';
	        html += '<td style="background-color: rgb(153, 215, 234)" >'+entry.reviewerEmail+'</td>';
	   		
	   		html += '<td style="background-color: rgb(239, 228, 176)" >'+entry.revieweeName+'</td>';
	        html += '<td style="background-color: rgb(239, 228, 176)" >'+entry.revieweeDesignation+'</td>';
	        html += '<td style="background-color: rgb(239, 228, 176)" ><a id="questionslink" name="questionslink" href="/UserFeedback/questions?&feedbackId='+entry.customerReviewerId+'">'+entry.revieweeEmail+'</a></td>';
	        html += '<td style="background-color: rgb(239, 228, 176)" >'+entry.feedbackStatus+'<td>';
	        html += '</tr>';
	        
	        rownum = rownum +  1;
           
		});
		
		html += '</table>'
		
		$('#tablerows').html(html);
	}

</script>

<style type="text/css">

a:link {
	color: blue;
	text-decoration: none;
}

a:visited {
	color: black;
}

a:hover {
	color: blue;
	text-decoration: underline;
}

tr {
     background-color: #fff;
}
.alt {
     background-color: #ccc;
   }



a:active {
	color: blue;
}
</style>

</head>
<body>
	<div class="container_12">
		<#include "assess-header.ftl">
		<#include "assess-left.ftl">
		<#include "assess-right-home.ftl">
		<#include "assess-footer.ftl">
	</div> 
</body>
</html>
