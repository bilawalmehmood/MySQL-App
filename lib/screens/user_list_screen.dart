import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mysql_app/controllers/user_list_controller.dart';
import 'package:mysql_app/screens/home_screen.dart';

class UserListScreen extends GetView<UserListController> {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserListController());
    controller.getAllUsers();
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        centerTitle: true,
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: <Widget>[
            Obx(
              () => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: Obx(
                        () => ListView.builder(
                          itemCount: controller.users.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: ListTile(
                                  title: Text(controller.users[index].name),
                                  subtitle: Text(controller.users[index].email),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      controller.deleteUser(
                                          controller.users[index].id);
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const HomeScreen());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
