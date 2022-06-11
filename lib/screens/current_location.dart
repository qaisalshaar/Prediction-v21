// import 'dart:collection';

// import 'package:dagnosis_and_prediction/db/db_helper.dart';
// import 'package:dagnosis_and_prediction/model/registration_model.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MyCurrentLocation extends StatefulWidget {
//   final String email;
//   const MyCurrentLocation({Key? key, required this.email}) : super(key: key);

//   @override
//   _CurrentLocationScreenState createState() => _CurrentLocationScreenState();
// }

// class _CurrentLocationScreenState extends State<MyCurrentLocation> {
//   late GoogleMapController googleMapController;
//   String? latitude;
//   String? longitude;

//   var myMarkers = HashSet<Marker>(); // Markers

//   getLatlong() async {
//     //print("ddddddddddddddddddddddd");
//     Registration? userlocation = await DBHelper.getuserLocation(widget.email);
//     latitude = userlocation?.latitude;
//     longitude = userlocation?.longitude;
//     return userlocation;
//   }

//   @override
//   void initState() {
//     super.initState();
//     getLatlong();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("User current location"),
//         centerTitle: true,
//       ),
//       body: FutureBuilder(
//           future: getLatlong(),
//           builder: (context, snapshot) {
//             print('eeeeeeeee$latitude');
//             if (snapshot.hasData) {
//               return GoogleMap(
//                 initialCameraPosition: CameraPosition(
//                   target: LatLng(
//                     // 29.982743,
//                     // 31.153599,
//                     double.parse(latitude!),
//                     double.parse(longitude!),
//                   ),
//                   zoom: 16,
//                 ),
//                 onMapCreated: (GoogleMapController googleMapController) {
//                   setState(
//                     () {
//                       myMarkers.add(
//                         Marker(
//                           markerId: const MarkerId('1'),
//                           position: LatLng(
//                             double.parse(latitude!),
//                             double.parse(longitude!),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//                 markers: myMarkers,
//               );
//             }
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }),
//     );
//   }

//   Future<Position> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();

//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled');
//     }

//     permission = await Geolocator.checkPermission();

//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();

//       if (permission == LocationPermission.denied) {
//         return Future.error("Location permission denied");
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error('Location permissions are permanently denied');
//     }

//     Position position = await Geolocator.getCurrentPosition();

//     return position;
//   }
// }

// 31.9768034 , 35.8840907
import 'dart:async';

// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyCurrentLocation extends StatefulWidget {
  const MyCurrentLocation({Key? key, required String email}) : super(key: key);

  @override
  State<MyCurrentLocation> createState() => _MyMapState();
}

class _MyMapState extends State<MyCurrentLocation> {
// servises Location = Enable  => True
  late Position cl;
  var lat;
  var long;
  late CameraPosition _kGooglePlex;
  var locationname;
  Future GetPer() async {
    bool servises;
    LocationPermission per;

    servises = await Geolocator.isLocationServiceEnabled();

//    print('Servises: $servises');

    // if (servises == false) {
    //   AwesomeDialog(
    //     context: context,
    //     title: "Servises",
    //     body: Text('Servises Not Open'),
    //     dialogType: DialogType.ERROR,
    //   )..show();
    // } else {
    //   AwesomeDialog(
    //     context: context,
    //     title: "Servises",
    //     body: Text('Servises is  Open'),
    //     dialogType: DialogType.SUCCES,
    //   )..show();
    // }

    per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();

      // if (per == LocationPermission.whileInUse ||
      //     per == LocationPermission.always) {
      //   getlatilong();
      // }
    }
    print('==================================================');
    print(per);
    print('==================================================');
  }

  @override
  void initState() {
    // TODO: implement initState
    getlatilong();
    GetPer();

    super.initState();
  }

  Future<void> getlatilong() async {
    cl = await Geolocator.getCurrentPosition().then((value) => value);
    lat = cl.latitude;
    long = cl.longitude;
    _kGooglePlex = CameraPosition(
      target: LatLng(lat, long),
      zoom: 17.4746,
    );
    setState(() {});
  }

  // Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController gmc;

  late Set<Marker> mymarker = {
    Marker(
      markerId: MarkerId('1'),
      // infoWindow: InfoWindow(title: lat.toString() + "--" + long.toString()),
      infoWindow: InfoWindow(title: locationname.toString()),
      position: LatLng(cl.latitude, cl.longitude),

// onTap: () async {
      //   List<Placemark> placemarks =
      //       await placemarkFromCoordinates(cl.latitude, cl.longitude);
      //   locationname = placemarks[0].administrativeArea!;
      //   setState(() {});
      // }
      // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
      // icon: await BitmapDescriptor.fromAssetImage(ImageConfiguration.empty,"images/logo.png"),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('Find User Location'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Navigator.of(context).pop();
            // Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => const HomeScreen()));
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(children: [
        _kGooglePlex == null
            ? CircularProgressIndicator()
            : Container(
                height: 600,
                width: 400,
                child: GoogleMap(
                    // markers: mymarker,
                    markers: mymarker,
                    mapType: MapType.satellite,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      gmc = controller;
                    }),
              ),
        RaisedButton(
          onPressed: () async {
            // cl = await getlatilong();

            print('latitude : ${cl.latitude} ');
            print('longitude :${cl.longitude} ');

            List<Placemark> placemarks =
//  31.9768034 , 35.8840907
                // await placemarkFromCoordinates(52.2165157, 6.9437819);
                await placemarkFromCoordinates(cl.latitude, cl.longitude);

            print(placemarks[0].country);
            AwesomeDialog(
              aligment: Alignment.center,
              context: context,
              title: "Servises",
              body: Text('Country Name : ${placemarks[0].country}\n ' +
                  'City Name :${placemarks[0].administrativeArea}\n ' +
                  'Area name :${placemarks[0].subLocality} '),
              dialogType: DialogType.INFO,
            )..show();

            print(placemarks[0].administrativeArea);
            print(placemarks[0].locality);
            print(placemarks[0].subLocality);
            print(placemarks[0].street);
            print(placemarks[0].name);
            print(placemarks[0].postalCode);
          },
          child: Text('Show Location Info'),
        )
      ]),
    );
  }
}
