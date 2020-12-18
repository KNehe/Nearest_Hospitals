# Nearest hospitals

- A mobile app built using flutter to help users find the closest hospitals around them

## Sample screenshots

<table>
  <tr>
    <td><img src="/../screenshots/home.png" width=270 height=480></td>
    <td><img src="/../screenshots/place_details.png" width=270 height=480></td>
    <td><img src="/../screenshots/permission_check.png" width=270 height=480></td>
  </tr>
 </table>


## Features
- Location service check
- Location permission check
- Open app settings to enable location service and permission
- Show nearest hospitals in radius of 5000m on google map markers
- Custom marker icon to indicate hospitals
- Show details when marker is tapped

## Follow steps below to successfully run app
- Clone the project
- Get a Google API key and add it to your project. If you do not know how to do it, [Go to google_maps_flutter docs](https://pub.dev/packages/google_maps_flutter) and follow instructions. Do not forget to enable and restrict it.
- Get a Client Id and Secret Id from [FourSquare](https://foursquare.com/developers/). This is used when getting nearest hsopitals. 
- Navigate to ```lib/notifiers/places_notifier```. Add the above mentioned Ids to the empty variables ``` static String _clientId = ''; and
  static String _clientSecret = ''; ```.
- Execute ```flutter run```.

## Note
- The app was mostly developed and tested on android only.
- On IOS you'll notice things like the AppIcon and splash screen are the default ones.
