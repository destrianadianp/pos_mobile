import 'package:flutter/material.dart';
import 'package:flutter_map_location_picker/flutter_map_location_picker.dart';

class LocationPickerPage extends StatelessWidget {
  const LocationPickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location Picker"),
      ),
      body: MapLocationPicker(
        onPicked: (result) {
          Navigator.pop(context, result);
        },
        initialLatitude: null,
        initialLongitude: null,
      ),
    );
  }
}