// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-datepicker
//= require filterrific-jquery
//= require_tree .
$(document).ready(function() {

  var checkbox = document.getElementById('paid');
  var delivery_div = document.getElementById('pay');
  var showHiddenDiv = function(){
     if(checkbox.checked) {
       delivery_div.style['display'] = 'block';
     } else {
       delivery_div.style['display'] = 'none';
     }
  }
  checkbox.onclick = showHiddenDiv;
  showHiddenDiv();


  $('.js-datepicker').datepicker();
   $('#overlayTrigger').click(function(event) {
     event.preventDefault();
     $('body').chardinJs('start');
   });

   close = document.getElementById("close");
   close.addEventListener('click', function() {
     note = document.getElementById("note");
     note.style.display = 'none';
   }, false);

});
