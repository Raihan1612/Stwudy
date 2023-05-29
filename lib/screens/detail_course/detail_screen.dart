import 'package:flutter/material.dart';

class DetailCourseScreen extends StatelessWidget {
  const DetailCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, // Change arrow color here
        ),
        title: const Text(
          "Judul Course",
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
                      height: 60,
                      width: double.infinity,
                      child: Row(
                        children: [
                          const Image(
                              image: AssetImage("assets/images/detail_course.png")),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Episode 1",
                                style: TextStyle(
                                  fontSize: 11,
                                ),
                              ),
                              Text(
                                "Introduction",
                                style: TextStyle(fontSize: 14),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 60,
                      width: double.infinity,
                      child: Row(
                        children: [
                          const Image(
                              image: AssetImage("assets/images/detail_course.png")),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Episode 2",
                                style: TextStyle(
                                  fontSize: 11,
                                ),
                              ),
                              Text(
                                "Introduction",
                                style: TextStyle(fontSize: 14),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 60,
                      width: double.infinity,
                      child: Row(
                        children: [
                          const Image(
                              image: AssetImage("assets/images/detail_course.png")),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Episode 3",
                                style: TextStyle(
                                  fontSize: 11,
                                ),
                              ),
                              Text(
                                "Introduction",
                                style: TextStyle(fontSize: 14),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 8, right: 8, bottom: 20),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          child: Text('Start Course'),
        ),
      ),
    );
  }
}
