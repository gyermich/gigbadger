$(document).ready(function(){
    var keys     = [];
    var konami  = '38,38,40,40,37,39,37,39,66,65';
 
   $(document)
           .keydown(
               function(e) {
                   keys.push( e.keyCode );
                   if ( keys.toString().indexOf( konami ) >= 0 ){
                      var src = '//www.youtube.com/embed/4r7wHMg5Yjg';
                              $('#myModal').modal('show');
                              $('#myModal iframe').attr('src', src);
                              

                              $('.close').click(function () {
                                $('#myModal').hide();
                                $('#myModal iframe').attr("src", jQuery("#myModal iframe").attr("src"));
                              }); 
                       keys = [];
                   }
               }
           );
});
