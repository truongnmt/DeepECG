<?php
  require_once 'dbconnect.php';

  if($_SERVER['REQUEST_METHOD']=='GET'){
    if(isset($_GET['report_id'])) {
      // images#index with repord_id
      $report_id = $_GET['report_id'];
      $sql = "SELECT * FROM images WHERE `report_id` = $report_id ORDER BY `id` DESC;";
      $result = mysqli_query($conn,$sql);
      $response = array();
      while($row = mysqli_fetch_array($result)){
      	$temp = array();
      	$temp['id']=$row['id'];
      	$temp['report_id']=$row['name'];
        $temp['url']=$row['url'];
        $temp['result']=$row['result'];
      	array_push($response, $temp);
      }
      echo json_encode($response);
    }
  }
