// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require bootstrap-sprockets
//= require turbolinks
//= require selectize
//= require_tree .

document.addEventListener("turbolinks:load", function() {
  $("#day").selectize();

  if (navigator.geolocation) {
    $('#search-form').hide();
    var x = document.getElementById("demo");
    navigator.geolocation.getCurrentPosition(function(position){
      document.cookie = "lat=" + position.coords.latitude;
      document.cookie = "lng=" + position.coords.longitude;
      x.innerHTML = "<div class='alert alert-info'>Latitude: " + position.coords.latitude +
            "<br>Longitude: " + position.coords.longitude + "</div>";
      if (!$("#weather-info").length ) {
        location.reload();
      }
    },
    function(failure) {
      if(failure.message.indexOf("User denied Geolocation") == 0) {
        $('#search-form').show();
        document.cookie = "lat=;expires=Thu, 01 Jan 1970 00:00:00 GMT";
        document.cookie = "lng=;expires=Thu, 01 Jan 1970 00:00:00 GMT"; 
      }
    });
  } 
});


