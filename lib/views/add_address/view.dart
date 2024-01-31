import 'dart:async';

import 'package:alalmiya_g2/core/logic/helper_methods.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressView extends StatefulWidget {
  const AddAddressView({Key? key}) : super(key: key);

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  Set<Marker> markers = {Marker(markerId: MarkerId("1"), position: LatLng(31.0191987, 31.3884559))};

  final _controller = Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  String? myAddress;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          height: 32,
          width: 32,
          padding: EdgeInsetsDirectional.only(start: 8),
          alignment: AlignmentDirectional.center,
          child: Center(
              child: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
          )),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(9), color: Theme.of(context).primaryColor.withOpacity(.13)),
        ),
        title: Text("إضافة عنوان"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 400,
            child: GoogleMap(
              markers: markers,

              circles: {
                 Circle(
                  circleId: CircleId("1"),
                  radius: 10000,
                  strokeColor: Colors.white,
                  fillColor: Theme.of(context).primaryColor.withOpacity(.2),
                  center: LatLng(31.0191987, 31.3884559)
                )
              },
              onMapCreated: (controller) {
                _controller.complete(controller);
              },
              onTap: (argument) {
                markers.add(
                  Marker(
                    markerId: MarkerId("1"),
                    position: LatLng(argument.latitude, argument.longitude),
                  ),
                );
                setState(() {});
                print(argument.latitude);
                print(argument.longitude);
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(31.0191987, 31.3884559),
                zoom: 14,
              ),
            ),
          ),
          if(myAddress!=null)
          Text(myAddress!)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          goToLocation(location: LatLng(37.43296265331129, -122.08832357078792));
        },
      ),
    );
  }

 Future<void> goToLocation({required LatLng location})async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: location, zoom: 14)));
    markers.add(
      Marker(
        markerId: MarkerId("1"),
        position: location,
      ),
    );
    List<Placemark> placemarks = await placemarkFromCoordinates(location.latitude, location.longitude);
    var element = placemarks.first;
    print(element.name);
    print(element.country);
    print(element.administrativeArea);
    print(element.locality);
    print(element.postalCode);
    print(element.subLocality);
    print(element.street);
    print(element.thoroughfare);
    print(element.subThoroughfare);
    print("***************");
    myAddress= "${element.country} / ${element.locality} / ${element.street}";
    setState(() {});
  }


  Future<Position> _determinePosition() async {
    bool serviceEnabled= await Geolocator.isLocationServiceEnabled();
    LocationPermission permission;

    // Test if location services are enabled.
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      showMessage("Location services are disabled.",type: MessageType.warning);
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    var myPosition = await Geolocator.getCurrentPosition();
    print("**************");
    print(myPosition.latitude);
    print(myPosition.longitude);
    await goToLocation(location: LatLng(myPosition.latitude, myPosition.longitude));
    return myPosition;
  }
}
