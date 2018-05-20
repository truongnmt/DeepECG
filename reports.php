<?php
  require_once 'dbconnect.php';
  $upload_path = 'uploads/';
  // $upload_url = 'http://apho2017.hust.edu.vn/uploads/';
  $upload_url = 'http://localhost:8888/diagnose-report/uploads/';

  $response = array();

  if($_SERVER['REQUEST_METHOD']=='GET'){
    if(isset($_GET['report_id'])) {
      // reports#show
      $report_id = $_GET['report_id'];
      $sql = "SELECT * FROM reports WHERE `id` = $report_id;";
      $result = mysqli_query($conn,$sql);
      $response = array();
      while($row = mysqli_fetch_array($result)){
        $temp = array();
        $temp['id']=$row['id'];
        $temp['user_id']=$row['user_id'];
        $temp['name']=$row['name'];
        $temp['description']=$row['description'];
        $temp['patient_name']=$row['patient_name'];
        $temp['patient_age']=$row['patient_age'];
        $temp['patient_height']=$row['patient_height'];
        $temp['patient_weight']=$row['patient_weight'];
        $temp['general_result']=$row['general_result'];
        $temp['created_at']=$row['created_at'];
        array_push($response, $temp);
      }
      echo json_encode($response);
    } else if(isset($_GET['user_id'])) {
      // reports#index
      $user_id = $_GET['user_id'];
      $sql = "SELECT * FROM reports WHERE `user_id` = $user_id ORDER BY `id` DESC;";
      $result = mysqli_query($conn,$sql);
      $response = array();
      while($row = mysqli_fetch_array($result)){
        $temp = array();
        $temp['id']=$row['id'];
        $temp['user_id']=$row['user_id'];
        $temp['name']=$row['name'];
        $temp['description']=$row['description'];
        $temp['patient_name']=$row['patient_name'];
        $temp['patient_age']=$row['patient_age'];
        $temp['patient_height']=$row['patient_height'];
        $temp['patient_weight']=$row['patient_weight'];
        $temp['general_result']=$row['general_result'];
        $temp['created_at']=$row['created_at'];
        array_push($response, $temp);
      }
      echo json_encode($response);
    }

  } else if($_SERVER['REQUEST_METHOD']=='POST' && isset($_POST['apicall'])){
      // reports#patch
      if($_POST['apicall'] == 'patch') {
        $report_id = $_POST['report_id'];
        $name = $_POST['name'];
        $description = $_POST['description'];
        $patient_name = $_POST['patient_name'];
        $patient_age = $_POST['patient_age'];
        $patient_height = $_POST['patient_height'];
        $patient_weight = $_POST['patient_weight'];
        $sql = "UPDATE `reports` SET `name` = '$name',
          `description` = '$description',
          `patient_name` = '$patient_name',
          `patient_age` = '$patient_age',
          `patient_height` = '$patient_height',
          `patient_weight` = '$patient_weight' WHERE `reports`.`id` = $report_id;";

        if(mysqli_query($conn,$sql)) {
          $response['result'] = true;
          $response['message'] = "Report update successfully";

          echo json_encode($response);
          mysqli_close($conn);
          return;
        } else {
          $response['result'] = false;
          $response['message'] = mysqli_error($conn);

          echo json_encode($response);
          mysqli_close($conn);
          return;
        }
      } else if($_POST['apicall'] == 'delete') {
      // reports#delete
      $report_id = $_POST['report_id'];
      $sql = "DELETE FROM `reports` WHERE `reports`.`id` = $report_id;";
      if(mysqli_query($conn,$sql)) {
        $response['result'] = true;
        $result = "Report deleted successfully!";

        echo json_encode($response);
        mysqli_close($conn);
        return;
      } else {
        $response['result'] = false;
        $response['message'] = mysqli_error($conn) . $sql;

        echo json_encode($response);
        mysqli_close($conn);
        return;
      }
    }
  } else if($_SERVER['REQUEST_METHOD']=='POST'){
    // reports#create
    $user_id = $_POST['user_id'];
    $name = $_POST['name'];
    $description = $_POST['description'];
    $patient_name = $_POST['patient_name'];
    $patient_age = $_POST['patient_age'];
    $patient_height = $_POST['patient_height'];
    $patient_weight = $_POST['patient_weight'];
    $sql = "INSERT INTO reports (`id`, `user_id`, `name`, `description`,
      `patient_name`, `patient_age`, `patient_height`, `patient_weight`,
      `created_at`)
      VALUES (NULL, $user_id, '$name', '$description', '$patient_name',
      '$patient_age', '$patient_height', '$patient_weight', NOW());";
    if(mysqli_query($conn,$sql)) {
      $report_id = mysqli_insert_id($conn);
    } else {
      $response['result'] = false;
      $response['message'] = mysqli_error($conn);

      echo json_encode($response);
      mysqli_close($conn);
      return;
    }

    // images#created
    if(count($_FILES['images']['name'])>0) {
      for($i = 0; $i < count($_FILES['images']['name']); $i ++) {
        $fileinfo = pathinfo($_FILES['images']['name'][$i]);
        $extension = $fileinfo['extension'];
        $file_url = $upload_url . getFileName($conn) . '.' . $extension;
        $file_path = $upload_path . getFileName($conn) . '.'. $extension;

        try {
          move_uploaded_file($_FILES['images']['tmp_name'][$i],$file_path);
          $output = json_decode(exec("./predict '".$file_path."' 2>&1"), true);
          $predict = round($output["target_pred"]["A"]*100, 2);
          $response['predict'] = $predict;
          $sql = "UPDATE reports SET general_result = $predict WHERE id = $report_id;";
          mysqli_query($conn, $sql);

          $sql = "INSERT INTO images (`id`, `report_id`, `url`) VALUES (NULL, '$report_id', '$file_url');";
          mysqli_query($conn,$sql);
        } catch(Exception $e){
          $response['result']=false;
          $response['message']=$e->getMessage();

          echo json_encode($response);
          mysqli_close($conn);
        }

      }
      $response['result']=true;
      $response['message']="Upload successfully.";

      echo json_encode($response);
      mysqli_close($conn);
    } else {
      $response['result']=false;
      $response['message']='Please choose a file';

      echo json_encode($response);
      mysqli_close($conn);
    }
  }

  function getFileName($conn){
    $sql = "SELECT max(id) as id FROM images";
    $result = mysqli_fetch_array(mysqli_query($conn,$sql));

    if($result['id']==null)
      return 1;
    else
      return ++$result['id'];
  }

  function responseResult($result, $message) {
    $response['result'] = $result;
    $response['message'] = $message;

    echo json_encode($response);
    mysqli_close($conn);
  }
