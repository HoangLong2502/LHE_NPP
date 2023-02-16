import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index_controller.dart';
import 'index_item.dart';

class GroupView extends StatefulWidget {
  const GroupView({super.key});

  @override
  State<GroupView> createState() => _GroupViewState();
}

class _GroupViewState extends State<GroupView> {
  final _groupController = Get.put(GroupController());

  bool isLoading = true;

  void createGroup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Card(
          child: PopCreateGroup(),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _groupController.getListGroup().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? CircularProgressIndicator()
        : _groupController.isEmtyList
            ? GroupEmty(createGroup: createGroup,)
            : GroupList(groupController: _groupController, createGroup: createGroup,);
  }
}
