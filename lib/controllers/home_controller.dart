import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mysql_app/db/database_helper.dart';
import 'package:mysql_app/db/mysql.dart';
import 'package:mysql_app/model/user_model.dart';
import 'package:mysql_app/screens/user_list_screen.dart';

class HomeController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Mysql mysql = Mysql();

  RxBool isLoading = false.obs;


  @override
  void onInit() async {
    // await mysql.getConnection();
    await DatabaseHelper().initializeDatabase();
    super.onInit();
  }

  void insert() async {
    try {
      isLoading(true);
      int id  = DateTime.now().millisecondsSinceEpoch;
      UserModel user = UserModel(
          id: id,
          name: nameController.text,
          email: emailController.text,);
      int result = await DatabaseHelper().insertContact(user);
      if (result == 0) {
        isLoading(false);
        Get.snackbar('Error', 'User not inserted');
        return;
      } else {
        nameController.clear();
        emailController.clear();
        passwordController.clear();
        isLoading(false);
        Get.offAll(() => const UserListScreen());
        Get.snackbar('Success', 'User inserted successfully');  
      }
    } catch (e) {
      isLoading(false);
      Get.snackbar('Error', e.toString());
    }
  }
}
