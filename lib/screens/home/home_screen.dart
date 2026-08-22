// import 'package:flutter/material.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Smart Parking Finder"),
//       ),
//       body: const Center(
//         child: Text(
//           "Welcome to Smart Parking Finder",
//           style: TextStyle(fontSize: 22),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Smart Parking Finder"),
//       ),
//       body: const Center(
//         child: Text(
//           "Google Map will appear here",
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   static const CameraPosition _initialPosition = CameraPosition(
//     target: LatLng(28.6139, 77.2090),
//     zoom: 14,
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Smart Parking Finder"),
//       ),
//       body: GoogleMap(
//         initialCameraPosition: _initialPosition,
//         mapType: MapType.normal,
//         myLocationEnabled: false,
//         myLocationButtonEnabled: true,
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Smart Parking Finder"),
//       ),
//       body: FlutterMap(
//         options: const MapOptions(
//           initialCenter: LatLng(28.6139, 77.2090),
//           initialZoom: 13,
//         ),
//         children: [
//           TileLayer(
//             urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//             userAgentPackageName: 'com.example.parking_finder',
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../database/parking_data.dart';
import '../../models/parking_model.dart';
import '../booking/booking_screen.dart';
import '../history/history_screen.dart';




class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  List<Parking> filteredParkingList = [];

  LatLng _currentLocation = const LatLng(28.6139, 77.2090);
  bool _locationLoaded = false;

  @override
  void initState() {
    super.initState();

    filteredParkingList = parkingList;

    _getCurrentLocation();
  }

  void _searchParking(String value) {
    setState(() {
      filteredParkingList = parkingList.where((parking) {
        return parking.name.toLowerCase().contains(value.toLowerCase());
      }).toList();
    });
  }



  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return;
    }

    // Check permission
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      _locationLoaded = true;
    });

    _mapController.move(_currentLocation, 16);
  }
  void _showParkingDetails(Parking parking) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                parking.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: 5),
                  Text(
                    parking.rating.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Text(
                "₹${parking.price.toStringAsFixed(0)} / hour",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              // Text(
              //   "Available Slots : ${parking.availableSlots}",
              //   style: const TextStyle(fontSize: 18),
              // ),
              Row(
                children: [
                  const Icon(Icons.local_parking, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(
                    "${parking.availableSlots} Slots Available",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BookingScreen(
                            parkingName: parking.name,
                            pricePerHour: parking.price,
                          ),
                        ),
                      );
                  },
                  child: const Text("Book Now"),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.history),
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (_) => const HistoryScreen(),
        //         ),
        //       );
        //     },
        //   ),
        // ],
        title: const Text("Smart Parking Finder"),
      ),
      // body: FlutterMap(
      //   mapController: _mapController,
      //   options: MapOptions(
      //     initialCenter: _currentLocation,
      //     initialZoom: 14,
      //   ),
      //   children: [
      //     TileLayer(
      //       urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      //       userAgentPackageName: 'com.example.parking_finder',
      //       tileProvider: NetworkTileProvider(),
      //     ),
      //
      //     MarkerLayer(
      //       markers: [
      //         Marker(
      //           point: _currentLocation,
      //           width: 60,
      //           height: 60,
      //           child: const Icon(
      //             Icons.location_on,
      //             color: Colors.blue,
      //             size: 40,
      //           ),
      //         ),
      body: Column(
          children: [

      Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: _searchController,
        onChanged: _searchParking,
        decoration: InputDecoration(
          hintText: "Search Parking...",
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ),

    Expanded(
    child: FlutterMap(
    mapController: _mapController,
    options: MapOptions(
    initialCenter: _currentLocation,
    initialZoom: 14,
    ),
    children: [

    TileLayer(
    urlTemplate:
    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    userAgentPackageName:
    'com.example.parking_finder',
    ),
    MarkerLayer(
    markers: [

    /// Current Location
    Marker(
    point: _currentLocation,
    width: 60,
    height: 60,
    child: const Icon(
    Icons.location_on,
    color: Colors.blue,
    size: 40,
    ),
    ),

    // Parking Markers
              ...filteredParkingList.map(
                    (parking) => Marker(
                  point: LatLng(parking.latitude, parking.longitude),
                  width: 50,
                  height: 50,
                  child: GestureDetector(
                    onTap: () {
                      _showParkingDetails(parking);
                    },
                    child: const Icon(
                      Icons.local_parking,
                      color: Colors.green,
                      size: 35,
                    ),
                  ),
                ),
              ),
                   ],
              ),
      ],
              ),
              ),
      ],
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}