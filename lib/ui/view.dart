import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:save_plan/constant/app_color.dart';
import 'package:save_plan/ui/logic.dart';
import 'package:save_plan/ui/state.dart';
import 'package:save_plan/utils/keep_alive_wrapper.dart';
import 'package:save_plan/utils/load_image.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _logic = Get.put(HomeLogic());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _logic.backApp,
      child: Obx(() {
        return Scaffold(
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _logic.state.pageController,
            children: _logic.state.tabList
                .map((e) => KeepAliveWrapper(
                      child: e.widget,
                      isKeep: e.text != 'Current record',
                    ))
                .toList(),
          ),
          bottomNavigationBar: _logic.state.currentIndex.value == 1
              ? const SizedBox()
              : BottomNavigationBar(
                  backgroundColor: const Color.fromRGBO(243, 249, 254, 1),
                  selectedItemColor: AppColor.mainColor,
                  unselectedItemColor: AppColor.color2906,
                  currentIndex: _logic.state.currentIndex.value,
                  onTap: (int index) => _logic.toPage(index),
                  items: _logic.state.tabList.map((TabItemModel e) {
                    return e.text.isNotEmpty
                        ? BottomNavigationBarItem(
                            icon: LoadImage(e.unSelectIcon,
                                width: 30.w, height: 30.w, fit: BoxFit.cover),
                            activeIcon: LoadImage(e.selectIcon,
                                width: 30.w, height: 30.w, fit: BoxFit.cover),
                            label: e.text,
                          )
                        : BottomNavigationBarItem(
                            icon: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColor.mainColor,
                                borderRadius: BorderRadius.circular(43.w * 0.5),
                              ),
                              width: 43.w,
                              height: 43.w,
                              child: Image.asset(
                                e.selectIcon,
                                width: 23.w,
                              ),
                            ),
                            activeIcon: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColor.mainColor,
                                borderRadius: BorderRadius.circular(43.w * 0.5),
                              ),
                              width: 43.w,
                              height: 43.w,
                              child: Image.asset(
                                e.selectIcon,
                                width: 23.w,
                              ),
                            ),
                            label: e.text,
                          );
                  }).toList(),
                ),
        );
      }),
    );
  }

  @override
  void dispose() {
    Get.delete<HomeLogic>();
    super.dispose();
  }
}
