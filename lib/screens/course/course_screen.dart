import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key});

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
          child: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          splashColor: Colors.purple.withAlpha(30),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              '/detail_course',
                            );
                          },
                          child: SizedBox(
                            width: 160,
                            height: 160,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Image(
                                    image: AssetImage(
                                        'assets/images/Course_Design.png')),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "Design",
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "UI/UX Design",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          splashColor: Colors.purple.withAlpha(30),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              '/detail_course',
                            );
                          },
                          child: SizedBox(
                            width: 160,
                            height: 160,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Image(
                                    image: AssetImage(
                                        'assets/images/Course_Market.png')),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "Marketing",
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "Digital Marketing",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          splashColor: Colors.purple.withAlpha(30),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              '/detail_course',
                            );
                          },
                          child: SizedBox(
                            width: 160,
                            height: 160,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Image(
                                    image: AssetImage(
                                        'assets/images/Course_Design.png')),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "Design",
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "UI/UX Design",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          splashColor: Colors.purple.withAlpha(30),
                          onTap: () {},
                          child: SizedBox(
                            width: 160,
                            height: 160,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Image(
                                    image: AssetImage(
                                        'assets/images/Course_Market.png')),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "Marketing",
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "Digital Marketing",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          splashColor: Colors.purple.withAlpha(30),
                          onTap: () {},
                          child: SizedBox(
                            width: 160,
                            height: 160,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Image(
                                    image: AssetImage(
                                        'assets/images/Course_Design.png')),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "Design",
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "UI/UX Design",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          splashColor: Colors.purple.withAlpha(30),
                          onTap: () {},
                          child: SizedBox(
                            width: 160,
                            height: 160,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Image(
                                    image: AssetImage(
                                        'assets/images/Course_Market.png')),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "Marketing",
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "Digital Marketing",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          splashColor: Colors.purple.withAlpha(30),
                          onTap: () {},
                          child: SizedBox(
                            width: 160,
                            height: 160,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Image(
                                    image: AssetImage(
                                        'assets/images/Course_Design.png')),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "Design",
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "UI/UX Design",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          splashColor: Colors.purple.withAlpha(30),
                          onTap: () {},
                          child: SizedBox(
                            width: 160,
                            height: 160,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Image(
                                    image: AssetImage(
                                        'assets/images/Course_Market.png')),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "Marketing",
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "Digital Marketing",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          splashColor: Colors.purple.withAlpha(30),
                          onTap: () {},
                          child: SizedBox(
                            width: 160,
                            height: 160,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Image(
                                    image: AssetImage(
                                        'assets/images/Course_Design.png')),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "Design",
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "UI/UX Design",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          splashColor: Colors.purple.withAlpha(30),
                          onTap: () {},
                          child: SizedBox(
                            width: 160,
                            height: 160,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Image(
                                    image: AssetImage(
                                        'assets/images/Course_Market.png')),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "Marketing",
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "Digital Marketing",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
