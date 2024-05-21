import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexx_bet/chat/chat_controller.dart';
import 'package:flexx_bet/constants/colors.dart';
import 'package:flexx_bet/constants/images.dart';
import 'package:flexx_bet/extensions/map_extentions.dart';
import 'package:flexx_bet/extensions/string_extentions.dart';
import 'package:flexx_bet/ui/bets_screens/create_bet_screen.dart';
import 'package:flexx_bet/ui/bets_screens/join_bet_screen.dart';
import 'package:flexx_bet/ui/components/custom_button.dart';
import 'package:flexx_bet/utils/bet_styles.dart';
import 'package:flexx_bet/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class MyGroups extends StatefulWidget {
  final Function()? onJoin;
  const MyGroups({super.key, this.onJoin});
  @override
  State<MyGroups> createState() => _MyGroupsState();
}

class _MyGroupsState extends State<MyGroups> {
  var controller = Get.find<ChatController>();

  bool isExpired(int timestamp) {
    // Convert milliseconds to DateTime
    DateTime expirationDate = DateTime.fromMillisecondsSinceEpoch(timestamp);

    // Get the current date and time
    DateTime currentDate = DateTime.now();

    // Check if the expiration date is in the past
    return expirationDate.isBefore(currentDate);
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstant.blueGray10096,
      child: Column(
        children: [
          Expanded(
            child: Obx(() {
                return controller.joinedGroups.isNotEmpty
                    ?ListView.builder(
                  itemCount: controller.joinedGroups.length,
                  reverse: true,
                  itemBuilder: (context,index){
                    var data = controller.joinedGroups[index].data();
                    var desc = (data as Map).getValueOfKey("description") ?? "";
                    var expireDateAndTime = data.getValueOfKey("endAt") ?? "";
                   // var joinAmount = (data as Map).getValueOfKey("joinAmount") ?? "";
                    var category = data.getValueOfKey("category") ?? "";
                    var categoryImage = categoriesNewList.firstWhere((element) => "${element["name"]}".toLowerCase() == "$category".toLowerCase())["imagePath"] ?? ImageConstant.beach;
                    var admin = "${"${data.getValueOfKey("admin") ?? ""}".getLastValueAfterUnderscore()}";
                    var adminId = "${"${data.getValueOfKey("admin") ?? ""}".getFirstValueAfterUnderscore()}";
                    var members =  data.getValueOfKey("members");


                    return GestureDetector(
                      onTap: (){
                        controller.currentGroup.value = controller.joinedGroups[index];
                        Get.to(const JoinBetScreen());
                      },
                      child: Container(
                        height: 200,
                        margin: const EdgeInsets.symmetric(vertical:2,horizontal: 2),
                        decoration: BoxDecoration(color: ColorConstant.primaryColor, borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(12),bottomLeft: Radius.circular(12)),
                                  child: FadeInImage(
                                    fit: BoxFit.cover,
                                    height: 180,
                                    width: 150,
                                    placeholder: const AssetImage(ImageConstant.imageBet,),
                                    imageErrorBuilder: (context,obj,stacktrace){
                                      return  Image.asset(ImageConstant.imageBet,fit: BoxFit.cover,height: 180, width: 150,);
                                    },
                                    image: NetworkImage("${controller.getGroupBanner(groupData: data as Map?)}"),
                                  ),
                                ),
                                isExpired(expireDateAndTime) ? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Event Ended",style: TextStyle(
                                    color: Colors.red
                                  ),),
                                ) : Padding(
                                  padding: const EdgeInsets.symmetric(horizontal:5.0),
                                  child: Image.asset(ImageConstant.liveButton,width: 60,),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "$desc",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: FlexxBetStyles.textStyle.copyWith(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "$category",
                                          style: FlexxBetStyles.textStyle.copyWith(fontSize: 16,fontWeight: FontWeight.bold,color: ColorConstant.gray),
                                        ),
                                        const SizedBox(width: 5.0,),
                                        Image.asset(categoryImage,width: 15,)
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 2.5,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.0),
                                          gradient: const LinearGradient(colors: [Colors.red,ColorConstant.lightGreen])),),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2.5),
                                          decoration: BoxDecoration(
                                              color: ColorConstant.red1,
                                              borderRadius:
                                              BorderRadius.circular(12)),
                                          child: Text(
                                            "No",
                                            style: FlexxBetStyles.textStyle.copyWith(fontSize: 8.0,color: Colors.white,fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2.5),
                                          decoration: BoxDecoration(
                                              color: ColorConstant.lightGreen,
                                              borderRadius:
                                              BorderRadius.circular(12)),
                                          child: Text(
                                            "Yes",
                                            style: FlexxBetStyles.textStyle.copyWith(fontSize: 8.0,color: Colors.white,fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5.0,),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Stack(
                                                alignment: Alignment.centerRight,
                                                children: [
                                                   Container(
                                                      margin: const EdgeInsets.only(right: 18),
                                                      child: Image.asset(getParticipantsAvatar(),height: 24.06)),
                                                  Container(
                                                      margin: const EdgeInsets.only(right: 18*2),
                                                      child: Image.asset(getParticipantsAvatar(),height: 24.06)),
                                                  Container(
                                                      margin: const EdgeInsets.only(right: 18*3),
                                                      child: Image.asset(getParticipantsAvatar(),height: 24.06)),

                                                  Container(
                                                    height: 24,
                                                    width: double.minPositive,
                                                    constraints: const BoxConstraints(minWidth: 24),
                                                    decoration: BoxDecoration(color: ColorConstant.primaryColor,
                                                        shape: BoxShape.circle),
                                                    child: Center(
                                                        child: Text(
                                                          (members is List)?(members.length - 1).toString():"+1",
                                                          style: const TextStyle(
                                                              color: Colors.white, fontFamily: "Popins"),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 5.0,),
                                              RichText(
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                text: TextSpan(
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: ColorConstant.blueGray400A2,
                                                      fontFamily: "Popins"
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text: 'Hosted By ',
                                                        style: FlexxBetStyles.textStyle.copyWith(color: ColorConstant.whiteA700,fontWeight: FontWeight.w700,fontSize: 13)
                                                    ),
                                                    TextSpan(
                                                        text: '@$admin',
                                                        style: FlexxBetStyles.textStyle.copyWith(color: ColorConstant.yellowGreen,fontWeight: FontWeight.w700,fontSize: 13)
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if(adminId == controller.uid)  ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStatePropertyAll(
                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),)
                                            ),
                                            backgroundColor: const MaterialStatePropertyAll(ColorConstant.yellowGreen),
                                            padding: MaterialStateProperty.all(const EdgeInsets.all(10.0)),
                                          ),
                                          onPressed: (){
                                            Get.to(CreateBetScreen(),arguments:  controller.joinedGroups[index].data())?.then((value) {
                                              if(value == true){
                                                "update group successfully".showSnackbar(isSuccess: true);
                                              }
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text("Edit",
                                                  style: FlexxBetStyles.textStyle.copyWith(color: ColorConstant.black,fontWeight: FontWeight.bold,fontSize: 18)
                                                )
                                            ],
                                          ),

                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
                    :const Center(child: Text("No event available"),);
              }
            ),
          ),

          const SizedBox(
            height: 20,
          ),
          CustomButton(
            onTap: (){
              // showAboutDialog(
              //     context: context,
              // );
              showAlertDialog(
                titleText: "Group Creation Fees",
                infoText: "N1000 fee will be charged from you wallet for group creation",
                buttonText: "Continue",
                buttonTextStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),
                buttonBackgroundColor: ColorConstant.primaryColor,
                onPressed: (){
                  Get.back(result: true);
                }
              ).then((value){
                if(value == true){
                  Get.to(CreateBetScreen())?.then((value) {
                    if(value == true){
                      // controller.getGroups();
                    }
                  });
                }
              });
            },
            text: "Create a Bet",
            fontStyle: ButtonFontStyle.InterSemiBold16,
            height: 48,
            width: 307,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
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

final List<dynamic> categoriesNewList = [
  {
    "name":"Games",
    "category": "game",
    "imagePath": ImageConstant.gamepadImage,
    "gradiant":[const Color(0xff7440FF), const Color(0xff04010E)]
  },
  {
    "name":"Sports",
    "category": "sports",
    "imagePath": ImageConstant.categorySportsImage,
    "gradiant":[const Color(0xff1B24FF), const Color(0xff04010E)]
  },{
    "name":"Music",
    "category": "music",
    "imagePath": ImageConstant.djSetup,
    "gradiant":[const Color(0xff34C759), const Color(0xffFD495E)]
  },
  {
    "name":"Crypto",
    "category": "crypto",
    "imagePath": ImageConstant.bitCoinImage,
    "gradiant":[const Color(0xffFF9900), const Color(0xff7440FF)]
  },
  {
    "name":"Movies/TV",
    "category": "movies/tv",
    "imagePath": ImageConstant.popCornBoxImage,
    "gradiant":[const Color(0xffFF2C2C), const Color(0xff080742)]
  },
  {
    "name":"Pop Culture",
    "category": "pop culture",
    "imagePath": ImageConstant.popCultureImage,
    "gradiant":[const Color(0xff6B0CFF), const Color(0xff266939)]
  },
  {
    "name":"Forex",
    "category": "forex",
    "imagePath": ImageConstant.forex,
    "gradiant":[const Color(0xff00A3FF), const Color(0xff64EA25)]
  },
  {
    "name":"Politics",
    "category": "politics",
    "imagePath": ImageConstant.politicsImage,
    "gradiant":[const Color(0xffFFBF66), const Color(0xff7440FF)]
  },
];

String getParticipantsAvatar(){
  final List<String> participants = [
    ImageConstant.avatar1,
    ImageConstant.avatar2,
    ImageConstant.avatar3,
  ];

  final Random random = Random();
  final String randomImage = participants[random.nextInt(participants.length)];

  return randomImage;
}

