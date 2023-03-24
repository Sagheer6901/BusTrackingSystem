import 'dart:async';
import 'package:firstapp/Maps/DriverTrackingPage.dart';
import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';

import '../Dashboards/MainScreenForDriver.dart';

class TrackingButton extends StatefulWidget {
  @override
  _TrackingButtonState createState() => _TrackingButtonState();
}

class _TrackingButtonState extends State<TrackingButton> {
  final _startSearchFieldController = TextEditingController();
  final _endSearchFieldController = TextEditingController();

  DetailsResult? startPosition;
  DetailsResult? endPosition;

  late FocusNode startFocusNode;
  late FocusNode endFocusNode;

  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  Timer? _debounce;

  @override
  void initState() {
    // to do implement initsate
    super.initState();
    String apiKey = 'AIzaSyDBorxMHcrLrPMvgzTDgEgLz9HA5UDuNY8';
    googlePlace = GooglePlace(apiKey);

    startFocusNode = FocusNode();
    endFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    startFocusNode.dispose();
    endFocusNode.dispose();
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      print(result.predictions!.first.description);
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffafdceb),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xffafdceb),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          color: Colors.black,
          onPressed: () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => MainScreenForDriver())),
        ),
        title: const Text("Bus System"),
        foregroundColor: Colors.black,

        /// leading: const BackButton(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _startSearchFieldController,
              autofocus: false,
              focusNode: startFocusNode,
              style: const TextStyle(fontSize: 24),
              decoration: InputDecoration(
                  hintText: 'Starting Point',
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 24),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  suffixIcon: _startSearchFieldController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              predictions = [];
                              _startSearchFieldController.clear();
                            });
                          },
                          icon: const Icon(Icons.clear_outlined),
                        )
                      : null),
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce!.cancel();
                _debounce = Timer(const Duration(milliseconds: 1000), () {
                  if (value.isNotEmpty) {
                    //places api
                    autoCompleteSearch(value);
                  } else {
                    //clear out the results
                    setState(() {
                      predictions = [];
                      startPosition = null;
                    });
                  }
                });
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _endSearchFieldController,
              autofocus: false,
              focusNode: endFocusNode,
              enabled: _startSearchFieldController.text.isNotEmpty &&
                  startPosition != null,
              style: const TextStyle(fontSize: 24),
              decoration: InputDecoration(
                  hintText: 'End Point',
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 24),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  suffixIcon: _endSearchFieldController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              predictions = [];
                              _endSearchFieldController.clear();
                            });
                          },
                          icon: const Icon(Icons.clear_outlined),
                        )
                      : null),
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce!.cancel();
                _debounce = Timer(const Duration(milliseconds: 1000), () {
                  if (value.isNotEmpty) {
                    //places api
                    autoCompleteSearch(value);
                  } else {
                    //clear out the results
                    setState(() {
                      predictions = [];
                      endPosition = null;
                    });
                  }
                });
              },
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: predictions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const CircleAvatar(
                      child: Icon(
                        Icons.pin_drop,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      predictions[index].description.toString(),
                    ),
                    onTap: () async {
                      final placeId = predictions[index].placeId!;
                      final details = await googlePlace.details.get(placeId);
                      if (details != null &&
                          details.result != null &&
                          mounted) {
                        if (startFocusNode.hasFocus) {
                          setState(() {
                            startPosition = details.result;
                            _startSearchFieldController.text =
                                details.result!.name!;
                            predictions = [];
                          });
                        } else {
                          setState(() {
                            endPosition = details.result;
                            _endSearchFieldController.text =
                                details.result!.name!;
                            predictions = [];
                          });
                        }
                        String a;
                        String b;
                        if (startPosition != null && endPosition != null) {
                          print('navigate');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapScreen(
                                  startPosition: startPosition,
                                  endPosition: endPosition),
                            ),
                          );
                        }
                      }
                    },
                  );
                }),
            const SizedBox(
              height: 80,
            ),
            Align(
              alignment: const Alignment(0.004, 0.487),
              child: Container(
                  width: 163.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(25.0),
                    border:
                        Border.all(width: 1.0, color: const Color(0xff707070)),
                  ),
                  child: Container(
                      alignment: const Alignment(0.100, 0.253),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainScreenForDriver()));
                        },
                        child: const Text(
                          'Go back',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                          softWrap: false,
                        ),
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}
