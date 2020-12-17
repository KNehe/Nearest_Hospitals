import 'package:flutter/material.dart';
import 'package:nearest_hospitals/models/venue_element.dart';
import 'package:nearest_hospitals/widgets/bottom_sheet_item.dart';
import 'package:nearest_hospitals/widgets/constant_vertical_height.dart';

class BottomSheet extends StatelessWidget {
  final VenueElement venueElement;
  const BottomSheet({this.venueElement});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 10.0,
        right: 10,
        top: 20,
        bottom: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              "${venueElement.name.toUpperCase()}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          BottomSheetItem(
            title: 'Distance',
            value: venueElement.location.distance.toString() + "m",
          ),
          ConstVerticalHeight(),
          BottomSheetItem(
            title: 'Country',
            value: venueElement.location.country,
          ),
          ConstVerticalHeight(),
          BottomSheetItem(
            title: 'State',
            value: venueElement.location.state,
          ),
          ConstVerticalHeight(),
          BottomSheetItem(
            title: 'City',
            value: venueElement.location.city,
          ),
          ConstVerticalHeight(),
          BottomSheetItem(
            title: 'Address',
            value: venueElement.location.address,
          ),
          ConstVerticalHeight(),
          BottomSheetItem(
            title: 'Cross street',
            value: venueElement.location.crossStreet,
          ),
          ConstVerticalHeight(),
          BottomSheetItem(
            title: 'Postal code',
            value: venueElement.location.postalCode,
          ),
        ],
      ),
    );
  }
}
