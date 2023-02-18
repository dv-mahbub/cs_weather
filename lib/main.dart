import 'package:cs_weather/responsive/responsive_layout.dart';
import 'package:cs_weather/view/homepage_desktop.dart';
import 'package:cs_weather/view/homepage_mobile.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(mobileView: HomepageMobileView(), desktopView: HomepageDesktopView(),);
  }
}
