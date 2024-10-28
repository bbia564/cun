import 'package:get/get.dart';

import 'batool_logic.dart';

class RentalBuildBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PageLogic(),
      permanent: true,
    );
  }
}
