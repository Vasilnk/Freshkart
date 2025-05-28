import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freshkart/view_model/services/user_services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart'
    show Placemark, placemarkFromCoordinates;

class LocationServices {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final UserServices userServices = UserServices();

  updateLocation(String uid, String location) async {
    await firebaseFirestore.collection('users').doc(uid).update({
      'location': location,
    });
  }

  fetchLocation(BuildContext context) async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.deniedForever) {}

      Position position = await Geolocator.getCurrentPosition();

      List<Placemark> placeMark = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      String locality = placeMark.first.locality ?? '';
      String area = placeMark.first.subAdministrativeArea ?? '';
      String location;

      if (locality.isEmpty && area.isEmpty) {
        location = 'Unknown';
      } else if (locality.isEmpty) {
        location = area;
      } else if (area.isEmpty) {
        location = locality;
      } else {
        location = '$locality, $area';
      }
      final currentUser = UserServices.currentUser;
      if (currentUser != null) {
        await updateLocation(currentUser.uid, location);
        userServices.fetchUserDataFromFirestore(currentUser.uid);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location finding failed'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
      FirebaseException;
    }
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.',
    );
  }
  return await Geolocator.getCurrentPosition();
}
