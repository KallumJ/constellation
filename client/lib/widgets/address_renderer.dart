import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class AddressRenderer extends StatelessWidget {
  final Position position;
  final TextStyle? style;

  const AddressRenderer({super.key, required this.position, this.style});

  Future<String?> getAddressFromPosition() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    final placemark = placemarks.first;

    return "${placemark.subAdministrativeArea}, ${placemark.administrativeArea}";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAddressFromPosition(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}', style: style);
        } else {
          return Text(snapshot.data ?? 'No address found', style: style);
        }
      },
    );
  }
}
