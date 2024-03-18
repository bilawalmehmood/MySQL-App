import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mysql_app/controllers/user_list_controller.dart';
import 'package:mysql_app/model/user_model.dart';
import 'package:mysql_app/screens/home_screen.dart';

class UserListScreen extends GetView<UserListController> {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserListController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        centerTitle: true,
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: FutureBuilder<List<UserModel>>(
          future: controller.getAllUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return ListView.builder(
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
                            controller.deleteUser(controller.users[index].id);
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            }else{
              return const Center(child: Text('No data found'));
            }
          },
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
