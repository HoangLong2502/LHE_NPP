import 'package:flutter/material.dart';

import '../../common/base/base_appBar.dart';
import '../../components/maps/index.dart';
import '../../constants/app_size_device.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar('Danh sách mạng lưới bán hàng'),
      body: SizedBox(
        width: widthDevice(context),
        height: heightDevice(context),
        child: const GoogleMapComponent(),
      ),
    );
  }
}