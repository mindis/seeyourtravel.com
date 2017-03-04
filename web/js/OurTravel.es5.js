﻿//#region Variables
'use strict';

var tracksFolder = 'tracks/';
//        var url = 'http://{s}.tile.cloudmade.com/5bcd2fc5d5714bd48096c7478324e0fe/997/256/{z}/{x}/{y}.png';
//        var url = 'https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6IjZjNmRjNzk3ZmE2MTcwOTEwMGY0MzU3YjUzOWFmNWZhIn0.Y8bhBaUMqFiPrDRW9hieoQ';     
var mapTileUrl = 'https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1Ijoib2x0dXJ1YSIsImEiOiJlODQ4ZTI2MWI4OGZkZjUyNDRiNjY4MDFkZGI0ODc4NyJ9.iiCb_tZgs_ipvEv3s6Zx0A';
//var panoramioUrl = "https://ssl.panoramio.com/map/get_panoramas.php?set=";
var flickrUrl = "https://api.flickr.com/services/rest/?method=flickr.photos.search&bbox={0}%2C{1}%2C{2}%2C{3}&per_page={4}&format=json&nojsoncallback=1&api_key=2203a1e292f7b65958730b236c0756fa";
var MAX_GOOGLE_PLACES = 10;
var MAX_HERE_PLACES = 50;
var MAX_GOOGLE_RADIUS = 10000;
var GOOGLE_TYPES = ['lodging', 'restaurant', 'museum', 'park', 'bakery', 'zoo'];
var sidePanelWidth = 200;
var cacheImages = false;
var updateIntervalSeconds = 5;

var scrollerEnabled = false;
var scroller;
var scrollerContent;
var curX;
var fullW;
var viewportW;

var versionUrl = "services/get_version.aspx";

var iconWhereIAm = L.icon({
    iconUrl: "img/youarehere.png",
    iconSize: [30, 50],
    iconAnchor: [15, 50]
});

//shadowUrl: null
var iconFriend = L.icon({
    iconUrl: "img/friendlocation.png",
    iconSize: [30, 30],
    iconAnchor: [15, 30]
});
//#endregion

//shadowUrl: null
function showDialog(id) {
    if (facebookAPIIsLoaded) {
        $('#' + id).dialog({
            //            dialogClass: "no-close",
            width: 550,
            minHeight: 400,
            maxHeight: 600
            //,buttons: [
            //  {
            //      text: "OK",
            //      click: function () {
            //          $(this).dialog("close");
            //      }
            //  }
            //]
        });
    } else {
            toastr.warning("Please wait, Facebook code is not loaded yet", "", { timeOut: 1000, extendedTimeOut: 2000 });
        }
}

// #region Utils
function pointToLatLng(point) {
    var result;
    if (point.hasOwnProperty("lat")) {
        result = new L.LatLng(point.lat, point.lng);
        if (point.hasOwnProperty("syt_text")) {
            result["syt_text"] = point["syt_text"];
        }
        if (point.hasOwnProperty("syt_audio")) {
            result["syt_audio"] = point["syt_audio"];
        }
        return result;
    } else {
        var lat = point[0];
        var lng = point[1];
        result = new L.LatLng(lat, lng);
        if (point.length > 2) {
            result["syt_text"] = point[2];
            if (point.length > 3) {
                result["syt_audio"] = point[3];
            }
        }
        return result;
    }
}

function translateTracksPath(path) {
    return tracksFolder + path;
}

function translateTracksContentPath(path) {
    return tracksFolder + "content/" + path;
}
//#endregion

//#region Handlers
function clickHelp() {
    $("#menuPanel").hide('slide', 500);
    $('#helpPanel').show('slide', { direction: "right" }, 500);
}
function clickSettings() {
    $("#menuPanel").hide('slide', 500);
    $('#settingsPanel').show('slide', { direction: "up" }, 500);
}
function clickMenu() {
    $("#helpPanel").hide('slide', { direction: "right" }, 500);
    $('#settingsPanel').hide('slide', { direction: "up" }, 500);
    $('#menuPanel').toggle('slide', 500);
}

function onBodyResize() {
    if ($("#map").length) {
        $("#map").height(window.innerHeight);
    }
    if ($("#menuPanel").length) {
        $("#menuPanel").height(window.innerHeight - 100);
    }
    if ($(".viewport").length) {
        $(".viewport").height(window.innerHeight - 150);
    }

    if (typeof switchSidePanel != "undefined") {
        if (window.innerWidth < 800 && showSidePanel != "no") {
            switchSidePanel(false);
        } else {
            switchSidePanel(true);
        }
    }
}

//#endregion

function showLocation() {
    if (navigator.geolocation) {
        var options = {
            enableHighAccuracy: true,
            timeout: 30000,
            maximumAge: 300000
        };
        navigator.geolocation.getCurrentPosition(showPosition, errorPosition, options);
        setTimeout(arguments.callee, 300000);
    } else {
        //x.innerHTML = "Geolocation is not supported by this browser.";
    }
}
function errorPosition(err) {
    console.warn('Cannot get position(' + err.code + '): ' + err.message);
};
function showPosition(position) {
    if ($("#map").length) {
        //x.innerHTML = "Latitude: " + position.coords.latitude +
        //"<br>Longitude: " + position.coords.longitude;
        var newLatLng = new L.LatLng(position.coords.latitude, position.coords.longitude);
        //crd.accuracy
        markerWhereIAm.setLatLng(newLatLng);
        //        markerWhereIAmCircle.setLatLng(newLatLng);
        //        markerWhereIAmCircle.setRadius(position.coord.accuracy);

        if (typeof track == "undefined") map.setView(newLatLng, 8);

        var urlp = "services/user_locations.aspx?action=senduserlocation&userId=" + globalUserId + "&lat=" + position.coords.latitude.toString() + "&lng=" + position.coords.longitude.toString();
        $.ajax({
            dataType: "jsonp",
            url: urlp,
            success: function success(data) {},
            error: function error(XMLHttpRequest, textStatus, errorThrown) {
                console.log("senduserlocation error status: " + textStatus);console.log("Error: " + errorThrown);
            }
        });

        var urlp = "services/user_locations.aspx?action=getfriendslocations&userId=" + globalUserId;

        markersFriends.clearLayers();

        $.ajax({
            dataType: "jsonp",
            url: urlp,
            success: function success(data) {
                for (var i in data) {
                    var markerFriend = L.marker(new L.LatLng(data[i].lat - 0.0002 + Math.random() * 0.0004, data[i].lng - 0.0002 + Math.random() * 0.0004), { icon: iconFriend }).bindPopup(data[i].userName.concat(", ", data[i].time));
                    markersFriends.addLayer(markerFriend);
                }
            },
            error: function error(XMLHttpRequest, textStatus, errorThrown) {
                console.log("getfriendslocations error status: " + textStatus);console.log("Error: " + errorThrown);
            }
        });
    }
}

function SaveSettings() {
    $.cookie("settings_scriptTextCheckBox", $("#scriptTextCheckBox").is(':checked'));
    $.cookie("settings_imagesCheckBox", $("#imagesCheckBox").is(':checked'));
    $.cookie("settings_loopTrackCheckBox", $("#loopTrackCheckBox").is(':checked'));
    $.cookie("settings_usePanoramioImagesCheckBox", $("#usePanoramioImagesCheckBox").is(':checked'));
    $.cookie("settings_useSYTImagesCheckBox", $("#useSYTImagesCheckBox").is(':checked'));
    $.cookie("settings_useGooglePlacesCheckBox", $("#useGooglePlacesCheckBox").is(':checked'));
    $.cookie("settings_useSYTPlacesCheckBox", $("#useSYTPlacesCheckBox").is(':checked'));

    $.cookie("settings_mapStyle", $('#mapStyle option:selected').val());
    $.cookie("settings_volume", $('#slider').slider("value"));
    $.cookie("settings_mute", audio.muted);
};

function LoadSettings() {
    if (typeof $.cookie("settings_scriptTextCheckBox") != "undefined") {
        var a = $.cookie("settings_scriptTextCheckBox") == "true";
        var b = $.cookie("settings_imagesCheckBox") == "true";
        var c = $.cookie("settings_mute") == "true";
        var d = $.cookie("settings_loopTrackCheckBox") == "true";
        $("#scriptTextCheckBox").prop("checked", a);
        $("#imagesCheckBox").prop("checked", b);
        $("#loopTrackCheckBox").prop("checked", d);
        $("#usePanoramioImagesCheckBox").prop("checked", $.cookie("settings_usePanoramioImagesCheckBox") == "true");
        $("#useSYTImagesCheckBox").prop("checked", $.cookie("settings_useSYTImagesCheckBox") == "true");
        $("#useGooglePlacesCheckBox").prop("checked", $.cookie("settings_useGooglePlacesCheckBox") == "true");
        $("#useSYTPlacesCheckBox").prop("checked", $.cookie("settings_useSYTPlacesCheckBox") == "true");

        if (a) $('#textToReadArea0').toggle('fold', 1000);
        if (!b) $('#imageDiv0').toggle('fold', 1000);
        if (c) clickMute();
    }
    if (typeof $.cookie("settings_mapStyle") != "undefined") {
        $('#mapStyle').val($.cookie("settings_mapStyle"));
        selectMapStyle();
    }
    if (typeof $.cookie("settings_volume") != "undefined") {
        $('#slider').slider("value", $.cookie("settings_volume"));
    }
};

function clickMute() {
    if (audio.muted) {
        audio.muted = false;
        $('#mute').css('background-image', 'url(img/unmute.png )');
    } else {
        audio.muted = true;
        $('#mute').css('background-image', 'url(img/mute.png )');
    }
}

var isTrackLoaded = false;
var iOS = /iPad|iPhone|iPod/.test(navigator.userAgent) && !window.MSStream;
var isTrackPaused = !iOS;

function doStartStop() {
    if (isTrackLoaded) {
        $('#continuePauseButton').removeAttr('disabled');
        if (isTrackPaused) {
            isTrackPaused = !isTrackPaused;
            if (typeof animatedMarker != "undefined") animatedMarker.startagain();
            if (track.audioSrc && track.audioSrc.length > 0) audio.play();
            scrollerEnabled = true;

            $('#continuePauseButton').css('background-image', 'url(img/pause.png )');
            if ($("#showGoesOn").length > 0) $("#showGoesOn").val("1");
        } else {
            isTrackPaused = !isTrackPaused;
            if (typeof animatedMarker != "undefined") animatedMarker.stop();
            audio.pause();
            scrollerEnabled = false;

            $('#continuePauseButton').css('background-image', 'url(img/play.png )');
            if ($("#showGoesOn").length > 0) $("#showGoesOn").val("0");
        }
    } else {
        $('#continuePauseButton').attr('disabled', 'disabled');
    }
}

function showPhotos(track, p, tolerancy) {
    if (!tolerancy) tolerancy = track.photoLocationTolerancy / 1000;
    if (!tolerancy) tolerancy = 0.1;

    if ($('#usePanoramioImagesCheckBox').is(':checked') && track.usePanoramioImages != "No") {
        //var set = "7459025";//"full";//"public";
        //var set = "full";
        var count = 0;

        var divHeight = $("#imageDiv").height();
        var size = divHeight > 150 ? "medium" : "small";
        //var urlp = panoramioUrl + set + "&from=0&to=" + track.numOfPhotos.toString() + "&miny="
        //    + (p.lat - tolerancy).toString()
        //    + "&minx=" + (p.lng - tolerancy).toString()
        //    + "&maxy=" + (p.lat + tolerancy).toString()
        //    + "&maxx=" + (p.lng + tolerancy).toString()
        //    + "&size=" + size + "&mapfilter=true&order=popularity&callback=?";

        //var flickrUrl =  "https://api.flickr.com/services/rest/?method=flickr.photos.search&bbox={0}%2C{1}%2C{2}%2C{3}&per_page={4}&format=json&nojsoncallback=1&api_key=2203a1e292f7b65958730b236c0756fa";

        var urlp = flickrUrl.replace("{4}", "50") //track.numOfPhotos.toString())
        .replace("{0}", (p.lng - tolerancy).toString()).replace("{1}", (p.lat - tolerancy).toString()).replace("{2}", (p.lng + tolerancy).toString()).replace("{3}", (p.lat + tolerancy).toString());

        $.ajax({
            dataType: "json",
            url: urlp,
            success: function success(data) {
                var result = { photos: [] };

                for (var i = 0; i < data.photos.photo.length; i++) {
                    var photoName = "https://farm{0}.staticflickr.com/{1}/{2}_{3}".replace("{0}", data.photos.photo[i].farm).replace("{1}", data.photos.photo[i].server).replace("{2}", data.photos.photo[i].id).replace("{3}", data.photos.photo[i].secret);
                    var photoUrlSmall = photoName + "_q.jpg";
                    var photoUrlLarge = photoName + ".jpg";

                    var resultPhoto = {
                        height: 150,
                        width: 150,
                        photo_file_url: photoUrlSmall,
                        photo_url: photoUrlLarge,
                        photo_title: data.photos.photo[i].title,
                        owner_name: data.photos.photo[i].owner
                    };
                    result.photos.push(resultPhoto);
                }

                //console.log("Panoramio success");
                get_panoramas_panoramio_success(result, p, tolerancy);
            },
            error: function error(XMLHttpRequest, textStatus, errorThrown) {
                console.log("Panoramio status: " + textStatus);console.log("Error: " + errorThrown);

                var data = { photos: [] };
                get_panoramas_panoramio_success(data, p, tolerancy);
            }
        });
    } else {
        var data = { photos: [] };
        get_panoramas_panoramio_success(data, p, tolerancy);
    }
}

function get_panoramas_panoramio_success(data, p, tolerancy) {

    //var urlp = "http://localhost/seeyourtravel/services/get_panoramas.aspx?x=x&set=full&from=0&to=10&miny=47.955776&minx=10.096568999999999&maxy=48.055775999999994&maxx=10.196569&size=medium&mapfilter=true&order=popularity";

    if ($('#useSYTImagesCheckBox').is(':checked') && track.useSYTImages != "No") {
        //var set = "7459025";//"full";//"public";
        var set = "full";
        var count = 0;

        var divHeight = $("#imageDiv").height();
        var size = divHeight > 150 ? "medium" : "small";
        var urlp = "services/get_panoramas.aspx?set=" + set + "&from=0&to=" + track.numOfPhotos.toString() + "&miny=" + (p.lat - tolerancy).toString() + "&minx=" + (p.lng - tolerancy).toString() + "&maxy=" + (p.lat + tolerancy).toString() + "&maxx=" + (p.lng + tolerancy).toString() + "&size=" + size + "&mapfilter=true&order=popularity&callback=?";

        $.ajax({
            dataType: "jsonp",
            url: urlp,
            success: function success(data2) {
                get_panoramas_seeyourtravel_success(data, data2, p, tolerancy);
            },
            error: function error(XMLHttpRequest, textStatus, errorThrown) {
                console.log("Status: " + textStatus);console.log("Error: " + errorThrown);

                var data2 = { photos: [] };
                get_panoramas_seeyourtravel_success(data, data2, tolerancy);
            }
        });
    } else {
        var data2 = { photos: [] };
        get_panoramas_seeyourtravel_success(data, data2, tolerancy);
    }
}

function isPortrait() {
    var w = window.innerWidth;
    var h = window.innerHeight;
    return w < h;
}

function get_panoramas_seeyourtravel_success(data, data2, p, tolerancy) {

    // remove?
    var divHeight = $("#imageDiv").height();
    var divWidth = $("#imageDiv").width();

    var photos = data2.photos.concat(data.photos);
    shuffle(photos);
    count = photos.length;
    $("#lblCoord").text(p.lat + " " + p.lng);
    var imageUl = imageDiv.children();
    imageUl.fadeOut(100);
    imageUl.empty();
    for (var i = 0; i < photos.length; i++) {
        var nextLi = document.createElement("li");
        var nextLink = document.createElement("a");
        var nextImage = document.createElement("img");
        nextLink.href = photos[i].photo_url;
        nextLink.target = "_blank";

        //var n = getNatural(nextImage);

        nextImage.width = photos[i].width * divHeight / photos[i].height;
        nextImage.height = divHeight;

        //if (isPortrait()) {
        //    nextImage.height = photos[i].height * ((divWidth + 0.0) / photos[i].width);
        //    nextImage.width = divWidth;
        //}
        //else {
        //    nextImage.width = photos[i].width * ((divHeight + 0.0) / photos[i].height);
        //    nextImage.height = divHeight;
        //}
        if (cacheImages == true) {
            getFromCacheOrServer(photos[i].photo_file_url, nextImage, function (obj, data) {
                obj.src = data;
            });
        } else {
            nextImage.src = photos[i].photo_file_url;
        }

        //nextImage.style.maxHeight = $("#pictureMaxHeight").val() + "px";
        //TODO: translate
        var template = $.t("Photo from {0} by {1}. Click to open the source.");
        nextImage.title = template.format([photos[i].photo_title, photos[i].owner_name]);
        //nextImage.title = "Photo from: " + photos[i].photo_title + " by " + photos[i].owner_name + ". Click to open the source.";
        nextImage.classList.add("photo");
        nextLink.appendChild(nextImage);
        nextLi.appendChild(nextLink);

        imageUl[0].appendChild(nextLi);
    }

    curX = 0;
    scrollerContent.children().clone().appendTo(scrollerContent);
    scrollerContent.children().each(function () {
        var $this = $(this);
        $this.css('left', curX);
        var img = $this.children().children()[0];
        curX += img.width; //$this.outerWidth(true);
    });
    fullW = curX / 2;
    viewportW = scroller.width();
    imageUl.fadeIn(100);
}

function GPXtoLatLng(urlGPX) {
    var result = "";
    if (window.XMLHttpRequest) {
        // code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    } else {
        // code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.open("GET", urlGPX + "?" + Math.random(), false);
    xmlhttp.send();
    xmlDoc = xmlhttp.responseXML;

    var nodes = xmlDoc.getElementsByTagName("trkpt");
    for (var i = 0; i < nodes.length; i++) {
        if (result.length > 0) result += ",";
        result += "[" + nodes[i].getAttribute("lat").toString() + "," + nodes[i].getAttribute("lon").toString() + "]";
    }
    result = "[" + result + "]";
    return result;
}

function selectMapStyle() {
    var id = $('#mapStyle option:selected').val();

    map.removeLayer(tileLayer);
    tileLayer = L.tileLayer(mapTileUrl, {
        attribution: 'SeeYourTravel.com &copy; Map data &copy; <a href="https://www.mapbox.com/">MapBox</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a> <img src="img/poweredbygoolge/desktop/powered-by-google-on-white.png"/>',
        maxZoom: 18,
        id: id
    });
    tileLayer.addTo(map);
}
function fixTrackData(track) {
    var newTrackData = [];
    var totalDistance = 0.0;
    for (var i = 0; i < track.trackData.length; i++) {
        var told = track.trackData[i];
        var tnew = pointToLatLng(told);
        newTrackData.push(tnew);
        if (i > 0) {
            totalDistance = totalDistance + newTrackData[i].distanceTo(newTrackData[i - 1]);
        }
    }
    track.trackData = newTrackData;
    track.avgDistM = totalDistance / (i - 1);
}

function loadTrack(path, handler) {
    var url = path + "?" + Math.random();
    $.ajax({
        url: url,
        //async: false,
        dataType: 'json',
        error: function error(XMLHttpRequest, textStatus, errorThrown) {
            console.log("loadTrack error: " + textStatus);console.log("Error: " + errorThrown);
        },
        success: function success(data) {
            var tempTrack = data;
            if (tempTrack.trackGpx) {
                tempTrack.trackData = $.parseJSON(GPXtoLatLng(translateTracksContentPath(tempTrack.trackGpx)));
            }

            fixTrackData(tempTrack);

            if ($("#textToReadArea").length > 0) {
                if (!isNullOrEmpty(tempTrack.textToRead)) {
                    textToReadArea.innerHTML = $.ajax({
                        url: translateTracksContentPath(tempTrack.textToRead + "?" + Math.random()),
                        async: false
                    }).responseText;
                    // COMMENTED THE AUTOREADING
                    //get_id('textToReadArea', 'en', 'ml');
                } else {
                        textToReadArea.innerHTML = "";
                    }
            }

            handler(tempTrack);
        }
    });
}

//function clearMap(m) {
//    for (i in m._layers) {
////        if (m._layers[i]._path != undefined) {
//            try {
//                m.removeLayer(m._layers[i]);
//            }
//            catch (e) {
//                console.log("problem with " + e + m._layers[i]);
//            }
////        }
//    }
//}

function init(filename, handler) {

    if (typeof map != "undefined") {
        //var mapNode = document.getElementById("map");
        //var mapContainerParent = mapNode.parentNode;
        //mapContainerParent.removeChild(mapNode);

        //mapNode = document.createElement('div');
        //mapNode.id = "map";
        //mapNode.style.zIndex = 10;
        //mapContainerParent.appendChild(mapNode);
        //map.removeLayer(tileLayer);
        markers.clearLayers();
        map.removeLayer(markers);
        //clearMap(map);
        //map = null;
    } else {
            map = L.map('map', { zoomControl: false });
            tileLayer = L.tileLayer(mapTileUrl, {
                attribution: 'SeeYourTravel.com &copy; Map data &copy; <a target-"_blank" href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a target-"_blank" href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a target-"_blank" href="http://flickr.com">Flickr</a> <img src="img/poweredbygoolge/desktop/powered-by-google-on-white.png"/>',
                maxZoom: 20,
                id: "mapbox.streets"
            });
            tileLayer.addTo(map);
            L.control.scale({ position: 'bottomleft' }).addTo(map);
            L.control.zoom({ position: 'topright' }).addTo(map);

            //Routing example
            //L.Routing.control({
            //    waypoints: [
            //      L.latLng(50.45, 30.52),
            //      L.latLng(50.56, 30.31)
            //    ]
            //}).addTo(map);
        }

    markers = new L.FeatureGroup();
    map.addLayer(markers);
    if (typeof markersFriends == "undefined") {
        markersFriends = new L.FeatureGroup();
        markers.addLayer(markersFriends);
    }
    if (typeof markersTracks == "undefined") {
        markersTracks = new L.FeatureGroup();
        markers.addLayer(markersTracks);
    }

    markerWhereIAm = L.marker(new L.LatLng(1000, 1000), { icon: iconWhereIAm, zIndexOffset: 100 }).bindPopup(globalUserName);
    markers.addLayer(markerWhereIAm);

    //markerWhereIAmCircle = L.circleMarker(new L.LatLng(1000, 1000),
    //    {
    //        radius: 50,
    //        fillColor: "#ff7800",
    //        color: "#000",
    //        weight: 1,
    //        opacity: 1,
    //        fillOpacity: 0.8,
    //        title: "test"
    //    });
    //markers.addLayer(markerWhereIAmCircle);

    showLocation();

    if (!filename) {} else {
        var path = translateTracksPath(filename + ".js");
        loadTrack(path, function (tempTrack) {

            track = tempTrack;

            var myIcon = L.icon({
                iconUrl: translateTracksContentPath(track.icon),
                iconSize: [markerSize, markerSize],
                iconAnchor: [1, markerSize],
                shadowUrl: null
            });

            var lastUpdateTime = new Date(2000, 2);

            var amOptions = {
                distance: track.velocityMetersPerSec, // meters
                interval: 1000, // milliseconds
                icon: myIcon, // icon
                autoStart: false,
                onEnd: function onEnd() {
                    if ($("#loopTrackCheckBox").is(':checked')) {
                        animatedMarker.start();
                    }
                },
                onStep: function onStep(p) {
                    counter++;
                    if (p.hasOwnProperty("syt_text") && p["syt_text"] != "") {
                        toastr.info(p["syt_text"], "", { timeOut: 5000, extendedTimeOut: 10000 });
                        //prependToSidePanel(p["syt_text"]);
                    }

                    if (p.hasOwnProperty("syt_audio")) {
                        audio.src = translateTracksContentPath(p["syt_audio"]);
                        audio.play();
                    }
                    //markerSize = 2 + map.getZoom() * 5;

                    var currentDate = new Date();
                    if ((currentDate.getTime() - lastUpdateTime.getTime()) / 1000 > updateIntervalSeconds) {

                        map.setView([p.lat, p.lng], map.getZoom());
                        showPhotos(track, p);
                        //                    animatedMarker.bindPopup("".concat(p.lat, ",", p.lng)).openPopup();

                        lastUpdateTime = currentDate;
                    }
                }
            };

            for (var i = 0; i < track.trackData.length; i++) {
                var point = track.trackData[i];
                if (point.hasOwnProperty("syt_text") && point["syt_text"] != "") {

                    var icon = L.icon({
                        iconUrl: "img/info.png",
                        //    shadowUrl: 'leaf-shadow.png',

                        iconSize: [25, 25], // size of the icon
                        //    shadowSize:   [50, 64], // size of the shadow
                        iconAnchor: [13, 25] // point of the icon which will correspond to marker's location
                        //    shadowAnchor: [4, 62],  // the same for the shadow
                        //    popupAnchor:  [0, 0] // point from which the popup should open relative to the iconAnchor
                    });

                    var text = point["syt_text"].toString();
                    var domelem = document.createElement('a');
                    //domelem.href = place.name;
                    domelem.innerHTML = "<p>" + text + "</p>"; //<img height='100px' width='100px' src='" + (isGoogle ? photos[0].getUrl({ 'maxWidth': 100, 'maxHeight': 100 }) : photos[0].raw_reference.fife_url) + "'/>";
                    domelem.alt = text;
                    //domelem.onclick = function () {
                    //    window.open("https://www.google.com.ua/search?q=" + place.name, "_blank");
                    //};
                    var marker = L.marker(new L.LatLng(point.lat, point.lng), { icon: icon }).bindPopup(domelem);
                    markers.addLayer(marker);
                    //    myMarkers.push(marker);
                }
            }
            animatedMarker = L.animatedMarker(track.trackData, amOptions);
            animatedMarker.setIcon(myIcon);
            markers.addLayer(animatedMarker);

            line = L.polyline(track.trackData, { color: 'green' });
            markers.addLayer(line);

            markerStart = L.marker(track.trackData[0]).bindPopup("Start"); //TODO
            markers.addLayer(markerStart);

            markerFinish = L.marker(track.trackData[track.trackData.length - 1]).bindPopup("Finish"); //TODO
            markers.addLayer(markerFinish);

            map.setView(track.trackData[0], track.defaultScale ? track.defaultScale : 8);

            if (track.audioSrc && track.audioSrc.length > 0) {
                audio.src = translateTracksContentPath(track.audioSrc);
                if (track.audioVolume) {
                    audio.volume = track.audioVolume ? track.audioVolume : 0.8;
                    $("#slider").slider("value", audio.volume);
                }
            }

            addMarkersNearAll(track.trackData, GOOGLE_TYPES);
            isTrackLoaded = true;

            if (handler) {
                handler();
            }
        });
    }
}

var myMarkers = [];

//Google places search
function addMarkersNearAll(allData, types) {

    var i;

    for (i = 0; i < myMarkers.length; i++) {
        var marker = myMarkers[i];
        map.removeLayer(marker);
    }
    myMarkers = [];
    allMarkers = [];

    var pieces = 3;

    for (var i = 0; i < pieces; i++) {
        var from = Math.round(allData.length * i / 3);
        var to = Math.round(allData.length * (i + 1) / 3);
        var step = Math.round(allData.length / (10 * pieces));
        if (step == 0) step = 1;
        doSetTimeout(allData, types, from, to, step, i);
    }
}

function doSetTimeout(allData, types, from, to, step, i) {
    setTimeout(function () {
        addMarkersNearRange(allData, types, from, to, step, i % 2 == 1);
    }, i * 5000 + 1);
}

function addMarkersNearRange(allData, types, from1, to1, step1, odd) {
    for (i = from1; i < to1; i += step1) {
        var x = allData[i];
        addMarkersNear(x.lat, x.lng, types, odd);
    }
}

function addMarkersNear(nearLat, nearLng, types, odd) {
    var here = new google.maps.LatLng(nearLat, nearLng);

    var request = {
        location: here,
        radius: MAX_GOOGLE_RADIUS,
        types: types
    };

    //if (odd) {
    //    $.ajax({
    //        dataType: "jsonp",
    //        url: "http://places.cit.api.here.com/places/v1/discover/explore?app_code=uEO7B5HdlYKIGSKmelLEtw&app_id=qiqSlXY6ilurDyZnKplJ&at=50.430837,30.539654&cat=accommodation, eat-drink&pretty=true&tf=html",
    //        success: function (data2) {
    //            console.log(data2);
    //            callbackHerePlacesSearch(data2);
    //        },
    //        error: function (XMLHttpRequest, textStatus, errorThrown) {
    //            console.log("Status: " + textStatus); console.log("Error: " + errorThrown);
    //            get_places_googlehere_success([]);
    //        }
    //    });
    //}
    //else {
    if ($('#useGooglePlacesCheckBox').is(':checked') && track.useGooglePlaces != "No") {

        var service = new google.maps.places.PlacesService(map2);

        service.nearbySearch(request, callbackGoodlePlacesSearch);
    } else {
        get_places_googlehere_success([]);
    }
    //    }
}

function callbackGoodlePlacesSearch(results, status) {
    //console.log("Google Places result: " + status);
    if (status == google.maps.places.PlacesServiceStatus.OK) {
        if (results.length > MAX_GOOGLE_PLACES) results = results.slice(0, MAX_GOOGLE_PLACES);
        get_places_googlehere_success(results);
    } else {
        get_places_googlehere_success([]);
    }
}

function callbackHerePlacesSearch(results) {
    if (results.length > MAX_HERE_PLACES) results = results.slice(0, MAX_HERE_PLACES);
    get_places_googlehere_success(results);
}

function get_places_googlehere_success(data) {

    if ($('#useSYTPlacesCheckBox').is(':checked') && track.useSYTPlaces != "No") {
        var urlp = "services/get_places.aspx?callback=?";

        $.ajax({
            dataType: "jsonp",
            url: urlp,
            success: function success(data2) {
                //console.log("get_places success");
                get_SYT_getplaces_success(data, data2.results);
            },
            error: function error(XMLHttpRequest, textStatus, errorThrown) {
                if (errorThrown.toString().indexOf("not called") == -1) {
                    console.log("get_places error status: " + textStatus + ", error: " + errorThrown);
                } else {
                    //console.log("get_places success");
                    get_SYT_getplaces_success(data, []);
                }
            }
        });
    } else {
        get_SYT_getplaces_success(data, []);
    }
}

function get_SYT_getplaces_success(data, data2) {

    var i;

    for (i = 0; i < Math.min(data.length, 100); i++) {
        createPhotoMarker(data[i], true);
    }

    for (i = 0; i < Math.min(data2.length, 100); i++) {
        createPhotoMarker(data2[i], false);
    }
}

function shuffle(array) {
    var currentIndex = array.length,
        temporaryValue,
        randomIndex;

    // While there remain elements to shuffle...
    while (0 !== currentIndex) {

        // Pick a remaining element...
        randomIndex = Math.floor(Math.random() * currentIndex);
        currentIndex -= 1;

        // And swap it with the current element.
        temporaryValue = array[currentIndex];
        array[currentIndex] = array[randomIndex];
        array[randomIndex] = temporaryValue;
    }

    return array;
}

function createPhotoMarker(place, isGoogle) {

    if (allMarkers.indexOf(place.id) < 0) allMarkers.push(place.id);else return;

    // console.log (place);

    var photos = place.photos;
    if (!photos) {
        return;
    }

    var icon = L.icon({
        iconUrl: place.types.indexOf("lodging") >= 0 ? "img/lodging.png" : place.types.indexOf("restaurant") >= 0 ? "img/restaurant1.png" : place.types.indexOf("museum") >= 0 ? "img/museum.png" : place.types.indexOf("park") >= 0 ? "img/park.png" : place.types.indexOf("bakery") >= 0 ? "img/bakery.png" : place.types.indexOf("zoo") >= 0 ? "img/zoo.png" : "img/something.png",
        //    shadowUrl: 'leaf-shadow.png',

        iconSize: [26, 35] // size of the icon
        //    shadowSize:   [50, 64], // size of the shadow
        //    iconAnchor:   [0, 0], // point of the icon which will correspond to marker's location
        //    shadowAnchor: [4, 62],  // the same for the shadow
        //    popupAnchor:  [0, 0] // point from which the popup should open relative to the iconAnchor
    });

    var domelem = document.createElement('a');
    //domelem.href = place.name;
    domelem.innerHTML = "<p>" + place.name + "</p><img height='100px' width='100px' src='" + (isGoogle ? photos[0].getUrl({ 'maxWidth': 100, 'maxHeight': 100 }) : photos[0].raw_reference.fife_url) + "'/>";
    domelem.alt = place.name;
    domelem.onclick = function () {
        window.open("https://www.google.com.ua/search?q=" + place.name, "_blank");
        // do whatever else you want to do - open accordion etc
    };
    var marker = L.marker(new L.LatLng(isGoogle ? place.geometry.location.lat() : place.geometry.location.lat, isGoogle ? place.geometry.location.lng() : place.geometry.location.lng), { icon: icon }).bindPopup(domelem);
    myMarkers.push(marker);

    markers.addLayer(marker);
}

//function createMarker(place) {
//  var placeLoc = place.geometry.location;
//  var marker = new google.maps.Marker({
//    map: map,
//    position: place.geometry.location
//  });

//  google.maps.event.addListener(marker, 'click', function() {
//    infowindow.setContent(place.name);
//    infowindow.open(map, this);
//  });
//}

function getFromCacheOrServer(url, obj, handler) {

    var data = $.jStorage.get(url);
    if (!data) {
        // if not - load the data from the server
        var xhr = new XMLHttpRequest();
        xhr.open('GET', url, true);
        xhr.responseType = 'blob';
        xhr.onload = function (e) {
            if (this.status == 200) {
                // Note: .response instead of .responseText
                var blob = new Blob([this.response], { type: 'image/png' });
                var reader = new window.FileReader();
                reader.readAsDataURL(blob);
                reader.onloadend = function (event) {
                    var data = event.target.result;
                    // and save it
                    $.jStorage.set(url, data, { TTL: 1000 * 60 * 60 * 24 });
                    handler(obj, data);
                };
            }
        };
        xhr.send();
    } else {
        handler(obj, data);
    }
}

//#region Immediate execute
$(function () {
    onBodyResize();

    $.ajax({
        url: versionUrl,
        success: function success(data) {
            var $hiddenInput = $('<input/>', { type: 'hidden', id: 'version', value: data });
            $hiddenInput.appendTo('form');
        },
        error: function error(XMLHttpRequest, textStatus, errorThrown) {
            console.log("get version error: " + textStatus);console.log("Error: " + errorThrown);
        }
    });

    scroller = $('#imageDiv0 div.innerScrollArea');
    scrollerContent = scroller.children('ul');
    curX = 0;
    fullW = 1;

    // extracted...

    // Scrolling speed management
    var controller = { curSpeed: 0, fullSpeed: 2 };
    var $controller = $(controller);
    var tweenToNewSpeed = function tweenToNewSpeed(newSpeed, duration) {
        if (duration === undefined) duration = 600;
        $controller.stop(true).animate({ curSpeed: newSpeed }, duration);
    };

    //// Pause on hover
    //scroller.hover(function () {
    //    tweenToNewSpeed(0);
    //}, function () {
    //    tweenToNewSpeed(controller.fullSpeed);
    //});

    // Scrolling management; start the automatical scrolling
    var doScroll = function doScroll() {
        if (scrollerEnabled) {
            var curX = scroller.scrollLeft();
            var newX = curX + controller.curSpeed;
            if (newX > fullW * 2 - scroller.width()) newX -= fullW;
            scroller.scrollLeft(newX);
        }
    };
    setInterval(doScroll, 20);
    tweenToNewSpeed(controller.fullSpeed);
});
//#endregion ImmediateExecute
