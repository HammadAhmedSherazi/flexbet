import 'package:flexx_bet/controllers/events_controller.dart';
import 'package:flexx_bet/ui/banter/banter.dart';
import 'package:flexx_bet/ui/home/landing_page_ui.dart';
import 'package:flexx_bet/ui/profile/profile_ui.dart';
import 'package:get/get.dart';

class LandingPageController extends GetxController {
  var tabIndex = 1.obs;
  static LandingPageController to = Get.find();
  Function onChange = () {
    Get.log("LandingPageController onChanged");
  };

  Future changeTabIndex(int index) async {
    Get.log("changeTabIndex");
    if (Get.currentRoute != "/" ||
        Get.currentRoute != "/landing-page" ||
        Get.currentRoute != "/LandingPage") {
      tabIndex.value = index;
      Get.back();
    }

    if (index == 0) {
      tabIndex.value = index;
      Get.offAll(() => LandingPage());
    }
    if(index == 1){
      EventsController eventsController = EventsController.to;
      eventsController.categoryName.value = null;
      eventsController.userFilteredAmount.value = null;
      await eventsController.fetchFirstEventsList(null);
    }

    if (index == 2) {
      // Get.to(() => const BanterScreen());
    } else if (index == 4) {
      Get.to(() => ProfileScreen());
    } else {
      tabIndex.value = index;
    }
    onChange();
  }
}
