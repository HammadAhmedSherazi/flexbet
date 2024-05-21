import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexx_bet/chat/chat_controller.dart';
import 'package:flexx_bet/chat/chat_service.dart';
import 'package:flexx_bet/chat/widgets/dashed_border.dart';
import 'package:flexx_bet/chat/widgets/groups_history.dart';
import 'package:flexx_bet/chat/widgets/terms_conditions_widget.dart';
import 'package:flexx_bet/extensions/map_extentions.dart';
import 'package:flexx_bet/ui/components/custom_appbar.dart';
import 'package:flexx_bet/ui/components/custom_button.dart';
import 'package:flexx_bet/ui/notifications_and_bethistory/notifications.dart';
import 'package:flexx_bet/ui/wallet/wallet.dart';
import 'package:flexx_bet/utils/bet_styles.dart';
import 'package:flexx_bet/utils/date_utils.dart';
import 'package:flexx_bet/utils/file_utils.dart';
import 'package:flexx_bet/utils/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/images.dart';
import '../../controllers/wallet_controller.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: CustomAppBar(
          showBackButton: true,
        ),
        body: GroupHistory());
  }
}
