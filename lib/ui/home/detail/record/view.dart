import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:save_plan/constant/app_color.dart';
import 'package:save_plan/ui/home/detail/record/logic.dart';

class RecordView extends StatefulWidget {
  @override
  _RecordViewState createState() => _RecordViewState();
}

class _RecordViewState extends State<RecordView> {
  RecordLogic _logic = Get.put(RecordLogic());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        appBar: AppBar(
          backgroundColor: AppColor.mainColor,
          title: Text(
            'edit',
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
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              _item(
                title: 'Record amount',
                content: 'Enter amount',
                controller: _logic.state.controller,
                type: TextInputType.number,
              ).marginOnly(top: 12.w),
              GestureDetector(
                onTap: () {
                  _logic.saveRecord();
                },
                child: Container(
                  width: double.infinity,
                  height: 50.h,
                  decoration: BoxDecoration(
                      color: AppColor.mainColor,
                      borderRadius: BorderRadius.all(Radius.circular(25.h))),
                  child: Center(
                    child: Text(
                      'Save',
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColor.colorFF,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ).marginOnly(top: 12.w),
              )
            ],
          ),
        ));
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
        Container(
          height: 1.w,
          color: AppColor.color10.withOpacity(0.1),
        ).marginOnly(top: 12.w),
      ],
    );
  }
}
