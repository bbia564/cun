import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:save_plan/constant/app_color.dart';
import 'package:save_plan/resource/R.dart';
import 'package:save_plan/ui/home/detail/logic.dart';
import 'package:save_plan/utils/load_image.dart';

class DetailPage extends StatefulWidget {
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DetailLogic _logic = Get.put(DetailLogic());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.mainColor,
          title: Text(
            'Detail',
            style: TextStyle(
                fontSize: 16.sp,
                color: AppColor.colorFF,
                fontWeight: FontWeight.bold),
          ),
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: AppColor.colorFF,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                _logic.deletePlan();
              },
              child: Icon(
                Icons.delete_forever,
                size: 23.w,
              ).marginOnly(right: 23.w),
            )
          ],
        ),
        body: Column(
          children: [
            Container(
                margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 10.w),
                height: 218.h,
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.w))),
                child: Column(
                  children: [
                    Obx(() {
                      String completed = '0';
                      String rate = '0%';
                      String time = '';
                      if (_logic.state.plan.value.record != null &&
                          _logic.state.plan.value.record!.isNotEmpty) {
                        double count = 0;
                        for (var element in _logic.state.plan.value.record!) {
                          count =
                              count + double.tryParse(element.amount ?? '0')!;
                        }
                        String r = (count /
                                _logic.state.plan.value.targetAmount! *
                                100)
                            .toStringAsFixed(2);
                        rate = '${r}%';
                        completed = count.toString();
                        time = _logic.state.plan.value.record?.last.time ?? '';
                      }
                      return Container(
                          height: 109.h,
                          child: Row(
                            children: [
                              _logic.state.plan.value.image != null &&
                                      _logic.state.plan.value.image!.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(6.w)),
                                      child: _logic.state.plan.value.image!
                                              .contains('assets')
                                          ? LoadImage(
                                              _logic.state.plan.value.image!,
                                              width: 93.w,
                                              height: 109.h,
                                              defaultIcon:
                                                  R.drawable.app_logo_gray_icon,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.memory(
                                              base64Decode(_logic
                                                  .state.plan.value.image!),
                                              width: 93.w,
                                              height: 109.h,
                                              fit: BoxFit.cover,
                                            ))
                                  : Container(
                                      width: 93.w,
                                      height: 109.h,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFEDEDED),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6.w))),
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
                                                _logic.state.plan.value.title ??
                                                    '',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: AppColor.color10,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
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
                                              content:
                                                  '${_logic.state.plan.value.targetAmount ?? 0}'),
                                          _textItem(
                                              title: 'Completed：',
                                              content: completed),
                                          _textItem(
                                              title: 'Progress：',
                                              content: rate),
                                        ],
                                      )))
                            ],
                          ));
                    }),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/record', parameters: {
                          'plan': jsonEncode(_logic.state.plan.value)
                        })!
                            .then((value) {
                          if (value != null) {
                            _logic.updateRecord(value);
                          }
                        });
                      },
                      child: Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                            color: AppColor.mainColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.h))),
                        child: Center(
                          child: Text(
                            'Record once',
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColor.colorFF,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ).marginOnly(top: 12.w),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Last record：',
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColor.color10.withOpacity(0.5)),
                        ),
                        Obx(() {
                          String time = '';

                          if (_logic.state.plan.value.record != null &&
                              _logic.state.plan.value.record!.isNotEmpty) {
                            time =
                                _logic.state.plan.value.record!.last.time ?? '';
                          }
                          return Text(
                            time,
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColor.color10),
                          );
                        })
                      ],
                    ).marginOnly(top: 4.w)
                  ],
                )),
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 10.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.w),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.w))),
                  child: Obx(() {
                    List<Widget> childs = [_title()];

                    if (_logic.state.plan.value.record != null &&
                        _logic.state.plan.value.record!.isNotEmpty) {
                      for (var element in _logic.state.plan.value.record!) {
                        childs.add(
                          _item(
                              time: element.time ?? '',
                              amount: element.amount ?? '0'),
                        );
                      }
                    }
                    return ListView(
                      children: childs,
                    );
                  })),
            )
          ],
        ));
  }

  Widget _textItem({@required String? title, String? content}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title ?? '',
          style: TextStyle(
              fontSize: 12.sp, color: AppColor.color10.withOpacity(0.5)),
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

  Widget _item({@required String? time, @required String? amount}) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  time ?? '',
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColor.color10,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  amount ?? '',
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColor.mainColor,
                      fontWeight: FontWeight.bold),
                )
              ],
            )),
        Container(
          height: 1.w,
          color: AppColor.color10.withOpacity(0.1),
          margin: EdgeInsets.symmetric(vertical: 14.w),
        )
      ],
    );
  }

  Widget _title() {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date',
                  style: TextStyle(fontSize: 12.sp, color: AppColor.colorA8),
                ),
                Text(
                  'Amount',
                  style: TextStyle(fontSize: 12.sp, color: AppColor.colorA8),
                )
              ],
            )),
        Container(
          height: 1.w,
          color: AppColor.color10.withOpacity(0.1),
          margin: EdgeInsets.symmetric(vertical: 14.w),
        )
      ],
    );
  }
}
