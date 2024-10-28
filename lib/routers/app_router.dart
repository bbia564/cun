import 'package:get/get.dart';
import 'package:save_plan/ui/center/view.dart';
import 'package:save_plan/ui/home/detail/record/view.dart';
import 'package:save_plan/ui/home/detail/view.dart';
import 'package:save_plan/ui/home/view.dart';
import 'package:save_plan/ui/setting/view.dart';
import 'package:save_plan/ui/view.dart';
import 'routers.dart';

class AppRouter {
  static final List<GetPage> pages = [
    GetPage(name: Routers.main, page: () => HomePage()),
    GetPage(
      name: Routers.home,
      page: () => HomeView(),
    ),
    GetPage(
      name: Routers.settings,
      page: () => SettingView(),
    ),
    GetPage(
      name: Routers.center,
      page: () => CenterView(),
    ),
    GetPage(name: Routers.detail, page: () => DetailPage()),
    GetPage(name: Routers.record, page: () => RecordView())
  ];
}
