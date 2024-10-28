import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CenterState {
  CenterState() {}

  var imageFile = XFile('').obs;
  TextEditingController nameTF = TextEditingController();
  TextEditingController amountTF = TextEditingController();
  TextEditingController timeTF = TextEditingController();

  Rx<DateTime> cuTime = DateTime.now().obs;
}
