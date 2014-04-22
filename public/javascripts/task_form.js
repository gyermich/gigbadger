var checkbox = document.getElementById('paid');
var delivery_div = document.getElementById('pay');
var showHiddenDiv = function(){
   if(checkbox.checked) {
     delivery_div.style['display'] = 'block';
   } else {
     delivery_div.style['display'] = 'none';
   }
}

$(document).on('click','#paid',function() {
  showHiddenDiv();
});