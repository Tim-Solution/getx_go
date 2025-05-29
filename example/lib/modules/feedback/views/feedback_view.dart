import 'package:flutter/material.dart';

import 'package:get/state_manager.dart';

import 'package:getx_go_example/modules/feedback/controllers/feedback_controller.dart';

class FeedbackView extends GetView<FeedbackController> {
  const FeedbackView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('This is just dummy feedback view ${controller.fakeRxValue.value}')),
    );
  }
}
