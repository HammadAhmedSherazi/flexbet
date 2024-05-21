import 'package:flexx_bet/constants/colors.dart';
import 'package:flexx_bet/controllers/auth_controller.dart';
import 'package:flexx_bet/helpers/validator.dart';
import 'package:flexx_bet/ui/components/custom_button.dart';
import 'package:flexx_bet/ui/components/form_input_field.dart';
import 'package:flexx_bet/ui/components/form_vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool hasError = false;

  late bool _passwordVisible;
  late bool _confirmPasswordVisible;
  late bool _oldPasswordVisible;

  @override
  void initState() {
    _passwordVisible = false;
    _confirmPasswordVisible = false;
    _oldPasswordVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    authController.pinTextController.clear();
    authController.passwordController.clear();
    authController.oldPasswordController.clear();
    authController.confirmPasswordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change Password",
          style: TextStyle(color: ColorConstant.black900),
        ),
        backgroundColor: ColorConstant.whiteA700,
        leading: BackButton(
          color: ColorConstant.black900,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const FormVerticalSpace(),
                FormInputField(
                  controller: authController.oldPasswordController,
                  labelText: 'auth.oldPasswordFormField'.tr,
                  validator: Validator().password,
                  obscureText: !_oldPasswordVisible,
                  onChanged: (value) {},
                  onSaved: (value) =>
                      authController.passwordController.text = value!,
                  suffixWidget: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _oldPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black45,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _oldPasswordVisible = !_oldPasswordVisible;
                      });
                    },
                  ),
                ),
                const FormVerticalSpace(),
                FormInputField(
                  controller: authController.passwordController,
                  labelText: 'auth.passwordFormField'.tr,
                  validator: Validator().password,
                  obscureText: !_passwordVisible,
                  onChanged: (value) {},
                  onSaved: (value) =>
                      authController.passwordController.text = value!,
                  suffixWidget: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black45,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                const FormVerticalSpace(),
                FormInputField(
                  controller: authController.confirmPasswordController,
                  labelText: 'auth.confirmPasswordFormField'.tr,
                  validator: Validator().confirmPassword,
                  obscureText: !_confirmPasswordVisible,
                  onChanged: (value) {},
                  onSaved: (value) {},
                  suffixWidget: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _confirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black45,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _confirmPasswordVisible = !_confirmPasswordVisible;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                const Text(
                  "Enter Pin to confirm new Password",
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PinCodeTextField(
                    appContext: context,
                    autoDisposeControllers: false,
                    length: 4,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    controller: authController.pinTextController,
                    pinTheme: PinTheme(
                      activeFillColor: ColorConstant.blueGray100,
                      activeColor: ColorConstant.gray200,
                      selectedFillColor: ColorConstant.blueGray100,
                      selectedColor: ColorConstant.blue400,
                      inactiveFillColor: ColorConstant.blueGray100,
                      inactiveColor: ColorConstant.gray200,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: Get.height / 16,
                      fieldWidth: Get.width / 6,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: const TextInputType.numberWithOptions(),
                    onChanged: (value) {},
                    beforeTextPaste: (text) {
                      return true;
                    },
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                CustomButton(
                  padding: ButtonPadding.PaddingAll16,
                  height: 50,
                  text: "Submit",
                  fontStyle: ButtonFontStyle.PoppinsSemiBold14WhiteA700,
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await SystemChannels.textInput.invokeMethod(
                          'TextInput.hide'); //to hide the keyboard - if any
                      await authController.updateUserPassword();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
