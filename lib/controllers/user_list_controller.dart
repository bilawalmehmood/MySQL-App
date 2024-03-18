import 'package:get/get.dart';
import 'package:mysql_app/db/database_helper.dart';
import 'package:mysql_app/model/user_model.dart';

class UserListController extends GetxController{
  RxList<UserModel> users = <UserModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onReady() async{
    getAllUsers();
    super.onInit();
  }

  Future<List<UserModel>> getAllUsers() async {
    List<UserModel> usersList =[];
    try {
      isLoading(true);
      await DatabaseHelper().initializeDatabase();
      List<Map<String, dynamic>> userMapList = await DatabaseHelper().getUserMapList();
      userMapList.map((data) {
        usersList.add(UserModel.fromJson(data));
      },).toList();
      users.value=usersList;
      isLoading(false);
    } catch (e) {
      isLoading(false);
      Get.snackbar('Error', e.toString());
    }
    return usersList;
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