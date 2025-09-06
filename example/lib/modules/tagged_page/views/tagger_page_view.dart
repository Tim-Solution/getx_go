import 'package:flutter/material.dart';

import 'package:get/state_manager.dart';

import 'package:getx_go_example/modules/tagged_page/controllers/tagged_page_controller.dart';

class TaggerPageView extends GetView<TaggedPageController> {
  final String pageTag;

  const TaggerPageView({super.key, required this.pageTag});

  @override
  String get tag => pageTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tagged Page View - $pageTag',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        centerTitle: true,
      ),
      body: Center(child: Text(controller.fakeRxVar.value)),
    );
  }
}
