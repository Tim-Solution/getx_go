import 'package:flutter/material.dart';

import 'package:get/state_manager.dart';
import 'package:go_router/go_router.dart';

import 'package:getx_go_example/modules/home/controllers/home_controller.dart';
import 'package:getx_go_example/router/app_router.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home View'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Align(child: _buildCounter()),
              const SizedBox(height: 80),
              Text(
                'Preview the counter value in the next view:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildOptionButton(
                label: 'Go to Counter Preview View with count',
                onPressed: () {
                  context.pushNamed(
                    AppRoutes.counterPreview.name,
                    extra: controller.count.value,
                  );
                },
              ),
              const SizedBox(height: 15),
              _buildOptionButton(
                label: 'Go to Counter Preview View without count',
                onPressed: () {
                  context.pushNamed(
                    AppRoutes.counterPreview.name,
                  );
                },
              ),
              const SizedBox(height: 50),
              Text('Go to the fake feedback view:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              _buildOptionButton(
                label: 'Go to Fake Feedback View',
                onPressed: () {
                  context.pushNamed(AppRoutes.feedback.name);
                },
              ),
              const SizedBox(height: 50),
              Text(
                'Go to the tagged page view with a unique tag:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildOptionButton(
                label: 'Go to Tagged Page View',
                onPressed: () {
                  context.pushNamed(
                    AppRoutes.taggedPage.name,
                    extra: UniqueKey().toString(),
                  );
                },
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCounter() {
    return Row(
      children: [
        Spacer(flex: 2),
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue,
          child: IconButton(
            icon: const Icon(Icons.remove, color: Colors.white),
            onPressed: controller.decrement,
          ),
        ),
        Spacer(),
        Obx(
          () => Text(
            '${controller.count}',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Spacer(),
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue,
          child: IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: controller.increment,
          ),
        ),
        Spacer(flex: 2),
      ],
    );
  }

  Widget _buildOptionButton({
    required String label,
    VoidCallback? onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
      ),
    );
  }
}
