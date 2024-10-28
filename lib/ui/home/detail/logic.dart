import 'dart:convert';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:save_plan/services/db.dart';
import 'package:save_plan/services/triangle.dart';
import 'package:save_plan/ui/home/detail/state.dart';
import 'package:save_plan/utils/toast_util.dart';

class DetailLogic extends GetxController {
  final DetailState state = DetailState();

  @override
  void onInit() {
    super.onInit();
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

  updateRecord(Record record) {
    Plan tplan = state.plan.value;
    tplan.record!.add(record);
    state.plan.value = tplan;
    state.plan.update((val) {});
  }

  deletePlan() async {
    ToastUtil().showLoading();
    await DatabaseService().delete(state.plan.value.id!);
    ToastUtil().dismiss();
    Get.back();
  }
}
