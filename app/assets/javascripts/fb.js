$(document).ready(function() {
    $.ajaxSetup({ cache: true });
    $.getScript('//connect.facebook.net/en_UK/all.js', function(){
        FB.init({
          appId: '462973483793316',
          frictionlessRequests : true,
          channelUrl: '//localhost:3000/channel.html',
        });
      });     
      
      $("li.fb-inv").click(function(){
        uid = $(this).attr('name')
        $(this).fadeOut();
          FB.ui(
            {
             method: 'apprequests',
             message: 'come and see this good app' ,
             to: uid
            },
            function(response) {
              //infrorm server that user has made an invitation
            }
          );
      });

  });
