import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData getThemeData(bool isDark) {
  final baseTheme = isDark ? ThemeData.dark() : ThemeData.light();
  // TextTheme textTheme = getTextTheme(baseTheme.textTheme, colors);
  return baseTheme.copyWith(
      // textTheme: textTheme,
      primaryColor: const Color(0xFFFF7C84),
      // backgroundColor: colors.grey.o1,
      scaffoldBackgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.grey[50], size: 18.r),
      // errorColor: colors.error,
      // bottomNavigationBarTheme: _bottomAppBarTheme(
      //   colors,
      //   textTheme,
      //   baseTheme: baseTheme.bottomNavigationBarTheme,
      // ),
      // appBarTheme: _appBarTheme(
      //   colors,
      //   textTheme,
      //   baseTheme: baseTheme.appBarTheme,
      // ),
    );
}