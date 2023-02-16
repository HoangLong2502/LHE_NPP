import 'package:flutter/material.dart';

import '../../common/base/base_layout.dart';
import '../../features/account_manager/views/index_view.dart';

class UserManagerScreen extends StatefulWidget {
  const UserManagerScreen({super.key});

  @override
  State<UserManagerScreen> createState() => _UserManagerScreenState();
}

class _UserManagerScreenState extends State<UserManagerScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseLayout('Danh sách người dùng', const UserManagerView());
  }
}