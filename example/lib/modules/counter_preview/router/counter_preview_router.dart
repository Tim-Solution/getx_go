import 'package:getx_go/getx_go.dart';
import 'package:getx_go_example/modules/counter_preview/controllers/counter_preview_controller.dart';
import 'package:getx_go_example/modules/counter_preview/views/counter_preview_view.dart';

class CounterPreviewRouter extends RouteControllerConfig {
  @override
  GetxGoBuilder builder() {
    return (context, state) {
      final count = state.extra as int;
      return ControllerBindingEntry(
        controllers: [
          ControllerEntry<CounterPreviewController>(() => CounterPreviewController(count)),
        ],
        view: () => const CounterPreviewView(),
      );
    };
  }

  @override
  Redirect redirect() {
    return (context, state) {
      if (state.extra is! int) {
        preventNavigation(state: state, message: 'Counter value is required');
      }
      return null;
    };
  }
}
