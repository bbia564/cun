import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:save_plan/services/triangle.dart';

class RecordState {
  RecordState() {}

  TextEditingController controller = TextEditingController();
  Rx<Plan> plan = Plan().obs;
}
