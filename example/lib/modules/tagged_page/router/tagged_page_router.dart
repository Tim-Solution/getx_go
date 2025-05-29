import 'package:getx_go/getx_go.dart';
import 'package:getx_go_example/modules/tagged_page/controllers/tagged_page_controller.dart';
import 'package:getx_go_example/modules/tagged_page/views/tagger_page_view.dart';

class TaggedPageRouter extends RouteControllerConfig {
  @override
  GetxGoBuilder builder() {
    return (context, state) {
      final tag = state.extra as String;
      return ControllerBindingEntry(
        controllers: [
          ControllerEntry<TaggedPageController>(() => TaggedPageController(), tag: tag),
        ],
        view: () => TaggerPageView(pageTag: tag),
      );
    };
  }

  @override
  Redirect? redirect() {
    return (context, state) {
      final tag = state.extra as String?;
      if (tag == null || tag.isEmpty) {
        preventNavigation(state: state, message: 'Tag is required');
      }
      return null;
    };
  }
}
