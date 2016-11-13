var data = { Username:"test", Password:"test" }
$.post( "http://timeless.dynu.com/Authenticate", function( data ) {
  $(".container").html( data );
});
