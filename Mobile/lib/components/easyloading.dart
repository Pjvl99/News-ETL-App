import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void showLoading(String label) {
  EasyLoading.instance

    ..displayDuration = const Duration(milliseconds: 2000)

    ..indicatorType = EasyLoadingIndicatorType.cubeGrid;

  EasyLoading.show(status: label, maskType: EasyLoadingMaskType.clear);

}