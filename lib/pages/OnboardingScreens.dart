import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/HelperWidgets.dart';
import 'package:hivemind_app/utils/colors.dart';
import 'package:hivemind_app/widgets/general/FilledBtn.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreens extends StatelessWidget {
  OnBoardingScreens({super.key});
  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.WEATHER_BG,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 500,
                width: 300,
                child: PageView(
                  controller: _controller,
                  children: [
                    OnBoardPage(
                      image: "assets/images/screen1.png",
                      title: "Manage Apiaries",
                      subtitle:
                          "Monitor your apiaries with ease. Check on your hives from your phone, thanks to IoT devices.",
                    ),
                    OnBoardPage(
                      image: "assets/images/screen2.png",
                      title: "Track Locations & Weather",
                      subtitle:
                          "Stay informed with weather updates and tracking of your apiaries' locations.",
                    ),
                    OnBoardPage(
                      image: "assets/images/screen3.png",
                      title: "Identify Diseases",
                      subtitle:
                          "Check hive status and health using image-based disease identification tools.",
                    ),
                  ],
                ),
              ),
              addVerticalSpace(40),
              SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: ExpandingDotsEffect(
                  activeDotColor: Theme.of(context).colorScheme.secondary,
                  dotColor: Theme.of(context).colorScheme.primary,
                  dotHeight: 8,
                  dotWidth: 8,
                  spacing: 20,
                ),
              ),
              addVerticalSpace(20),
              FilledBtn(
                text: "Get Started",
                onPress: () {
                  Navigator.pushNamed(context, "/login");
                },
              )
            ]),
      ),
    );
  }
}

class OnBoardPage extends StatelessWidget {
  const OnBoardPage(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle});

  final image;
  final title;
  final subtitle;

  @override
  Widget build(BuildContext context) {
    final titleStyle =
        Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 24);
    final subtitleStyle = Theme.of(context).textTheme.titleMedium;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        spacing: 40,
        children: [
          SizedBox(
            width: 220,
            height: 250,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            spacing: 40,
            children: [
              Text(
                title,
                style: titleStyle,
                textAlign: TextAlign.center,
              ),
              Text(
                subtitle,
                style: subtitleStyle,
                textAlign: TextAlign.center,
              ),
            ],
          )
        ],
      ),
    );
  }
}
