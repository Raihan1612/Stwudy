import 'dart:io';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:tubes/database/kursus_database.dart';
import 'package:tubes/database/subscription_database.dart';
import 'package:tubes/database/user_database.dart';
import 'package:tubes/screens/other/card_course.dart';
import 'package:tubes/sharePref/user_session.dart';

List<cardCourse> card = [
  cardCourse("Design", "UI/UX Design", "/detail_course",
      "assets/images/Course_Design.png"),
  cardCourse("Marketing", "Digital Marketing", "/detail_course",
      'assets/images/Course_Market.png'),
  cardCourse("Marketing", "Digital Marketing", "/detail_course",
      'assets/images/Course_Market.png')
];

List<cardCourse> card2 = [
  cardCourse("Programming", "Front End Development", "/detail_course",
      "assets/images/Course_Programming1.png"),
  cardCourse("Programming", "Back End Development", "/detail_course",
      'assets/images/Course_Programming2.png'),
  cardCourse("Programming", "Front End Development", "/detail_course",
      "assets/images/Course_Programming1.png"),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  screen createState() => screen();
}

class screen extends State<HomeScreen> {
  List<Map<String, dynamic>> _data = [];
  List<Map<String, dynamic>> _dataKursus = [];
  List<Map<String, dynamic>> _dataSubs = [];
  bool _isLoading = true;
  bool _isDefault = true;
  File? _imageFile;
  int? _id;

  Future<void> loadId() async {
    int? temp = await UserSession.getId();
    setState(() {
      _id = temp;
    });
  }

  Future<void> _refreshJournals(int id) async {
    final data = await UserTable.getUser(id);
    final dataKursus = await KursusTable.getAllKursus();
    final dataSubs = await SubsTable.getAllSubscriptionById(id);
    setState(() {
      _data = data;
      _dataKursus = dataKursus;
      _dataSubs = dataSubs;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadId().then((_) {
      _refreshJournals(_id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> user;
    if (!_data.isEmpty) {
      user = _data[0];
    } else {
      user = {
        'user_id': 0,
      };
    }

    _isDefault = user['userImage'] == 'assets/icons/Logo.png';

    final _screen = MediaQuery.of(context).size;
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8),
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 30,
                                width: _screen.width * 0.65,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Hi! ${user['name']}",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Roboto"),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                  height: 30,
                                  width: _screen.width * 0.3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                              '/wish',
                                            );
                                          },
                                          child:
                                              const Icon(Icons.shopping_cart)),
                                      const SizedBox(width: 15),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                            '/profile',
                                          );
                                        },
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Colors.white,
                                            image: DecorationImage(
                                              image: _isDefault
                                                  ? AssetImage(
                                                      '${user['userImage']}')
                                                  : FileImage(File(
                                                          '${user['userImage']}'))
                                                      as ImageProvider<Object>,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: _screen.width,
                      child: const Text(
                        "Find your course 😁",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 16,
                    // ),
                    // Container(
                    //   width: 330,
                    //   height: 40,
                    //   decoration: BoxDecoration(
                    //     color: const Color.fromARGB(59, 159, 162, 162),
                    //     borderRadius: BorderRadius.circular(100),
                    //   ),
                    //   child: TextField(
                    //     decoration: InputDecoration(
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(100),
                    //       ),
                    //       hintText: 'Search here ...',
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text(
                                "Category",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Card(
                                color: const Color.fromARGB(225, 220, 204, 255),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: InkWell(
                                  splashColor: Colors.purple.withAlpha(30),
                                  onTap: () {
                                    UserSession.saveDataKategori("Design");
                                    Navigator.of(context).pushNamed(
                                      '/course',
                                    );
                                  },
                                  child: SizedBox(
                                    width: 70,
                                    height: 70,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/Design.svg',
                                          width: 22,
                                          height: 16,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "Design",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                color: const Color.fromARGB(225, 204, 225, 255),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: InkWell(
                                  splashColor: Colors.purple.withAlpha(30),
                                  onTap: () {
                                    UserSession.saveDataKategori("Market");
                                    Navigator.of(context).pushNamed(
                                      '/course',
                                    );
                                  },
                                  child: SizedBox(
                                    width: 70,
                                    height: 70,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/Market.svg',
                                          width: 18,
                                          height: 20,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "Market",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                color: const Color.fromARGB(225, 255, 204, 204),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: InkWell(
                                  splashColor: Colors.purple.withAlpha(30),
                                  onTap: () {
                                    UserSession.saveDataKategori("Coding");
                                    Navigator.of(context).pushNamed(
                                      '/course',
                                    );
                                  },
                                  child: SizedBox(
                                    width: 70,
                                    height: 70,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/Coding.svg',
                                          width: 20,
                                          height: 20,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "Coding",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                color: const Color.fromARGB(225, 230, 237, 243),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: InkWell(
                                  splashColor: Colors.purple.withAlpha(30),
                                  onTap: () {
                                    UserSession.saveDataKategori("Business");
                                    Navigator.of(context).pushNamed(
                                      '/course',
                                    );
                                  },
                                  child: SizedBox(
                                    width: 70,
                                    height: 70,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/Business.svg',
                                          width: 20,
                                          height: 20,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "Business",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ]),
                    const SizedBox(
                      height: 24,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Your Course",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                            TextButton(
                              child: const Text(
                                'View All',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 128, 128, 128),
                                    fontSize: 14),
                              ),
                              onPressed: () {
                                UserSession.saveDataKategori("user");
                                Navigator.of(context).pushNamed(
                                  '/course',
                                );
                              },
                            ),
                          ],
                        ),
                        Container(
                          height: 165,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _dataSubs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: [
                                  Card(
                                    clipBehavior: Clip.hardEdge,
                                    child: InkWell(
                                      splashColor: Colors.purple.withAlpha(30),
                                      onTap: () {
                                        UserSession.saveDataKursus(_dataKursus[
                                            _dataSubs[index]['kursus_id'] -
                                                1]['kursus_id']);
                                        Navigator.of(context).pushNamed(
                                          "/detail_course",
                                        );
                                      },
                                      child: SizedBox(
                                        width: 160,
                                        height: 160,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image(
                                                image: AssetImage(_dataKursus[
                                                    _dataSubs[index]
                                                            ['kursus_id'] -
                                                        1]['kursusImage'])),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        _dataKursus[_dataSubs[
                                                                    index]
                                                                ['kursus_id'] -
                                                            1]['kategori'],
                                                        style: const TextStyle(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        _dataKursus[_dataSubs[
                                                                    index]
                                                                ['kursus_id'] -
                                                            1]['judul_kursus'],
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Other Course",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                            TextButton(
                              child: const Text(
                                'View All',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 128, 128, 128),
                                    fontSize: 14),
                              ),
                              onPressed: () {
                                UserSession.saveDataKategori("other");
                                Navigator.of(context).pushNamed(
                                  '/course',
                                );
                              },
                            ),
                          ],
                        ),
                        Container(
                          height: 165,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _dataKursus.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: [
                                  Card(
                                    clipBehavior: Clip.hardEdge,
                                    child: InkWell(
                                      splashColor: Colors.purple.withAlpha(30),
                                      onTap: () {
                                        UserSession.saveDataKursus(
                                            _dataKursus[index]['kursus_id']);
                                        Navigator.of(context).pushNamed(
                                          "/detail_course",
                                        );
                                      },
                                      child: SizedBox(
                                        width: 160,
                                        height: 160,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image(
                                                image: AssetImage(
                                                    _dataKursus[index]
                                                        ['kursusImage'])),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        _dataKursus[index]
                                                            ['kategori'],
                                                        style: const TextStyle(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        _dataKursus[index]
                                                            ['judul_kursus'],
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
