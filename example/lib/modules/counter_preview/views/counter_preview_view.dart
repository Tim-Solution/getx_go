import 'package:flutter/material.dart';

import 'package:get/state_manager.dart';

import 'package:getx_go_example/modules/counter_preview/controllers/counter_preview_controller.dart';

class CounterPreviewView extends GetView<CounterPreviewController> {
  const CounterPreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter Preview View'), centerTitle: true),
      body: Center(
        child: Text(
          controller.getCount.toString(),
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
