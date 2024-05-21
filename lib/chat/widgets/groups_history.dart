import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexx_bet/chat/chat_controller.dart';
import 'package:flexx_bet/chat/chat_service.dart';
import 'package:flexx_bet/chat/widgets/my_groups.dart';
import 'package:flexx_bet/constants/colors.dart';
import 'package:flexx_bet/constants/images.dart';
import 'package:flexx_bet/extensions/map_extentions.dart';
import 'package:flexx_bet/extensions/string_extentions.dart';
import 'package:flexx_bet/ui/bets_screens/join_bet_screen.dart';
import 'package:flexx_bet/ui/components/components.dart';
import 'package:flexx_bet/ui/components/custom_button.dart';
import 'package:flexx_bet/utils/bet_styles.dart';
import 'package:flexx_bet/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import '../../controllers/wallet_controller.dart';
import '../../ui/wallet/wallet.dart';

class GroupHistory extends StatefulWidget {
  final Function()? onJoin;
  const GroupHistory({super.key, this.onJoin});
  @override
  State<GroupHistory> createState() => _GroupHistoryState();
}

class _GroupHistoryState extends State<GroupHistory> {
  var controller = Get.find<ChatController>();
  var walletController = Get.find<WalletContoller>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,()async{
      // controller.groupHistory.value = await controller.getGroups();
      controller.getGroupsStream();
    });

  }


  bool isExpired(int timestamp) {
    // Convert milliseconds to DateTime
    DateTime expirationDate = DateTime.fromMillisecondsSinceEpoch(timestamp);

    // Get the current date and time
    DateTime currentDate = DateTime.now();

    // Check if the expiration date is in the past
    return expirationDate.isBefore(currentDate);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstant.blueGray10096,
      child:Obx(() {
        print("unjoind list size------------>${controller.unJoinedGroups.length}");
          return  controller.unJoinedGroups.isNotEmpty
              ?ListView.builder(
            itemCount: controller.unJoinedGroups.length,
            reverse: true,
            itemBuilder: (context,index){
              var data = controller.unJoinedGroups[index].data();
              var desc = (data as Map).getValueOfKey("description") ?? "";
              var category = data.getValueOfKey("category") ?? "";
              var expireDateAndTime = data.getValueOfKey("endAt") ?? "";
              var categoryImage = categoriesNewList.firstWhere((element) => "${element["name"]}".toLowerCase() == "$category".toLowerCase())["imagePath"] ?? ImageConstant.beach;
              var admin = "${"${data.getValueOfKey("admin") ?? ""}".getLastValueAfterUnderscore()}";
              var members =  data.getValueOfKey("members");
              var joinAmount = data.getValueOfKey("joinAmount");
              return Container(
                height: 200,
                margin: const EdgeInsets.symmetric(vertical:2,horizontal: 2),
                decoration: BoxDecoration(color: ColorConstant.primaryColor, borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(12),bottomLeft: Radius.circular(12)),
                      child: Stack(
                        children: [
                          FadeInImage(
                             fit: BoxFit.cover,
                             height: 180,
                             width: 150,
                             placeholder: const AssetImage(ImageConstant.imageBet,),
                             imageErrorBuilder: (context,obj,stacktrace){
                               return  Image.asset(ImageConstant.imageBet,fit: BoxFit.cover,height: 180, width: 150,);
                             },
                             image: NetworkImage("${controller.getGroupBanner(groupData: data as Map?)}"),
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
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "$desc",
                              maxLines: 3,
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
                                          // Container(
                                          //     margin: const EdgeInsets.only(right: 12),
                                          //     child: Image.asset(ImageConstant.iconParticipant,height: 24.06)),
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
                                                  (members is List)?members.length.toString():"+1",
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
                                StreamBuilder(
                                    stream: controller.chatService.hasAlreadySendRequest(groupId: controller.groupHistory[index].id,userId: controller.uid),
                                    builder: (context,snapshot) {
                                      if(snapshot.hasData && (snapshot.data is bool) && snapshot.data == false && (controller.groupHistory[index].data() is Map) &&  controller.chatService.ifGroupFullAlready(groupData:controller.groupHistory[index].data() as Map)){
                                        return const Text("Group Capacity\nreached",style: TextStyle(fontFamily: "Popins",color: Colors.green),textAlign: TextAlign.center,);
                                      }
                                      if(snapshot.hasData && (snapshot.data is bool) && snapshot.data == true){
                                        return const Text("Awaiting\nApproval",style: TextStyle(fontFamily: "Popins",color: Colors.green),textAlign: TextAlign.center,);
                                      }
                                      return ElevatedButton(
                                        style: ButtonStyle(
                                            shape: MaterialStatePropertyAll(
                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),)
                                            ),
                                            backgroundColor: const MaterialStatePropertyAll(ColorConstant.yellowGreen),
                                          padding: MaterialStateProperty.all(const EdgeInsets.all(10.0)),
                                        ),
                                        onPressed: (){
                                          if(controller.checkIfGroupPrivate(obj:controller.groupHistory[index].data())){
                                            showAlertDialog(
                                                titleText: "Private Group",
                                                infoText: "You need admin approval before joining this group. Click on below button to send joining request to group admin",
                                                buttonText: "Send Joining Request",
                                                buttonTextStyle: const TextStyle(color: Colors.white),
                                                onPressed: (){
                                                  controller.chatService.sendJoinRequestMessage(
                                                      groupId: controller.groupHistory[index].id,
                                                      requestData: {
                                                        "uid":controller.uid,
                                                        "name":controller.currentUserData.value.getValueOfKey("name") ?? "",
                                                        "createdAt":DateTime.now().millisecondsSinceEpoch,
                                                        //"joinAmount":controller.,
                                                      }
                                                  ).then((value){
                                                    Get.back();
                                                    "request has been sent to the group admin".showSnackbar(isSuccess: true);
                                                  });
                                                }
                                            );
                                          }else{
                                            _showPopupProfile(context,groupDetails: controller.groupHistory[index].data() as Map);
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if(controller.checkIfGroupPrivate(obj:controller.groupHistory[index].data())) Image.asset(ImageConstant.lock,height: 25,width: 25,),
                                            Text("Join",
                                                style: FlexxBetStyles.textStyle.copyWith(color: ColorConstant.black,fontWeight: FontWeight.bold,fontSize: 18)

                                            )
                                          ],
                                        ),

                                      );
                                    }
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
              :const Center(child: Text("No event available"),);
        }
      ),
    );
  }
  void _showPopupProfile(BuildContext context,{required Map groupDetails}) {
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
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60.0),
                              child: FutureBuilder(
                                  future: controller.chatService.getUserImage(userId: (groupDetails["admin"].toString()).getFirstValueAfterUnderscore() ?? ""),
                                  builder: (context, data) {
                                    if(data.hasData && data.data!=null && data.data is String && (data.data as String).isNotEmpty){
                                      return FadeInImage(
                                        fit: BoxFit.cover,
                                        placeholder: const AssetImage(ImageConstant.profile1),
                                        imageErrorBuilder: (context,obj,stacktrace){
                                          return  Image.asset(ImageConstant.profile1,fit: BoxFit.cover,);
                                        },
                                        image: NetworkImage("${data.data!}"),
                                      );
                                    }else{
                                      return Image.asset(ImageConstant.profile1,fit: BoxFit.cover,);
                                    }
                                  }),
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
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'Welcome to',
                        ),
                        TextSpan(
                          text: ' @${"${groupDetails["admin"]}".getLastValueAfterUnderscore()}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        const TextSpan(
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
                      Text("${groupDetails["rules"]}",style: TextStyle(
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
                      Text(groupDetails["joinAmount"]== null ? "Join amount not available":"Join amount ₦${groupDetails["joinAmount"]}",style: TextStyle(
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
                      joinBetFunction(groupDetails);

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

  void joinBetFunction(Map<dynamic, dynamic> groupDetails) {


    //first check wallet amount

    controller.groupEventJoinEligibilityCheck(controller: walletController,groupJoinAmount: groupDetails["joinAmount"])
        .then((value) {
      if (value == false) {
        showAlertDialog(
            titleText: "Group Event Join failure",
            infoText:
            "You've not enough balance in your wallet. N1000 balance is required to join a group event. please fund your wallet & continue",
            buttonText: "Go to wallet",
            buttonTextStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16),
            buttonBackgroundColor:
            ColorConstant.primaryColor,
            onPressed: () {
              Get.back(result: true);
            }).then((value) {
          if (value == true) {
            Get.to(() => WalletScreen());
          }
        });
      } else {
        // join group function
        controller.joinExitGroup(
          context:context,
          groupId: groupDetails['groupId'] ?? "",
          groupName: groupDetails['groupName'] ?? "",
          userName: controller.currentUserData.value.getValueOfKey("name") ?? "",
          walletContoller: walletController,
          amount: groupDetails["joinAmount"]
        ).then((value){
          if(value == true){
            Get.to(const JoinBetScreen());
          }
        });
      }
    });

  }
}

