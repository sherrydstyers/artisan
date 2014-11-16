<!doctype html>
<html lang="en">
   <head>
      <meta charset="utf-8"/>
      <title>Artisan WebLCDs</title>
      <script type="text/javascript">
         var ws = new WebSocket("ws://" + location.host.split(":")[0] + ":{{port}}/websocket");
         ws.onopen = function() {
            ws.send("");
         };
         ws.onmessage = function (evt) {
             var data = JSON.parse(evt.data);
             if (data.data) { // { "data" : { "time": <string>, "bt": <string>, "et": <string> }}
                 if (data.data.time) {
                     document.getElementById("time").innerHTML = data.data.time;
                 }
                 if (data.data.et) {
                     if (data.data.et.toString().indexOf(".") > -1) {
                         document.getElementById("et").innerHTML = (("   " + data.data.et).slice(-5)).replace(" ","&nbsp;");
                     } else {
                         document.getElementById("et").innerHTML = (("   " + data.data.et).slice(-3)).replace(" ","&nbsp;");
                     }
                 }
                 if (data.data.bt) {
                     if (data.data.bt.toString().indexOf(".") > -1) {
                         v = (("   " + data.data.bt).slice(-5)).replace(" ","&nbsp;");
                     } else {
                         v = (("   " + data.data.bt).slice(-3)).replace(" ","&nbsp;");
                     }
                     document.getElementById("bt").innerHTML = v;
                     document.getElementById("bt2").innerHTML = v;
                 }
                 $('#artisan').bigtext();
             }
             if (data.alert && data.alert.text) { // { "alert" : { "title": <string>, "text": <string>, "timeout": <int> }}
                 alert(data.alert.text);
             }
         };
      </script>
      <style type='text/css'>
         @font-face {
         font-family: 'alarmclock';
         src: url('alarmclock.eot?#iefix') format('embedded-opentype'),  url('alarmclock.woff') format('woff'), url('alarmclock.ttf')  format('truetype'), url('alarmclock.svg#alarmclock') format('svg');
         font-weight: normal;
         font-style: normal;
         }
         html {
         -webkit-text-size-adjust: none; /* Prevent font scaling in landscape */
         }
         body,html { 
         font-family: 'alarmclock' !important; 
         background-color:#EEEEEE; 
         margin: 0 !important;
         padding: 0 !important;
         width: 100%; 
         height: 100%;
         }
         @media screen and (orientation: landscape) {
         .spacer,.spacel,#hbt {
         display: none;  
         }
         #bt, .space, .tspace {
         display: inline;  
         }
         }
         @media screen and (orientation: portrait)  {
         .space, #bt, .spacel {
         display: none;  
         }
         #hbt, .spacer, .tspace {
         display: inline;  
         }
         }
         @media only screen and (orientation: portrait) and (min-device-width : 768px) and (max-device-width : 1024px) {
         .space, #et, .spacer {
         display: none;
         }
         #hbt, .spacel, .tspace {
         display: inline;  
         }
         }
         #time {
         color: {{timecolor}};
         background: {{timebackground}};
         }
         #bt,#bt2 {
         color: {{btcolor}};
         background: {{btbackground}};
         }
         #et {
         color: {{etcolor}};
         background: {{etbackground}};
         }
         #showbt,#showhbt {
            display: {{showbt}};
         }
         #showet {
            display: {{showet}};
         }
      </style>
   </head>
   <body>
      <div id="artisan" style="width:100%;">
         <div>&nbsp;<span class="tspace">&nbsp;</span><span id="time">00:00</span><span class="tspace">&nbsp;</span>&nbsp;</div>
         <div><span id="showet"><span class="spacel">&nbsp;</span><span class="spacer">&thinsp;</span><span id="et">{{!nonesymbol}}</span><span class="spacel">&nbsp;</span><span class="spacer">&thinsp;</span></span><span id="showbt"><span class="space">&thinsp;</span><span id="bt">{{!nonesymbol}}</span></span></div>
         <div id="hbt"><span id="showhbt"><span class="spacel">&nbsp;</span><span class="spacer">&thinsp;</span><span id="bt2">{{!nonesymbol}}</span><span class="spacel">&nbsp;</span><span class="spacer">&thinsp;</span></span></div>
      </div>
      <script src="jquery-1.11.1.min.js"></script>
      <script src="bigtext.js"></script>
      <script>
         $(document).ready(function() {
             $(window).load(function() {
                 $('#artisan').bigtext();
                 });
         });
      </script>
   </body>
</html>