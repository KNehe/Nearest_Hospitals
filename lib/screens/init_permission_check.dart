import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nearest_hospitals/Notifiers/location_notifier.dart';
import 'package:nearest_hospitals/constants/error_messages.dart';
import 'package:nearest_hospitals/customError/fault.dart';
import 'package:nearest_hospitals/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class InitialPermissionCheck extends StatefulWidget {
  InitialPermissionCheck({Key key}) : super(key: key);

  @override
  _InitialPermissionCheckState createState() => _InitialPermissionCheckState();
}

class _InitialPermissionCheckState extends State<InitialPermissionCheck>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    var permission = await Geolocator.checkPermission();
    var isEnabled = await Geolocator.isLocationServiceEnabled();

    if (state == AppLifecycleState.resumed) {
      if (isEnabled &&
          permission != LocationPermission.denied &&
          permission != LocationPermission.deniedForever &&
          permission == LocationPermission.always) {
        Provider.of<LocationNotifier>(context, listen: false).setLoading(true);

        Provider.of<LocationNotifier>(context, listen: false).setError(null);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      } else {
        _setPermissionErrorMessage(permission, isEnabled);
      }
    }
  }

  _openParticularAppSettings(Fault fault) async {
    switch (fault.message) {
      case LOCATION_SERVICES_DISABLED:
        await Geolocator.openLocationSettings();
        break;
      case LOCATION_PERMISSION_DENIED:
        await Geolocator.requestPermission();
        break;
      case LOCATION_SERVICES_PERMANENTLY_DISABLED:
        await Geolocator.openAppSettings();
        break;
      default:
        await Geolocator.openAppSettings();
        break;
    }
  }

  _setPermissionErrorMessage(
      dynamic permission, bool isLocationServiceEnabled) {
    String errorMessage;

    if (!isLocationServiceEnabled) {
      _triggerProviderSetError(LOCATION_SERVICES_DISABLED);
      return;
    }

    switch (permission) {
      case LocationPermission.denied:
        errorMessage = LOCATION_PERMISSION_DENIED;
        break;
      case LocationPermission.deniedForever:
        errorMessage = LOCATION_SERVICES_PERMANENTLY_DISABLED;
        break;
      case LocationPermission.whileInUse:
        errorMessage = LOCATION_PERMISSION_ONLY_WHILE_USE;
        break;
      default:
        errorMessage = LOCATION_PERMISSION_AND_SERVICES_REQUIRED;
        break;
    }

    _triggerProviderSetError(errorMessage);
  }

  _triggerProviderSetError(String message) {
    Provider.of<LocationNotifier>(context, listen: false)
        .setError(Fault(message: message));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.red,
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder(
                future: Provider.of<LocationNotifier>(context, listen: false)
                    .checkLocationPermissions(),
                builder: (context, snapshot) {
                  return Consumer<LocationNotifier>(builder: (_, notifier, __) {
                    if (notifier.isLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      );
                    }

                    if (!notifier.isLoading && notifier.getError != null) {
                      return initScreenErrorContainer(size, notifier);
                    } else {
                      WidgetsBinding.instance.addPostFrameCallback(
                        (_) => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                        ),
                      );
                    }

                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    );
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container initScreenErrorContainer(Size size, LocationNotifier notifier) {
    return Container(
      padding: EdgeInsets.all(8.0),
      width: size.width / 2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${notifier.getError}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8),
          ),
          RaisedButton(
            color: Colors.red,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onPressed: () {
              _openParticularAppSettings(notifier.getError);
            },
            child: Text(
              'Enable service',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
