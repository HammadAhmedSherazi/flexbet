import 'package:flexx_bet/constants/colors.dart';
import 'package:flexx_bet/constants/images.dart';
import 'package:flexx_bet/controllers/bank_controller.dart';
import 'package:flexx_bet/controllers/wallet_controller.dart';
import 'package:flexx_bet/models/transaction_model.dart';
import 'package:flexx_bet/ui/wallet/transfer.dart';
import 'package:flexx_bet/ui/wallet/widget/payment_bottom_sheet.dart';
import 'package:flexx_bet/ui/wallet/widget/transaction_history_card.dart';
import 'package:flexx_bet/ui/wallet/withdraw.dart';
import 'package:flexx_bet/ui/components/custom_appbar.dart';
import 'package:flexx_bet/ui/components/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletScreen extends StatelessWidget {
  WalletScreen({super.key});
  final WalletContoller _walletContoller = WalletContoller.to;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: Get.width,
              height: 15,
            ),
            Text(
              "Wallet Balance",
              style: TextStyle(
                  color: ColorConstant.gray500,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            GetBuilder<WalletContoller>(builder: (controller) {
              return Text(
                "₦ ${controller.totalAmount.value}",
                style: const TextStyle(
                    fontFamily: 'inter',
                    fontSize: 40,
                    fontWeight: FontWeight.w500),
              );
            }),
            const SizedBox(
              height: 10,
            ),

            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => TransferScreen());
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12)),
                        child: CustomImageView(
                          imagePath: ImageConstant.sendIcon,
                          height: 35,
                          width: 35,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text("Transfer")
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await paymentBottomSheet();
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Icon(
                          Icons.arrow_downward,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text("Deposit")
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (_walletContoller.userWallet.value!.currentAmount == 0) {
                      Get.showSnackbar(const GetSnackBar(
                        duration: Duration(seconds: 2),
                        title: "Unable to withdraw",
                        message:
                            "Insufficient balance, The amount you currently have is for in app use only",
                      ));
                    } else {
                      await Get.put(BanksController()).getAllBanks();
                      Get.to(() => WithdrawScreen());
                    }
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12)),
                        child: CustomImageView(
                          imagePath: ImageConstant.withdrawIcon,
                          height: 35,
                          width: 35,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text("Withdraw")
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              height: Get.height / 2.2,
              child: GetBuilder<WalletContoller>(builder: (walletContoller) {
                List transactions =
                    _walletContoller.userWallet.value!.transactions;
                return ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    TransactionModel currentTransaction =
                        TransactionModel.fromMap(transactions[index]);
                    num amount = num.parse(currentTransaction.amount);

                    if (currentTransaction.action == "withdraw" ||
                        currentTransaction.action == "transfer" ||
                        currentTransaction.action == "bet") {
                      amount = amount * -1;
                    }

                    return TransactionHistoryCard(
                      amount: amount,
                      title: "You ${currentTransaction.narration}",
                      imagePath: ImageConstant.betIcon,
                      subTitle: currentTransaction.account.isEmpty
                          ? currentTransaction.concerned
                          : currentTransaction.account,
                      eventHeldDate:
                          DateTime.parse(currentTransaction.dateAndTime),
                    );
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
