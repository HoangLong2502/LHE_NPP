import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/constants/app_size_device.dart';
import '../../../../common/constants/app_typography.dart';
import '../../../../common/constants/assets_path.dart';
import 'login_controller.dart';
import 'login_item.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  TextEditingController? username, password;

  final _loginValidate = GlobalKey<FormState>();
  final _loginController = Get.put(LoginController());

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: widthDevice(context),
          height: heightDevice(context),
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 124,
            bottom: 16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset('${AssetsPath.image}/lh_logo.png')),
              const SizedBox(
                height: 48,
              ),
              Text(
                'Đăng nhập'.tr,
                style: AppTypography.h2,
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 24,
              ),
              buildFormLogin(context, _loginValidate, _loginController.username, _loginController.password),
              const SizedBox(
                height: 16,
              ),
              buildMoreActionLogin(),
              const SizedBox(
                height: 82,
              ),
              buildLoginButton(context, _loginValidate),
            ],
          ),
        ),
      ),
    );
  }
}
