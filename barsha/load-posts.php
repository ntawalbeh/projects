<?php
include 'dbh.php';
$commentNewCount = $_POST['commentNewCount'];


$sql = "SELECT * FROM posts ORDER BY newsid DESC LIMIT $commentNewCount";
$sqlLength = "SELECT COUNT(*) FROM posts";
$result = mysqli_query($conn, $sql);
if (mysqli_num_rows($result) == $commentNewCount  ) {

  while ($row = mysqli_fetch_assoc($result) ){
    echo'
    <a style="text-decoration: none" href="'.$row['href'].'">
    <div class="card bg-transparent mb-3 border-bottom">
      <img  style="background-size:  auto;" src="'.$row['imgsrc'].'" class="card-img-top" alt="..." />
     <Div> <span
        style="direction: ltr; color: white;"
        data-livestamp="'.strtotime($row['date']).'"
      ></span></div>
      <div class="card-body bg-transparent">
        <p
          style="direction: rtl; "
          class="card-text text-light text-center pt-1"
        >
          '.$row['headline'].'
        </p>
      </div>
    </div>
  </a>
  '; }

}
else 
{
  while ($row = mysqli_fetch_assoc($result) ){
    echo'

    <a style="text-decoration: none" href="'.$row['href'].'">
    <div class="card bg-transparent mb-3 border-bottom">
      <img src="'.$row['imgsrc'].'" class="card-img-top" alt="..." />
      <span
        style="direction: ltr; color: #edbc00"
        data-livestamp="'.strtotime($row['date']).'"
      ></span>
      <div class="card-body bg-transparent">
        <p
          style="direction: rtl; "
          class="card-text text-warning text-center pt-1"
        >
          '.$row['headline'].'
        </p>
      </div>
    </div>
  </a>
    ';
  }
  echo '

  <div class="alert alert-danger text-center " role="alert">
  لا يوجد المزيد من الاخبار
</div>

  
  '; 
}