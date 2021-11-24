<?php


// API-key  "http://www.bashni.org/sites/iphone/corona/qr.php?name=БВВ_15.03.1964_22625"

if (isset($_GET['name'])) $name=($_GET['name']); else $name="БВВ_15.03.1964_22625";
list($fio, $birth, $pass) = explode("_", $name);
$user = mb_substr($fio, 0, 1, 'UTF-8')."*******  ".mb_substr($fio, 1, 1, 'UTF-8')."*****  ".mb_substr($fio, 2, 1, 'UTF-8')."********"; 
$port = "Паспорт: ".substr($pass, 0, 2)."*****".substr($pass, 2, 3);    



echo '
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
body {
  background-color: white;
}

html {
  font-family:verdana;
}

div.top {
  position: relative;
  margin: auto;
  width: 100%;
  height: 60px;
  top: 40px;
  text-align: center;
}

div.info {
  position: relative;
  top: 40px;
  margin: auto;
  padding: 10px;
  width: 100%;
  text-align: center;
}

div.relative {
  position: relative;
  top: 40px;
  margin: auto;
  width: 95%;
  padding: 10px;
  border-radius: 16px;
  height: 140px;
  background: #23bd21;
  text-align: center;
  color: white; 
} 

div.absolute {
  position: relative;
  margin: auto;
  top: 25px;
  padding: 5px;
  width: 60%;
  height: 22px;
  background: #ffffff;
  border-radius: 14px;
  text-align: center;
  color: black; 
}

div.close {
  position: relative;
  margin: auto;
  top: 70px;
  padding: 12px;
  width: 90%;
  height: 25px;
  border-radius: 8px;
  text-align: center;
  color: blue;
  border: 2px solid blue; 
}

</style>
</head>
<body>
';

    echo '<div class="top"><strong><span style="font-size:140%;color:#FF0000">QR</span>
    <span style="font-size:140%;color:#6666CC">УСЛУГИ</span></strong>
    <span style="color:#ffffff">BASHNI.ORG</span>
    <span style="font-size:140%;color:#000000">RUS</span></div>';
    echo '<div class="relative">СЕРТИФИКАТ О ГЕНЕРАЦИИ<br>QR-КОДА-19
  <div class="absolute">Действителен</div><br><p>№ QR9290499831</p></div>';
    echo '<div class="info"><br>'.$user.'</div>';
    echo '<div class="info">'.$port.'</div>';
    echo '<div class="info">Дата рождения: '.$birth.'</div>';
    echo '<div class="close">Закрыть</div>';
    echo '</body></html>';
?>
