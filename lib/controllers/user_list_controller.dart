import 'package:get/get.dart';
import 'package:mysql_app/db/database_helper.dart';
import 'package:mysql_app/model/user_model.dart';

class UserListController extends GetxController{
  RxList<UserModel> users = <UserModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() async{
    await DatabaseHelper().initializeDatabase();
    getAllUsers();
    super.onInit();
  }

  void getAllUsers() async {
    try {
      isLoading(true);
      List<Map<String, dynamic>> userMapList = await DatabaseHelper().getUserMapList();
      users.value = userMapList.map((e) => UserModel.fromJson(e)).toList();
      isLoading(false);
    } catch (e) {
      isLoading(false);
      Get.snackbar('Error', e.toString());
    }
  }

  void deleteUser(int id) async {
    try {
      isLoading(true);
      await DatabaseHelper().deleteUser(id);
      getAllUsers();
      isLoading(false);
    } catch (e) {
      isLoading(false);
      Get.snackbar('Error', e.toString());
    }
  }

}