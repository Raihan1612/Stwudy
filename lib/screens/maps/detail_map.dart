import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tubes/sharePref/user_session.dart';

void showContactModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Contact Person',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const ListTile(
              leading: Icon(Icons.person),
              title: Text('Name'),
              subtitle: Text("Budi Sudarsono"),
            ),
            const ListTile(
              leading: Icon(Icons.phone),
              title: Text('Phone'),
              subtitle: Text("08123123123"),
            ),
            const ListTile(
              leading: Icon(Icons.email),
              title: Text('Email'),
              subtitle: Text("iniemail@gmail.com"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        ),
      );
    },
  );
}

class DetailMapScreen extends StatelessWidget {
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
      body: FutureBuilder<Map<String, dynamic>?>(
        future: UserSession.getDataLokasi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While data is being fetched, display a loading indicator
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // If an error occurs while fetching the data, display an error message
            return const Center(child: Text('Error fetching data'));
          } else {
            // Data has been successfully fetched, display the map and information
            final data = snapshot.data;
            if (data == null) {
              // If data is null, handle the case when there is no data available
              return const Center(child: Text('No data available'));
            }

            final String nama = data['nama'] ?? 'null';
            final String alamat = data['alamat'] ?? 'null';
            final String deskripsi = data['deskripsi'] ?? 'null';
            final double latitude = data['latitude'] ?? 0.0;
            final double longitude = data['longitude'] ?? 0.0;

            final LatLng location = LatLng(latitude, longitude);

            return Column(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  child: FlutterMap(
                    options: MapOptions(
                      center: location,
                      zoom: 17.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: ['a', 'b', 'c'],
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 70.0,
                            height: 70.0,
                            point: location,
                            builder: (ctx) => Container(
                              child: const Icon(
                                Icons.location_pin,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Detail Information",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 400,
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/icons/Logo.png',
                          width: 100,
                          height: 100,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Nama:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(nama),
                      const SizedBox(height: 5),
                      const Text(
                        "Alamat:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(alamat),
                      const SizedBox(height: 5),
                      const Text(
                        "Informasi:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(deskripsi),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            onPressed: () {
              showContactModal(context);
            },
            child: const Text("Contact Now!")),
      ),
    );
  }
}
