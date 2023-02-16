import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

PreferredSizeWidget BaseAppBar(String title) {
  return AppBar(
    title: Text('$title'),
    actions: [
      // IconButton(onPressed:() {
        
      // }, icon: Icon(Icons.search, size: 20,)),
      IconButton(onPressed:() {
        
      }, icon: Icon(Icons.notifications_outlined, size: 20,)),
      IconButton(onPressed:() {
        Get.offAndToNamed(Routes.routeAccount);
      }, icon: Icon(Icons.account_circle_outlined, size: 20,))
    ],
  );
}