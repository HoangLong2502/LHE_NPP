import 'package:flutter/material.dart';

import '../../features/app/views/app_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AppView()
    );
  }
}