
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'alert.dart';
import 'navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Position> _getCurrentLocation()async {
    bool serviceEnabled= await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return Future.error('Location services are disabled.');
    }
  Future<Position> _getCurrentLocation()async {
    bool serviceEnabled= await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      permission=await Geolocator.requestPermission();
      if(permission==LocationPermission.denied){
        return Future.error('Location permissioons are denied');

      }

    }
    if(permission==LocationPermission.deniedForever){
      return Future.error(
        'Locations permissions are permanently denied, we cannot request permssions'
      );
    }
    return await Geolocator.getCurrentPosition();

  }

    LocationPermission permission = await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      permission=await Geolocator.requestPermission();
      if(permission==LocationPermission.denied){
        return Future.error('Location permissioons are denied');

      }

    }
    if(permission==LocationPermission.deniedForever){
      return Future.error(
        'Locations permissions are permanently denied, we cannot request permssions'
      );
    }
    return await Geolocator.getCurrentPosition();

  }
    Future<void> _openMap(String lat, String long) async{
    String googleURL= 'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    await canLaunchUrlString(googleURL)?
    await launchUrlString(googleURL):
    throw 'Could not launch $googleURL';
  
  
  }

  late String lat="";
  late String long="";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Row(
            children: [
              Text(
                'SheSecure',
                style: GoogleFonts.mansalva(
                  fontSize: 32,
                ),
              )
            ],
          ),
          elevation:
              defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
          backgroundColor: const Color.fromARGB(255, 167, 76, 106)),
      body:TextButton(
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
  ),
  onPressed: () async{
    Map<Permission,PermissionStatus> status=await[
      Permission.camera,
      Permission.microphone,
      Permission.location,
      Permission.sms
      
    ].request();
    
debugPrint(status.toString());
 Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => VoiceRecognitionScreen(),
      ),
    );
   },
  child: Column(
    children: [
      Center(
        
        child: const Text('ACTIVATE',style:TextStyle(fontSize: 30))
        ),
         ElevatedButton(onPressed: () async {
          Map<Permission,PermissionStatus> status=await[
     
      Permission.location,
      
      
    ].request();

          _getCurrentLocation().then((value){
            lat='${value.latitude}';
            long='${value.longitude}';
          });
          setState((){
            var locationMessage='Latitude: $lat, Logitude: $long';

          });
          _livelocation();


        }, child: const Text('Get current location'),),
const SizedBox(
  height:20
),
ElevatedButton(onPressed: () async {
  Map<Permission,PermissionStatus> status=await[
     
      Permission.location,
      
      
    ].request();
  _openMap(lat,long);
},
  child: const Text('Open Google Map'),
  )

    ],
  ),
)
,
      
      drawer:NavBar(),
    )
    );
  }

  
  
//   late Position _currentPosition;
// String _currentAddress = "";
// _getCurrentLocation() async {

//     await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
//     .then((Position position) {
//   setState(() {
//    //Pass the lat and long to the function
//     _getAddressFromLatLng(position.latitude, position.longitude);

//   });
// }).catchError((e) {
//   print(e);
// });
//   }
  
  void _livelocation() {
    LocationSettings locationSettings=const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,

    );
    Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position){
      lat= position.latitude.toString();
      long=position.longitude.toString();


      setState((){
        var locationMessage= 'Latitude: $lat, Location: $long';

      });
    });

  }
  

}