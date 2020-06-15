---
title: "Places to Visit in India"
author: "Shubham Kumar"
date: "7/27/2019"
output: 
  html_document:
    keep_md: TRUE
---



# Map


```r
library(leaflet)

LatLong1 <- data.frame(
  lat = c(28.612928, 27.175359, 12.305450, 12.302515, 31.620273, 22.545105, 18.940088, 18.922299, 20.591372, 26.912999, 19.887908, 25.155408),
  lng = c(77.229513, 78.042134, 76.655138, 76.664042, 74.876496, 88.342558, 72.835458, 72.834611, 75.696000, 70.912222, 86.094558, 73.587010))

LatLong2 <- data.frame(
        lat = c(26.031506, 33.718659, 29.530275, 23.722808, 21.137764, 26.595470, 22.334821, 26.659423, 21.835949, 20.248745, 21.763192, 22.503698),
        lng = c(76.504797, 77.388351, 78.774725, 81.024208, 70.823313, 93.170612, 80.611481, 91.000959, 88.884244, 79.360571, 79.339145, 78.435679))

PopUp1 <- c("India Gate, Delhi","Taj Mahal","Mysore Palace","Mysuru Zoo","Harmandir Sahib, Amritsar","Victoria Memorial, Kolkata","Chhatrapati Shivaji Terminus, Mumbai", "Gateway of India, Mumbai", "Ajanta Ellora Caves, Aurangabad", "Jaisalmer Fort, Jaisalmer", "Konark Sun Temple, Konark", "Kumbhalgarh Fort, Rajasthan")

PopUp2 <- c("Ranthambore National Park, Rajasthan", "Hemis National Park, Ladakh", "Jim Corbett, Uttarakhand", "Bandhavgarh National Park, Madhya Pradesh", "Sasan-Gir Wildlife Sanctuary, Gujarat", "Kaziranga National Park, Assam", "Kanha National Park, Madhya Pradesh", "Manas Wildlife Sanctuary, Assam", "Sunderbans National Park, West Bengal", "Tadoba National Park, Maharashtra", "Pench National Park, Madhya Pradesh", "Satpura National Park, Madhya Pradesh")

LatLong1[3] <- PopUp1
LatLong2[3] <- PopUp2
LatLong <- rbind(LatLong1, LatLong2)
names(LatLong) <- c("Latitude", "Longitude", "Place")

LatLong %>% 
  leaflet() %>%
  addTiles() %>%
  addCircleMarkers(popup = LatLong$Place, color = "Blue")
```

<!--html_preserve--><div id="htmlwidget-622c785d9ec7f44b80c0" style="width:672px;height:480px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-622c785d9ec7f44b80c0">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">OpenStreetMap<\/a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA<\/a>"}]},{"method":"addCircleMarkers","args":[[28.612928,27.175359,12.30545,12.302515,31.620273,22.545105,18.940088,18.922299,20.591372,26.912999,19.887908,25.155408,26.031506,33.718659,29.530275,23.722808,21.137764,26.59547,22.334821,26.659423,21.835949,20.248745,21.763192,22.503698],[77.229513,78.042134,76.655138,76.664042,74.876496,88.342558,72.835458,72.834611,75.696,70.912222,86.094558,73.58701,76.504797,77.388351,78.774725,81.024208,70.823313,93.170612,80.611481,91.000959,88.884244,79.360571,79.339145,78.435679],10,null,null,{"interactive":true,"className":"","stroke":true,"color":"Blue","weight":5,"opacity":0.5,"fill":true,"fillColor":"Blue","fillOpacity":0.2},null,null,["India Gate, Delhi","Taj Mahal","Mysore Palace","Mysuru Zoo","Harmandir Sahib, Amritsar","Victoria Memorial, Kolkata","Chhatrapati Shivaji Terminus, Mumbai","Gateway of India, Mumbai","Ajanta Ellora Caves, Aurangabad","Jaisalmer Fort, Jaisalmer","Konark Sun Temple, Konark","Kumbhalgarh Fort, Rajasthan","Ranthambore National Park, Rajasthan","Hemis National Park, Ladakh","Jim Corbett, Uttarakhand","Bandhavgarh National Park, Madhya Pradesh","Sasan-Gir Wildlife Sanctuary, Gujarat","Kaziranga National Park, Assam","Kanha National Park, Madhya Pradesh","Manas Wildlife Sanctuary, Assam","Sunderbans National Park, West Bengal","Tadoba National Park, Maharashtra","Pench National Park, Madhya Pradesh","Satpura National Park, Madhya Pradesh"],null,null,{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]}],"limits":{"lat":[12.302515,33.718659],"lng":[70.823313,93.170612]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->
