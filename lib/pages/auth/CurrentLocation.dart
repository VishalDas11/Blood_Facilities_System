//
//
// import 'dart:html';
//
// import 'package:flutter/foundation.dart';
// import 'package:geolocator/geolocator.dart';
//
// class CurrentLocation1{
//   Future<Position> getUserCurrentLocation () async{
//     await Geolocator.requestPermission().then((value){
//
//     }).onError((error, stackTrace){
//       if (kDebugMode) {
//         print('Error $error');
//       }
//     });
//     return await Geolocator.getCurrentPosition();
//   }
//
//   loadData()async{
//     await getUserCurrentLocation().then((value){
//        final latitude =  value.latitude;
//        final longitue = value.longitude;
//     });
//
//   }
// }