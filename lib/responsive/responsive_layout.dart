import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget? mobileView;
  final Widget? desktopView;
  const ResponsiveLayout({Key? key, this.desktopView, required this.mobileView}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      if (constrains.maxWidth > 600) {
        return desktopView?? Container();
      } else {
        return mobileView ?? Container();
      }
    });
  }
}
