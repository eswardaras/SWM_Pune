<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="SWM.WebForm2" %>

<%--<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>  --%>
  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
  
<html>  
  <head>  
    <title></title>  
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">  
    <meta charset="utf-8">  
    <style type="text/css">  
      html, body, #canvasMap {  
        height: 100%;  
        margin: 0px;  
        padding: 0px  
      }  
    </style>  
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>  
    <script type="text/javascript">  
        var map;  
        function LoadGoogleMAP() {  
            var SetmapOptions = {  
                zoom: 10,  
                center: new google.maps.LatLng(19.0760, 72.8777)  
            };  
            map = new google.maps.Map(document.getElementById('canvasMap'),  
      SetmapOptions);  
        }  
  
        google.maps.event.addDomListener(window, 'load', LoadGoogleMAP);  
  
    </script>  
  </head>  
  <body>        
    <div id="canvasMap"> </div>  
  </body>  
</html> 