import 'dart:io';

import 'package:alalmiya_g2/core/design/app_image.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_recorder/audio_encoder_type.dart';
import 'package:social_media_recorder/screen/social_media_recorder.dart';
import 'package:video_player/video_player.dart';

class MixView extends StatefulWidget {
  const MixView({Key? key}) : super(key: key);

  @override
  State<MixView> createState() => _MixViewState();
}

class _MixViewState extends State<MixView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: 60,
          child: SocialMediaRecorder(
            backGroundColor: Colors.red,
            sendRequestFunction: (soundFile, time) {
              print(soundFile.path);
              AudioPlayer().play(DeviceFileSource(soundFile.path));
            },
            encode: AudioEncoderType.AAC,
          ),
        ),
      ),
    );
  }
}
