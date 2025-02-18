// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:second_project/core/constant.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';
import 'dart:math'as math;

class VideoConference extends StatelessWidget {
  final String conferenceID;
  const VideoConference({super.key,required this.conferenceID});

  @override
  Widget build(BuildContext context) {
    final userId=math.Random().nextInt(9999);
  // final userid = FirebaseAuth.instance.currentUser?.uid ?? '';
    return SafeArea(
      child: ZegoUIKitPrebuiltVideoConference(
        appID: Constant.appID, 
        appSign: Constant.appsign, 
        conferenceID: conferenceID, 
        userID: userId.toString(), 
        userName: '$userId user_name', 
        config: ZegoUIKitPrebuiltVideoConferenceConfig()
        )
      );
  }
}