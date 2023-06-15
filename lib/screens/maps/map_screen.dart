import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tubes/screens/maps/detail_map.dart';
import 'package:tubes/sharePref/user_session.dart';

class MapContent {
  double longitude, latitude;
  String namaTempat, alamatTempat, deskripsiTempat;
  MapContent(this.latitude, this.longitude, this.namaTempat, this.alamatTempat,
      this.deskripsiTempat);
}

class FirebaseMapsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'mapsInfo';

  Future<List<Map<String, dynamic>>> fetchData() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection(_collectionName).get();

      final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
          snapshot.docs;

      return documents.map((document) => document.data()).toList();
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final FirebaseMapsService _firebaseMapsService = FirebaseMapsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, // Change arrow color here
        ),
        title: const Text(
          "Offline Course Location",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Container(
            height: 400,
            width: double.infinity,
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(
                    -6.943020, 107.630507), // Initial map center coordinates
                zoom: 17.0, // Initial zoom level
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'], // Subdomains for the tile URLs
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Text("Location",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Container(
            height: 300,
            width: double.infinity,
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _firebaseMapsService.fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final List<Map<String, dynamic>> data = snapshot.data ?? [];

                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final mapData = data[index];
                    final String name = mapData['nama_tempat'];
                    final String alamat = mapData['alamat_tempat'];
                    final String deskripsi = mapData['deskripsi_tempat'];
                    final double latitude =
                        double.tryParse(mapData['latitude']) ?? 0.0;
                    final double longitude =
                        double.tryParse(mapData['longitude']) ?? 0.0;

                    return Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(60),
                        onTap: () {
                          MapContent map = MapContent(
                              latitude, longitude, name, alamat, deskripsi);
                          UserSession.saveDataLokasi(map);
                          Navigator.pushNamed(context, '/detail_map');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            height: 60,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      alamat,
                                      style: const TextStyle(fontSize: 11),
                                    ),
                                  ],
                                ),
                                Icon(Icons.arrow_forward_ios)
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
