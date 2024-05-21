import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/notification_model.dart';
import '../models/user_model.dart';
import 'auth_controller.dart';


class NotificationController extends GetxController{
  static NotificationController to = Get.find<NotificationController>();
  final Rxn<List<NotificationModel>> notificationsList = Rxn<List<NotificationModel>>();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  AuthController authController = AuthController.to;


  @override
  void onReady() {
    notificationsList.bindStream(fetchData());
    super.onReady();
  }


  Future<void> addNotification(NotificationModel notification) async {
      final CollectionReference notificationsCollection =
      _db.collection('notifications');
      try {
        await notificationsCollection.add(notification.toJson());
        print("Notification added successfully!");
      } catch (e) {
        print("Error adding notification: $e");
      }
    }

  Stream<List<NotificationModel>> fetchData() {
    final UserModel userModel = authController.userFirestore!;
    Get.log("_streamNotifications");

    return _db
        .collection('/notifications').where("id" ,isEqualTo: userModel.uid )
        .snapshots()
        .map((snapshot) {
      List<NotificationModel> notifications = [];
      for (var doc in snapshot.docs) {
        notifications.add(NotificationModel.fromJson(doc.data()));
      }
      return notifications;
    });
  }
}