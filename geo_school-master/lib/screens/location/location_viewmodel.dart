import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:geo_school/helper/global_variables.dart';

import 'package:geo_school/screens/form/form_view.dart';
import 'package:geo_school/widgets/Loader.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:share_plus/share_plus.dart';

class LocationViewModel extends GetxController {
  Location location = new Location();
  RxString latitude = '0.00'.obs;
  RxString longitude = '0.00'.obs;
  RxString accuracy = '0.00'.obs;
  RxString address = ''.obs;
  RxString altitude = '0.00'.obs;
  String key = 'AIzaSyCUU0fPgwwW36HyBMHfh4xyxrJlvNx5w4w';

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData locationData;
  bool shareSheetOpen = false;

  @override
  void onReady() {
    super.onReady();
    getCurrentLatLng();
  }

  @override
  void onClose() {
    super.onClose();
    Loader.loader.value = false;
  }

  getCurrentLatLng() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    Loader.loader.value = true;
    location.onLocationChanged.listen((LocationData currentLocation) {
      Loader.loader.value = false;

      // Use current location
      latitude.value = currentLocation.latitude.toString();
      longitude.value = currentLocation.longitude.toString();
      accuracy.value = currentLocation.accuracy?.round().toString() ?? '';
      altitude.value = currentLocation.altitude.toString();
      locationData = currentLocation;

      GlobalVariables.currentLocation = currentLocation;

      print('location heading = ' + currentLocation.heading.toString());
    });
  }

  openForm() {
    Get.to(
      () => FormView(
        latLng:
            new LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
        altitude: locationData.altitude ?? 0,
        accuracy: accuracy.value,
      ),
    );
  }

  shareData(BuildContext context) {
    String shareData =
        'Altitude: $altitude\nLatitude: $latitude\nLongitude: $longitude\nDate/Time: ${DateTime.now()}\nAddress: $address\nhttp://maps.google.com/maps?q=$latitude,$longitude';
    // final RenderBox box = context.findRenderObject();
    final box = context.findRenderObject() as RenderBox?;
    Share.share(shareData,
        subject: 'Current Location',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  void getAddress(BuildContext context) async {
    shareSheetOpen = true;
    String time = formatDate(DateTime.now(), [hh, ':', nn, ' ', am]);
    String date = formatDate(DateTime.now(), [dd, '/', MM, '/', yyyy]);
    String shareData =
        'Altitude: $altitude\nLatitude: $latitude\nLongitude: $longitude\nDate/${'time'.tr}: $date $time\nhttp://maps.google.com/maps?q=$latitude,$longitude';
    // final RenderBox box = context.findRenderObject();
    final box = context.findRenderObject() as RenderBox?;
    Share.share(shareData,
        subject: 'Current Location',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    shareSheetOpen = false;
  }
}
