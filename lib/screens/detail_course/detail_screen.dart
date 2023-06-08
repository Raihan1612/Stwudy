import 'package:flutter/material.dart';
import 'package:tubes/database/kursus_database.dart';
import 'package:tubes/database/subscription_database.dart';
import 'package:tubes/database/video_database.dart';
import 'package:tubes/database/wishlist_database.dart';
import 'package:tubes/sharePref/user_session.dart';

class DetailCourseScreen extends StatefulWidget {
  const DetailCourseScreen({Key? key}) : super(key: key);

  @override
  screen createState() => screen();
}

class screen extends State<DetailCourseScreen> {
  List<Map<String, dynamic>> _dataKursus = [];
  List<Map<String, dynamic>> _dataVideo = [];
  List<Map<String, dynamic>> _dataSubs = [];
  bool _isLoading = true;
  bool _isSubscribe = false;
  int? _idUser;
  int? _idKursus;

  Future<void> loadId() async {
    int? tempUser = await UserSession.getId();
    int? tempKursus = await UserSession.getKursus();
    setState(() {
      _idUser = tempUser;
      _idKursus = tempKursus;
    });
  }

  Future<void> _refreshJournals(int idUser, int idKursus) async {
    final dataKursus = await KursusTable.getKursus(idKursus);
    final dataVideo = await VideoTable.getVideoByKursus(idUser);
    final dataSubs = await SubsTable.getSubscriptionById(idUser, idKursus);
    setState(() {
      _dataKursus = dataKursus;
      _dataVideo = dataVideo;
      _dataSubs = dataSubs;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadId().then((_) {
      _refreshJournals(_idUser!, _idKursus!);
    });
  }

  void showPaymentModal(int idUser, int idKursus) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Course Payment',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Please proceed with the payment to access the course content.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  SubsTable.createSubscription(idUser, idKursus);
                  Navigator.of(context).pushNamed(
                    '/home',
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Proceed to Payment'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> kursus;
    if (!_dataKursus.isEmpty) {
      kursus = _dataKursus[0];
    } else {
      kursus = {
        'kursus_id': 0,
      };
    }

    _isSubscribe = _dataSubs.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, // Change arrow color here
        ),
        title: Text(
          " ${kursus['judul_kursus']}",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Image(image: AssetImage("assets/images/ux_dashboard.png")),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "About",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                        "UI/UX (User Interface/User Experience) design course is designed to teach students the principles of designing effective and user-friendly interfaces for digital products such as websites, mobile apps, and other interactive systems. "),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Playlist",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: 330,
                        child: ListView.builder(
                          itemCount: _dataVideo.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: InkWell(
                                splashColor: Colors.purple.withAlpha(30),
                                onTap: _isSubscribe
                                    ? () {
                                        Navigator.of(context).pushNamed(
                                          '/video',
                                        );
                                      }
                                    : () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                                "You are not subscribed to this course."),
                                          ),
                                        );
                                      },
                                child: Container(
                                  height: 60,
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                          "assets/images/detail_course.png"),
                                      const SizedBox(width: 20),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Episode ${index + 1}",
                                            style:
                                                const TextStyle(fontSize: 11),
                                          ),
                                          Text(
                                            _dataVideo[index]['judul_video'],
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 8, right: 8, bottom: 20),
        child: Row(
          children: [
            ElevatedButton(
              onPressed: _isSubscribe
                  ? () {
                      Navigator.of(context).pushNamed(
                        '/video',
                      );
                    }
                  : () {
                      showPaymentModal(_idUser!, _idKursus!);
                    },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(355, 30),
                primary: Colors.blue,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              child: Text('Start Course'),
            ),
            SizedBox(
              width: 5,
            ),
            ElevatedButton(
              onPressed: () {
                WishlistTable.createWishlist(_idUser!, _idKursus!);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text("Course added to your wishlist."),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              child: Icon(Icons.shopping_cart),
            ),
          ],
        ),
      ),
    );
  }
}
