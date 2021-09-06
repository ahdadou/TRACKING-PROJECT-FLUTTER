import 'dart:async';
import 'dart:typed_data';
import 'package:delivery/screens/map/panel_widget.dart';
import 'package:delivery/services/repositories/trackingRepository.dart';
import 'package:delivery/shared/models/tracking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:delivery/services/repositories/trackingRepository.dart'
    as trackRepository;

class MapScreen extends StatefulWidget {
  MapScreen({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MapScreen> {
  Tracking otherLocation;
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker myMarker;
  Marker pigeonMarker = Marker(
      markerId: const MarkerId("rrr"),
      position: LatLng(35.4691306, -5.2962822),
      infoWindow: const InfoWindow(title: "rrr"),
      // icon: BitmapDescriptor.fromBytes(imageData)
      );
  Circle circle;
  GoogleMapController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    otherLocation$.stream.listen((event) {
      if (this.mounted) setState(() {});
      this.otherLocation = event;
      if (_controller != null) {
        getCurrentLocation(otherLocation);
      }
    });
  }

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SlidingUpPanel(
          minHeight: 50,
          maxHeight: 120,
          panelBuilder: (controller) => Panelwidget(
            controller: controller,
            functionON: turnOnTracking,
            functionOFF: turnOffTracking,
          ),
          body: GoogleMap(
            mapType: MapType.hybrid,
            zoomControlsEnabled: false,
            initialCameraPosition: initialLocation,
            // markers: Set.of((myMarker != null) ? [myMarker, pigeonMarker] : []),
            markers: {
              if (myMarker != null) myMarker,
              if (pigeonMarker != null) pigeonMarker
            },
            circles: Set.of((circle != null) ? [circle] : []),
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
          ),
        ),
      ),
    );
  }

  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/icons/car_icon.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(Tracking track, Uint8List imageData) {
    LatLng latlng = LatLng(track.latitude, track.longitude);
    this.setState(() {
      myMarker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
    });
  }

  void getCurrentLocation(Tracking track) async {
    try {
      Uint8List imageData = await getMarker();
      _controller.animateCamera(CameraUpdate.newCameraPosition(
          new CameraPosition(
              bearing: 192.8334901395799,
              target: LatLng(otherLocation.latitude, otherLocation.longitude),
              tilt: 0,
              zoom: 15.00)));
      updateMarkerAndCircle(track, imageData);
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  void turnOnTracking() async {
    try {
      trackRepository.getTracking(lan: 0, lon: 0);
      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }
      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) {
        if (_controller != null) {
          trackRepository.updateTrackingLocation(
              lan: newLocalData.latitude, lon: newLocalData.longitude);
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  void turnOffTracking() {
    if (_locationSubscription != null) _locationSubscription.cancel();
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }
}
