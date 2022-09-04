
var audio = new Audio()
$(function() {
  window.addEventListener("message", function(event) {
    var item = event.data;

    if (item !== undefined) {
      if (item.type == "ui") {
        if (item.display == true) {
          $(".box-onlinePlayers").hide();
          $(".box-playerId").hide();
          $("#body").show();
          $(".container").css("background-image", "url('https://cdn.discordapp.com/attachments/966674003127324703/969136116382978088/scoreboardCopy.png')");
          setTimeout(function(){ 
            $(".container").css("background-image", "url('https://cdn.discordapp.com/attachments/966674003127324703/969136116382978088/scoreboardCopy.png')");
            $(".box-onlinePlayers").show(); 
            $(".box-playerId").show();
          }, 0);
        } else {
          $("#body").hide();
          audio.pause();
        }
      } else if (item.type == "update") {
        $("#my_id").html(item.my_id);
        $("#my_phonenumber").html(item.my_phonenmumber);
        $("#my_fullname").html(item.my_fullname);
        $("#my_job").html(item.my_job);
        $("#my_ping").html(item.my_ping + "ms");

        $("#players").html(item.players);
        $("#blue").html(item.blue);
        $("#churn").html(item.churn);
        $("#kanok").html(item.kanok);
        $("#indra").html(item.indra);
      }
    }
  });
});
