import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:save_plan/constant/app_color.dart';
import 'package:save_plan/services/db.dart';
import 'package:save_plan/ui/setting/logic.dart';

class SettingView extends StatefulWidget {
  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  final SettingLogic _logic = Get.put(SettingLogic());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w, top: 70.h),
          child: Text(
            'Settings',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.sp,
                color: Colors.white),
          ),
        ),
        Expanded(
            child: Padding(
          padding:
              EdgeInsets.only(left: 16.w, right: 16.w, top: 12.w, bottom: 33.w),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
                color: AppColor.colorFF,
                borderRadius: BorderRadius.all(Radius.circular(10.w))),
            child: Column(
              children: [
                InkWell(
                    onTap: () {
                      _logic.clearPlans();
                    },
                    child: _item(title: 'Clear records')),
                _item(title: 'App version', content: '1.0.0')
              ],
            ),
          ),
        ))
      ],
    );
  }

  Widget _item({@required String? title, String? content}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title ?? "",
              style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColor.color10,
                  fontWeight: FontWeight.bold),
            ),
            content != null && content.isNotEmpty
                ? Text(
                    content,
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColor.color10.withOpacity(0.5)),
                  )
                : Icon(
                    Icons.arrow_forward_ios,
                    size: 13.w,
                    color: const Color(0xFFC8C8C8),
                  )
          ],
        ),
        Container(
          height: 1.w,
          color: AppColor.color10.withOpacity(0.1),
        ).marginSymmetric(vertical: 14.w)
      ],
    );
  }
}
