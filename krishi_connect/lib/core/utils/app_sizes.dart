import 'package:flutter/widgets.dart';

class AppSizes {
  final BuildContext context;

  AppSizes(this.context);

  // ---------------------------
  // MediaQuery Shortcuts
  // ---------------------------
  Size get size => MediaQuery.of(context).size;

  double get width => size.width;
  double get height => size.height;

  double get topPadding => MediaQuery.of(context).padding.top;
  double get bottomPadding => MediaQuery.of(context).padding.bottom;
  double get statusBarHeight => MediaQuery.of(context).padding.top;

  Orientation get orientation => MediaQuery.of(context).orientation;
  bool get isPortrait => orientation == Orientation.portrait;
  bool get isLandscape => orientation == Orientation.landscape;

  // ---------------------------
  // Breakpoints
  // ---------------------------
  static const double mobileMax = 600;
  static const double tabletMax = 1024;

  bool get isMobile => width <= mobileMax;
  bool get isTablet => width > mobileMax && width <= tabletMax;
  bool get isDesktop => width > tabletMax;

  // ---------------------------
  // Percentage based sizing
  // ---------------------------
  double wp(double percent) => width * percent / 100;
  double hp(double percent) => height * percent / 100;

  // Example: text responsive sizing
  double sp(double size) => size * (width / 375);

  // ---------------------------
  // Responsive Builder
  // ---------------------------
  static Widget builder({
    required BuildContext context,
    required Widget Function(BuildContext context) mobile,
    Widget Function(BuildContext context)? tablet,
    Widget Function(BuildContext context)? desktop,
  }) {
    final width = MediaQuery.of(context).size.width;

    if (width > tabletMax && desktop != null) {
      return desktop(context);
    } else if (width > mobileMax && tablet != null) {
      return tablet(context);
    } else {
      return mobile(context);
    }
  }
}
