import 'package:go_router/go_router.dart';

import 'package:getx_go/getx_go.dart';
import 'package:getx_go_example/modules/counter_preview/router/counter_preview_router.dart';
import 'package:getx_go_example/modules/feedback/router/feedback_router.dart';
import 'package:getx_go_example/modules/home/router/home_router.dart';
import 'package:getx_go_example/modules/tagged_page/router/tagged_page_router.dart';

abstract class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      ControllerRoute(path: AppRoutes.home, routeControllerConfig: HomeRouter()),
      ControllerRoute(path: AppRoutes.feedback, routeControllerConfig: FeedbackRouter()),
      ControllerRoute(
        path: AppRoutes.counterPreview,
        routeControllerConfig: CounterPreviewRouter(),
      ),
      ControllerRoute(path: AppRoutes.taggedPage, routeControllerConfig: TaggedPageRouter()),
    ],
  );
}

abstract class AppRoutes {
  static const String home = '/home';
  static const String feedback = '/feedback';
  static const String counterPreview = '/counter-preview';
  static const String taggedPage = '/tagged-page';
}
