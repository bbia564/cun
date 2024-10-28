import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:save_plan/constant/app_color.dart';
import 'package:save_plan/resource/R.dart';
import 'package:save_plan/ui/center/logic.dart';
import 'package:save_plan/ui/logic.dart';

class CenterView extends StatefulWidget {
  @override
  _CenterViewState createState() => _CenterViewState();
}

class _CenterViewState extends State<CenterView> {
  final _logic = Get.put(HomeLogic());
  final _tLogic = Get.put(CenterLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
        title: Text(
          'Add plan',
          style: TextStyle(
              fontSize: 16.sp,
              color: AppColor.colorFF,
              fontWeight: FontWeight.bold),
        ),
        leading: InkWell(
          onTap: () {
            _tLogic.clearData();
            _logic.toPage(_logic.state.lastIndex.value);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: AppColor.colorFF,
          ),
        ),
      ),
      body: Container(
          width: double.infinity,
          height: 479.h,
          margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h),
          padding:
              EdgeInsets.only(left: 22.w, right: 22.w, top: 23.h, bottom: 23.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.w))),
          child: ListView(
            children: [
              Text(
                'Image illustration',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    color: AppColor.color34),
              ),
              Obx(() {
                return GestureDetector(
                  onTap: () {
                    _tLogic.choseAvator(context);
                  },
                  child: Row(
                    children: [
                      _tLogic.state.imageFile.value != null &&
                              _tLogic.state.imageFile.value.path.isNotEmpty
                          ? ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.w)),
                              child: Image.file(
                                File(_tLogic.state.imageFile.value.path),
                                width: 107.w,
                                height: 107.w,
                                fit: BoxFit.cover,
                              ),
                            ).marginOnly(top: 14.w)
                          : Container(
                              width: 107.w,
                              height: 107.w,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF7F7F7),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.w))),
                              child: Center(
                                child: Image.asset(
                                  R.drawable.add_icon,
                                  width: 35.w,
                                ),
                              ),
                            ).marginOnly(top: 14.w),
                      const Expanded(child: SizedBox())
                    ],
                  ),
                );
              }),
              _item(
                title: 'Project Name',
                content: 'Enter name',
                controller: _tLogic.state.nameTF,
                type: TextInputType.text,
              ).marginOnly(top: 12.w),
              _item(
                title: 'Target amount',
                content: 'Enter amount',
                controller: _tLogic.state.amountTF,
                type: TextInputType.number,
              ).marginOnly(top: 12.w),
              _item(
                      title: 'Duration',
                      content: 'Enter time',
                      controller: _tLogic.state.timeTF)
                  .marginOnly(top: 12.w),
              GestureDetector(
                onTap: () {
                  _tLogic.savePlan(
                    callback: () {
                      _tLogic.clearData();
                      _logic.toPage(_logic.state.lastIndex.value);
                    },
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 50.h,
                  decoration: BoxDecoration(
                      color: AppColor.mainColor,
                      borderRadius: BorderRadius.all(Radius.circular(25.h))),
                  child: Center(
                    child: Text(
                      'Add',
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColor.colorFF,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ).marginOnly(top: 12.w),
              )
            ],
          )),
    );
  }

  Widget _item(
      {@required String? title,
      @required String? content,
      TextEditingController? controller,
      TextInputType? type}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? '',
          style: TextStyle(fontSize: 12.sp, color: AppColor.color34),
        ),
        Stack(
          children: [
            CupertinoTextField(
              textInputAction: TextInputAction.done,
              controller: controller,
              padding: const EdgeInsets.all(0),
              keyboardType: type ?? TextInputType.text,
              decoration: null,
              placeholder: content ?? '',
              placeholderStyle: TextStyle(
                color: AppColor.colorA8,
                fontSize: 14.sp,
              ),
              style: TextStyle(
                color: AppColor.color10,
                fontSize: 14.sp,
              ),
              onChanged: (value) {},
              onSubmitted: (value) {},
            ).marginOnly(top: 12.w),
            title == 'Duration'
                ? Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: GestureDetector(
                        onTap: () {
                          _tLogic.selectDate(context);
                        },
                        child: Container(
                          color: Colors.transparent,
                        )))
                : const SizedBox()
          ],
        ),
        Container(
          height: 1.w,
          color: AppColor.color10.withOpacity(0.1),
        ).marginOnly(top: 12.w),
      ],
    );
  }
}
