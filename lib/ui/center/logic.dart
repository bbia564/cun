import 'dart:convert';
import 'dart:io';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:save_plan/services/db.dart';
import 'package:save_plan/services/triangle.dart';
import 'package:save_plan/ui/center/state.dart';
import 'package:save_plan/utils/image_picker_dialog.dart';
import 'package:save_plan/utils/toast_util.dart';

class CenterLogic extends GetxController {
  final CenterState state = CenterState();

  void choseAvator(BuildContext context) async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        state.imageFile.value = pickedFile;
        update();
      }
    } catch (e) {
      return;
    }
  }

  void savePlan({VoidCallback? callback}) async {
    if (state.imageFile.value.path.isEmpty) {
      ToastUtil().showToast('Please select an image.');
      return;
    }
    if (state.nameTF.text.isEmpty) {
      ToastUtil().showToast('Please enter the name.');
      return;
    }
    if (state.amountTF.text.isEmpty) {
      ToastUtil().showToast('Please enter the amount.');
      return;
    }
    if (state.timeTF.text.isEmpty) {
      ToastUtil().showToast('Please enter the time.');
      return;
    }

    String image = await imageToBase64(File(state.imageFile.value.path));
    Plan plan = Plan(
        id: faker.randomGenerator.integer(1000, min: 21),
        title: state.nameTF.text,
        targetAmount: double.tryParse(state.amountTF.text),
        image: image);
    ToastUtil().showLoading();
    await DatabaseService().insert(plan);
    ToastUtil().dismiss();
    callback!();
  }

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: state.cuTime.value,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));
    if (picked != null) {
      state.cuTime.value = picked;
      state.timeTF.text = '${picked.year}-${picked.month}-${picked.day}';
    }
  }

  void clearData() {
    state.imageFile.value = XFile('');
    state.nameTF.clear();
    state.amountTF.clear();
    state.timeTF.clear();
  }

  Future<String> imageToBase64(File image) async {
    List<int> imageBytes = await image.readAsBytes();
    return base64Encode(imageBytes);
  }
}
