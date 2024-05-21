import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexx_bet/chat/chat_controller.dart';
import 'package:flexx_bet/chat/screens/events_screen.dart';
import 'package:flexx_bet/chat/widgets/groups_history.dart';
import 'package:flexx_bet/controllers/landing_page_controller.dart';
import 'package:flexx_bet/ui/bets_screens/created_bet_history.dart';
import 'package:flexx_bet/ui/components/navigation_bar.dart';
import 'package:flexx_bet/ui/events/detailed_event_screen.dart';
import 'package:flexx_bet/ui/home/home_ui.dart';
import 'package:flexx_bet/ui/leaderboard/leaderboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPage extends StatelessWidget {
  LandingPage({super.key});

  final GlobalKey stackKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final LandingPageController landingPageController =
        Get.put(LandingPageController(), permanent: false);
    Get.put(ChatController(uid: FirebaseAuth.instance.currentUser?.uid ?? ""));
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: buildBottomNavigationMenu(context),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Get.height / 1.130,
              width: Get.width,
              child: Stack(
                key: stackKey,
                children: [
                  Obx(() => IndexedStack(
                        index: landingPageController.tabIndex.value,
                        children: [
                          const HomeScreen(),
                           DetailedEventScreen(),
                          // const EventsScreen(),
                          const Padding(
                            padding: EdgeInsets.only(bottom:50.0),
                            child: CreatedBetHistory(),
                          ),
                          const LeaderBoardScreen(),
                          Container()
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
