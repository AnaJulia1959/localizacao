import 'package:flutter/material.dart';
import 'package:flutter_localizaca/modules/location/models/location_model.dart';
import 'package:location/location.dart';

class LocationViewModel extends ChangeNotifier {
  final Location _service = Location();
  LocationModel? _current;
  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;

  LocationModel? get current => _current;

  LocationViewModel() {
    _init();
  }

  Future<void> _init() async {
    _serviceEnabled = await _service.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _service.requestService();
      if (!_serviceEnabled) return;
    }

    _permissionGranted = await _service.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _service.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    }

    final loc = await _service.getLocation();
    _updateLocation(loc);

    _service.onLocationChanged.listen(_updateLocation);
  }

  void _updateLocation(LocationData data) {
    _current = LocationModel(
      latitude: data.latitude ?? 0.0,
      longitude: data.longitude ?? 0.0,
    );
    notifyListeners();
  }
}
