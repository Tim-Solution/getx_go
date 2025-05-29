import 'package:getx_go/getx_go.dart';
import 'package:getx_go_example/modules/home/controllers/home_controller.dart';
import 'package:getx_go_example/modules/home/views/home_view.dart';

class HomeRouter extends RouteControllerConfig {
  @override
  GetxGoBuilder builder() {
    return (context, state) {
      return ControllerBindingEntry(
        controllers: [ControllerEntry<HomeController>(() => HomeController(), permanent: true)],
        view: () => const HomeView(),
      );
    };
  }
}
