import 'package:flexx_bet/chat/chat_controller.dart';
import 'package:flexx_bet/chat/widgets/shimmer.dart';
import 'package:flexx_bet/chat/widgets/terms_conditions_widget.dart';
import 'package:flexx_bet/constants/colors.dart';
import 'package:flexx_bet/constants/images.dart';
import 'package:flexx_bet/controllers/landing_page_controller.dart';
import 'package:flexx_bet/controllers/wallet_controller.dart';
import 'package:flexx_bet/ui/bets_screens/create_bet_screen.dart';
import 'package:flexx_bet/ui/bets_screens/created_bet_history.dart';
import 'package:flexx_bet/ui/wallet/wallet.dart';
import 'package:flexx_bet/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../notifications_and_bethistory/notifications.dart';
import 'custom_button.dart';
import 'custom_image_view.dart';
import 'package:flutter_html/flutter_html.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.showBackButton,this.showBetCreateButton});
  final bool? showBackButton;
  final bool? showBetCreateButton;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
  @override
  Size get preferredSize => Size.fromHeight(
      Get.height / 12 > kToolbarHeight ? Get.height / 11 : kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final LandingPageController _landingPageController = LandingPageController.to;
  final controller = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    final bool shouldShowBackbutton = (Get.currentRoute != "/" ||
            Get.currentRoute != "/LandingPage" ||
            Get.currentRoute != "/landing-page") &&
        _landingPageController.tabIndex.value != 0;
    return AppBar(
      iconTheme: IconThemeData(
        color: ColorConstant.whiteA700
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: ColorConstant.primaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
      toolbarHeight: Get.height*2,
      actions: [
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
        IconButton(
            onPressed: () {
              Get.to(() => NotificationsScreen());
            },
            icon: SvgPicture.asset(ImageConstant.notificationIcon)),

        // GestureDetector(
        //     onTap: () {
        //       Get.to(() =>  NotificationsScreen());
        //     },
        //     child: Center(
        //       child: badges.Badge(
        //           position: badges.BadgePosition.topEnd(top: -1, end: -1),
        //           badgeAnimation: const badges.BadgeAnimation.slide(),
        //           badgeStyle: const badges.BadgeStyle(
        //             padding: EdgeInsets.all(8),
        //             badgeColor: Colors.red,
        //           ),
        //           child: const Icon(
        //             Icons.notifications,
        //             size: 28,
        //           )),
        //     )),
        // const SizedBox(
        //   width: 15,
        // ),
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
      leading: (widget.showBackButton ?? shouldShowBackbutton)
          ? BackButton(
              onPressed: () {
                setState(() {
                  _landingPageController.changeTabIndex(0);
                });
              },
            )
          : CustomImageView(
              imagePath: ImageConstant.appLogo,
              fit: BoxFit.contain,
            ),
      leadingWidth: (widget.showBackButton ?? shouldShowBackbutton)
          ? null
          : Get.width / 2.5,
    );
  }
  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black.withOpacity(0.5),
          contentPadding: EdgeInsets.zero,
          content: Container(
            height: Get.height/1.5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorConstant.gradiant1, ColorConstant.gradiant2],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: const EdgeInsets.all(20.0),
            child: TermsConditions(
              onPressed: () {
                controller.termsConditionsAccepted.value = true;
                Get.off(const CreatedBetHistory());
              },
            ),

            /*child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Expanded(
                  child: FutureBuilder(
                      future: controller.getChatAbout(),
                      builder: (context, data) {
                        if(data.connectionState == ConnectionState.done && data.hasData && data.data!=null && data.data is Map && (data.data as Map).isNotEmpty){
                          return SingleChildScrollView(
                            child: SizedBox(
                              width: Get.width - (20*2),
                              child: Html(
                                  data: "${data.data!["terms_conditions"]}",
                              ),
                            ),
                          );
                          return Text("${data.data!["terms_conditions"]}");
                        }else if(data.connectionState == ConnectionState.waiting){
                          return Shimmer.fromColors(
                            baseColor: ColorConstant.shimmerBaseColor,
                            highlightColor: ColorConstant.shimmerHighlightColor,
                            child: const Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",style: TextStyle(backgroundColor: Colors.white),),
                          );
                        }else{
                          return const Center(child: Text("No content found."));
                        }
                      }),
                ),
                *//*Text(
                  "Please Read Terms.",
                  style: TextStyle(
                      color: ColorConstant.primaryColor, fontSize: 18,fontWeight: FontWeight.bold,fontFamily: "Popins"),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Spacer(
                ),*//*
                const SizedBox(height: 10.0,),
                CustomButton(
                  text: "Proceed",
                  fontStyle: ButtonFontStyle.InterSemiBold16,
                  onTap: () {
                    // Get.to(const BetScreen());
                    Get.to(const CreatedBetHistory());
                  },
                  height: 48,
                  width: 307,
                )
              ],
            ),*/
          ),
        );
      },
    );
  }
}
