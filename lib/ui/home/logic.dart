import 'dart:io';

import 'package:get/get.dart';
import 'package:save_plan/services/db.dart';
import 'package:save_plan/ui/home/state.dart';

class HomeViewLogic extends GetxController {
  final HomeViewState state = HomeViewState();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  void updatePlans() {
    DatabaseService().getAll().then((result) {
      if (result != null) {
        state.plans.value = result;
      }
    });
  }
}
