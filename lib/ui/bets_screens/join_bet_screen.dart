import 'package:flexx_bet/chat/chat_controller.dart';
import 'package:flexx_bet/chat/widgets/join_requests.dart';
import 'package:flexx_bet/chat/widgets/messages_view.dart';
import 'package:flexx_bet/extensions/map_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../constants/colors.dart';
import '../../constants/images.dart';
import '../../controllers/wallet_controller.dart';
import '../components/custom_button.dart';
import '../notifications_and_bethistory/notifications.dart';
import '../wallet/wallet.dart';

class JoinBetScreen extends StatefulWidget {
  const JoinBetScreen({super.key});

  @override
  State<JoinBetScreen> createState() => _JoinBetScreenState();
}

class _JoinBetScreenState extends State<JoinBetScreen> {
  var controller = Get.find<ChatController>();
  var isAdmin = false;

  @override
  void initState() {
    super.initState();
    isAdmin = ((controller.currentGroup.value?.data() as Map)
            .getValueOfKey("admin") ==
        "${controller.uid}_${controller.currentUserData.value.getValueOfKey("name")}");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: isAdmin ? 4 : 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          iconTheme: IconThemeData(color: ColorConstant.whiteA700),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => NotificationsScreen());
                },
                icon: SvgPicture.asset(ImageConstant.notificationIcon)),
            const SizedBox(
              width: 12,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => WalletScreen());
              },
              child: Container(
                height: 37,
                width: 97,
                margin: const EdgeInsets.only(top: 14, bottom: 14),
                padding: const EdgeInsets.only(left: 18, right: 18),
                decoration: BoxDecoration(
                    color: ColorConstant.whiteA700,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        bottomLeft: Radius.circular(50))),
                child: Center(
                  child: GetBuilder<WalletContoller>(builder: (controller) {
                    return Text(
                      "₦${controller.totalAmount}",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          color: ColorConstant.primaryColor),
                    );
                  }),
                ),
              ),
            )
          ],
          bottom: PreferredSize(
            preferredSize: const Size.square(50),
            child: Material(
              color: Colors.white,
              elevation: 0,
              child: TabBar(
                padding: const EdgeInsets.only(left: 35, right: 35),
                tabs: [
                  const Tab(text: 'Banter'),
                  Image.asset(ImageConstant.liveButton),
                  const Tab(text: 'Results'),
                  if (isAdmin) const Tab(text: 'Requests'),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(
            children: [
              const MessagesView(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No bet Created Yet!',
                      style: TextStyle(
                          color: ColorConstant.blueGray40002,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Popins")),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomButton(
                    text: "Create a Bet",
                    fontStyle: ButtonFontStyle.PoppinsSemiBold18,
                    height: 48,
                    width: 307,
                  ),
                ],
              ),
              ListView.builder(
                itemCount: 6, // Set the number of items in the list
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 110,
                        decoration:
                            BoxDecoration(color: ColorConstant.listBackground),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  GradientText(
                                    "${index + 1}",
                                    // Text changes according to the list index
                                    style: TextStyle(
                                      fontSize: 30,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 3
                                        ..color = ColorConstant.whiteA700,
                                    ),
                                    colors: [
                                      ColorConstant.amber300,
                                      ColorConstant.purple50,
                                    ],
                                    gradientType: GradientType.linear,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Image.asset(
                                    ImageConstant.profile1,
                                    height: 54,
                                    width: 54,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    '@Thomas',
                                    style: TextStyle(
                                      color: ColorConstant.black900,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Popins",
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Column(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: ColorConstant.gray500,
                                            fontFamily: "Popins",
                                          ),
                                          children: <TextSpan>[
                                            const TextSpan(
                                              text: 'Staked ',
                                            ),
                                            TextSpan(
                                              text: '₦1000',
                                              // Change this text as needed
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: ColorConstant.gray500,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const CustomButton(
                                        width: 100,
                                        text: "₦1000",
                                        fontStyle:
                                            ButtonFontStyle.InterSemiBold16,
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 13),
                                    child: GestureDetector(
                                      onTap: ()async{
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: ColorConstant.greenLight,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Yes",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Popins",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(ImageConstant.upIcon),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      )
                    ],
                  );
                },
              ),
              if (isAdmin) const JoinRequests(),
            ],
          ),
        ),
      ),
    );
  }
}
