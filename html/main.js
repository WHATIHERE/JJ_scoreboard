// Created By.xZero
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
          // $(".container").css("background-image", "url('https://cdn.discordapp.com/attachments/1008405713695019099/1016774298582667394/gq.png')");
          setTimeout(function(){ 
            // $(".container").css("background-image", "url('https://cdn.discordapp.com/attachments/1008405713695019099/1016774298582667394/gq.png')");
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
        $("#players").html(item.players);
        $("#kanok").html(item.kanok);
        $("#buranaphon").html(item.buranaphon);
        $("#prachachuen").html(item.prachachuen);
        $("#indra").html(item.indra);
      }
    }
  });
});
