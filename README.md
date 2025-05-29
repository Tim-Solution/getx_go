# GetxGo

A lightweight Flutter package that bridges [GoRouter](https://pub.dev/packages/go_router) with [GetX](https://pub.dev/packages/get) controllers — allowing you to seamlessly manage route-based controller initialization without relying on GetX's routing system.

## ✨ Features

- Automatic controller binding on route entry.
- Controller lifecycle handled automatically via `StatefulWidget`.
- Supports `lazy` and `permanent` controller instantiation.
- GoRouter-compatible route redirection and validation.
- Fully customizable transitions via `CustomTransitionPage`.
- Supports multiple controllers and tagging (`tag`) per route.

---

## 🚀 Getting Started

### Installation
```bash
flutter pub add getx_go
```

### Basic Usage
```dart
ControllerRoute(
  path: '/profile',
  routeControllerConfig: ProfileRouter(),
)
```

Each route must extend `RouteControllerConfig` and provide a builder that returns `ControllerBindingEntry`:

```dart
class ProfileRouter extends RouteControllerConfig {
  @override
  GetxGoBuilder builder() {
    return (context, state) {
      return ControllerBindingEntry(
        controllers: [
          ControllerEntry<ProfileController>(() => ProfileController()),
        ],
        view: () => const ProfileView(),
      );
    };
  }
}
```

## 🧠 Concepts

### `ControllerEntry`
Used to define how a controller is created and managed.
```dart
ControllerEntry<ProfileController>(
  () => ProfileController(),
  tag: 'optional-tag',
  lazy: true,
  permanent: false,
)
```

### `ControllerBindingEntry`
Wraps your view and handles all controller registration/disposal:
```dart
ControllerBindingEntry(
  controllers: [
    ControllerEntry(...),
    ControllerEntry(...),
  ],
  view: () => YourWidget(),
)
```

### Using Tags
```dart
ControllerEntry<ChatController>(
  () => ChatController(),
  tag: state.extra as String,
)
```
And inside the view:
```dart
class ChatView extends GetView<ChatController> {
  final String chatId;
  @override
  String get tag => chatId;
}
```

## 🔁 Redirect Logic
You can use `redirect()` to validate route conditions and cancel navigation:
```dart
@override
Redirect redirect() {
  return (context, state) {
    final token = state.uri.queryParameters['token'];
    if (token == null) {
      preventNavigation(state: state, message: 'Missing token');
    }
    return null;
  };
}
```

## 🎬 Custom Transitions
If `transitionsBuilder()` is provided, the route will use `CustomTransitionPage`:
```dart
@override
CustomTransitionBuilder? transitionsBuilder() {
  return (context, animation, secondaryAnimation, child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  };
}
```

---

## 📦 Example
```dart
GoRouter(
  routes: [
    ControllerRoute(path: '/login', routeControllerConfig: LoginRouter()),
    ControllerRoute(path: '/chat', routeControllerConfig: ChatRouter()),
    ControllerRoute(path: '/profile', routeControllerConfig: ProfileRouter()),
  ],
);
```

---

## 🧪 Advanced: Redirect + Tagged Controller
```dart
class ChatRouter extends RouteControllerConfig {
  @override
  GetxGoBuilder builder() {
    return (context, state) {
      final chatId = state.extra as String;
      return ControllerBindingEntry(
        controllers: [
          ControllerEntry<ChatController>(() => ChatController(), tag: chatId),
        ],
        view: () => ChatView(chatId: chatId),
      );
    };
  }

  @override
  Redirect? redirect() {
    return (context, state) {
      final chatId = state.extra as String?;
      if (chatId == null || chatId.isEmpty) {
        preventNavigation(state: state, message: 'Chat ID is required');
      }
      return null;
    };
  }
}
```

---

## 🔚 Notes
- Use `permanent: true` if you want your controller to persist across route changes.
- Use `lazy: false` if you want the controller to be instantiated immediately.
- Be careful with `tagged` controllers; make sure your view overrides `tag` properly.


---

## 💡 Contributions
Pull requests and issues are welcome!

If you find this package useful, consider starring the repo 🌟