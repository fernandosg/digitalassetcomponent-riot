<?PHP
  $element_id = $_GET["id"];
  $gallery = ["gallery"=>[
    ["type"=> "image", "id"=> 1, "name"=> "from_server.jpg", "image"=>"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXx2us5DVrluBa7RmQzRN19L7EZThjtwxMxJfTEpdNaj4S1QzX"],
    ["type"=> "image", "id"=> 2, "name"=> "from_server.jpg", "image"=>""],
      ["type"=> "image", "id"=> 1, "name"=> "from_server.jpg", "image"=>"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXx2us5DVrluBa7RmQzRN19L7EZThjtwxMxJfTEpdNaj4S1QzX"],
      ["type"=> "image", "id"=> 2, "name"=> "from_server.jpg", "image"=>""],
        ["type"=> "image", "id"=> 1, "name"=> "from_server.jpg", "image"=>"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXx2us5DVrluBa7RmQzRN19L7EZThjtwxMxJfTEpdNaj4S1QzX"],
        ["type"=> "image", "id"=> 2, "name"=> "from_server.jpg", "image"=>""]
  ]];
  echo json_encode($gallery);
?>
