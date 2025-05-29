import 'package:flutter/material.dart';

import 'package:get/get.dart';

typedef ControllerInstanceBuilder<T> = T Function();
typedef ViewBuilder = Widget Function();

class ControllerEntry<T extends GetxController> {
  /// The controller instance builder. This is a function that returns an instance of the controller.
  /// It is used to create the controller when it is needed.
  final ControllerInstanceBuilder<T> controller;

  /// Optional tag to register the controller with a specific tag.
  final String? tag;

  /// If true, the controller will be created lazily. If false, it will be created immediately.
  final bool lazy;

  /// If true, the controller will be registered as permanent and will not be removed from memory.
  final bool permanent;

  ControllerEntry(this.controller, {this.tag, this.lazy = true, this.permanent = false})
    : assert(T.toString() != 'dynamic', 'Type must be specified');

  void initController() {
    if (!Get.isRegistered<T>(tag: tag)) {
      if (lazy) {
        Get.lazyPut<T>(() => controller(), tag: tag, fenix: permanent);
      } else {
        Get.put(controller(), tag: tag, permanent: permanent);
      }
    }
  }

  void disposeController() {
    if (!permanent) Get.delete<T>(tag: tag);
  }
}

class ControllerBindingEntry extends StatefulWidget {
  final List<ControllerEntry> controllers;
  final ViewBuilder view;

  const ControllerBindingEntry({super.key, this.controllers = const [], required this.view});

  @override
  State<ControllerBindingEntry> createState() => _ControllerBindingEntryState();
}

class _ControllerBindingEntryState extends State<ControllerBindingEntry> {
  @override
  void initState() {
    super.initState();
    _registerControllers();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _registerControllers() {
    for (final entry in widget.controllers) {
      entry.initController();
    }
  }

  void _disposeControllers() {
    for (final entry in widget.controllers) {
      entry.disposeController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.view();
  }
}
