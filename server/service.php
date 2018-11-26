<?PHP
  $element_id = $_GET["id"];
  $gallery = ["gallery"=>[["type"=> "image", "id"=> 2, "name"=> "from_server.jpg"]]];
  echo json_encode($gallery);
?>
