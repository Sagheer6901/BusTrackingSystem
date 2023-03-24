import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'Maputils.dart';
import 'constant.dart';
import 'package:firstapp/ButtonsfordriverDashboard/TrackingButton.dart';

/*
class DriverTracking extends StatefulWidget {
  const DriverTracking({super.key});

  @override
  State<DriverTracking> createState() => _DriverTrackingState();
}

class _DriverTrackingState extends State<DriverTracking> {
  final Completer<GoogleMapController> _controller = Completer();
  
  // setting latitude and longitude of source and dest
  static const LatLng sourceLocation = LatLng(24.87683, 67.033055);
  static const LatLng destination = LatLng(24.7942792, 67.1359821);

  List<LatLng> polylineCoordinates = [];
  // three cursors for source destination and current location

  // allowing phone to get curr location
  LocationData? currentLocation;
  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );
    // after getting location define googlemapcontroller
    GoogleMapController googleMapController = await _controller.future;
    //updating current location
    location.getLocation().then((location) {
      currentLocation = location;
    });
    // making it visible to the map
    location.onLocationChanged.listen((newloc) {
      currentLocation = newloc;

      //once location changes initiate to the new location
      googleMapController
          .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
              zoom: 13.5,
              target: LatLng(
                newloc.latitude!,
                newloc.longitude!,
              ))));

      setState(() {});
    });
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key, // Your Google Map Key
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  void setCustomMarkerIcon() {}

  @override
  void initState() {
    // get cuurrent location method
    getCurrentLocation();
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffdcd3d3),
        title: const Text(
          "Traking Area",
          style: TextStyle(
              fontFamily: 'Segoe UI',
              fontSize: 18,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: currentLocation == null
          ? const Center(child: Text("Loading"))
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!),
                zoom: 12.5,
              ),
              polylines: {
                Polyline(
                  polylineId: const PolylineId("route"),
                  points: polylineCoordinates,
                  color: const Color(0xFF7B61FF),
                  width: 5,
                ),
              },
              markers: {
                Marker(
                  infoWindow: const InfoWindow(title: "My current Location"),
                  markerId: const MarkerId("Current Location"),
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                ),
                const Marker(
                  markerId: MarkerId("source"),
                  position: sourceLocation,
                ),
                const Marker(
                  infoWindow:
                      const InfoWindow(title: "My Destination Location"),
                  markerId: MarkerId("destination"),
                  position: destination,
                ),
              },
              onMapCreated: (mapController) {
                _controller.complete(mapController);
              },
            ),
    );
  }
}

*/
import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:flutter_uber_youtube/map_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firstapp/ButtonsfordriverDashboard/TrackingButton.dart';

class MapScreen extends StatefulWidget {
  final DetailsResult? startPosition;
  final DetailsResult? endPosition;

  const MapScreen({Key? key, this.startPosition, this.endPosition})
      : super(key: key);
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late CameraPosition _initialPosition;
  final Completer<GoogleMapController> _controller = Completer();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialPosition = CameraPosition(
      target: LatLng(widget.startPosition!.geometry!.location!.lat!,
          widget.startPosition!.geometry!.location!.lng!),
      zoom: 14.4746,
    );
  }

  _addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.black,
        points: polylineCoordinates,
        width: 5);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyDBorxMHcrLrPMvgzTDgEgLz9HA5UDuNY8',
        PointLatLng(widget.startPosition!.geometry!.location!.lat!,
            widget.startPosition!.geometry!.location!.lng!),
        PointLatLng(widget.endPosition!.geometry!.location!.lat!,
            widget.endPosition!.geometry!.location!.lng!),
        travelMode: TravelMode.driving);

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> _markers = {
      Marker(
          markerId: const MarkerId('start'),
          position: LatLng(widget.startPosition!.geometry!.location!.lat!,
              widget.startPosition!.geometry!.location!.lng!)),
      Marker(
          markerId: const MarkerId('end'),
          position: LatLng(widget.endPosition!.geometry!.location!.lat!,
              widget.endPosition!.geometry!.location!.lng!))
    };

    return Scaffold(
        body: Stack(children: [
      GoogleMap(
        polylines: Set<Polyline>.of(polylines.values),
        initialCameraPosition: _initialPosition,
        markers: Set.from(_markers),
        zoomGesturesEnabled: true,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        mapToolbarEnabled: true,
        compassEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          Future.delayed(const Duration(milliseconds: 200), () {
            controller.animateCamera(CameraUpdate.newLatLngBounds(
                MapUtils.boundsFromLatLngList(
                    _markers.map((loc) => loc.position).toList()),
                1));
            _getPolyline();
          });
        },
      ),
    ]));
  }
}
