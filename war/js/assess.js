
      // Load the Visualization API and the piechart package.
   google.load('visualization', '1.0', {'packages':['corechart']});
    
      
   $(document).ready(function() {
  
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
        var chart = new google.visualization.BarChart(document.getElementById(id));
        chart.draw(gdata, options);
	}
	
   
     $('#reviews_search').submit(function(event) {
       event.preventDefault();
       
       
       var url = "/UserFeedback/reviews_search_json";
       var formValues = $(this).serialize();
       // alert(formValues);
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
	