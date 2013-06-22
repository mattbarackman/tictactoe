$(document).ready(function () {


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
  $.ajax({ url: gameURL + "/state", method: 'get' }).done(function(values){
  // $.get({ url: gameURL + '/state' }).done(function(values){
    console.log(values);
    var cont = values['continue'];
    var winner = values['outcome'];
    var cells = values['cells'];
    var current_turn = ['current_turn'];

    if (cont === true) {

      // update the board
      for (var i = 0; i<9; i++){
        var index = i+1
        $('.cell:nth-child(' + index + ')').text(cells[i]);
      }


    } else {
      for (var i = 0; i<9; i++){
        var index = i+1
        $('.cell:nth-child(' + index + ')').text(cells[i]);
      }

      $('#outcome').text('The winner is: ' + winner);
        // announce winner, lock game, clear interval

        clearInterval(checkStatus);
      }

  });
  }, 1000);
  
   
});

