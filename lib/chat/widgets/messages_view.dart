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
import 'package:get/get.dart';

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
          height: 200,
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
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        image(),
                        height: 30,
                        width: 30,
                      ),
                      Container(
                        width: 130,
                        height: 20,
                        decoration: BoxDecoration(
                            color: ColorConstant.primaryColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Event Pool",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Popins",
                                  fontSize: 14),
                            ),
                            Text(
                              " ₦${controller.getGroupMember(
                                    groupData: controller.currentGroup.value
                                        ?.data() as Map?,
                                  ) ?? "0"}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Popins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            )
                          ],
                        ),
                      ),
                      Image.asset(
                        ImageConstant.shareIcon,
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${controller.getGroupDescription(groupData: controller.currentGroup.value?.data() as Map?)}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 4,
                        width: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                                colors: [
                                  ColorConstant.red1,
                                  ColorConstant.greenLight1,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.topRight)),
                      ),
                    ],
                  ),
                  isLoading ? const Center(child: CircularProgressIndicator()) : SizedBox(
                    width: 250,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                                height: 50,
                                width: 60,
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

                                              Future.delayed(
                                                      const Duration(seconds: 1))
                                                  .then((value) async {
                                                var data = {
                                                  'selectedOutCome': 'No',
                                                  'userId': controller.uid,
                                                  // Add more key-value pairs as needed
                                                };

                                                await controller.addOutcomeToGroup(
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
                                        height: 40,
                                        width: 40,
                                        margin:
                                            const EdgeInsets.only(left: 10.0),
                                        decoration: BoxDecoration(
                                            color: isAnswered
                                                ? ColorConstant.gray
                                                : ColorConstant.red1,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: const Center(
                                          child: Text(
                                            "No",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Popins"),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      margin:
                                          const EdgeInsets.only(bottom: 5.0),
                                      decoration: BoxDecoration(
                                          color: ColorConstant.grey1,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Text(
                                        controller.noCount.toString() ?? '',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Popins"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                       SizedBox(
                                height: 50,
                                width: 60,
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
                                              Future.delayed(
                                                      const Duration(seconds: 1))
                                                  .then((value) async {
                                                var data = {
                                                  'selectedOutCome': 'Yes',
                                                  'userId': controller.uid,
                                                  // Add more key-value pairs as needed
                                                };

                                               await controller.addOutcomeToGroup(
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
                                        height: 40,
                                        width: 40,
                                        margin:
                                            const EdgeInsets.only(right: 10.0),
                                        decoration: BoxDecoration(
                                            color: isAnswered
                                                ? ColorConstant.gray
                                                : ColorConstant.greenLight,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: const Center(
                                          child: Text(
                                            "Yes",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Popins"),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      margin:
                                          const EdgeInsets.only(bottom: 5.0),
                                      decoration: BoxDecoration(
                                          color: ColorConstant.grey1,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Text(
                                        controller.yesCount.toString() ?? '',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Popins"),
                                      ),
                                    ),
                                  ],
                                ),
                              )
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageConstant.unsplash),
            const SizedBox(
              width: 8,
            ),
            Text(
              "Please abide to the rules!",
              style:
                  TextStyle(color: ColorConstant.gray500, fontFamily: "Popins"),
            ),
            const SizedBox(
              width: 8,
            ),
            Image.asset(ImageConstant.pushpin),
          ],
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
                ? ListView.builder(
                    controller: _scrollController,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.dialog(const ChatUserInfoCard(),
                                      arguments: {
                                        "userId": snapshot.data.docs[index]
                                            ['senderId'],
                                        "group": controller.currentGroup.value
                                            ?.data(),
                                      });
                                },
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(5.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
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
                                                  height: 30.0,
                                                  width: 30.0,
                                                  child: FadeInImage(
                                                    fit: BoxFit.cover,
                                                    placeholder:
                                                        const AssetImage(
                                                            ImageConstant
                                                                .unsplash),
                                                    imageErrorBuilder: (context,
                                                        obj, stacktrace) {
                                                      return Image.asset(
                                                        ImageConstant.unsplash,
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
                                              ImageConstant.iconAdmin,
                                              fit: BoxFit.cover,
                                            )),
                                      )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  () {
                                    if (snapshot.data.docs[index]['type'] ==
                                        MessageType.text.name) {
                                      return Text(
                                        "${snapshot.data.docs[index]['message'] ?? ""}",
                                        style: TextStyle(
                                            color: ColorConstant.black900,
                                            fontFamily: "Popins"),
                                      );
                                    } else if (snapshot.data.docs[index]
                                            ['type'] ==
                                        MessageType.image.name) {
                                      return ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image.network(
                                          "${snapshot.data.docs[index]['image'] ?? ""}",
                                          width: 150,
                                        ),
                                      );
                                    } else {
                                      return Text(
                                        "${snapshot.data.docs[index]['message'] ?? ""}",
                                        style: TextStyle(
                                            color: ColorConstant.black900,
                                            fontFamily: "Popins"),
                                      );
                                    }
                                  }(),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(ImageConstant.heart),
                                      Text(
                                        "  ___",
                                        style: TextStyle(
                                            color: ColorConstant.black900,
                                            fontFamily: "Popins"),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Image.asset(ImageConstant.message),
                                      Text(
                                        "  ___",
                                        style: TextStyle(
                                            color: ColorConstant.black900,
                                            fontFamily: "Popins"),
                                      ),
                                      /* const SizedBox(
                          width: 16,
                        ),
                        Image.asset(ImageConstant.eye),
                        Text(
                          "  ___",
                                style: TextStyle(
                                    color: ColorConstant.black900,
                              fontFamily: "Popins"),
                        ),*/
                                      /*const SizedBox(
                          width: 16,
                        ),
                        Image.asset(ImageConstant.export),
                        const SizedBox(
                          width: 40,
                        ),*/
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
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
          height: 40.0,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: ColorConstant.gray500)),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: msgController,
                          scrollController: _scrollController,
                          maxLines: 1,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 14),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            isDense: true,
                            hintText: "Send a message",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                                fontSize: 14),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     setState(() {
                      //       _emojiShowing = !_emojiShowing;
                      //     });
                      //   },
                      //   child: const SizedBox(
                      //       height: 30.0,
                      //       width: 30.0,
                      //       child: Icon(
                      //         Icons.emoji_emotions_outlined,
                      //         color: Colors.grey,
                      //       )),
                      // ),
                      GestureDetector(
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
                                            var url = await controller
                                                .uploadChatImage(
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
                                                            .currentUserData
                                                            .value
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
                                            var url = await controller
                                                .uploadChatImage(
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
                                                            .currentUserData
                                                            .value
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
                        child: const SizedBox(
                            height: 30.0,
                            width: 30.0,
                            child: Icon(
                              Icons.attach_file_sharp,
                              color: Colors.grey,
                            )),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                    ],
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
                child: Container(
                    height: 30.0,
                    width: 30.0,
                    decoration: const BoxDecoration(
                        color: Colors.grey, shape: BoxShape.circle),
                    child: const Icon(
                      Icons.navigate_next_rounded,
                      color: Colors.white,
                    )),
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
}
