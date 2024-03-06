


import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mirrorfly_plugin/flychat.dart';
import 'package:mirrorfly_plugin/model/user_list_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import '../../../product/extension/string_extension.dart';
import '../../config/routes/route.dart';
import '../../custom/loader/easy_loader.dart';
import '../../feature/tutorial/messages/model/chat_message_model.dart';



class MirrorFlyChatViewController extends GetxController {
  String userJid='';
  RxString message=''.obs;
  String userName='';
  String croppedFilePath = '';
  final record = AudioRecorder();
  RxString timerInit = '00:00'.obs;
  RxBool isOnTapPause = false.obs;
  DateTime? startTime;
  late Timer? _audioTimer;
  late String audioSavePath;
  late String? recordedAudioPath;
  AudioPlayer player = AudioPlayer();
  RxDouble currentPos = 0.0.obs;
  RxBool isPlayAudio = false.obs;
  var profile_ = Profile().obs;
  Completer<GoogleMapController> completer = Completer();
  late GoogleMapController controller;

  Rx<Marker> marker = const Marker(
    markerId: MarkerId('riyadh1'),
    position: LatLng(20.42796133580664, 75.885749655962),
  ).obs;

  final  Rx<LatLng> markerLocation = const LatLng(0,0).obs;


  Rx<CameraPosition> kGooglePlex = const CameraPosition(
    target: LatLng(24.7136, 46.6753),
    zoom: 14.4746,
  ).obs;

  Completer<GoogleMapController> mapController =
  Completer<GoogleMapController>();
  GoogleMapController? googleMapController;

  RxList<ChatMessageModel> chatMessageModel=<ChatMessageModel>[].obs;
  @override
  onInit() async{
    super.onInit();

     userJid = Get.arguments['jid'];
    getMessage();
    Mirrorfly.onMessageReceived.listen((event) {
      final ChatMessageModel chatData = sendMessageModelFromJson(event);
      chatMessageModel.add(chatData);
    });
    setAudioPath();
    // player.onPlayerComplete.listen((event) {
    //   currentPos(0);
    //   final ChatMessageModel chatData = sendMessageModelFromJson(event);
    //   chatMessageModel.add(chatData);
    //   player.stop();
    // });
  }


  // ignore: always_declare_return_types
  sendMessage() async {
    // ignore: avoid_dynamic_calls
    Mirrorfly.sendTextMessage(message.value, userJid, '').then((value) {
      final ChatMessageModel data = sendMessageModelFromJson(value);
      chatMessageModel.add(data);
    });
  }


  // ignore: always_declare_return_types
  getMessage() async {
    showLoading();
    // ignore: avoid_dynamic_calls, always_specify_types
    Mirrorfly.getMessagesOfJid(userJid).then((value) {
       chatMessageModel.value = chatMessageModelFromJson(value);
       hideLoading();
    });

  }
  // ignore: always_declare_return_types
  sendImageMessage(String imageFile,String replyMessageId,String caption){
    // ignore: avoid_dynamic_calls, always_specify_types
    Mirrorfly.sendImageMessage(userJid, imageFile,caption, replyMessageId).then((value) {
      final ChatMessageModel data = sendMessageModelFromJson(value);
      chatMessageModel.add(data);
    });
  }



  // ignore: always_declare_return_types
  sendDocumentMessage(String documentFile,String replyMessageId,String caption){
    // ignore: avoid_dynamic_calls, always_specify_types
    Mirrorfly.sendDocumentMessage(userJid, documentFile, replyMessageId).then((value) {
      final ChatMessageModel data = sendMessageModelFromJson(value);
      chatMessageModel.add(data);
    });
  }


  // ignore: always_declare_return_types
  sendVideoMessage(String videoFile,String replyMessageId,String caption){
    // ignore: avoid_dynamic_calls, always_specify_types
    Mirrorfly.sendVideoMessage(userJid, videoFile,'', replyMessageId).then((value) {
      final ChatMessageModel data = sendMessageModelFromJson(value);
      chatMessageModel.add(data);
    });
  }

  // ignore: always_declare_return_types
  sendAudioMessage(String recordAudioPath,String replyMessageId,String audioDuration){
    // ignore: avoid_dynamic_calls, always_specify_types
    Mirrorfly.sendAudioMessage(userJid, recordAudioPath, true, audioDuration, replyMessageId).then((value) {
      final ChatMessageModel data = sendMessageModelFromJson(value);
      chatMessageModel.add(data);
    });
  }


  // ignore: always_declare_return_types
  sendAudio() async {
    timerInit.value='00:00';
    final DateFormat format = DateFormat('mm:ss');
    final DateTime dt = format.parse(timerInit.value, true);
    final int recordDuration = dt.millisecondsSinceEpoch;
    if(recordedAudioPath!=null)
    {
      sendAudioMessage(recordedAudioPath!, '', recordDuration.toString());
    }
  }


  // ignore: always_declare_return_types
  startRecording() async {

      if (await AudioRecorder().hasPermission()) {
        timerInit('00:00');
        startTimer();
        await record.start(
            const RecordConfig(),
          path:
          '$audioSavePath/audio_${DateTime
              .now()
              .millisecondsSinceEpoch}.m4a',
        );
        // ignore: always_specify_types
        Future.delayed(const Duration(seconds: 300), () {
            stopRecording();
        });
      }

  }

  Future<void> stopRecording() async {
    _audioTimer?.cancel();
    _audioTimer = null;
     recordedAudioPath = await record.stop();
  }


  void startTimer() {
    const Duration oneSec = Duration(seconds: 1);
    startTime = DateTime.now();
    _audioTimer = Timer.periodic(
      oneSec,
          (Timer timer) {
        final int minDur = DateTime
            .now()
            .difference(startTime!)
            .inMinutes;
        final int secDur = DateTime
            .now()
            .difference(startTime!)
            .inSeconds % 60;
        final String min = minDur < 10 ? '0$minDur' : minDur.toString();
        final String sec = secDur < 10 ? '0$secDur' : secDur.toString();
        timerInit('$min:$sec');
      },
    );
  }


  Future<void> setAudioPath() async {
    Directory? directory = Platform.isAndroid
        ? await getExternalStorageDirectory() //FOR ANDROID
        : await getApplicationSupportDirectory(); //FOR iOS
    if (directory != null) {
      audioSavePath = directory.path;
      debugPrint(audioSavePath);
    } else {
      debugPrint("=======Unable to set Audio Path=========");
    }
  }


   String durationToString(Duration duration) {

    final String seconds = ((duration.inSeconds % 60)).toStringAsFixed(0).padLeft(2,'0');
    // debugPrint("return ")
    return '${(duration.inMinutes).toStringAsFixed(0).padLeft(2,'0')}:$seconds';
  }


  // ignore: always_declare_return_types
  audioPlay(ChatMessageModel data)async{
    await player.play(
        data.mediaChatMessage!.mediaLocalStoragePath as Source,
        position: Duration(
            milliseconds:
            data.mediaChatMessage!.currentPos),);
  }

  // ignore: always_declare_return_types
  sendLocation() async {

        Get.toNamed(Routes.locationSentView)?.then((value) {
          if (value != null) {
            value as LatLng;
            sendLocationMessage( value.latitude, value.longitude,'');
          }
        });
      }

  // ignore: always_declare_return_types
  sendLocationMessage(double lat,double long,String replyMessageId){
    // ignore: avoid_dynamic_calls, always_specify_types
    Mirrorfly.sendLocationMessage(userJid, lat, long, replyMessageId).then((value) {
      final ChatMessageModel data = sendMessageModelFromJson(value);
      chatMessageModel.add(data);
    });

  }
  // ignore: always_declare_return_types
  sendContactNumber( String number,String name){
    Mirrorfly.sendContactMessage(<String>[number], userJid, name, '').then((value) {
      final ChatMessageModel data = sendMessageModelFromJson(value);
      chatMessageModel.add(data);
    });
  }


  onMapCreated(GoogleMapController googleMapController){
    completer.complete(googleMapController);
    controller = googleMapController;
    setLocation(markerLocation.value);
    debugPrint('onMapCreated ${googleMapController.getVisibleRegion().toString()}');
  }


  setLocation(LatLng position){
    //var position = LatLng(value.latitude, value.longitude);
    Marker updatedMarker = marker.value.copyWith(
      positionParam: position,
    );
    marker(updatedMarker);
    markerLocation(position);
    kGooglePlex(CameraPosition(target: position,zoom: 17.0));
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        kGooglePlex.value,
      ),
    );
    update();
  }

}
