import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:save_plan/resource/R.dart';
import 'package:save_plan/ui/center/view.dart';
import 'package:save_plan/ui/home/view.dart';
import 'package:save_plan/ui/setting/view.dart';

class TabItemModel {
  String text;
  String selectIcon;
  String unSelectIcon;
  Widget widget;

  TabItemModel({
    required this.text,
    required this.selectIcon,
    required this.widget,
    this.unSelectIcon = "",
  });
}

class HomeState {
  HomeState() {}

  DateTime? lastPopTime;
  PageController pageController = PageController();
  RxInt currentIndex = 0.obs;
  RxInt lastIndex = 0.obs;

  List<TabItemModel> tabList = [
    TabItemModel(
      text: "Current",
      selectIcon: R.drawable.home_s_icon,
      unSelectIcon: R.drawable.home_u_icon,
      widget: Stack(
        children: [
          Positioned.fill(child: HomeView()),
        ],
      ),
      // widget: HistoryRecordPage(),
    ),
    TabItemModel(
      text: "",
      selectIcon: R.drawable.center_icon,
      unSelectIcon: R.drawable.center_icon,
      widget: Stack(
        children: [
          Positioned.fill(child: CenterView()),
        ],
      ),
      // widget: HistoryRecordPage(),
    ),
    TabItemModel(
      text: "Settings",
      selectIcon: R.drawable.setting_s_icon,
      unSelectIcon: R.drawable.setting_u_icon,
      widget: Stack(
        children: [
          Positioned.fill(
            child: SettingView(),
          ),
        ],
      ),
    ),
  ];
}
