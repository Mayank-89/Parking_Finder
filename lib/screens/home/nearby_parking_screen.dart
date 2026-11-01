
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../database/parking_data.dart';
import '../../models/parking_model.dart';
import 'home_screen.dart';

class NearbyParkingScreen extends StatefulWidget {
  const NearbyParkingScreen({super.key});

  @override
  State<NearbyParkingScreen> createState() =>
      _NearbyParkingScreenState();
}

class _NearbyParkingScreenState extends State<NearbyParkingScreen> {
  Position? currentPosition;
  bool loading = true;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _getNearbyParking();
  }

  Future<void> _getNearbyParking() async {
    try {
      bool enabled =
      await Geolocator.isLocationServiceEnabled();

      if (!enabled) {
        throw Exception('Please enable location services.');
      }

      LocationPermission permission =
      await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception('Location permission is required.');
      }

      Position position =
      await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      if (!mounted) return;

      setState(() {
        currentPosition = position;
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  double _getDistance(Parking parking) {
    if (currentPosition == null) return 0;

    return Geolocator.distanceBetween(
      currentPosition!.latitude,
      currentPosition!.longitude,
      parking.latitude,
      parking.longitude,
    ) / 1000;
  }

  void _openParkingMap(Parking parking) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(
          selectedParking: parking,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Parking> nearbyList = parkingList
        .where((parking) =>
        parking.name.toLowerCase().contains(
          searchQuery.toLowerCase(),
        ))
        .toList();

    if (currentPosition != null) {
      nearbyList.sort(
            (a, b) => _getDistance(a).compareTo(_getDistance(b)),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAF2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7FAF2),
        title: const Text('Nearby Parking'),
        elevation: 0,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search parking...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          Expanded(
            child: nearbyList.isEmpty
                ? const Center(
              child: Text('No parking locations found'),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              itemCount: nearbyList.length,
              itemBuilder: (context, index) {
                final parking = nearbyList[index];

                return Card(
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 14),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius:
                                BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.local_parking,
                                size: 38,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    parking.name,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        size: 15,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        currentPosition == null
                                            ? 'Distance unavailable'
                                            : '${_getDistance(parking).toStringAsFixed(2)} km away',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 16,
                                      ),
                                      Text(
                                        ' ${parking.rating}',
                                        style: const TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 25),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '₹${parking.price.toStringAsFixed(0)}/hr',
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            Text(
                              '${parking.availableSlots} slots available',
                              style: const TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () =>
                                _openParkingMap(parking),
                            icon: const Icon(
                              Icons.map_outlined,
                            ),
                            label: const Text('View on Map'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              const Color(0xFF47794A),
                              foregroundColor: Colors.white,
                              padding:
                              const EdgeInsets.all(13),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
