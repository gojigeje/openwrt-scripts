<?php 
  // GET CLIENT IP 
  function getRealIpAddr()
  {
    if (!empty($_SERVER['HTTP_CLIENT_IP']))
    //check ip from share internet
    {
      $ip=$_SERVER['HTTP_CLIENT_IP'];
    }
    elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR']))
    //to check ip is pass from proxy
    {
      $ip=$_SERVER['HTTP_X_FORWARDED_FOR'];
    }
    else
    {
      $ip=$_SERVER['REMOTE_ADDR'];
    }
    return $ip;
  }
  $ip_client = getRealIpAddr();
  // echo "$ip_client<br>";

  // akses eksklusif dari 192.168.2.9 dan 192.168.2.2
  if ($ip_client!="192.168.2.9" && $ip_client!="192.168.2.2") {
    die("FORBIDDEN");
  } 

  if (isset($_GET['code'])) {
    switch ($_GET['code']) {

      case 'gojimini2.cctv_not_responding':
        exec("bash script/gojimini2.cctv_not_responding.sh > /dev/null 2>&1 &");
      break;

      case 'gojimini2.cctv_successfully_started':
        exec("bash script/gojimini2.cctv_successfully_started.sh > /dev/null 2>&1 &");
      break;

      case 'gojimini2.system_is_ready':
        exec("bash script/gojimini2.system_is_ready.sh > /dev/null 2>&1 &");
      break;
      
      case 'gojimini2.reboot_maintenance':
        exec("bash script/gojimini2.reboot_maintenance.sh > /dev/null 2>&1 &");
      break;

      default:
        echo "NOT_RECOGNIZED";
      break;
    }
  } else {
echo "<pre>
API@gojimini
v 0.1 ~ 2014/03/26 01:30 WIB
</pre>";
  }

?>