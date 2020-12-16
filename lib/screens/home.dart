import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nearest_hospitals/Notifiers/location_notifier.dart';
import 'package:nearest_hospitals/models/location.dart';
import 'package:nearest_hospitals/models/venue.dart';
import 'package:nearest_hospitals/models/venue_element.dart';
import 'package:provider/provider.dart';
import 'package:nearest_hospitals/Notifiers/places_notifier.dart';
import 'package:nearest_hospitals/widgets/bottom_sheet.dart'
    as ModalBottomSheet;

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 10,
  );

  final Map<String, Marker> _markers = {};

  final _scafoldKey = GlobalKey<ScaffoldState>();

  bool _isCreatingMarkers = true;
  bool _isLoadingDetails = false;

  _onMapCreated(GoogleMapController controller) async {
    await Provider.of<LocationNotifier>(context, listen: false)
        .checkLocationPermissions();

    Position position = Provider.of<LocationNotifier>(context, listen: false)
        .getCurrentPosition;

    if (position != null) {
      await Provider.of<PlacesNotifier>(context, listen: false).getPlaces(
          position.latitude.toString(), position.longitude.toString());

      _createMarkers(controller);
    }

    _controller.complete(controller);
  }

  _createMarkers(GoogleMapController controller) {
    Location lastLocation;

    setState(() {
      _markers.clear();

      Venue venue =
          Provider.of<PlacesNotifier>(context, listen: false).getVenue;

      for (final venue in venue.response.venues) {
        final marker = Marker(
          markerId: MarkerId(venue.name),
          position: LatLng(venue.location.lat, venue.location.lng),
          onTap: () {
            _onMarkerTappedHandler(venue);
          },
        );

        _markers[venue.name] = marker;
        lastLocation = venue.location;
      }
    });

    Position position =
        Position(longitude: lastLocation.lng, latitude: lastLocation.lat);

    _animateCamera(controller, position);

    setState(() {
      _isCreatingMarkers = false;
    });
  }

  _animateCamera(GoogleMapController controller, Position position) {
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            position.latitude,
            position.longitude,
          ),
          zoom: 13,
        ),
      ),
    );
  }

  _onMarkerTappedHandler(VenueElement venueElement) {
    setState(() {
      _isLoadingDetails = true;
    });

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ModalBottomSheet.BottomSheet(venueElement: venueElement);
        });

    setState(() {
      _isLoadingDetails = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        key: _scafoldKey,
        appBar: AppBar(
          title: Row(
            children: [
              Icon(Icons.local_hospital),
              SizedBox(
                width: 5,
              ),
              Text('Nearest Hospitals'),
            ],
          ),
        ),
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: _initialCameraPosition,
              onMapCreated: _onMapCreated,
              markers: _markers.values.toSet(),
            ),

            //progress when loading markers
            Consumer<LocationNotifier>(builder: (context, notifier, child) {
              return Align(
                child: notifier.getError == null && _isCreatingMarkers
                    ? Container(
                        width: size.width / 3,
                        height: size.width / 3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : Visibility(
                        child: Text(''),
                        visible: false,
                      ),
              );
            }),

            //show message when error with getting location occurs
            Consumer<LocationNotifier>(
              builder: (context, notifier, child) {
                if (!notifier.isLoading && notifier.getError != null) {
                  return Align(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      width: size.width / 2,
                      height: size.width / 2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          '${notifier.getError}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                }
                return Visibility(
                  child: Text(''),
                  visible: false,
                );
              },
            ),

            //progress when loading bottom sheet
            Align(
              child: _isLoadingDetails
                  ? Container(
                      width: size.width / 3,
                      height: size.width / 3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : Visibility(
                      child: Text(''),
                      visible: false,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
