
import 'package:flexx_bet/ui/bets_screens/create_bet_screen.dart';
import 'package:flexx_bet/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constants/colors.dart';
import '../../constants/images.dart';
import '../../controllers/wallet_controller.dart';
import '../components/custom_button.dart';
import '../notifications_and_bethistory/notifications.dart';
import '../wallet/wallet.dart';
import 'created_bet_history.dart';

class BetScreen extends StatefulWidget {
  const BetScreen({super.key});

  @override
  State<BetScreen> createState() => _BetScreenState();
}

class _BetScreenState extends State<BetScreen> {
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
                    _showPopup(context);
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
                    child: Center(child:  Text(MyConstant.createEventTitle,style: TextStyle(color: ColorConstant.whiteA700,fontFamily: "Popins",fontWeight: FontWeight.w600,fontSize: 16),)),
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
                      Container(
                        height: 30,
                        width: 40,
                        decoration: BoxDecoration(
                            color: ColorConstant.green1,
                            borderRadius: BorderRadius.circular(15)),
                        child: const Center(
                            child: Text(
                          "60",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
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
                        height: 30,
                        width: 40,
                        decoration: BoxDecoration(
                            color: ColorConstant.grey1,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                            child: Text(
                          "0",
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(
            children: [
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
                  CustomButton(
                    text: "Create a Bet",
                    fontStyle: ButtonFontStyle.PoppinsSemiBold18,
                    height: 48,
                    width: 307,
                    onTap: () {
                      Get.to(const CreatedBetHistory());
                    },
                  )
                ],
              ),
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
                   CustomButton(
                    text: "Create a Bet",
                    fontStyle: ButtonFontStyle.PoppinsSemiBold18,
                    height: 48,
                    width: 307,
                    onTap: (){
                      Get.to( CreateBetScreen());
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPopup(BuildContext context) {
    showDialog(
      barrierColor: ColorConstant.black900.withOpacity(0.8),
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          contentPadding: EdgeInsets.zero,
          content: Container(
            height: 467,
            width: 500,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorConstant.gradiant1, ColorConstant.gradiant2],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Please Read Terms",
                  style: TextStyle(
                      color: ColorConstant.primaryColor, fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Please read and agree to terms before you proceed.\nPlease read and agree to terms before you proceed\nPlease read and agree to terms before you proceed\nPlease read and agree to terms before you proceed\nPlease read and agree to terms before you proceed",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                ),
                const Spacer(),
                 CustomButton(
                  text: "Proceed",
                  fontStyle: ButtonFontStyle.InterSemiBold16,
                   onTap: (){
                    Get.to(BetScreen());
                   },
                )
              ],
            ),
          ),
        );
      },
    );
  }

}
