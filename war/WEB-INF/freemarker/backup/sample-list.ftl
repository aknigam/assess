<html>
<head>
  <title>Welcome!</title>
</head>
<body>
  
  <#list joblist.getData() as job>
   <tr><h2>
        <td>${job.getEmail()}</td> 
        <td>${job.getName()}</td> 
    </h2></tr>
    </#list>
  
  
  <p>Our latest product:
  <a href="products/greenmouse.html">green mouse</a>!
</body>
</html>