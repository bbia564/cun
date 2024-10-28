import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:save_plan/utils/camera_permission_dialog.dart';

class PermissionHelper {
  Future<bool> checkAndRequestCameraPermissions(BuildContext context) async {
    final status = await Permission.camera.status;
    if (status.isDenied || status.isRestricted) {
      // 权限被拒绝或受限，请求权限
      final requestStatus = await Permission.camera.request();
      // 用户已拒绝，并且不再询问
      if (requestStatus.isPermanentlyDenied) {
        // 引导用户去设置页面开启权限
        // await openAppSettings();
        showDialog(
            context: context,
            builder: (context) {
              return CameraPermissionDialog(
                callback: () async {
                  await openAppSettings();
                },
              );
            });
        return false;
      }
      // 用户拒绝，但仍可以再次请求
      return requestStatus.isGranted;
    } else if (status.isGranted) {
      // 权限已经被授予
      return true;
    }
    // 应用第一次运行，权限未知
    return false;
  }

  Future<bool> checkAndRequestPhotoPermissions(BuildContext context) async {
    final status = await Permission.camera.status;
    if (status.isDenied || status.isRestricted) {
      // 权限被拒绝或受限，请求权限
      final requestStatus = await Permission.camera.request();
      // 用户已拒绝，并且不再询问
      if (requestStatus.isPermanentlyDenied) {
        // 引导用户去设置页面开启权限
        showDialog(
            context: context,
            builder: (context) {
              return CameraPermissionDialog(
                callback: () async {
                  await openAppSettings();
                },
              );
            });
        return false;
      }
      // 用户拒绝，但仍可以再次请求
      return requestStatus.isGranted;
    } else if (status.isGranted) {
      // 权限已经被授予
      return true;
    }
    // 应用第一次运行，权限未知
    return false;
  }
}
