import 'package:flexx_bet/constants/colors.dart';
import 'package:flexx_bet/constants/images.dart';
import 'package:flexx_bet/ui/wallet/widget/pay_confirm_bottom_sheet.dart';
import 'package:flexx_bet/ui/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;
// ignore: depend_on_referenced_packages
import 'package:image/image.dart' as image;
import 'package:flutter/services.dart';

Future<double> paymentBottomSheet() async {
  double currentSliderValue = 0;
  await Get.bottomSheet(
    Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      width: Get.width,
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 8.0, top: 8, left: 16, right: 16),
        child: StatefulBuilder(
          builder: (context, setState) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Amount",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.minimize,
                    color: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "₦",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: 'Inter'),
                      ),
                      Text(
                        (currentSliderValue * 10).round().toString(),
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const Icon(Icons.add, color: Colors.grey),
                ],
              ),
              FutureBuilder(
                future: getUiImage(ImageConstant.sliderButton, 15, 20),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? SliderTheme(
                          data: SliderThemeData(
                            activeTrackColor: ColorConstant.primaryColor,
                            thumbShape: SliderThumbImage(image: snapshot.data!),
                          ),
                          child: Slider(
                            value: currentSliderValue,
                            max: 100,
                            label: currentSliderValue.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                currentSliderValue = value;
                              });
                            },
                          ),
                        )
                      : Container();
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentSliderValue = 0.5;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          "₦5",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Inter',
                              color: ColorConstant.primaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentSliderValue = 1;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          "₦10",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Inter',
                              color: ColorConstant.primaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentSliderValue = 1.5;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          "₦15",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Inter',
                              color: ColorConstant.primaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentSliderValue = 2.0;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          "₦20",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Inter',
                              color: ColorConstant.primaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentSliderValue = 5.0;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          "₦50",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Inter',
                              color: ColorConstant.primaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentSliderValue = 10.0;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          "₦100",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Inter',
                              color: ColorConstant.primaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentSliderValue = 20.0;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          "₦200",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Inter',
                              color: ColorConstant.primaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        currentSliderValue = 50.0;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          "₦500",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Inter',
                              color: ColorConstant.primaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    width: Get.width / 1.1,
                    padding: ButtonPadding.PaddingAll4,
                    text: "Topup",
                    fontStyle: ButtonFontStyle.PoppinsMedium16,
                    onTap: () async {
                      Get.back();
                      await paymentConfirmBottomSheet(
                          (currentSliderValue * 10).round());
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
  return currentSliderValue;
}

Future<ui.Image> getUiImage(
    String imageAssetPath, int height, int width) async {
  final ByteData assetImageByteData = await rootBundle.load(imageAssetPath);
  image.Image baseSizeImage =
      image.decodeImage(assetImageByteData.buffer.asUint8List())!;
  image.Image resizeImage =
      image.copyResize(baseSizeImage, height: height, width: width);
  ui.Codec codec = await ui.instantiateImageCodec(image.encodePng(resizeImage));
  ui.FrameInfo frameInfo = await codec.getNextFrame();
  return frameInfo.image;
}

class SliderThumbImage extends SliderComponentShape {
  final ui.Image image;

  SliderThumbImage({required this.image});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(0, 0);
  }

  @override
  void paint(context, center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required Size sizeWithOverflow,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double textScaleFactor,
      required double value}) {
    final canvas = context.canvas;
    final imageWidth = image.width;
    final imageHeight = image.height;

    Offset imageOffset = Offset(
      center.dx - (imageWidth / 2),
      center.dy - (imageHeight / 2),
    );

    Paint paint = Paint()..filterQuality = FilterQuality.high;

    canvas.drawImage(image, imageOffset, paint);
  }
}
