import 'package:flutter/material.dart';
import 'package:responsive_demo/constants.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;
  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  // This size work fine on my design, maybe you need some customization depends on your design

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileWidth;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < desktopWidth &&
      MediaQuery.of(context).size.width >= mobileWidth;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktopWidth;

  @override
  Widget build(BuildContext context) {
    // If our width is more than 1100 then we consider it a desktop
    if (isDesktop(context)) {
      return desktop;
    }
    // If width it less then 1100 and more then 850 we consider it as tablet
    else if (isTablet(context)) {
      return tablet!;
    }
    // Or less then that we called it mobile
    else {
      return mobile;
    }
  }
}
