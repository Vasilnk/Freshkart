import 'package:flutter/material.dart';
import 'package:freshkart/view_model/services/location_services.dart';

class LocationProvider extends ChangeNotifier {
  LocationServices locationServices = LocationServices();
  bool isLoading = false;

  Future<void> getLocation(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    await locationServices.fetchLocation(context);
    isLoading = false;
    notifyListeners();
  }
}
