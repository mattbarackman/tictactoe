$(document).ready(function () {

  // send an HTTP DELETE request for the sign-out link
  $('a#sign-out').on("click", function (e) {
    e.preventDefault();
    var request = $.ajax({ url: $(this).attr('href'), type: 'delete' });
    request.done(function () { window.location = "/"; });
  });


  $.get(url: window.location.pathname + '/state').done(function(values){
    for (var i = 0; i<9; i++){
    $('.cell:nth-child(' + i+1 + ')').text(values[i]);
  }

  });
  values = {status:"player1",cells:["X","","","","X","O","","",""]};

  

});



