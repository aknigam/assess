<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>assess</title>

<link rel="stylesheet" href="http://960.gs/css/960.css" />
<link rel="stylesheet" href="http://960.gs/css/demo.css" />

<link rel="stylesheet" href="/Users/anigam/Downloads/jquery-ui-1.11.0/jquery-ui.min.css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>


  

<script>
	
      // Load the Visualization API and the piechart package.
      google.load('visualization', '1.0', {'packages':['corechart']});
    
      
   $(document).ready(function() {
   
   
   // a3 is individual detailed
	$( "#a3" ).click(function( event ) {
		event.preventDefault();
		var href = $("#a1").attr('href');
		
		$.get(href,function(data) {
         		
         		handleDetailedReportdata(data);
		 	}
		 );
		
		
        
	});
	
	function handleDetailedReportdata(data)
	{
		
		
		
        var areaReport =data.assessmentAreaReports;
		
		$.each( areaReport, function( key, val ) {
    		var questionReports = val.questionReports;
    		
    		$.each( questionReports, function( key, val ) {
    		
    			var gdata = new google.visualization.DataTable();
        		gdata.addColumn('string', 'Reviewer');
        		gdata.addColumn('number', 'Rating');
        		
        		$( "#rightpanel" ).append( "<div id="+"qc"+val.questionId+" class=grid_4></div>" );
        		
    			$( "#rightpanel" ).append( "<div id="+"q"+val.questionId+">test</div>" );
    			var rank = val.rank;
    			gdata.addRow(['Self', rank.selfRating]);
    			gdata.addRow(['Manager', rank.managerRating]);
    			gdata.addRow(['Peer', rank.peerRating]);
    			gdata.addRow(['Direct reports', rank.directReportRating]);
    			gdata.addRow(['Indirect reports', rank.indirectReportRating]);
    			gdata.addRow(['Others', rank.otherRating]);
    			// alert(rank);
    			
    					// Set chart options
        		var options = {'title':val.question,
                       'width':500,
                       'height':200,
                       bar: {
    						groupWidth: '100%'
						}};

        		// Instantiate and draw our chart, passing in some options.
        		var chart = new google.visualization.BarChart(document.getElementById('q'+val.questionId));
        		chart.draw(gdata, options);
    		});
  		});
  		
        /*
		for (var i = 0; i < data.charData.length; i++) {
    		var object = data.charData[i];
    		gdata.addRow(object);
    		
		}
		*/
		
        // data.addRows(data.charData)


	
	}
	
  	// a1 is individual summary
	$( "#a1" ).click(function( event ) {
		event.preventDefault();
		var href = $("#a1").attr('href');
		
		$.get(href,function(data) {
         		
         		handleSummaryReportdata(data);
		 	}
		 );
		
		
        
	});
	
	function handleSummaryReportdata(data)
	{
		
		var areaReport =data.assessmentAreaReports;
		
		$.each( areaReport, function( key, val ) {
    		var questionReports = val.questionReports;
    		$.each( questionReports, function( key, val ) {
    			var rank = val.rank;
    		});
  		});
		
		var gdata = new google.visualization.DataTable();
        gdata.addColumn('string', 'Question');
        gdata.addColumn('number', 'Rating');
        
		for (var i = 0; i < data.charData.length; i++) {
    		var object = data.charData[i];
    		gdata.addRow(object);
    		
		}
		
        // data.addRows(data.charData)

		// Set chart options
        var options = {'title':'Others ratings',
                       'width':400,
                       'height':300};

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.BarChart(document.getElementById('rightpanel'));
        chart.draw(gdata, options);
	
	}
	
	$( "#a2" ).click(function( event ) {
		event.preventDefault();
		var href = $("#a2").attr('href');
		
		$.get(href,function(data) {
         		
         		handleFrequencyReportdata(data);
		 	}
		 );
		
		
        
	});
	
	function handleFrequencyReportdata(data)
	{
        
		for (var i = 0; i < data.others.length; i++) {
    		var object = data.others[i].mcFrequency;
    		var question = data.others[i].question
    		var x=  i+1;
    		var id = 'd'+x;
    		addFrequencyChart(id,question, object);
		}
		
      
	}
	
	function addFrequencyChart(id,question,data)
	{
		var gdata = new google.visualization.DataTable();
		gdata.addColumn('string', 'Choice');
        gdata.addColumn('number', 'Frequency');
        
        gdata.addRows(data);
        
        var options = {'title':question,
                       'width':600,
                       'height':300};

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.PieChart(document.getElementById(id));
        chart.draw(gdata, options);
	}
	
   
     $('#reviews_search').submit(function(event) {
       event.preventDefault();
       
       
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
	        html += '<td style="background-color: rgb(239, 228, 176)" ><a href="/UserFeedback/questions?&feedbackId='+entry.customerReviewerId+'">'+entry.revieweeEmail+'</a></td>';
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
	<!-- Can be tested @ http://htmledit.squarefree.com/ -->
	
	<div class="container_12">
		<#include "assess-header.ftl">
		<#include "assess-left.ftl">
		<#include "assess-right-review-list.ftl">
		<#include "assess-footer.ftl">
		
	</div> 
	
	
</body>
</html>
