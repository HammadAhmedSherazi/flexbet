import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flexx_bet/chat/chat_controller.dart';
import 'package:flexx_bet/constants/colors.dart';
import 'package:flexx_bet/constants/images.dart';
import 'package:flexx_bet/extensions/string_extentions.dart';
import 'package:flexx_bet/ui/components/custom_button.dart';
import 'package:flexx_bet/ui/components/custom_image_view.dart';
import 'package:flexx_bet/ui/components/loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ChatUserInfoCard extends StatefulWidget {
  const ChatUserInfoCard({
    super.key,
  });

  @override
  State<ChatUserInfoCard> createState() => _ChatUserInfoCardState();
}

class _ChatUserInfoCardState extends State<ChatUserInfoCard> {
  final _globelKey = GlobalKey();
  final controller = Get.find<ChatController>();
  var userData = {};
  var groupData = {};
  var name = "";
  var betsLost = [];
  var betsWon = [];
  var followers = [];
  var totalBets = [];
  var rank = 000;
  var image = "";
  var about = "";
  var following = [];

  @override
  void initState() {
    super.initState();
    if (Get.arguments is Map) {
      controller.getUserData(uid: "${Get.arguments["userId"]}").then((value) {
        if (value is Map) {
          userData = value;
          name = value["name"] ?? "User Name";
          betsLost = value["betsLost"] ?? [];
          betsWon = value["betsWon"] ?? [];
          followers = value["followers"] ?? [];
          totalBets = value["allBets"] ?? [];
          rank = value["rank"] ?? 000;
          image = value["photoUrl"] ?? "";
          about = value["about"] ?? "";
          setState(() {});
        }
      });
      if((Get.arguments as Map).containsKey("group")){
        groupData = Get.arguments["group"];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _globelKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: Get.height / 1.75,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      height: Get.height,
                      width: Get.width / 1.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: <Color>[
                              Color.fromRGBO(215, 200, 255, 1),
                              Color.fromRGBO(239, 239, 239, 1)
                              //add more color here.
                            ],
                          )),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16, top: 30, bottom: 10),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 85,
                                    width: 85,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(5.0),
                                          child: FadeInImage(
                                            fit: BoxFit.cover,
                                            placeholder: const AssetImage(ImageConstant.unsplash),
                                            imageErrorBuilder: (context,obj,stacktrace){
                                              return  Image.asset(ImageConstant.unsplash,fit: BoxFit.cover,);
                                            },
                                            image: NetworkImage(image),
                                          ),
                                        ),
                                        if(userData['uid'] == (groupData["admin"] as String).getFirstValueAfterUnderscore()) Align(
                                          alignment: Alignment.topRight,
                                          child: SizedBox(
                                              height: 40.0,
                                              width: 40.0,
                                              child: Image.asset(ImageConstant.iconAdmin,fit: BoxFit.cover,)),
                                        )
                                        // Align(
                                        //   alignment: Alignment.topRight,
                                        //   child: GestureDetector(
                                        //     child: Container(
                                        //         width: 25,
                                        //         height: 25,
                                        //         padding:
                                        //             const EdgeInsets.all(4),
                                        //         decoration: BoxDecoration(
                                        //           color: ColorConstant
                                        //               .primaryColor,
                                        //           borderRadius:
                                        //               const BorderRadius.all(
                                        //             Radius.circular(100),
                                        //           ),
                                        //         ),
                                        //         child: Icon(
                                        //           Icons.check,
                                        //           color:
                                        //               ColorConstant.whiteA700,
                                        //           size: 13,
                                        //         )),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "@$name🏆",
                                        style: const TextStyle(
                                            fontSize: 25,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        ColorConstant.fromHex(
                                                            "#5d4599"),
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            child: Text(
                                              "Rank",
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: ColorConstant.fromHex(
                                                      "#5d4599")),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            "#$rank",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: Get.width / 2.3,
                                        child: Text(
                                          about,
                                          style: TextStyle(
                                            fontSize: 13,
                                            shadows: [
                                              Shadow(
                                                color: const Color(0x00000000)
                                                    .withOpacity(0.3),
                                                offset: const Offset(.5, 1),
                                                blurRadius: 0,
                                              )
                                            ],
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                bottom: 14, left: 14, right: 14, top: 8),
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: Colors.white.withAlpha(125),
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 55,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${followers.length}",
                                          style: TextStyle(
                                              color: ColorConstant.fromHex(
                                                  "#000094"),
                                              fontSize: 20),
                                        ),
                                        Text("Followers",
                                            style: TextStyle(
                                                color:
                                                    ColorConstant.primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11))
                                      ]),
                                ),
                                SizedBox(
                                  width: 55,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${totalBets.length}",
                                          style: TextStyle(
                                              color: ColorConstant.fromHex(
                                                  "#000094"),
                                              fontSize: 20),
                                        ),
                                        Text("Total Bet",
                                            style: TextStyle(
                                                color:
                                                    ColorConstant.primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11))
                                      ]),
                                ),
                                SizedBox(
                                  width: 55,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${betsWon.length}",
                                          style: TextStyle(
                                              color: ColorConstant.fromHex(
                                                  "#000094"),
                                              fontSize: 20),
                                        ),
                                        Text("Wins",
                                            style: TextStyle(
                                                color:
                                                    ColorConstant.primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11))
                                      ]),
                                ),
                                SizedBox(
                                  width: 55,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${betsLost.length}",
                                          style: TextStyle(
                                              color: ColorConstant.fromHex(
                                                  "#000094"),
                                              fontSize: 20),
                                        ),
                                        Text("Loses",
                                            style: TextStyle(
                                                color:
                                                    ColorConstant.primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11))
                                      ]),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 1,
                            width: Get.width / 1.5,
                            color: ColorConstant.gray500,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: ColorConstant.fromHex("#0500cd"))),
                              child: Text(
                                "No badge yet",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: ColorConstant.fromHex("#0500cd")),
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                          userData["uid"] == controller.uid
                              ? const SizedBox(
                                  height: 49,
                                )
                              : CustomButton(
                                  width: Get.width / 1.3,
                                  height: 49,
                                  variant: ButtonVariant.FillGray90051,
                                  padding: ButtonPadding.PaddingAll4,
                                  fontStyle: ButtonFontStyle.PoppinsSemiBold18,
                                  text: "Challenge me to a bet!  🤑",
                                  onTap: () {
                                    // Get.put(LandingPageController()).changeTabIndex(2);
                                    // Get.back();
                                    // Get.off(() => LandingPage());
                                  },
                                ),
                          const SizedBox(
                            height: 9,
                          ),
                          userData["uid"] == controller.uid
                              ? const SizedBox(
                                  height: 49,
                                )
                              : (controller.currentUserData.value is Map
                              && controller.currentUserData.value!.containsKey("following")
                              && controller.currentUserData.value!["following"] is List
                              && controller.currentUserData.value!["following"].contains(userData["uid"])
                                  ? CustomButton(
                                      width: Get.width / 1.3,
                                      height: 49,
                                      onTap: () async {
                                        // await showLoader(() async {
                                        //   await _authController.removeFollow();
                                        //   await _authController.loadAnotherUserData(_authController.otherUser!.uid);
                                        // });
                                        //
                                        // setState(() {});
                                        // captureAndShareScreenshot(_globelKey);
                                      },
                                      padding: ButtonPadding.PaddingAll4,
                                      fontStyle:
                                          ButtonFontStyle.PoppinsSemiBold18,
                                      text: "Following      |         ",
                                      suffixWidget: CustomImageView(
                                          height: 18,
                                          width: 20,
                                          imagePath:
                                              ImageConstant.followMeIcon),
                                    )
                                  : CustomButton(
                                      width: Get.width / 1.3,
                                      height: 40,
                                      onTap: () async {
                                        // await showLoader(() async {
                                        //   await _authController
                                        //       .followAnotherUser();
                                        //   await _authController
                                        //       .loadAnotherUserData(
                                        //       _authController.otherUser!.uid);
                                        // });
                                        // setState(() {});
                                        // captureAndShareScreenshot(_globelKey);
                                      },
                                      padding: ButtonPadding.PaddingAll4,
                                      fontStyle:
                                          ButtonFontStyle.PoppinsSemiBold18,
                                      text: "Follow Me       |         ",
                                      suffixWidget: CustomImageView(
                                          height: 18,
                                          width: 20,
                                          imagePath:
                                              ImageConstant.followMeIcon),
                                    )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(.9, -1.1),
                  child: GestureDetector(
                    onTap: () {
                      Get.log("user info card");
                      Get.back();
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: ColorConstant.red500,
                          borderRadius: BorderRadius.circular(100)),
                      child: Transform.rotate(
                          angle: 45 * math.pi / 180,
                          child: Icon(
                            Icons.add,
                            size: 50,
                            color: ColorConstant.whiteA700,
                          )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> captureAndShareScreenshot(
      GlobalKey<State<StatefulWidget>> globalKey) async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        Uint8List pngBytes = byteData.buffer.asUint8List();
        // Specify a filename for the shared image
        String fileName = 'screenshot.png';
        // Save the image to the device's temporary directory
        final tempDir = await getTemporaryDirectory();
        final file = await File('${tempDir.path}/$fileName').create();
        await file.writeAsBytes(pngBytes);
        // Share the image file
        await Share.shareFiles([file.path], text: 'Check out this profile');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error capturing screenshot: $e');
      }
    }
  }
}
