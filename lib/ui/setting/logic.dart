import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:save_plan/services/db.dart';
import 'package:save_plan/utils/toast_util.dart';

class SettingLogic extends GetxController {
  void clearPlans() async {
    ToastUtil().showLoading();
    await DatabaseService().clean();
    ToastUtil().dismiss();
  }
}
