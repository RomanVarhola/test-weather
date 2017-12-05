document.addEventListener("turbolinks:load", function() {
  $("#day").selectize();

  if (navigator.geolocation) {
    document.getElementById("search").disabled = true;
    $('#search-form').hide();
    var x = document.getElementById("demo");
    navigator.geolocation.getCurrentPosition(function(position){
      document.cookie = "lat=" + position.coords.latitude;
      document.cookie = "lng=" + position.coords.longitude;
      x.innerHTML = "<div class='alert alert-info'>Latitude: " + position.coords.latitude +
            "<br>Longitude: " + position.coords.longitude + "</div>";
      if (!$("#weather-info").length ) {
        //location.reload();
      }
    },
    function(failure) {
      if(failure.message.indexOf("User denied Geolocation") == 0) {
        document.getElementById("search").disabled = false;
        $('#search-form').show();
        document.cookie = "lat=;expires=Thu, 01 Jan 1970 00:00:00 GMT";
        document.cookie = "lng=;expires=Thu, 01 Jan 1970 00:00:00 GMT"; 
      }
    });
  } 
});