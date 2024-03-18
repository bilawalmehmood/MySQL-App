import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mysql_app/controllers/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Welcome to MySQL App',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              const Text(
                'You can use this app to perform CRUD operations on MySQL database',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller.nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter your name'
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller.emailController,
                decoration: const InputDecoration(
                  hintText: 'Enter your email'
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                ()=> controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                  onPressed: controller.insert,
                  child: const Text('Insert'),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}