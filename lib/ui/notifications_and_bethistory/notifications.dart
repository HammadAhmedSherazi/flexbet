import 'package:flexx_bet/constants/images.dart';
import 'package:flexx_bet/ui/components/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constants/colors.dart';
import '../../controllers/notification_controller.dart';
import '../../controllers/wallet_controller.dart';
import '../bets_screens/bets_screen.dart';
import '../components/custom_button.dart';
import '../components/custom_image_view.dart';
import 'package:get/get.dart';

import '../wallet/wallet.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationController notificationController = NotificationController.to;
  NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: ColorConstant.whiteA700
          ),
          toolbarHeight: 80,
          actions: [
            Stack(
              children: [
                InkWell(
                  onTap: (){
                    _showPopup(context);
                  },
                  child: Container(
                    height: 30,
                    width: 125,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [ColorConstant.deepPurpleA200,ColorConstant.orange]
                        ),
                        shape: BoxShape.rectangle,
                        borderRadius: const BorderRadius.only(topRight: Radius.circular(18),bottomRight: Radius.elliptical(50,70))

                    ),
                    child: Center(child:  Text("Create A Bet",style: TextStyle(color: ColorConstant.whiteA700,fontFamily: "Popins",fontWeight: FontWeight.w600,fontSize: 16),)),
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
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      const Tab(text: 'Notofication'),
                      const SizedBox(
                        width: 4,
                      ),
                      Container(
                        height: 25,
                        width: 30,
                        decoration: BoxDecoration(
                            color: ColorConstant.pink1,
                            borderRadius: BorderRadius.circular(15)),
                        child: const Center(
                            child: Text(
                              "1",
                              style: TextStyle(color: Colors.black),
                            )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Tab(text: 'Bet History'),
                      const SizedBox(
                        width: 4,
                      ),
                      Container(
                        height: 25,
                        width: 30,
                        decoration: BoxDecoration(
                            color: ColorConstant.lightPurpul,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                            child: Text(
                              "1",
                              style: TextStyle(color: ColorConstant.black900),
                            )),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.user1,
                              height: 40,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("A new event has been created by",style: TextStyle(
                                    color: ColorConstant.black900,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Popins"
                                ),),
                                Text("@boybet44",style: TextStyle(
                                    color: ColorConstant.red300,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Popins"
                                ),)
                              ],
                            ),

                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomButton(
                              width: 205,
                              height: 45,
                              text: "Event Pool ₦2,000,000",
                              fontStyle: ButtonFontStyle.PoppinsMedium16,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            CustomButton(
                              width: 80,
                              height: 45,
                              text: "Join",
                              fontStyle: ButtonFontStyle.PoppinsMedium16,
                            )
                          ],
                        )
                      ],
                    ),

                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: notificationController.notificationsList.value!.length,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: Get.width,
                          child: Row(
                            children: [
                              Container(
                                height: 80,
                                width: 10,
                                color: ColorConstant.primaryColor,
                              ),
                              Container(
                                height: 80,
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: ColorConstant.whiteA700,
                                ),
                                child: Row(
                                  children: [
                                    CustomImageView(
                                      imagePath: ImageConstant.user1,
                                      height: 40,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              "Congrats!",
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            CustomImageView(
                                              imagePath: ImageConstant.congratsImage,
                                              height: 30,
                                            ),
                                            Text(
                                              notificationController.notificationsList.value![index].title,
                                              style: const TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "${takeAmount(index)}",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'Inter',
                                                  color: ColorConstant.green500,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        RichText(
                                          text:  TextSpan(
                                            style: const TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black,
                                            ),
                                            children: <TextSpan>[
                                              const TextSpan(text: ''),
                                              TextSpan(
                                                  text: notificationController.notificationsList.value![index].body,
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontStyle: FontStyle.italic,
                                                      fontSize: 12
                                                  )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: CustomImageView(
                                        imagePath: ImageConstant.categorySportsImage,
                                        height: 25,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: ColorConstant.listBackground,
                ),
                child: ListView.builder(
                  itemCount: 6, // Replace 'itemCount' with the actual number of items
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                color: ColorConstant.blueGray10096,
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(ImageConstant.beach,width: 10,height: 10,),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          "Chelsea will beat Manu",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Popins",
                                            color: ColorConstant.gray90010,
                                          ),
                                        ),
                                        const Spacer(),
                                        Image.asset(ImageConstant.history,height: 12,width: 12,),
                                        Text(
                                          "09:30:54",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Popins",
                                            color: ColorConstant.textColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(ImageConstant.profile1,width: 50,height: 50,),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              Text(
                                                "⏳ Awaiting an opponent.\nPlease kindly wait.....",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: "Popins",
                                                  fontWeight: FontWeight.w500,
                                                  color: ColorConstant.gray90010,
                                                ),
                                              ),
                                              Text(
                                                "@logosboy23",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Popins",
                                                  fontWeight: FontWeight.w500,
                                                  color: ColorConstant.red300,
                                                ),
                                              ),
                                              Text(
                                                "Picked Yes",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Popins",
                                                  fontWeight: FontWeight.w500,
                                                  color: ColorConstant.textColor,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 2), // Add spacing between the columns
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                              color: ColorConstant.blueGray10096,
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: ColorConstant.gray700,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Popins",
                                      ),
                                      children: const <TextSpan>[
                                        TextSpan(
                                          text: 'Staked',
                                        ),
                                        TextSpan(
                                          text: ' ₦5,000',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                 ElevatedButton(onPressed: (){},
                                     style: ButtonStyle(
                                       backgroundColor: MaterialStatePropertyAll(
                                           ColorConstant.primaryColor
                                       ),
                                       fixedSize: MaterialStatePropertyAll(
                                         Size(110,30)
                                       ),
                                       shape: MaterialStatePropertyAll(
                                         RoundedRectangleBorder(
                                           borderRadius: BorderRadius.circular(8)
                                         )
                                       )
                                     ),
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       children: [
                                         Text("Potential Return",style: TextStyle(
                                           fontSize: 8,
                                           fontFamily: "Popins",
                                           color: ColorConstant.whiteA700
                                         ),),
                                         Text("₦ 10,000",style: TextStyle(
                                             fontSize: 12,
                                             fontFamily: "Popins",
                                             color: ColorConstant.whiteA700
                                         ),)
                                       ],
                                     ))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            )


          ],
        )
            ),
    );



  }

  takeAmount(int index){
    final String body = notificationController.notificationsList.value![index].body;
    final RegExp regExp = RegExp(r'\d+');
    final Match? match = regExp.firstMatch(body);

    String extractedNumber = '';
    if (match != null) {
      extractedNumber = match.group(0)!;
    }
    return "₦${extractedNumber}";
  }
  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black.withOpacity(0.5),
          contentPadding: EdgeInsets.zero,
          content: Container(
            height: 467,
            width: 353,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorConstant.gradiant1, ColorConstant.gradiant2],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Please Read Terms.",
                  style: TextStyle(
                      color: ColorConstant.primaryColor, fontSize: 18,fontWeight: FontWeight.bold,fontFamily: "Popins"),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Please read and agree to terms before you proceed.\nPlease read and agree to terms before you proceed\nPlease read and agree to terms before you proceed\nPlease read and agree to terms before you proceed\nPlease read and agree to terms before you proceed",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontFamily: "Popins"
                  ),
                ),
                const Spacer(
                ),
                CustomButton(
                  text: "Proceed",
                  fontStyle: ButtonFontStyle.InterSemiBold16,
                  onTap: () {
                    Get.to(const BetScreen());
                  },
                  height: 48,
                  width: 307,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
