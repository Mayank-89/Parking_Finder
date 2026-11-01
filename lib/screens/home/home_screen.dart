// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:latlong2/latlong.dart';
//
// import '../../database/parking_data.dart';
// import '../../models/parking_model.dart';
// import '../booking/booking_screen.dart';
// import '../history/history_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
//
//
//
// class HomeScreen extends StatefulWidget {
//   final Parking? selectedParking;
//
//   const HomeScreen({
//     super.key,
//     this.selectedParking,
//   });
//   // const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final MapController _mapController = MapController();
//   final TextEditingController _searchController = TextEditingController();
//   List<Parking> filteredParkingList = [];
//
//   Future<void> _logout() async {
//     await FirebaseAuth.instance.signOut();
//   }
//
//   LatLng _currentLocation = const LatLng(28.6139, 77.2090);
//   bool _locationLoaded = false;
//   double get _selectedParkingDistance {
//     final parking = widget.selectedParking;
//
//     if (parking == null || !_locationLoaded) return 0;
//
//     return Geolocator.distanceBetween(
//       _currentLocation.latitude,
//       _currentLocation.longitude,
//       parking.latitude,
//       parking.longitude,
//     ) / 1000;
//   }
//   Widget _buildSelectedParkingPanel() {
//     final parking = widget.selectedParking!;
//
//     return Container(
//       margin: const EdgeInsets.all(14),
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(22),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.15),
//             blurRadius: 15,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Center(
//             child: Container(
//               height: 5,
//               width: 45,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade300,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           ),
//
//           const SizedBox(height: 16),
//
//           Row(
//             children: [
//               Container(
//                 height: 55,
//                 width: 55,
//                 decoration: BoxDecoration(
//                   color: Colors.green.shade50,
//                   borderRadius: BorderRadius.circular(13),
//                 ),
//                 child: const Icon(
//                   Icons.local_parking,
//                   color: Colors.green,
//                   size: 32,
//                 ),
//               ),
//
//               const SizedBox(width: 12),
//
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       parking.name,
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//
//                     const SizedBox(height: 5),
//
//                     Row(
//                       children: [
//                         const Icon(
//                           Icons.star,
//                           color: Colors.amber,
//                           size: 17,
//                         ),
//                         Text(' ${parking.rating}'),
//
//                         const SizedBox(width: 12),
//
//                         const Icon(
//                           Icons.location_on,
//                           color: Colors.grey,
//                           size: 16,
//                         ),
//
//                         Text(
//                           _locationLoaded
//                               ? '${_selectedParkingDistance.toStringAsFixed(2)} km away'
//                               : 'Distance unavailable',
//                           style: const TextStyle(
//                             color: Colors.grey,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//
//           const SizedBox(height: 18),
//
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Price',
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                   Text(
//                     '₹${parking.price.toStringAsFixed(0)}/hr',
//                     style: const TextStyle(
//                       fontSize: 19,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green,
//                     ),
//                   ),
//                 ],
//               ),
//
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   const Text(
//                     'Available slots',
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                   Text(
//                     '${parking.availableSlots}',
//                     style: const TextStyle(
//                       fontSize: 19,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//
//           const SizedBox(height: 18),
//
//           SizedBox(
//             width: double.infinity,
//             height: 50,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF47794A),
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(13),
//                 ),
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => BookingScreen(
//                       parkingName: parking.name,
//                       pricePerHour: parking.price,
//                     ),
//                   ),
//                 );
//               },
//               child: const Text(
//                 'Book Now',
//                 style: TextStyle(
//                   fontSize: 17,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     filteredParkingList = parkingList;
//
//     if (widget.selectedParking != null) {
//       final parking = widget.selectedParking!;
//
//       _mapController.move(
//         LatLng(parking.latitude, parking.longitude),
//         16,
//       );
//     }
//
//     _getCurrentLocation();
//   }
//
//   void _searchParking(String value) {
//     setState(() {
//       filteredParkingList = parkingList.where((parking) {
//         return parking.name.toLowerCase().contains(value.toLowerCase());
//       }).toList();
//     });
//   }
//
//
//
//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled =
//     await Geolocator.isLocationServiceEnabled();
//
//     if (!serviceEnabled) return;
//
//     LocationPermission permission =
//     await Geolocator.checkPermission();
//
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//     }
//
//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       return;
//     }
//
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//         locationSettings: const LocationSettings(
//           accuracy: LocationAccuracy.high,
//         ),
//       );
//
//       if (!mounted) return;
//
//       setState(() {
//         _currentLocation = LatLng(
//           position.latitude,
//           position.longitude,
//         );
//         _locationLoaded = true;
//       });
//
//       // Only move to the user's location when no parking
//       // location was selected.
//       if (widget.selectedParking == null) {
//         _mapController.move(_currentLocation, 16);
//       }
//     } catch (e) {
//       debugPrint('Location error: $e');
//     }
//   }
//   void _showParkingDetails(Parking parking) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(25),
//         ),
//       ),
//       builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               Text(
//                 parking.name,
//                 style: const TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//
//               const SizedBox(height: 15),
//
//               Row(
//                 children: [
//                   const Icon(Icons.star, color: Colors.amber),
//                   const SizedBox(width: 5),
//                   Text(
//                     parking.rating.toString(),
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 10),
//
//               Text(
//                 "₹${parking.price.toStringAsFixed(0)} / hour",
//                 style: const TextStyle(
//                   fontSize: 20,
//                   color: Colors.green,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//
//               const SizedBox(height: 10),
//
//
//               Row(
//                 children: [
//                   const Icon(Icons.local_parking, color: Colors.blue),
//                   const SizedBox(width: 8),
//                   Text(
//                     "${parking.availableSlots} Slots Available",
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 25),
//
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                         Navigator.pop(context);
//                         Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => BookingScreen(
//                             parkingName: parking.name,
//                             pricePerHour: parking.price,
//                           ),
//                         ),
//                       );
//                   },
//                   child: const Text("Book Now"),
//                 ),
//               ),
//
//               const SizedBox(height: 10),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: const Text("Smart Parking Finder"),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.logout),
//               onPressed: _logout,
//             ),
//           ],
//         ),
//
//       body: Column(
//           children: [
//
//       Padding(
//       padding: const EdgeInsets.all(12),
//       child: TextField(
//         controller: _searchController,
//         onChanged: _searchParking,
//         decoration: InputDecoration(
//           hintText: "Search Parking...",
//           prefixIcon: const Icon(Icons.search),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//       ),
//     ),
//
//
//             Expanded(
//               child: Stack(
//                 children: [
//                   FlutterMap(
//                     mapController: _mapController,
//                     options: MapOptions(
//                       initialCenter: widget.selectedParking != null
//                           ? LatLng(
//                         widget.selectedParking!.latitude,
//                         widget.selectedParking!.longitude,
//                       )
//                           : _currentLocation,
//                       initialZoom:
//                       widget.selectedParking != null ? 16 : 14,
//                     ),
//                     children: [
//                       TileLayer(
//                         urlTemplate:
//                         'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                         userAgentPackageName:
//                         'com.example.parking_finder',
//                       ),
//
//                       MarkerLayer(
//                         markers: [
//                           // Actual user location
//                           Marker(
//                             point: _currentLocation,
//                             width: 50,
//                             height: 50,
//                             child: const Icon(
//                               Icons.my_location,
//                               color: Colors.blue,
//                               size: 32,
//                             ),
//                           ),
//
//                           // Parking locations
//                           ...filteredParkingList.map((parking) {
//                             final isSelected =
//                                 widget.selectedParking?.name == parking.name;
//
//                             return Marker(
//                               point: LatLng(
//                                 parking.latitude,
//                                 parking.longitude,
//                               ),
//                               width: 55,
//                               height: 55,
//                               child: GestureDetector(
//                                 onTap: () {
//                                   _mapController.move(
//                                     LatLng(
//                                       parking.latitude,
//                                       parking.longitude,
//                                     ),
//                                     16,
//                                   );
//                                   _showParkingDetails(parking);
//                                 },
//                                 child: Icon(
//                                   Icons.local_parking,
//                                   color: isSelected
//                                       ? Colors.orange
//                                       : Colors.green,
//                                   size: isSelected ? 45 : 35,
//                                 ),
//                               ),
//                             );
//                           }),
//                         ],
//                       ),
//                     ],
//                   ),
//
//                   // Selected parking information panel
//                   if (widget.selectedParking != null)
//                     Positioned(
//                       left: 0,
//                       right: 0,
//                       bottom: 5,
//                       child: _buildSelectedParkingPanel(),
//                     ),
//                 ],
//               ),
//             ),
//
//           ],
//               ),
//
//
//
//       floatingActionButton: FloatingActionButton(
//         onPressed: _getCurrentLocation,
//         child: const Icon(Icons.my_location),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../database/parking_data.dart';
import '../../models/parking_model.dart';
import '../booking/booking_screen.dart';

class HomeScreen extends StatefulWidget {
  final Parking? selectedParking;

  const HomeScreen({
    super.key,
    this.selectedParking,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController =
  TextEditingController();

  List<Parking> filteredParkingList = [];

  LatLng _currentLocation = const LatLng(28.6139, 77.2090);

  bool _locationLoaded = false;
  bool _loadingLocation = false;

  Parking? _activeParking;

  @override
  void initState() {
    super.initState();

    filteredParkingList = parkingList;

    _activeParking = widget.selectedParking;

    // Initially show the selected parking location.
    if (_activeParking != null) {
      _mapControllerReadyLocation();
    }

    _getCurrentLocation();
  }

  // Move map to selected parking location.
  // The initial map position is also set in MapOptions.
  void _mapControllerReadyLocation() {
    // Actual movement is handled after the map is created.
    // This method intentionally does not move the controller.
  }

  // Logout
  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
  }

  // Get current user location.
  Future<void> _getCurrentLocation() async {
    if (_loadingLocation) return;

    _loadingLocation = true;

    try {
      bool serviceEnabled =
      await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please enable location services.'),
            ),
          );
        }
        return;
      }

      LocationPermission permission =
      await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Location permission is required.'),
            ),
          );
        }
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      if (!mounted) return;

      setState(() {
        _currentLocation = LatLng(
          position.latitude,
          position.longitude,
        );

        _locationLoaded = true;
      });

      // If no parking location was selected,
      // move the map to the user's current location.
      if (_activeParking == null) {
        _mapController.move(_currentLocation, 16);
      }
    } catch (e) {
      debugPrint('Location error: $e');
    } finally {
      _loadingLocation = false;
    }
  }

  // Search parking locations.
  void _searchParking(String value) {
    setState(() {
      filteredParkingList = parkingList.where((parking) {
        return parking.name.toLowerCase().contains(
          value.toLowerCase(),
        );
      }).toList();
    });
  }

  // Calculate distance from user to parking.
  double _getDistance(Parking parking) {
    if (!_locationLoaded) return 0;

    return Geolocator.distanceBetween(
      _currentLocation.latitude,
      _currentLocation.longitude,
      parking.latitude,
      parking.longitude,
    ) / 1000;
  }

  // Select parking location on map.
  void _selectParking(Parking parking) {
    setState(() {
      _activeParking = parking;
    });

    _mapController.move(
      LatLng(
        parking.latitude,
        parking.longitude,
      ),
      16,
    );
  }

  // Open parking details bottom sheet.
  void _showParkingDetails(Parking parking) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 5,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                parking.name,
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    parking.rating.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Text(
                '₹${parking.price.toStringAsFixed(0)} / hour',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  const Icon(
                    Icons.local_parking,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${parking.availableSlots} Slots Available',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF47794A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(sheetContext);

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
                  child: const Text(
                    'Book Now',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // Uber-style selected parking information panel.
  Widget _buildSelectedParkingPanel() {
    final parking = _activeParking!;

    return Container(
      margin: const EdgeInsets.all(14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 5,
              width: 45,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.local_parking,
                  color: Colors.green,
                  size: 32,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      parking.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 17,
                        ),
                        Text(' ${parking.rating}'),

                        const SizedBox(width: 10),

                        const Icon(
                          Icons.location_on,
                          color: Colors.grey,
                          size: 16,
                        ),

                        Text(
                          _locationLoaded
                              ? '${_getDistance(parking).toStringAsFixed(2)} km away'
                              : 'Distance unavailable',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              IconButton(
                onPressed: () {
                  setState(() {
                    _activeParking = null;
                  });
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Price',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    '₹${parking.price.toStringAsFixed(0)}/hr',
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Available slots',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    '${parking.availableSlots}',
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 18),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF47794A),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
              onPressed: () {
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
              child: const Text(
                'Book Now',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Parking Finder'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),

      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              onChanged: _searchParking,
              decoration: InputDecoration(
                hintText: 'Search Parking...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _searchParking('');
                  },
                )
                    : null,
              ),
            ),
          ),

          // Map
          Expanded(
            child: Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: widget.selectedParking != null
                        ? LatLng(
                      widget.selectedParking!.latitude,
                      widget.selectedParking!.longitude,
                    )
                        : _currentLocation,
                    initialZoom:
                    widget.selectedParking != null ? 16 : 14,
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
                        // User's actual location
                        if (_locationLoaded)
                          Marker(
                            point: _currentLocation,
                            width: 50,
                            height: 50,
                            child: const Icon(
                              Icons.my_location,
                              color: Colors.blue,
                              size: 32,
                            ),
                          ),

                        // Parking markers
                        ...filteredParkingList.map((parking) {
                          final isSelected =
                              _activeParking?.name == parking.name;

                          return Marker(
                            point: LatLng(
                              parking.latitude,
                              parking.longitude,
                            ),
                            width: 55,
                            height: 55,
                            child: GestureDetector(
                              onTap: () {
                                _selectParking(parking);
                                _showParkingDetails(parking);
                              },
                              child: Icon(
                                Icons.local_parking,
                                color: isSelected
                                    ? Colors.orange
                                    : Colors.green,
                                size: isSelected ? 45 : 35,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),

                // Selected parking panel
                if (_activeParking != null)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 5,
                    child: _buildSelectedParkingPanel(),
                  ),
              ],
            ),
          ),
        ],
      ),

      // Current location button
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFB8E9B5),
        onPressed: () {
          if (_locationLoaded) {
            _mapController.move(_currentLocation, 16);
          } else {
            _getCurrentLocation();
          }
        },
        child: const Icon(
          Icons.my_location,
          color: Color(0xFF263329),
        ),
      ),
    );
  }
}
