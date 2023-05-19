import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'Maputils.dart';
import '../../Constants/constant.dart';
import 'package:firstapp/ButtonsfordriverDashboard/StartingpointEndingpointMap/TrackingButton.dart';
import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:flutter_uber_youtube/map_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firstapp/ButtonsfordriverDashboard/StartingpointEndingpointMap/TrackingButton.dart';
import 'package:location/location.dart' as loc;

class MapScreen extends StatefulWidget {
  final DetailsResult? startPosition;
  final DetailsResult? endPosition;
  final String user_id;

  const MapScreen(this.startPosition, this.endPosition, this.user_id,
      {super.key});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final loc.Location location = loc.Location();
  late GoogleMapController _controller1;
  bool _added = false;
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
    return Scaffold(
        body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('location').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (_added) {
                mymap(snapshot);
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return GoogleMap(
                mapType: MapType.normal,
                polylines: Set<Polyline>.of(polylines.values),
                markers: {
                  Marker(
                      markerId: const MarkerId('start'),
                      position: LatLng(
                          widget.startPosition!.geometry!.location!.lat!,
                          widget.startPosition!.geometry!.location!.lng!)),
                  const Marker(
                      markerId: MarkerId('Dot1'),
                      position: LatLng(24.8723, 67.0353)),
                  const Marker(
                      markerId: MarkerId('Dot2'),
                      position: LatLng(24.86525, 67.05625)),
                  const Marker(
                      markerId: MarkerId('Dot3'),
                      position: LatLng(24.87059, 67.04719)),
                  const Marker(
                      markerId: MarkerId('Dot4'),
                      position: LatLng(24.86584, 67.07754)),
                  Marker(
                      markerId: const MarkerId('end'),
                      position: LatLng(
                          widget.endPosition!.geometry!.location!.lat!,
                          widget.endPosition!.geometry!.location!.lng!)),
                  Marker(
                      position: LatLng(
                        snapshot.data!.docs.singleWhere((element) =>
                            element.id == widget.user_id)['latitude'],
                        snapshot.data!.docs.singleWhere((element) =>
                            element.id == widget.user_id)['longitude'],
                      ),
                      markerId: const MarkerId('start'),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueMagenta)),
                },
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                      snapshot.data!.docs.singleWhere((element) =>
                          element.id == widget.user_id)['latitude'],
                      snapshot.data!.docs.singleWhere((element) =>
                          element.id == widget.user_id)['longitude'],
                    ),
                    zoom: 14.47),
                zoomGesturesEnabled: true,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                mapToolbarEnabled: true,
                compassEnabled: true,
                onMapCreated: (GoogleMapController controller) async {
                  /*
                  Future.delayed(const Duration(milliseconds: 200), () {
                    controller.animateCamera(CameraUpdate.newLatLngBounds(
                        MapUtils.boundsFromLatLngList(
                            _markers.map((loc) => loc.position).toList()),
                        1));
                        */
                  _getPolyline();

                  setState(() {
                    _controller1 = _controller1;
                    _added = true;
                  });
                },
              );
            }));
  }

  Future<void> mymap(AsyncSnapshot<QuerySnapshot> snapshot) async {
    await _controller1
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(
              snapshot.data!.docs.singleWhere(
                  (element) => element.id == widget.user_id)['latitude'],
              snapshot.data!.docs.singleWhere(
                  (element) => element.id == widget.user_id)['longitude'],
            ),
            zoom: 14.47)));
  }
}
