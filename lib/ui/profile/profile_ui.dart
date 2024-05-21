import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flexx_bet/constants/colors.dart';
import 'package:flexx_bet/constants/images.dart';
import 'package:flexx_bet/controllers/auth_controller.dart';
import 'package:flexx_bet/controllers/image_picker_contoller.dart';
import 'package:flexx_bet/controllers/landing_page_controller.dart';
import 'package:flexx_bet/controllers/leaderboard_controller.dart';
import 'package:flexx_bet/models/models.dart';
import 'package:flexx_bet/ui/components/custom_button.dart';
import 'package:flexx_bet/ui/components/custom_image_view.dart';
import 'package:flexx_bet/ui/profile/activity_screen.dart';
import 'package:flexx_bet/ui/profile/edit_profile_ui.dart';
import 'package:flexx_bet/ui/profile/privacy_policy_ui.dart';
import 'package:flexx_bet/ui/profile/settings_ui.dart';
import 'package:flexx_bet/ui/profile/support_ui.dart';
import 'package:flexx_bet/ui/referral/referral.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'change_password_ui.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ImageController imageController = Get.put(ImageController());
  final AuthController authController = AuthController.to;
  final LeaderboardController leaderboardController = LeaderboardController.to;
  final LandingPageController landingPageController =
      Get.put(LandingPageController());
  final int rank = 452;

  final List options = [
    // {
    //   "title": "Edit profile information",
    //   "image": ImageConstant.editProfileIcon,
    //   "toPage": const EditProfileScreen()
    // },
    {
      "title": "Activity",
      "image": ImageConstant.editProfileIcon,
      "toPage": ActivityScreen()
    },
    {
      "title": "Settings",
      "image": ImageConstant.settingsIcon,
      "toPage": const SettingsScreen()
    },
    {
      "title": "Change password",
      "image": ImageConstant.changePasswordIcon,
      "toPage": const ChangePasswordScreen()
    },
    {
      "title": "Referrals",
      "image": ImageConstant.referralIcon,
      "toPage":  ReferralScreen()
    },
    {
      "title": "Become a FlexxBet agent",
      "image": ImageConstant.flexxAgentIcon,
      // "toPage": const CreateBetScreen()
      "toPage": const SizedBox()
    },
    {
      "title": "Privacy policy",
      "image": ImageConstant.privacyPolicyIcon,
      "toPage": const PrivacyPolicy()
    },
    {
      "title": "Support and Contact",
      "image": ImageConstant.supportIcon,
      "toPage": const SupportScreen()
    },
  ];

  @override
  Widget build(BuildContext context) {
    UserModel user = authController.userFirestore!;
    final UserModel userModel = authController.userFirestore!;
    return WillPopScope(
      onWillPop: () async {
        landingPageController.changeTabIndex(0);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstant.whiteA700,
          leading: BackButton(
            color: ColorConstant.black900,
            onPressed: () {
              LandingPageController.to.changeTabIndex(0);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GetBuilder<ImageController>(
                    init: ImageController(),
                    builder: (imageController) => SizedBox(
                      height: 100,
                      width: 100,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    userModel.photoUrl),
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () => {_onPictureSelection()},
                              child: Container(
                                width: 40,
                                height: 40,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: ColorConstant.gray200,
                                  border: Border.all(
                                      color: ColorConstant.whiteA700, width: 5),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                ),
                                child: CustomImageView(
                                  svgPath: ImageConstant.editIcon,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      badges.Badge(
                        position:
                            badges.BadgePosition.topEnd(top: 10, end: -25),
                        showBadge: user.appliedForVerification,
                        badgeStyle: badges.BadgeStyle(
                            badgeColor: ColorConstant.primaryColor),
                        badgeContent: Icon(
                          Icons.check,
                          size: 10,
                          color: ColorConstant.whiteA700,
                        ),
                        child: Text(
                          "@${userModel.username}",
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          CustomButton(
                            onTap: () {
                              Get.log("TO EditProfileScreen");
                              Get.to(() => const EditProfileScreen());
                            },
                            padding: ButtonPadding.PaddingAll4,
                            width: 100,
                            text: "Edit Profile ",
                            height: 30,
                            suffixWidget: CustomImageView(
                              imagePath: ImageConstant.userProfileIcon,
                              height: 15,
                            ),
                            fontStyle: ButtonFontStyle.PoppinsMedium12WhiteA700,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          CustomButton(
                            padding: ButtonPadding.PaddingT4,
                            width: 110,
                            text: "Following ${user.following.length}",
                            height: 30,
                            fontStyle: ButtonFontStyle.PoppinsMedium12WhiteA700,
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                userModel.about,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: ColorConstant.black900,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorConstant.primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.followersImage,
                                height: 45,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Followers",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    "${user.followers.length}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: ColorConstant.gray500),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.rankImage,
                                fit: BoxFit.fill,
                                height: 60,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Rank",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    "#${leaderboardController.currentUserRank}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: ColorConstant.gray500),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.betsImage,
                                height: 45,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Bets",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    "${userModel.betsLost.length + userModel.betsWon.length}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: ColorConstant.gray500),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(4),
                    child: ListTile(
                      onTap: () {
                        Get.to(() {
                          Get.log("To settings option");
                          Widget page = options[index]["toPage"];
                          return page;
                        },
                            routeName: options[index]["toPage"]
                                .runtimeType
                                .toString());
                      },
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 0),
                                spreadRadius: -6,
                                blurRadius: 33,
                                color: Color.fromRGBO(0, 0, 0, 0.21),
                              )
                            ],
                            borderRadius: BorderRadius.circular(8),
                            color: ColorConstant.whiteA700),
                        child: CustomImageView(
                          imagePath: options[index]["image"],
                        ),
                      ),
                      title: Text(
                        options[index]["title"],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: Get.width / 1.2,
                height: 1,
                color: ColorConstant.gray400,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: GestureDetector(
                  onTap: () async {
                    await authController.signOut();
                  },
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 0),
                              spreadRadius: -6,
                              blurRadius: 33,
                              color: Color.fromRGBO(0, 0, 0, 0.21),
                            )
                          ],
                          borderRadius: BorderRadius.circular(8),
                          color: ColorConstant.whiteA700),
                      child: CustomImageView(
                        imagePath: ImageConstant.logoutIcon,
                      ),
                    ),
                    title: const Text(
                      "Logout",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onPictureSelection() async {
    Get.bottomSheet(Container(
      height: Get.height / 3,
      width: Get.width,
      padding: const EdgeInsets.all(8),
      color: ColorConstant.whiteA700,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            "Options For Image ",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: Get.width / 15, right: Get.width / 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  style: ButtonStyle(
                      side: MaterialStateBorderSide.resolveWith(
                          (states) => BorderSide(
                                width: 2,
                                color: ColorConstant.gray100,
                              ))),
                  onPressed: () {
                    Get.log("profile ui");
                    Get.back();
                    imageController.getImage(ImageSource.camera);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera,
                        size: 35,
                        color: ColorConstant.primaryColor,
                      ),
                      Text(
                        "Camera",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.black900,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                      side: MaterialStateBorderSide.resolveWith(
                          (states) => BorderSide(
                                width: 2,
                                color: ColorConstant.gray100,
                              ))),
                  onPressed: () {
                    Get.log("profile UI 2");
                    Get.back();
                    imageController.getImage(ImageSource.gallery);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.image,
                        size: 35,
                        color: ColorConstant.primaryColor,
                      ),
                      Text(
                        "Gallery",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.black900,
                            fontSize: 20),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
