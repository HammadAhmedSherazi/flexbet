// ignore_for_file: prefer_const_constructors

import 'package:flexx_bet/chat/chat_controller.dart';
import 'package:flexx_bet/chat/chat_service.dart';
import 'package:flexx_bet/chat/widgets/chat_user_info.dart';
import 'package:flexx_bet/constants/colors.dart';
import 'package:flexx_bet/constants/images.dart';
import 'package:flexx_bet/extensions/map_extentions.dart';
import 'package:flexx_bet/extensions/string_extentions.dart';
import 'package:flexx_bet/ui/bets_screens/join_bet_screen.dart';
import 'package:flexx_bet/ui/components/custom_button.dart';
import 'package:flexx_bet/utils/file_utils.dart';
import 'package:flexx_bet/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MessagesView extends StatefulWidget {
  const MessagesView({super.key});

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  var controller = Get.find<ChatController>();
  var msgController = TextEditingController();
  final _scrollController = ScrollController();

  bool isLoading = false;
  bool isAnswered = false;
  // final _footerScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getCount();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 222,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  ColorConstant.black900,
                  ColorConstant.blackLight,
                ],
              )),
          child: Stack(fit: StackFit.expand, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                fit: BoxFit.cover,
                placeholder: const AssetImage(ImageConstant.staticJoinBet),
                imageErrorBuilder: (context, obj, stacktrace) {
                  return Image.asset(
                    ImageConstant.staticJoinBet,
                    fit: BoxFit.cover,
                  );
                },
                image: NetworkImage(
                    "${controller.getGroupBanner(groupData: controller.currentGroup.value?.data() as Map?)}"),
              ),
              // child: Image.asset(
              //   ImageConstant.staticJoinBet,
              //   fit: BoxFit.cover,
              // )
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color:
                    Colors.black.withOpacity(0.5), // Adjust opacity as needed
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 7,
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        image(),
                        height: 30,
                        width: 30,
                      ),
                      Container(
                        // width: 130,
                        // height: 20,
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 11,
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstant.primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Event Pool",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Popins",
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                              ),
                            ),
                            Text(
                              " ₦${controller.getGroupMember(
                                    groupData: controller.currentGroup.value
                                        ?.data() as Map?,
                                  ) ?? "0"}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: "Popins",
                                fontWeight: FontWeight.w800,
                                fontSize: 11,
                              ),
                            )
                          ],
                        ),
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.black,
                        child: SvgPicture.asset(
                          'assets/images/Subtract.svg',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        child: Text(
                          // 'Omah Lay will drop a new Album this weekend.',
                          "${controller.getGroupDescription(groupData: controller.currentGroup.value?.data() as Map?)}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        height: 7,
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                            colors: [
                              ColorConstant.red1,
                              ColorConstant.greenLight1,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.topRight,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SizedBox(
                          width: 250,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 60,
                                width: 70,
                                child: Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    InkWell(
                                      onTap: isAnswered
                                          ? null
                                          : () {
                                              setState(() {
                                                isLoading = true;
                                              });

                                              Future.delayed(const Duration(
                                                      seconds: 1))
                                                  .then((value) async {
                                                var data = {
                                                  'selectedOutCome': 'No',
                                                  'userId': controller.uid,
                                                  // Add more key-value pairs as needed
                                                };

                                                await controller
                                                    .addOutcomeToGroup(
                                                        "chatrooms",
                                                        controller.currentGroup
                                                                .value?.id ??
                                                            "",
                                                        data,
                                                        controller.uid);

                                                getCount();
                                              });
                                            },
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        margin:
                                            const EdgeInsets.only(left: 10.0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,

                                          color: isAnswered
                                              ? ColorConstant.gray
                                              : ColorConstant.red1,
                                          // borderRadius:
                                          //     BorderRadius.circular(30),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "NO",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 27,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Popins",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0,
                                      ),
                                      width: 21,
                                      margin:
                                          const EdgeInsets.only(bottom: 5.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Text(
                                        formatCount(
                                          controller.noCount.toString(),
                                        ),
                                        // controller.noCount.toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Popins",
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 60,
                                width: 70,
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    InkWell(
                                      onTap: isAnswered
                                          ? null
                                          : () async {
                                              setState(() {
                                                isLoading = true;
                                              });
                                              Future.delayed(const Duration(
                                                      seconds: 1))
                                                  .then((value) async {
                                                var data = {
                                                  'selectedOutCome': 'Yes',
                                                  'userId': controller.uid,
                                                  // Add more key-value pairs as needed
                                                };

                                                await controller
                                                    .addOutcomeToGroup(
                                                        "chatrooms",
                                                        controller.currentGroup
                                                                .value?.id ??
                                                            "",
                                                        data,
                                                        controller.uid);

                                                getCount();
                                              });
                                            },
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        margin:
                                            const EdgeInsets.only(right: 10.0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,

                                          color: isAnswered
                                              ? ColorConstant.gray
                                              : ColorConstant.greenLight,
                                          // borderRadius:
                                          //     BorderRadius.circular(30),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "YES",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 27,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Popins",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0,
                                      ),
                                      constraints: const BoxConstraints(
                                        minWidth: 21,
                                        maxHeight: 25,
                                      ),
                                      margin:
                                          const EdgeInsets.only(bottom: 5.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Text(
                                        formatCount(
                                          controller.yesCount.toString(),
                                        ),
                                        // controller.noCount.toString() ,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Popins",
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                  Container()
                ],
              ),
            )
          ]),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 43,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 43,
                width: 41,
                child: Stack(
                  children: [
                    Positioned(
                      top: 5,
                      right: 3,
                      child: CircleAvatar(
                        radius: 19,
                        child: Image.asset(
                          ImageConstant.unsplash2,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: ColorConstant.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                "Please abide to the rules!",
                style: TextStyle(
                    color: ColorConstant.gray500, fontFamily: "Popins"),
              ),
              const SizedBox(
                width: 4,
              ),
              Image.asset(
                ImageConstant.pushpin,
                height: 20,
                width: 20,
              ),
            ],
          ),
        ),

        ///MessagesView
        /*Expanded(
          child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(ImageConstant.unsplash),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          "I agree. Worth waiting till it's trading at \nits true valuation post lock up...",
                          style: TextStyle(
                              color: ColorConstant.black900,
                              fontFamily: "Popins"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 40,
                        ),
                        Image.asset(ImageConstant.heart),
                        Text(
                          "23.5k",
                          style: TextStyle(
                              color: ColorConstant.black900,
                              fontFamily: "Popins"),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Image.asset(ImageConstant.message),
                        Text(
                          "3.3k",
                          style: TextStyle(
                              color: ColorConstant.black900,
                              fontFamily: "Popins"),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Image.asset(ImageConstant.eye),
                        Text(
                          "104k",
                          style: TextStyle(
                              color: ColorConstant.black900,
                              fontFamily: "Popins"),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Image.asset(ImageConstant.export),
                        const SizedBox(
                          width: 40,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    )
                  ],
                );
              }),
        ),*/
        Expanded(
            child: StreamBuilder(
          stream: controller.chatService
              .getChats(controller.currentGroup.value?.id ?? ""),
          builder: (context, AsyncSnapshot snapshot) {
            return snapshot.hasData
                ? ListView.separated(
                    controller: _scrollController,
                    itemCount: snapshot.data.docs.length + 1,
                    padding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 20),
                    separatorBuilder: (_, i) => const SizedBox(
                      height: 10,
                    ),
                    itemBuilder: (context, index) {
                      if (index == snapshot.data.docs.length) {
                        return Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 7),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0Xff6F6F87),
                                    offset: Offset(0, 0),
                                    spreadRadius: -4,
                                    blurRadius: 8,
                                  )
                                ]),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '@johdoe ',
                                    style: TextStyle(
                                      fontFamily: "Popins",
                                      fontSize: 8,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstant.primaryColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'just joined the group',
                                    style: TextStyle(
                                      fontFamily: "Popins",
                                      fontSize: 8,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.dialog(const ChatUserInfoCard(),
                                    arguments: {
                                      "userId": snapshot.data.docs[index]
                                          ['senderId'],
                                      "group":
                                          controller.currentGroup.value?.data(),
                                    });
                              },
                              child: SizedBox(
                                height: 38,
                                width: 42,
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Container(
                                        height: 38,
                                        width: 38,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: ClipOval(
                                          child: FutureBuilder(
                                              future: controller.chatService
                                                  .getUserImage(
                                                      userId: snapshot
                                                              .data.docs[index]
                                                          ['senderId']),
                                              builder: (context, data) {
                                                if (data.hasData &&
                                                    data.data != null &&
                                                    data.data is String &&
                                                    (data.data as String)
                                                        .isNotEmpty) {
                                                  return SizedBox(
                                                    height: 38,
                                                    width: 38,
                                                    child: FadeInImage(
                                                      fit: BoxFit.cover,
                                                      placeholder:
                                                          const AssetImage(
                                                              ImageConstant
                                                                  .unsplash),
                                                      imageErrorBuilder:
                                                          (context, obj,
                                                              stacktrace) {
                                                        return Image.asset(
                                                          ImageConstant
                                                              .unsplash,
                                                          fit: BoxFit.cover,
                                                        );
                                                      },
                                                      image: NetworkImage(
                                                          "${data.data!}"),
                                                    ),
                                                  );
                                                } else {
                                                  return SizedBox(
                                                      height: 30.0,
                                                      width: 30.0,
                                                      child: Image.asset(
                                                        ImageConstant.unsplash,
                                                        fit: BoxFit.cover,
                                                      ));
                                                }
                                              }),
                                        ),
                                      ),
                                    ),
                                    // if (snapshot.data.docs[index]['senderId'] ==
                                    //     ((controller.currentGroup.value!.data()
                                    //             as Map)["admin"] as String)
                                    //         .getFirstValueAfterUnderscore())
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        height: 12,
                                        width: 12,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xff1BF631),
                                              Color(0xff00AE11),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data.docs[index]['sender']
                                          .toString(),
                                      style: TextStyle(
                                        fontFamily: "Popins",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    if (snapshot.data.docs[index]['senderId'] ==
                                        ((controller.currentGroup.value!.data()
                                                as Map)["admin"] as String)
                                            .getFirstValueAfterUnderscore())
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: SizedBox(
                                          height: 20.0,
                                          width: 20.0,
                                          child: Image.asset(
                                            ImageConstant.iconAdmin2,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 1,
                                        horizontal: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0X40FFC700),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(12),
                                          bottomLeft: Radius.circular(12),
                                          bottomRight: Radius.circular(12),
                                        ),
                                      ),
                                      child: (snapshot.data.docs[index]
                                                  ['type'] ==
                                              MessageType.image.name)
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: Image.network(
                                                "${snapshot.data.docs[index]['image'] ?? ""}",
                                                width: 150,
                                              ),
                                            )
                                          : Text(
                                              snapshot.data.docs[index]
                                                      ['message'] ??
                                                  "",
                                              style: TextStyle(
                                                fontFamily: "Popins",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                            ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: Image.asset(
                                        'assets/images/faceplus.png',
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(right: 5),
                                      decoration: BoxDecoration(
                                        color: Color(0XFFCCCCCC),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        "😀 ${formatCount('0')}",
                                        style: TextStyle(
                                          fontFamily: "Popins",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 5),
                                      decoration: BoxDecoration(
                                        color: Color(0XFFCCCCCC),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        "🔥  ${formatCount('0')}",
                                        style: TextStyle(
                                          fontFamily: "Popins",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  convertTimestamp(
                                      snapshot.data.docs[index]['createdAt']),
                                  style: TextStyle(
                                    fontFamily: "Popins",
                                    fontSize: 8,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff9191A8),
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      }
                      // return Column(
                      //   children: [
                      //     Row(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      // GestureDetector(
                      //   onTap: () {
                      //     Get.dialog(const ChatUserInfoCard(),
                      //         arguments: {
                      //           "userId": snapshot.data.docs[index]
                      //               ['senderId'],
                      //           "group": controller.currentGroup.value
                      //               ?.data(),
                      //         });
                      //   },
                      //   child: Stack(
                      //     alignment: Alignment.topRight,
                      //     children: [
                      //       Container(
                      //         margin: const EdgeInsets.all(5.0),
                      //         child: ClipRRect(
                      //           borderRadius:
                      //               BorderRadius.circular(15.0),
                      //           child: FutureBuilder(
                      //               future: controller.chatService
                      //                   .getUserImage(
                      //                       userId: snapshot
                      //                               .data.docs[index]
                      //                           ['senderId']),
                      //               builder: (context, data) {
                      //                 if (data.hasData &&
                      //                     data.data != null &&
                      //                     data.data is String &&
                      //                     (data.data as String)
                      //                         .isNotEmpty) {
                      //                   return SizedBox(
                      //                     height: 30.0,
                      //                     width: 30.0,
                      //                     child: FadeInImage(
                      //                       fit: BoxFit.cover,
                      //                       placeholder:
                      //                           const AssetImage(
                      //                               ImageConstant
                      //                                   .unsplash),
                      //                       imageErrorBuilder: (context,
                      //                           obj, stacktrace) {
                      //                         return Image.asset(
                      //                           ImageConstant.unsplash,
                      //                           fit: BoxFit.cover,
                      //                         );
                      //                       },
                      //                       image: NetworkImage(
                      //                           "${data.data!}"),
                      //                     ),
                      //                   );
                      //                 } else {
                      //                   return SizedBox(
                      //                       height: 30.0,
                      //                       width: 30.0,
                      //                       child: Image.asset(
                      //                         ImageConstant.unsplash,
                      //                         fit: BoxFit.cover,
                      //                       ));
                      //                 }
                      //               }),
                      //         ),
                      //       ),
                      //       if (snapshot.data.docs[index]['senderId'] ==
                      //           ((controller.currentGroup.value!.data()
                      //                   as Map)["admin"] as String)
                      //               .getFirstValueAfterUnderscore())
                      //         Align(
                      //           alignment: Alignment.topRight,
                      //           child: SizedBox(
                      //               height: 20.0,
                      //               width: 20.0,
                      //               child: Image.asset(
                      //                 ImageConstant.iconAdmin,
                      //                 fit: BoxFit.cover,
                      //               )),
                      //         )
                      //     ],
                      //   ),
                      // ),
                      //         const SizedBox(
                      //           width: 15,
                      //         ),
                      //         Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             () {
                      //               if (snapshot.data.docs[index]['type'] ==
                      //                   MessageType.text.name) {
                      //                 return Text(
                      //                   "${snapshot.data.docs[index]['message'] ?? ""}",
                      //                   style: TextStyle(
                      //                       color: ColorConstant.black900,
                      //                       fontFamily: "Popins"),
                      //                 );
                      //               } else if (snapshot.data.docs[index]
                      //                       ['type'] ==
                      //                   MessageType.image.name) {
                      //                 return ClipRRect(
                      //                   borderRadius:
                      //                       BorderRadius.circular(10.0),
                      //                   child: Image.network(
                      //                     "${snapshot.data.docs[index]['image'] ?? ""}",
                      //                     width: 150,
                      //                   ),
                      //                 );
                      //               } else {
                      //                 return Text(
                      //                   "${snapshot.data.docs[index]['message'] ?? ""}",
                      //                   style: TextStyle(
                      //                       color: ColorConstant.black900,
                      //                       fontFamily: "Popins"),
                      //                 );
                      //               }
                      //             }(),
                      //             const SizedBox(
                      //               height: 15,
                      //             ),
                      //             Row(
                      //               mainAxisAlignment: MainAxisAlignment.start,
                      //               children: [
                      //                 Image.asset(ImageConstant.heart),
                      //                 Text(
                      //                   "  ___",
                      //                   style: TextStyle(
                      //                       color: ColorConstant.black900,
                      //                       fontFamily: "Popins"),
                      //                 ),
                      //                 const SizedBox(
                      //                   width: 16,
                      //                 ),
                      //                 Image.asset(ImageConstant.message),
                      //                 Text(
                      //                   "  ___",
                      //                   style: TextStyle(
                      //                       color: ColorConstant.black900,
                      //                       fontFamily: "Popins"),
                      //                 ),
                      //                 /* const SizedBox(
                      //     width: 16,
                      //   ),
                      //   Image.asset(ImageConstant.eye),
                      //   Text(
                      //     "  ___",
                      //           style: TextStyle(
                      //               color: ColorConstant.black900,
                      //         fontFamily: "Popins"),
                      //   ),*/
                      //                 /*const SizedBox(
                      //     width: 16,
                      //   ),
                      //   Image.asset(ImageConstant.export),
                      //   const SizedBox(
                      //     width: 40,
                      //   ),*/
                      //               ],
                      //             ),
                      //             const SizedBox(
                      //               height: 12,
                      //             )
                      //           ],
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // );
                    },
                  )
                : Container();
          },
        )),
        // Row(
        //   children: [
        //     SizedBox(
        //         height: 30,
        //         width: 30,
        //         child: Image.asset(ImageConstant.messageGreen)),
        //     const SizedBox(
        //       width: 12,
        //     ),
        //     Text(
        //       "View all 22 comments",
        //       style: TextStyle(
        //           color: ColorConstant.greenA700,
        //           fontFamily: "Popins",
        //           fontSize: 14,
        //           fontWeight: FontWeight.w500),
        //     ),
        //     const Spacer(),
        //     SizedBox(
        //       height: 33,
        //       width: 33,
        //       child: Card(
        //         elevation: 10,
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(20),
        //         ),
        //         color: ColorConstant.whiteA700,
        //         child: Image.asset(ImageConstant.caretDown),
        //       ),
        //     )
        //   ],
        // ),
        // const SizedBox(
        //   height: 10,
        // ),

        ///Chat Footer
        SizedBox(
          height: 50.0,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: msgController,
                  maxLines: 1,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 14),
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        showAlertDialog(
                            titleText: 'Choose an option',
                            infoText:
                                "choose one of the option from following to continue",
                            extraDetails: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      FileUtils.getImageFromCamera()
                                          .then((value) async {
                                        if (value != null) {
                                          var url =
                                              await controller.uploadChatImage(
                                                  context: context,
                                                  groupId: controller
                                                          .currentGroup
                                                          .value
                                                          ?.id ??
                                                      "",
                                                  image: value);
                                          controller
                                              .sendMessage(
                                                  groupId: controller
                                                          .currentGroup
                                                          .value
                                                          ?.id ??
                                                      "",
                                                  message: msgController.text,
                                                  messageType:
                                                      MessageType.image.name,
                                                  senderId: controller.uid,
                                                  senderName: controller
                                                          .currentUserData.value
                                                          .getValueOfKey(
                                                              "name") ??
                                                      "",
                                                  image: url)
                                              .then((value) {
                                            msgController.clear();
                                            Get.back();
                                            Future.delayed(
                                                const Duration(seconds: 1),
                                                () async {
                                              _scrollController.animateTo(
                                                _scrollController
                                                    .position.maxScrollExtent,
                                                duration: const Duration(
                                                    milliseconds: 100),
                                                curve: Curves.easeOut,
                                              );
                                            });
                                          });
                                        }
                                      });
                                    },
                                    child: Image.asset(
                                      ImageConstant.iconCamera,
                                      height: 60.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 40.0,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      FileUtils.getImageFromGallery()
                                          .then((value) async {
                                        if (value != null) {
                                          var url =
                                              await controller.uploadChatImage(
                                                  context: context,
                                                  groupId: controller
                                                          .currentGroup
                                                          .value
                                                          ?.id ??
                                                      "",
                                                  image: value);
                                          controller
                                              .sendMessage(
                                                  groupId: controller
                                                          .currentGroup
                                                          .value
                                                          ?.id ??
                                                      "",
                                                  message: msgController.text,
                                                  messageType:
                                                      MessageType.image.name,
                                                  senderId: controller.uid,
                                                  senderName: controller
                                                          .currentUserData.value
                                                          .getValueOfKey(
                                                              "name") ??
                                                      "",
                                                  image: url)
                                              .then((value) {
                                            msgController.clear();
                                            Get.back();
                                            Future.delayed(
                                                const Duration(seconds: 1),
                                                () async {
                                              _scrollController.animateTo(
                                                _scrollController
                                                    .position.maxScrollExtent,
                                                duration: const Duration(
                                                    milliseconds: 100),
                                                curve: Curves.easeOut,
                                              );
                                            });
                                          });
                                        }
                                      });
                                    },
                                    child: Image.asset(
                                      ImageConstant.iconGallery,
                                      height: 60.0,
                                    ),
                                  )
                                ],
                              ),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Image.asset(
                          'assets/images/Actions.png',
                          width: 22,
                          height: 18,
                        ),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.emoji_emotions,
                      color: ColorConstant.primaryColor,
                      size: 30,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    isDense: true,
                    hintText: "Send a message",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  controller
                      .sendMessage(
                    groupId: controller.currentGroup.value?.id ?? "",
                    message: msgController.text,
                    messageType: MessageType.text.name,
                    senderId: controller.uid,
                    senderName: controller.currentUserData.value
                            .getValueOfKey("name") ??
                        "",
                  )
                      .then((value) {
                    msgController.clear();
                    Future.delayed(const Duration(seconds: 1), () async {
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.easeOut,
                      );
                    });
                  });
                },
                child: SizedBox(
                  height: 36.0,
                  width: 36.0,
                  // color: Colors.red,
                  child: Image.asset(
                    'assets/images/Group 1171275130 (1).png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 12.0,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String image() {
    var category = controller.getGroupCategory(
        groupData: controller.currentGroup.value?.data() as Map?);
    return controller.getCategoryImage(category);
  }

  Future<void> getCount() async {
    await controller.getOutcomeCount(controller.currentGroup.value?.id ?? "");
    isAnswered = await controller.checkMemberAnswered(
        "chatrooms", controller.currentGroup.value?.id ?? "", controller.uid);

    setState(() {
      isLoading = false;
    });
  }

  String formatCount(String count) {
    if (count.isEmpty) {
      return '';
    }
    try {
      int _count = int.parse(count);
      if (_count > 99) {
        return '99+';
      } else {
        return count;
      }
    } catch (e) {
      return '';
    }
  }

  String convertTimestamp(timeStamp) {
    // The given timestamp in milliseconds
    int timestamp = timeStamp;

    // Convert the timestamp to DateTime
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

    // Format the DateTime object to the desired string format
    String formattedDate = DateFormat('EEEE h:mma').format(dateTime);

    // Output the formatted date
    return formattedDate; // Example output: "Friday 5:50PM"
  }
}
