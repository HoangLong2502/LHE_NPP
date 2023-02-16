import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/app_size_device.dart';
import '/constants/assets_path.dart';
import '/features/app/model/app_model.dart';
import 'app_controller.dart';
import 'app_item.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _appController = Get.put(AppController());

  List<AppModel> _listApp = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _listApp = _appController.listApp;
    });
  }

  @override
  void dispose() {
    super.dispose();
    // _visitController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(child: Image.asset('${AssetsPath.image}/bg_home.png', width: widthDevice(context), height: heightDevice(context), fit: BoxFit.cover,)),
          Padding(
            padding: const EdgeInsets.all(0),
            child: CarouselSlider(
              options: CarouselOptions(
                height: heightDevice(context),
                viewportFraction: 1
              ),
              items:[
                buildSlider_2(context, _appController),
                buildSlider_1(context, _listApp),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
