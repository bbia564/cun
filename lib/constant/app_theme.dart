import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_plan/constant/app_color.dart';

class AppTheme {
  static final ThemeData mainTheme = ThemeData(
    primaryColor: AppColor.mainColor,
    bottomAppBarTheme: BottomAppBarTheme(color: Colors.transparent),
    colorScheme: const ColorScheme.light(
      primary: AppColor.mainColor,
    ),
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      iconTheme: IconThemeData(
        color: AppColor.colorFF,
      ),
      titleTextStyle: TextStyle(
        color: AppColor.colorFF,
        fontSize: 16,
      ),
    ),

    /// 水波纹透明
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryColor,
        padding: EdgeInsets.zero,
        elevation: 3,
      ),
    ),
    scaffoldBackgroundColor: AppColor.mainColor,
    indicatorColor: AppColor.mainColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.colorFF,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(
        fontSize: 12.sp,
        color: AppColor.mainColor,
      ),
      unselectedItemColor: AppColor.color34,
      unselectedLabelStyle: TextStyle(
        fontSize: 12.sp,
        color: AppColor.color2906,
      ),
    ),
  );
}
