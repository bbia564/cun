import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:save_plan/constant/app_color.dart';
import 'package:save_plan/resource/R.dart';
import 'package:save_plan/services/db.dart';
import 'package:save_plan/services/triangle.dart';
import 'package:save_plan/ui/home/logic.dart';
import 'package:save_plan/utils/load_image.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewLogic _logic = Get.put(HomeViewLogic());

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void initState() {
    _logic.updatePlans();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.w, top: 70.h),
                child: Text(
                  'Savings plan',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.sp,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w, top: 6.h),
                child: Text(
                  'Keep going and achieve your goals.',
                  style: TextStyle(fontSize: 12.sp, color: Colors.white),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(
                    left: 16.w, right: 16.w, top: 28.h, bottom: 33.h),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: AppColor.linearGradient,
                      borderRadius: BorderRadius.all(Radius.circular(10.w))),
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Target list',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: AppColor.mainColor),
                      ).marginOnly(bottom: 14.h),
                      Expanded(child: Obx(() {
                        return _logic.state.plans.isNotEmpty
                            ? ListView.separated(
                                padding: EdgeInsets.only(top: 0.h),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        Get.toNamed('/detail',
                                                parameters: {
                                              'plan': jsonEncode(
                                                  _logic.state.plans[index])
                                            })!
                                            .then((value) {
                                          _logic.updatePlans();
                                        });
                                      },
                                      child: _item(_logic.state.plans[index]));
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 5.w,
                                  );
                                },
                                itemCount: _logic.state.plans.length)
                            : _emptyView();
                      }))
                    ],
                  ),
                ),
              ))
            ],
          ),
          Positioned(
              top: 62.h,
              right: 16.w,
              child: Image.asset(
                R.drawable.app_logo_icon,
                width: 128.w,
              ))
        ],
      ),
    );
  }

  Widget _item(Plan plan) {
    String completed = '0';
    String rate = '0%';
    String time = '';
    if (plan.record != null && plan.record!.isNotEmpty) {
      double count = 0;
      for (var element in plan.record!) {
        count = count + double.tryParse(element.amount ?? '0')!;
      }
      String r = (count / plan.targetAmount! * 100).toStringAsFixed(2);
      rate = '${r}%';
      completed = count.toString();
      time = plan.record?.last.time ?? '';
    }
    return Card(
        borderOnForeground: false,
        shadowColor: const Color(0xFF000000).withOpacity(0.16),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0.w),
        ),
        child: Container(
          height: 179.h,
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(6.w))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  height: 109.h,
                  child: Row(
                    children: [
                      plan.image != null && plan.image!.isNotEmpty
                          ? ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.w)),
                              child: plan.image!.contains('assets')
                                  ? LoadImage(
                                      plan.image!,
                                      width: 93.w,
                                      height: 109.h,
                                      defaultIcon:
                                          R.drawable.app_logo_gray_icon,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.memory(
                                      base64Decode(plan.image!),
                                      width: 93.w,
                                      height: 109.h,
                                      fit: BoxFit.cover,
                                    )
                              // Image.network(
                              //   plan.image!,
                              //   width: 93.w,
                              //   height: 109.h,
                              //   fit: BoxFit.cover,
                              // )
                              )
                          : Container(
                              width: 93.w,
                              height: 109.h,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFEDEDED),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6.w))),
                              child: Center(
                                child: Image.asset(
                                  R.drawable.app_logo_gray_icon,
                                  width: 70.w,
                                ),
                              ),
                            ),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(left: 14.w),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        plan.title ?? '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: AppColor.color10,
                                            fontWeight: FontWeight.bold),
                                      )),
                                      const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 13,
                                        color: AppColor.mainColor,
                                      ).marginOnly(left: 15.w)
                                    ],
                                  ),
                                  Container(
                                    height: 1.w,
                                    color: const Color(0xFF000000)
                                        .withOpacity(0.1),
                                    width: double.infinity,
                                  ),
                                  _textItem(
                                      title: 'Target amount：',
                                      content: '${plan.targetAmount ?? 0}'),
                                  _textItem(
                                      title: 'Completed：', content: completed),
                                  _textItem(title: 'Progress：', content: rate),
                                ],
                              )))
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Last record：',
                        style:
                            TextStyle(fontSize: 12.sp, color: AppColor.color10),
                      ),
                      Text(
                        time,
                        style:
                            TextStyle(fontSize: 12.sp, color: AppColor.color10),
                      ).marginOnly(top: 4.w),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/detail',
                          parameters: {
                            'plan': jsonEncode(plan)
                          })!
                          .then((value) {
                        _logic.updatePlans();
                      });
                    },
                    child: Container(
                      width: 124.w,
                      height: 36.h,
                      decoration: BoxDecoration(
                          color: AppColor.mainColor,
                          borderRadius: BorderRadius.all(Radius.circular(6.w))),
                      child: Center(
                        child: Text(
                          'Record',
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget _textItem({@required String? title, String? content}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title ?? '',
          style: TextStyle(fontSize: 12.sp, color: AppColor.color10),
        ),
        Text(
          content ?? '',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
              color: AppColor.color10),
        ),
      ],
    );
  }

  Widget _emptyView() {
    return Center(
        child: GestureDetector(
            onTap: () async {
              var result = await DatabaseService().getAll();
              if (result != null) {}
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  R.drawable.app_logo_gray_icon,
                  width: 70.w,
                ),
                Text(
                  'No plans at the moment',
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColor.color10.withOpacity(0.3)),
                ).marginOnly(top: 12.w),
              ],
            ))).marginOnly(bottom: 100.h);
  }
}
