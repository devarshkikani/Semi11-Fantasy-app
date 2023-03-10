// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:semi11/constant/sizedbox.dart';
import 'package:semi11/screens/authentication/mobile/mobile_screen_controller.dart';
import 'package:semi11/screens/authentication/verify_code/verify_code_controller.dart';
import 'package:semi11/theme/colors.dart';
import 'package:semi11/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class VerifyCodeScreen extends GetView<VerifyCodeController> {
  const VerifyCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: light,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            controller.isValid.value = false;
            controller.otpValue.value = '';
            Get.back();
          },
          icon: Icon(
            Platform.isIOS
                ? Icons.arrow_back_ios_new_rounded
                : Icons.arrow_back_rounded,
            color: primary,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      controller.phoneNumber.toString(),
                      style: mediumText16.copyWith(color: secondary),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.isValid.value = false;
                        controller.otpValue.value = '';
                        Get.back();
                      },
                      iconSize: 18,
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.mode_edit_outline_outlined),
                    ),
                  ],
                ),
                Text(
                  'Enter your\nVerification code?',
                  style: boldText28.copyWith(
                    color: primary,
                    fontFamily: 'source_serif_pro',
                  ),
                ),
                height10,
                OTPTextField(
                  controller: controller.otpController,
                  length: 6,
                  width: MediaQuery.of(context).size.width,
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldWidth: 45,
                  fieldStyle: FieldStyle.box,
                  outlineBorderRadius: 15,
                  style: regularText18.copyWith(
                    color: blackColor,
                  ),
                  otpFieldStyle: OtpFieldStyle(
                    borderColor: primary,
                    enabledBorderColor: blackColor,
                    focusBorderColor: primary.withOpacity(0.8),
                  ),
                  onChanged: (String value) {
                    if (value.length < 6) {
                      controller.isValid.value = false;
                    }
                  },
                  onCompleted: (String pin) async {
                    controller.isValid.value = true;
                    controller.otpValue.value = pin;
                    await controller.verifyOtp(context: context);
                  },
                ),
                height20,
                Obx(
                  () => Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        maximumSize: Size(Get.width / 2, 50),
                        disabledBackgroundColor: secondary.withOpacity(0.5),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      onPressed: controller.isValid.value
                          ? () {
                              controller.verifyOtp(context: context);
                            }
                          : null,
                      child: Center(
                        child: Text(
                          'Continue',
                          style: mediumText16.copyWith(
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                height10,
                Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      maximumSize: Size(Get.width / 2, 50),
                    ),
                    onPressed: () {
                      Get.find<MobileScreenController>().sendOtp(context);
                      controller.otpController.clear();
                    },
                    child: Center(
                      child: Text(
                        'Resend',
                        style: mediumText16.copyWith(
                          color: blackColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
