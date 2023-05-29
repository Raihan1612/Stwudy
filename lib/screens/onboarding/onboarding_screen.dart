import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentIndex = 0;
  CarouselController carouselController = CarouselController();

  List<String> titles = [
    "Belajar via Video",
    "Belajar Dimana dan Kapan Saja",
    "Uji Kemampuanmu",
  ];

  List<String> subTitles = [
    "Pilih course yang cocok dengan ",
    "Kamu bisa menentukan sendiri jadwalmu",
    "Tes kemampuanmu dengan mengerjakan challenge yang disediakan",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider(
              items: [
                SvgPicture.asset(
                  'assets/images/Media.svg',
                  height: 329,
                ),
                SvgPicture.asset(
                  'assets/images/Consultation.svg',
                  height: 329,
                ),
                SvgPicture.asset(
                  'assets/images/Thesis.svg',
                  height: 329,
                ),
              ],
              options: CarouselOptions(
                height: 331,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
              carouselController: carouselController,
            ),
            const SizedBox(height: 100),
            Text(
              titles[currentIndex],
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 26),
            Text(
              subTitles[currentIndex],
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        '/login',
                      );
                    },
                    child: const Text(
                      'SKIP',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentIndex == 0 ? Colors.blue : Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentIndex == 1 ? Colors.blue : Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentIndex == 2 ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      if (currentIndex == 2) {
                        Navigator.of(context).pushNamed(
                          '/login',
                        );
                      } else {
                        carouselController.nextPage();
                      }
                    },
                    child: const Text(
                      'NEXT',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
