<html><head>
   <title>OCI - Webserver</title>
 </head>
 <body>
 <img src="https://www.oci-workshop.com/oci.png"><br>
 Welcome to the OCI Webserver!<br>
 <br>
 <button onclick="window.location.href='/speedtest';">
      Speedtest
 </button>
 <br><br>

<?php
ini_set('default_socket_timeout', 2);
$json = file_get_contents("http://169.254.169.254/opc/v1/instance/");
$obj = json_decode($json);
$displayName = $obj->displayName;
$shape = $obj->shape;
$ad = $obj->availabilityDomain;
$region = $obj->region;
$faultDomain = $obj->faultDomain;
$internal_ip = $_SERVER['SERVER_ADDR'];
$external_ip = exec('curl https://www.oci-workshop.com/myip/');
$os = exec("awk -F= '/PRETTY_NAME/{print $2}' /etc/os-release");
print ("<p><b>My info</b><br>");
print ("");
print ("<table border=1><tbody><tr><td>My Public IP</td><td>$external_ip</td></tr><tr><td>My Private IP</td><td>$internal_ip</td></tr><tr><td>Instance</td><td>$displayName</td></tr><tr><td>Shape</td><td>$shape</td></tr><tr><td>Region</td><td>$region</td></tr><tr><td>Availability Domain</td><td>$ad</td></tr><tr><td>Fault Domain</td><td>$faultDomain</td></tr><tr><td>Operating System</td><td>$os</td></tr></tbody></table>");
?>
</p></body></html>