import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexx_bet/chat/chat_controller.dart';
import 'package:flexx_bet/chat/widgets/groups_history.dart';
import 'package:flexx_bet/chat/widgets/my_groups.dart';
import 'package:flexx_bet/ui/bets_screens/join_bet_screen.dart';
import 'package:flexx_bet/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import '../../constants/colors.dart';
import '../../constants/images.dart';
import '../../controllers/wallet_controller.dart';
import '../components/custom_button.dart';
import '../notifications_and_bethistory/notifications.dart';
import '../wallet/wallet.dart';

class CreatedBetHistory extends StatefulWidget {
  const CreatedBetHistory({super.key});

  @override
  State<CreatedBetHistory> createState() => _CreatedBetHistoryState();
}

class _CreatedBetHistoryState extends State<CreatedBetHistory> {
  var controller = Get.find<ChatController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          iconTheme: IconThemeData(color: ColorConstant.whiteA700),
          actions: [
            const SizedBox(
              width: 50,
            ),
            Stack(
              children: [
                InkWell(
                  onTap: (){
                    //_showPopup(context);
                  },
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [ColorConstant.deepPurpleA200,ColorConstant.orange]
                        ),
                        shape: BoxShape.rectangle,
                        borderRadius: const BorderRadius.only(topRight: Radius.circular(18),bottomRight: Radius.elliptical(50,70))

                    ),
                    child: Center(
                        child: Text(
                      MyConstant.createEventTitle,
                      style: TextStyle(
                          color: ColorConstant.whiteA700,
                          fontFamily: "Popins",
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    )),
                  ),
                ),
                Positioned(
                    left: 6,
                    top: 2,
                    child: SvgPicture.asset(ImageConstant.starIcon))
              ],
            ),
            const SizedBox(
              width: 12,
            ),
            IconButton(
                onPressed: () {
                  Get.to(() => NotificationsScreen());
                },
                icon: SvgPicture.asset(ImageConstant.notificationIcon)),
            const SizedBox(
              width: 6,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => WalletScreen());
              },
              child: Container(
                height: 35,
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
                tabs: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      const Tab(text: 'Public Bets'),
                      const SizedBox(
                        width: 10,
                      ),
                      Obx(() {
                        return Container(
                          height: 25,
                          width: 40,
                          decoration: BoxDecoration(
                              color: ColorConstant.yellowGreen,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                              child: Text(
                            "${controller.unJoinedGroups.length}",
                            style: const TextStyle(
                                color: Colors.black, fontFamily: "Popins"),
                          )),
                        );
                      }),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      const Tab(text: 'My Bets'),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 25,
                        width: 40,
                        decoration: BoxDecoration(
                            color: ColorConstant.primaryColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(child: Obx(() {
                          return Text(
                            "${controller.joinedGroups.length}",
                            style: TextStyle(
                                color: ColorConstant.whiteA700,
                                fontFamily: "Popins"),
                          );
                        })),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            GroupHistory(),
            MyGroups(),
          ],
        ),
      ),
    );
  }

  void _showPopupProfile(BuildContext context) {
    showDialog(
      barrierColor: ColorConstant.black900.withOpacity(0.87),
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Container(
            height: 420,
            width: 335,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorConstant.gradiant1, ColorConstant.gradiant2],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: const EdgeInsets.all(12.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children:[
                      Container(
                        height: 128,
                        width: 128,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(69),
                          border:  GradientBoxBorder(
                            gradient: LinearGradient(colors: [ColorConstant.deepPurpleA2007a, ColorConstant.gradiant3]),
                            width: 4,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage(ImageConstant.staticProfile),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 80,
                        left: 108,
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: ColorConstant.greenLight,
                            borderRadius: BorderRadius.circular(30)
                          ),
                        ),
                      )
                    ]
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                          fontSize: 16,
                          color: ColorConstant.black900,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Popins"
                      ),
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'Welcome to',
                        ),
                        TextSpan(
                          text: ' @bingogees',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        TextSpan(
                          text: ' events.',
                        ),
                      ],
                    ),
                  ),

                  Text("Please kindly read the rules before", style: TextStyle(
                      fontSize: 16,
                      color: ColorConstant.black900,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Popins"
                  ),),
                  Center(
                    child: Text("joining.", style: TextStyle(
                        fontSize: 16,
                        color: ColorConstant.black900,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Popins"
                    ),),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 3,
                        width: 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text("I do not charge joining fee. ❌",style: TextStyle(
                          fontSize: 14,
                          color: ColorConstant.gray80001,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Popins"
                      ),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 3,
                        width: 3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text("No curse or swear words is allowed. ❌",style: TextStyle(
                          fontSize: 14,
                          color: ColorConstant.gray80001,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Popins"
                      ),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 3,
                        width: 3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              fontSize: 14,
                              color: ColorConstant.gray80001,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Popins"
                          ),
                          children:  <TextSpan>[
                            const TextSpan(
                              text: 'Betting commission is',
                            ),
                            TextSpan(
                              text: ' ₦50',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: ColorConstant.green2,
                              ),
                            ),
                            const TextSpan(
                              text: ' per win 😉',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 3,
                        width: 3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text("Nice to meet you 🤝",style: TextStyle(
                          fontSize: 14,
                          color: ColorConstant.gray80001,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Popins"
                      ),)
                    ],
                  ),
                  const Spacer(
                  ),
                  CustomButton(
                    text: "Enter event",
                    fontStyle: ButtonFontStyle.InterSemiBold16,
                    suffixWidget: Image.asset(ImageConstant.appLogo1,),
                    onTap: () {
                      Get.to(const JoinBetScreen());
                    },
                    height: 48,
                    width: 307,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  void _showPopupEvent(BuildContext context) {
    showDialog(
      barrierColor: ColorConstant.black900.withOpacity(0.87),
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Container(
            height: 420,
            width: 335,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorConstant.gradiant1, ColorConstant.gradiant2],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: const EdgeInsets.all(12.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children:[
                      Container(
                        height: 128,
                        width: 128,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(69),
                          border:  GradientBoxBorder(
                            gradient: LinearGradient(colors: [ColorConstant.deepPurpleA2007a, ColorConstant.gradiant3]),
                            width: 4,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage(ImageConstant.imageBet,),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 70,
                        left: 70,
                        child: Image.asset(ImageConstant.lock,width: 80,height: 80,)
                      )
                    ]
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text("This event is Private!",style: TextStyle(
                      fontSize: 16,
                      color: ColorConstant.black900,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Popins"
                  ),),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                          fontSize: 16,
                          color: ColorConstant.black900,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Popins"
                      ),
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'Please kindly massage',
                        ),
                        TextSpan(
                          text: ' @bingogees',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Text("to send a request", style: TextStyle(
                      fontSize: 16,
                      color: ColorConstant.black900,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Popins"
                  ),),
                 const Spacer(),

                  CustomButton(
                    text: "Send me a request",
                    fontStyle: ButtonFontStyle.InterSemiBold16,
                    onTap: () {
                      //Get.to(JoinBetScreen());
                    },
                    height: 48,
                    width: 307,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomButton(
                    text: "Enter event",
                    fontStyle: ButtonFontStyle.InterSemiBold16,
                    suffixWidget: Image.asset(ImageConstant.appLogo1,),
                    onTap: () {
                      Get.to(const JoinBetScreen());
                    },
                    height: 48,
                    width: 307,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
