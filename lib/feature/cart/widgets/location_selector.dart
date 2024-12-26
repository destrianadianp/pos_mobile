import 'package:flutter/material.dart';
import 'package:flutter_map_location_picker/flutter_map_location_picker.dart';
import '../../../helper/location_picker.dart';

class LocationSelector extends StatefulWidget {
  final Function(String, double, double) onLocationSelected;

  const LocationSelector({super.key, required this.onLocationSelected});

  @override
  _LocationSelectorState createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  String? location;
  double? latitude;
  double? longitude;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Alamat pengantaran', onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => const LocationPickerPage()))
              .then((result) {
            if (result != null) {
              final locationResult = result as LocationResult;
              setState(() {
                location = locationResult.completeAddress;
              });
            }
          });
        }),
        Text(location ?? "You haven't picked a location yet"),
      ],
    );
  }

  Widget _buildSectionTitle(String title, {VoidCallback? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        if (onTap != null)
          TextButton(
            onPressed: onTap,
            child: const Text('Ganti alamat', style: TextStyle(color: Colors.blue)),
          ),
      ],
    );
  }
}
