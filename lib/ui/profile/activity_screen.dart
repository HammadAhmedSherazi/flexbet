import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flexx_bet/constants/colors.dart';
import 'package:flexx_bet/constants/images.dart';
import 'package:flexx_bet/controllers/achievements_controller.dart';
import 'package:flexx_bet/controllers/auth_controller.dart';
import 'package:flexx_bet/controllers/image_picker_contoller.dart';
import 'package:flexx_bet/controllers/leaderboard_controller.dart';
import 'package:flexx_bet/models/achievement_model.dart';
import 'package:flexx_bet/models/models.dart';
import 'package:flexx_bet/ui/components/custom_button.dart';
import 'package:flexx_bet/ui/components/custom_image_view.dart';
import 'package:flexx_bet/ui/profile/edit_profile_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ActivityScreen extends StatelessWidget {
  ActivityScreen({super.key});

  final AuthController authController = AuthController.to;
  final LeaderboardController leaderboardController = LeaderboardController.to;
  final AchievementController achievementController = AchievementController.to;

  @override
  Widget build(BuildContext context) {
    AchievementModel userAchievements =
        achievementController.userAchievements.value!;

    UserModel user = authController.userFirestore!;
    final UserModel userModel = authController.userFirestore!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        leading: BackButton(
          color: ColorConstant.black900,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Stats",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: Get.width / 2.2,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF000000).withOpacity(0.1),
                            offset: const Offset(18, 6),
                            blurRadius: 20,
                            spreadRadius: -10,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: ColorConstant.primaryColor.withOpacity(.2),
                              borderRadius: BorderRadius.circular(100)),
                          child: Image.asset(ImageConstant.betIcon),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "0",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            Text("swipes",
                                style: TextStyle(color: Colors.grey)),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: Get.width / 2.2,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF000000).withOpacity(0.1),
                            offset: const Offset(18, 6),
                            blurRadius: 20,
                            spreadRadius: -10,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          margin: const EdgeInsets.all(10),
                          child: Image.asset(ImageConstant.leaderBOardActivity),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "#${leaderboardController.currentUserRank}",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            const Text("Leaderboard",
                                style: TextStyle(color: Colors.grey)),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Levels",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Center(
              child: Container(
                  width: Get.width / 1.1,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF000000).withOpacity(0.1),
                        offset: const Offset(18, 6),
                        blurRadius: 20,
                        spreadRadius: -10,
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                color: ColorConstant.primaryColor,
                                borderRadius: BorderRadius.circular(100)),
                            child: Center(
                              child: Text("${achievementController.level}",
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white)),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Level ${achievementController.level}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500)),
                              Text(
                                  "${achievementController.nextLevelPoints} points to next level",
                                  style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500)),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      LinearPercentIndicator(
                        percent: achievementController.progress,
                        lineHeight: 20,
                        leading: levelContainer(false),
                        trailing: levelContainer(true),
                        center: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${userAchievements.points}/",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                  color: Colors.brown[800]),
                            ),
                            Text(
                              "${achievementController.nextLevelPoints}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                  color: Colors.grey[500]),
                            )
                          ],
                        ),
                        barRadius: const Radius.circular(100),
                        backgroundColor: const Color(0x53F3B14E),
                        linearGradient: const LinearGradient(colors: [
                          Color(0xFFFFCE51),
                          Color(0xFFF3B14E),
                        ]),
                      ),
                    ],
                  )),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Badges",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Center(
              child: Container(
                  width: Get.width / 1.1,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF000000).withOpacity(0.1),
                        offset: const Offset(18, 6),
                        blurRadius: 20,
                        spreadRadius: -10,
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: achievementController
                        .userAchievements.value!.badges
                        .map((e) {
                      if (e == "amateur") {
                        return badgeContainer(
                            "Amateur",
                            "Complete 5 swipes and profile.",
                            ImageConstant.ameteurBadge,
                            Colors.blue[400],
                            15);
                      }
                      if (e == "master") {
                        return badgeContainer("Master", "Complete 20 swipes.",
                            ImageConstant.masterBadge, Colors.orange[400], 13);
                      }
                      if (e == "chief") {
                        return badgeContainer(
                            "Chief",
                            "All the above + 50 swipes",
                            ImageConstant.chiefBadge,
                            Colors.yellow[400],
                            20);
                      }
                      return Container();
                    }).toList(),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget levelContainer(bool isNextLevel) {
    num level = achievementController.level;
    return Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color:
              isNextLevel ? const Color(0x53F3B14E) : const Color(0xFFF3B14E)),
      child: Center(
          child: Text(
        "${isNextLevel ? level + 1 : level}",
        style: TextStyle(
            color: isNextLevel ? Colors.grey[500] : Colors.brown[700],
            fontWeight: FontWeight.w500),
      )),
    );
  }
}

Widget badgeContainer(String title, subtitle, image, color, double scale) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Container(
          height: 50,
          width: 70,
          decoration: BoxDecoration(
              image: DecorationImage(scale: scale, image: AssetImage(image)),
              color: color,
              borderRadius: BorderRadius.circular(10)),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.grey, fontSize: 8),
            )
          ],
        )
      ],
    ),
  );
}
