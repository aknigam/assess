<html>
<head>
  <title>Welcome to list of reviews !</title>
</head>
<body>
  
    
  <#list myreviews.getData() as r>
  
  
   <tr><h4>
        <td>${r.getCustomerReviewerId()}</td> 
        <td>${r.revieweeId}</td>
        <a href=${"questions?&feedbackId="+r.getCustomerReviewerId()}>${r.revieweeEmail}</a>
        
    </h4></tr>
    </#list>
  
  
</body>
</html>