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

 <script type="text/javascript">
	  // alert('individual report jkhkjh');
      // Load the Visualization API and the piechart package.
      google.load('visualization', '1.0', {'packages':['corechart']});
      // alert('individual report jkhkjh jahjad');
      
      $(document).ready(function() {
      $( "#a1" ).click(function( event ) {
  		event.preventDefault();
  		// alert('individual report jkhkjh');
  		var data = new google.visualization.DataTable();
        data.addColumn('string', 'Topping');
        data.addColumn('number', 'Slices');
        data.addRows([
          ['Mushrooms', 3],
          ['Onions', 1],
          ['Olives', 1],
          ['Zucchini', 1],
          ['Pepperoni', 2]
        ]);
		// alert(data)

		// Set chart options
        var options = {'title':'How Much Pizza I Ate Last Night',
                       'width':400,
                       'height':300};

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
        chart.draw(data, options);
        
	});
	});
	// alert('individual report Anand nigam');

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
		<#include "assess-right-summary-report.ftl">
		<#include "assess-footer.ftl">
	</div> 
	
</body>
</html>
