import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KshowSnakbar {
  KshowSnakbar(String title,String msg) {
    Get.snackbar(title, msg,snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.black,
    colorText: Colors.white);
  }
}
