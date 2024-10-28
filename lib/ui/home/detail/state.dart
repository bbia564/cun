import 'package:get/get.dart';
import 'package:save_plan/services/triangle.dart';

class DetailState {
  DetailState() {}

  Rx<Plan> plan = Plan().obs;
}
