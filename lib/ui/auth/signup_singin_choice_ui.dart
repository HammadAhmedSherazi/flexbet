import 'package:flexx_bet/constants/colors.dart';
import 'package:flexx_bet/constants/images.dart';
import 'package:flexx_bet/controllers/auth_controller.dart';
import 'package:flexx_bet/helpers/size.dart';
import 'package:flexx_bet/ui/auth/auth.dart';
import 'package:flexx_bet/ui/auth/sign_in_with_phone.dart';
import 'package:flexx_bet/ui/video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/login_card.dart';

class SignupSignInChoiceScreen extends StatelessWidget {
  const SignupSignInChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // const VideoForBackground(),
      SafeArea(
        child: Scaffold(
            /*appBar: AppBar(
            leading: const BackButton(color: Colors.black),
            backgroundColor: ColorConstant.whiteA700,
          ),*/
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.only(
                top: 24,
                bottom: 105,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 296,
                      height: 80,
                      child: Image.asset(ImageConstant.newLogo)),
                  Column(
                    children: [
                      NewLoginCard(
                        text: "Sign in with your number",
                        color: ColorConstant.primaryColor,
                        imagePath: ImageConstant.callLogo,
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Row(),
                    ],
                  ),
                ],
              ),
            )

            // Padding(
            //   padding: EdgeInsets.fromLTRB(
            //       getHorizontalSize(15), 10, getHorizontalSize(15), 0),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       GestureDetector(
            //         onTap: () {
            //           Get.to(() => const SignInWithPhone());
            //         },
            //         child: LoginCard(
            //             text: "     Log in with phone number",
            //             textStyle: TextStyle(
            //                 color: ColorConstant.whiteA700,
            //                 fontWeight: FontWeight.bold,
            //                 fontFamily: 'Poppins',
            //                 fontSize: 14),
            //             color: ColorConstant.primaryColor,
            //             imagePath: ImageConstant.phoneLogo),
            //       ),
            //       const SizedBox(
            //         height: 14,
            //       ),
            //       LoginCard(
            //           text: "     Log in with Facebook",
            //           textStyle: TextStyle(
            //               color: ColorConstant.whiteA700,
            //               fontWeight: FontWeight.bold,
            //               fontFamily: 'Poppins',
            //               fontSize: 14),
            //           color: ColorConstant.blueA400,
            //           imagePath: ImageConstant.faceBookLogo),
            //       const SizedBox(
            //         height: 14,
            //       ),
            //       GestureDetector(
            //         onTap: ()async{
            //           await AuthController.to.getLoginTikTok();
            //         },
            //         child: LoginCard(
            //             text: "    Sign in with TikTok",
            //             textStyle: TextStyle(
            //                 color: ColorConstant.whiteA700,
            //                 fontWeight: FontWeight.bold,
            //                 fontFamily: 'Poppins',
            //                 fontSize: 14),
            //             color: ColorConstant.pinkFB003F,
            //             imagePath: ImageConstant.tikTokLogo),
            //       ),
            //       const SizedBox(
            //         height: 14,
            //       ),
            //       GestureDetector(
            //         onTap: () async {
            //           await AuthController.to.registerOrSignInUserWithGoogle();
            //         },
            //         child: LoginCard(
            //             text: "    Continue with Google",
            //             textStyle: TextStyle(
            //                 color: ColorConstant.black900,
            //                 fontWeight: FontWeight.bold,
            //                 fontFamily: 'Poppins',
            //                 fontSize: 14),
            //             color: ColorConstant.whiteC6DAC5,
            //             imagePath: ImageConstant.google),
            //       ),
            //       const SizedBox(
            //         height: 14,
            //       ),
            //       // Row(
            //       //   mainAxisAlignment: MainAxisAlignment.center,
            //       //   children: [
            //       //     Container(
            //       //       height: 1,
            //       //       width: getHorizontalSize(150),
            //       //       color: ColorConstant.gray400,
            //       //     ),
            //       //     Text("  or  ",style: TextStyle(color: ColorConstant.whiteA700)),
            //       //     Container(
            //       //       height: 1,
            //       //       width: getHorizontalSize(150),
            //       //       color: ColorConstant.gray400,
            //       //     ),
            //       //   ],
            //       // ),
            //       // CustomButton(
            //       //   height: getVerticalSize(60),
            //       //   fontStyle: ButtonFontStyle.PoppinsMedium16,
            //       //   onTap: () {
            //       //     Get.to(() => const SignInScreen());
            //       //   },
            //       //   text: "Sign In With Email".toUpperCase(),
            //       // ),
            //       GestureDetector(
            //           onTap: () {
            //             Get.to(() => const SignInScreen());
            //           },
            //           child: Text("Or Sign in with Email",style: TextStyle(color: ColorConstant.whiteA700,fontWeight: FontWeight.bold,fontSize: 18,fontFamily: 'Poppins',),)),
            //       SizedBox(
            //         height: getVerticalSize(10),
            //       ),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Text(
            //             "Don't Have a account? ",
            //             style: TextStyle(color: ColorConstant.whiteA700,fontFamily: 'Poppins',),
            //           ),
            //           GestureDetector(
            //             onTap: () {
            //               Get.to(() => const SignUpScreen());
            //             },
            //             child: Text(
            //               "Sign Up",
            //               style: TextStyle(color: ColorConstant.whiteA700),
            //             ),
            //           ),
            //         ],
            //       ),
            //       SizedBox(
            //         height: getVerticalSize(30),
            //       ),
            //     ],
            //   ),
            // ),
            ),
      ),
    ]);
  }
}
