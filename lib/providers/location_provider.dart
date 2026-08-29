import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:location/location.dart';

class LocationProvider extends ChangeNotifier {
  Location location = Location();
LatLng ? eventLocation;
  Set<Marker> markers = {
    Marker(
      markerId: MarkerId("0"),

      position: LatLng(37.42796133580664, -122.085749655962),
    ),
  };

  late GoogleMapController mapController;

  String locationMessage = "";

  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Future<void> getLocation() async {

    bool locationPermissionGranted = await _getLocationPerimission();
    if (!locationPermissionGranted) {

      notifyListeners();
      return;
    }

    bool locationServiceEnabled = await _locationServiceEnabled();

    if (!locationServiceEnabled) {

      notifyListeners();
      return;
    }

    notifyListeners();
    LocationData locationdata = await location.getLocation();


    changeLocatiomOnMap(locationdata);

  }


  Future<bool> _getLocationPerimission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
    }

    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> _locationServiceEnabled() async {
    bool locationServiceEnabled = await location.serviceEnabled();
    if (!locationServiceEnabled) {
      locationServiceEnabled = await location.requestService();
    }
    return locationServiceEnabled;
  }

  void changeLocatiomOnMap(LocationData locationdata) {
    cameraPosition = CameraPosition(
      target: LatLng(locationdata.latitude ?? 0, locationdata.longitude ?? 0),

      zoom: 17,
    );
    markers = {
      Marker(
        markerId: MarkerId("0"),

        position: LatLng(
            locationdata.latitude ?? 0, locationdata.longitude ?? 0),


      )};
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    notifyListeners();
  }

  void changeLocationListner() {
    location.onLocationChanged.listen((locationdata) {
      changeLocatiomOnMap(locationdata);
      mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    });
  }
  void setLocationListner(){
location.changeSettings(

  accuracy: LocationAccuracy.high,
  interval: 1000
);
location.onLocationChanged.listen((location){
  changeLocatiomOnMap(location);



});

  }


  void changeCameraPossitionOnMap(LatLng location){
    cameraPosition = CameraPosition(
      target: LatLng(location.latitude , location.longitude),

      zoom: 17,
    );
    markers = {
      Marker(
        markerId:const MarkerId("0"),

        position:  LatLng(
            location.latitude , location.longitude ),


      )};

    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    notifyListeners();



  }
  void changeLocation(LatLng newEventLocation){

    eventLocation=newEventLocation;
    notifyListeners();

  }
}