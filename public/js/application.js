$(document).ready(function () {

  // send an HTTP DELETE request for the sign-out link
  $('a#sign-out').on("click", function (e) {
    e.preventDefault();
    var request = $.ajax({ url: $(this).attr('href'), type: 'delete' });
    request.done(function () { window.location = "/"; });
  });

  var gameURL = window.location.pathname;

  $('#board').on('click', '.cell', function(e) {
    // console.log($(this));
    $.ajax({
      url: gameURL + "/move",
      method: 'post',
      data: {'cell_id': $(this).attr("id")}
    });

  });



var checkStatus = setInterval(function(){ 
  console.log("Im running");  
  $.ajax({ url: gameURL + "/state", method: 'get' }).done(function(values){
  // $.get({ url: gameURL + '/state' }).done(function(values){
    console.log(values);
    var cont = values['continue'];
    var winner = values['winner'];
    var cells = values['cells'];
    var current_turn = ['current_turn'];

    if (cont === true) {

      // update the board
      for (var i = 0; i<9; i++){
        $('.cell:nth-child(' + i + ')').text(cells[i]);
      }


    } else
        // announce winner, lock game, clear interval

        clearInterval(checkStatus);


  });
  }, 1000);
   
});



