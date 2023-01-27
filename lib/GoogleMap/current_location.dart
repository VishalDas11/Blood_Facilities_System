import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

    class GetLocation extends StatefulWidget {
        GetLocation({Key? key, required this.latitude, required this.longitude}) : super(key: key);

        dynamic latitude;
        dynamic longitude;

      @override
      State<GetLocation> createState() => _GetLocationState();
    }
    class _GetLocationState extends State<GetLocation> {

      final Completer<GoogleMapController> _controller = Completer();

      // TODO Get Self Current Location
      LocationData? currentLocation;

      getLocation() async {
        Location location = Location();
        location.getLocation().then((value){
          setState(() {
            currentLocation = value;
          });
        }).onError((error, stackTrace){
          if (kDebugMode) {
            print(error.toString());
          }
        });

        CameraPosition cameraposition = CameraPosition(
            target:LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
            zoom: 14
        );
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(cameraposition));
        setState((){});
      }

        // getDonaterLocation()async{
        //   await getUserCurrentLocation().then((value) async {
        //     _marker.add(
        //       Marker(markerId: MarkerId("3"),
        //           position: LatLng(value.latitude , value.longitude),
        //           infoWindow: InfoWindow(
        //               title: "My Current Position"
        //           )
        //       ),
        //     );
        //     CameraPosition cameraposition = CameraPosition(
        //         target:LatLng(value.latitude , value.longitude),
        //         zoom: 14
        //     );
        //     final GoogleMapController controller = await _controller.future;
        //     controller.animateCamera(CameraUpdate.newCameraPosition(cameraposition));
        //     setState((){
        //
        //     });
        //   });
        // }

        // TODO  Get Blood Donater Location
        // load(){
        //   _marker.add(
        //     Marker(markerId: MarkerId('10'),
        //         position: LatLng(widget.latitude, widget.longitude),
        //         infoWindow: InfoWindow(
        //             title: "User Position"
        //         ),
        //     ),
        //   );
        //   setState((){});
        // }

        // TODO Set polyline
      // Set<Polyline> _polylin = HashSet<Polyline>();

        // poly()async{
        //   await getUserCurrentLocation().then((value){
        //     List<LatLng> latlng = [
        //     LatLng(value.latitude, value.longitude),
        //     LatLng(widget.latitude, widget.longitude)
        //     ];
        //
        //     for(int i =0; i< latlng.length; i++){
        //       _marker.add(
        //         Marker(markerId: MarkerId(i.toString()),
        //         position: latlng[i],
        //           infoWindow: InfoWindow(
        //             title: "Really Cool Places",
        //             snippet: "5 star",
        //           ),
        //           icon: BitmapDescriptor.defaultMarker
        //         )
        //       );
        //       setState(() {
        //
        //       });
        //       _polylin.add(
        //         Polyline(polylineId: PolylineId('2'),
        //         points: latlng,
        //           color: Colors.lightBlue
        //         )
        //       );
        //     }
        //     // _polygon.add(
        //     //     Polygon(polygonId: PolygonId('1'), points: point,
        //     //     fillColor: Colors.red.withOpacity(0.2),
        //     //       geodesic: true,
        //     //       strokeWidth: 4
        //     //     )
        //     // );
        //   });
        //
        // }

      List<LatLng> _polyCordinates  =  [];

      static String api = 'AIzaSyDNxUM3OubA9E7RHYembDo_FqFDPIJIwNw';
      polyPoints()async{
        PolylinePoints polylinePoints = PolylinePoints();
        PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
            api,
            PointLatLng(widget.latitude, widget.longitude),
            PointLatLng(currentLocation!.latitude!, currentLocation!.longitude!)
        );
        if(result.points.isNotEmpty){
          for (var pointLatLng in result.points) {
            _polyCordinates.add(
              LatLng(pointLatLng.latitude, pointLatLng.longitude )
            );
            setState(() {

            });
          }
          setState(() {

          });
        }
      }

        @override
        void initState(){
          super.initState();
          getLocation();
          // poly();
        }

        @override
        Widget build(BuildContext context) {
          return SafeArea(
            child: Scaffold(
              body: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(widget.latitude, widget.longitude),
                    zoom: 14
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                tiltGesturesEnabled: true,
                compassEnabled: true,
                scrollGesturesEnabled: true,
                polylines: {
                  Polyline(
                    polylineId: PolylineId('a'),
                    points: _polyCordinates,
                    visible: true
                  )
                }
                ,markers: {
                  Marker(
                    markerId: MarkerId('11'),
                    position: LatLng(widget.latitude, widget.longitude),
                    infoWindow: InfoWindow(
                      title: "User Dononr Location"
                    )
                  ),
                  Marker(
                    markerId: MarkerId('12'),
                    position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                    infoWindow: InfoWindow(
                      title: "Current"
                    )
                  ),
                },


                onMapCreated: (GoogleMapController controller){
                  _controller.complete(controller);
                },
              ),

            ),
          );
  }
}


