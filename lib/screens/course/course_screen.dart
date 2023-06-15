import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:tubes/database/kursus_database.dart';
import 'package:tubes/database/subscription_database.dart';
import 'package:tubes/sharePref/user_session.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({Key? key}) : super(key: key);

  @override
  screen createState() => screen();
}

class screen extends State<CourseScreen> {
  List<Map<String, dynamic>> _dataKursus = [];
  List<Map<String, dynamic>> _dataSubs = [];
  bool _isLoading = true;
  int? id;
  String? kat;

  Future<void> loadId() async {
    int? temp1 = await UserSession.getId();
    String? temp2 = await UserSession.getKategori();
    setState(() {
      id = temp1;
      kat = temp2;
    });
  }

  Future<void> _refreshJournals(int id) async {
     final dataKursus = await KursusTable.getKursusSubs(id);
    setState(() {
      _dataKursus = dataKursus;
      _isLoading = false;
    });
  }

  Future<void> _refreshJournals2(String kat) async {
    final dataKursus = await KursusTable.getKursusbyKat(kat);
    setState(() {
      _dataKursus = dataKursus;
      _isLoading = false;
    });
  }

  Future<void> _refreshJournals3() async {
    final dataKursus = await KursusTable.getAllKursus();
    setState(() {
      _dataKursus = dataKursus;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadId().then((_) {
      if (kat == "user") {
        _refreshJournals(id!);
      } else if (kat == "other") {
        _refreshJournals3();
      } else {
        _refreshJournals2(kat!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, // Change arrow color here
        ),
        title: const Text(
          "Course",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              mainAxisSpacing: 10, // Spacing between rows
              crossAxisSpacing: 10, // Spacing between columns
            ),
            itemCount:
                _dataKursus.length, // Replace with the actual number of items
            itemBuilder: (BuildContext context, int index) {
              return Card(
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  splashColor: Colors.purple.withAlpha(30),
                  onTap: () {
                    UserSession.saveDataKursus(_dataKursus[index]['kursus_id']);
                    Navigator.of(context).pushNamed('/detail_course');
                  },
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage(_dataKursus[index]['kursusImage']),
                        ),
                        const SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _dataKursus[index]['kategori'],
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              _dataKursus[index]['judul_kursus'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
