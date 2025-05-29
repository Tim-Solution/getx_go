import 'package:flutter/material.dart';

import 'package:getx_go/getx_go.dart';
import 'package:getx_go_example/modules/feedback/controllers/feedback_controller.dart';
import 'package:getx_go_example/modules/feedback/views/feedback_view.dart';

class FeedbackRouter extends RouteControllerConfig {
  @override
  GetxGoBuilder builder() {
    return (context, state) {
      return ControllerBindingEntry(
        controllers: [
          ControllerEntry<FeedbackController>(
            () => FeedbackController(),
            lazy: false,
            permanent: true,
          ),
        ],
        view: () => const FeedbackView(),
      );
    };
  }

  @override
  CustomTransitionBuilder? transitionsBuilder() {
    return (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero).animate(animation),
        child: child,
      );
    };
  }
}
