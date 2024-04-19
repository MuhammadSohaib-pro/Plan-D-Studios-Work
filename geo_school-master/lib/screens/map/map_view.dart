import 'dart:async';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geo_school/database/database_helper.dart';
import 'package:geo_school/screens/login/school_list_model.dart';
import 'package:geo_school/widgets/Loader.dart';
import 'package:get/get.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapView extends StatefulWidget {
  @override
  State<MapView> createState() => MapSampleState();
}

class MapSampleState extends State<MapView> {
  late ClusterManager manager;
  late GoogleMapController _controller;
  Set<Marker> markers = Set();
  bool isDataLoaded = false;
  String name = '';
  String latitude = '0.00';
  String longitude = '0.00';
  CameraPosition _parisCameraPosition =
  CameraPosition(target: LatLng(17.6078, 8.90817), zoom: 14.0);
  DBHelper db = DBHelper();

  List<Place> items = [];

  @override
  void initState() {
    getSchools();
    manager = initClusterManager();
    super.initState();

    if (!mounted) return;
    setState(() {
      isDataLoaded = true;
    });
  }

  ClusterManager initClusterManager() {
    return ClusterManager<Place>(items, _updateMarkers,
        markerBuilder: _markerBuilder,
        extraPercent: 0.19,
        //initialZoom: _parisCameraPosition.zoom,
        stopClusteringZoom: 15.0);
  }

  void _updateMarkers(Set<Marker> markers) {
    print('Updated ${markers.length} markers');

    if (!mounted) return;
    setState(
          () {
        this.markers = markers;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: appBar(),
      body: Stack(
        children: [
          Column(
            children: [
              (name.length > 1)
                  ? Container(
                child: Column(
                  children: [
                    firstTile(),
                    Divider(
                      height: 0,
                    ),
                    secondTile(),
                  ],
                ),
              )
                  : Container(
                height: 0,
              ),
              Expanded(child: map())
            ],
          ),
          (!isDataLoaded) ? Loader() : Container(height: 0),
        ],
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: Text('locationInfo'.tr),
    );
  }

  Widget map() {
    return GoogleMap(
      mapType: MapType.normal,
      mapToolbarEnabled: false,
      myLocationEnabled: true,
      tiltGesturesEnabled: false,
      myLocationButtonEnabled: true,
      initialCameraPosition: _parisCameraPosition,
      markers: markers,
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
        //manager.setMapController(controller);

        manager.setMapId(controller.mapId);
      },
      onCameraMove: manager.onCameraMove,
      onCameraIdle: manager.updateMap,
    );
  }

  Widget firstTile() {
    return ListTile(
      dense: true,
      contentPadding:
      EdgeInsets.only(left: Get.width * 0.06, right: Get.width * 0.01),
      title: Text(
        'schoolName'.tr + ' :',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Color(0xff999999),
          fontFamily: 'Poppins-Regular',
        ),
      ),
      subtitle: Text(
        name,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Color(0xff999999),
          fontFamily: 'Poppins-Regular',
        ),
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.copy,
          size: 20,
          color: Color(0xff023330),
        ),
        onPressed: () {
          Clipboard.setData(new ClipboardData(text: name));
//mapViewModel.copytoClipBoard(mapViewModel.address.value);
        },
      ),
    );
  }

  Widget secondTile() {
    return ListTile(
      dense: true,
      contentPadding:
      EdgeInsets.only(left: Get.width * 0.06, right: Get.width * 0.01),
      title: Row(
        children: [
          Expanded(
            child: Text(
              'Latitude :',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xff999999),
                fontFamily: 'Poppins-Regular',
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                'Longitude :',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff999999),
                  fontFamily: 'Poppins-Regular',
                ),
              ),
            ),
          ),
        ],
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: Text(
              latitude,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xff999999),
                fontFamily: 'Poppins-Regular',
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                longitude,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff999999),
                  fontFamily: 'Poppins-Regular',
                ),
              ),
            ),
          ),
        ],
      ),
      trailing: IconButton(
        onPressed: () {
          copyToClipBoard();
        },
        icon: Icon(
          Icons.copy,
          size: 20,
          color: Color(0xff023330),
        ),
      ),
    );
  }

  copyToClipBoard() {
    String data = 'Latitude : ' + latitude + '\n' + 'Longitude : ' + longitude;
    Clipboard.setData(new ClipboardData(text: data));
  }

  getSchools() async {
    Location location = new Location();
    LocationData locationData = await location.getLocation();

    List<SchoolListModel> schools = [];
    schools.addAll(await db.getAllSchools());

    //print("marker : ${schools.length}");

    CameraUpdate cameraUpdate = CameraUpdate.newLatLngZoom(new LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0), 17);
    _controller.animateCamera(cameraUpdate);

    if (!mounted) return;
    setState(() {
      isDataLoaded = true;

      for (int i = 0; i < schools.length; i++) {
        items.add(
          Place(
            name:schools[i].name ?? '',
            latLng: LatLng(double.parse(schools[i].lat ?? '0'), double.parse(schools[i].lng ?? '0')),
          ),
        );
      }
    });
  }

  Future<Marker> Function(Cluster<Place>) get _markerBuilder =>
          (cluster) async {
        return Marker(
          markerId: MarkerId(cluster.getId()),
          position: cluster.location,
          infoWindow: cluster.isMultiple
              ? InfoWindow()
              : InfoWindow(
            title: cluster.items.first.name,
          ),
          icon: await _getMarkerBitmap1(
            cluster.isMultiple ? 125 : 75,
            text: cluster.isMultiple ? cluster.count.toString() : null,
          ),
          onTap: () {
            print('---- $cluster');
            if (!mounted) return;
            setState(() {
              cluster.items.forEach((p) => p);
              var d = cluster.items.toList();
              name = d.length < 2 ? d.first.name : '';
              latitude = cluster.location.latitude.toString();
              longitude = cluster.location.longitude.toString();

              if (cluster.isMultiple) {}
            });
          },
        );
      };

  Future<BitmapDescriptor> _getMarkerBitmap1(int size, {String? text}) async {
    if (kIsWeb) size = (size / 2).floor();

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = Colors.orange;
    final Paint paint2 = Paint()..color = Colors.white;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(
            fontSize: size / 3,
            color: Colors.white,
            fontWeight: FontWeight.normal),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    } else {
      return BitmapDescriptor.defaultMarker;
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }
}

// class Place {
//   final String name;
//   final bool isClosed;
//
//   const Place({@required this.name, this.isClosed = false});
//
//   @override
//   String toString() {
//     return 'Place $name (closed : $isClosed)';
//   }
// }

class Place with ClusterItem {
  final String name;
  final LatLng latLng;

  Place({required this.name, required this.latLng});

  @override
  LatLng get location => latLng;
}