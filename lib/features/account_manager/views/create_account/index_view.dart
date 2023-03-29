import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/base/base_appBar.dart';
import '../../../../common/util/enum/type_user.dart';
import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/app_size_device.dart';
import '../../../../common/constants/app_spacing.dart';
import 'index_controller.dart';
import 'index_item/npp.dart';
import 'index_item/nvtt.dart';

class CreateUserView extends StatefulWidget {
  const CreateUserView({super.key});

  @override
  State<CreateUserView> createState() => _CreateUserViewState();
}

class _CreateUserViewState extends State<CreateUserView> {
  CreateUserController _controller = Get.put(CreateUserController());

  TypeUser? _typeUser;
  bool _isLoading = true;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    if (_typeUser == null) {
      _typeUser = ModalRoute.of(context)!.settings.arguments as TypeUser;
      print(_typeUser);
      switch (_typeUser) {
        case TypeUser.NPP:
          await _controller.get_profile('NPP');
          break;
        default:
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar('Tạo người dùng'),
      body: Container(
        width: widthDevice(context),
        height: heightDevice(context),
        padding: EdgeInsets.only(top: sp24),
        color: AppColors.bg_4,
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_typeUser == TypeUser.NPP)
                      CreateNPP(controller: _controller)
                    else if (_typeUser == TypeUser.NVTT)
                      CreateNVTT(controller: _controller)
                    else if (_typeUser == TypeUser.KT)
                      Text('KT')
                    else if (_typeUser == TypeUser.KH)
                      Text('KHO')
                    else
                      Text('AD'),
                  ],
                ),
              ),
      ),
    );
  }
}
