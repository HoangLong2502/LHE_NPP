import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/base/base_button.dart';
import '../../../common/base/base_input.dart';
import '../../../common/base/base_layout.dart';
import '../../../common/constants/app_size_device.dart';
import '../../../common/constants/app_spacing.dart';
import 'index_controller.dart';
import 'index_item.dart';

class NppView extends StatefulWidget {
  const NppView({super.key});

  @override
  State<NppView> createState() => _NppViewState();
}

class _NppViewState extends State<NppView> {
  final _nppController = Get.put(NppController());

  TextEditingController? search;
  FocusNode? search_fn;
  bool isLoading = true;

  void _getAllNpp() {
    var page = 1;
    var systemKey = 'NPP';
    _nppController.getAllNpp(page, systemKey).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    search = TextEditingController();
    search_fn = FocusNode();

    _getAllNpp();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    search!.dispose();
    search_fn!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      'Quản lý nhà phân phối',
      isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  width: double.infinity,
                  child: MainButton(
                    title: 'Thêm mới người dùng',
                    event: () {},
                    largeButton: true,
                    icon: const Icon(
                      Icons.add_circle_outline,
                      size: 16,
                    ),
                  ),
                ),
                AppInput(
                  label: '',
                  hintText: 'Tìm kiếm nhà phân phối',
                  controller: search,
                  context: context,
                  show: true,
                  isPassword: false,
                  textInputType: TextInputType.text,
                  suffixIcon: const Icon(Icons.mic),
                  validate: () {},
                  fn: search_fn,
                ),
                SizedBox(height: sp16),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: heightDevice(context) - 400,
                    maxHeight: heightDevice(context) - 340,
                  ),
                  child: ListView.separated(
                    itemBuilder:(context, index) => NppCard(npp: _nppController.listNpp[index],),
                    separatorBuilder: (context, index) => SizedBox(height: sp16),
                    itemCount: _nppController.listNpp.length,
                  ),
                ),
              ],
            ),
    );
  }
}
