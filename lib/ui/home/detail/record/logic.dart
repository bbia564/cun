import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:save_plan/services/db.dart';
import 'package:save_plan/services/triangle.dart';
import 'package:save_plan/ui/home/detail/record/state.dart';
import 'package:save_plan/utils/toast_util.dart';

class RecordLogic extends GetxController {
  final RecordState state = RecordState();

  void saveRecord() async {
    if (state.controller.text.isEmpty) {
      ToastUtil().showToast('Please enter the amount to record.');
      return;
    }
    state.plan.value.record!.add(Record(
        time: formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]),
        amount: state.controller.text));
    ToastUtil().showLoading();
    await DatabaseService().update(state.plan.value);
    ToastUtil().dismiss();
    Get.back(
        result: Record(
            time: formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]),
            amount: state.controller.text));
  }

  @override
  void onReady() {
    var result = Get.parameters;
    if (result != null) {
      if (result['plan'] is String) {
        var json = jsonDecode(result['plan'].toString());
        if (json != null) {
          state.plan.value = Plan.fromJson(json);
        }
      }
    }
    update();
    super.onReady();
  }
}
