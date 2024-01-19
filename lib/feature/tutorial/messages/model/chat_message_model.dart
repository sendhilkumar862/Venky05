// To parse this JSON data, do
//
//     final chatMessageModel = chatMessageModelFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

import '../../../../product/extension/string_extension.dart';

List<ChatMessageModel> chatMessageModelFromJson(String str) =>
    List<ChatMessageModel>.from(
        // ignore: avoid_dynamic_calls, always_specify_types
        json.decode(str).map((x) => ChatMessageModel.fromJson(x)));

String chatMessageModelToJson(List<ChatMessageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

ChatMessageModel sendMessageModelFromJson(String str) =>
    ChatMessageModel.fromJson(json.decode(str));

String sendMessageModelToJson(ChatMessageModel data) =>
    json.encode(data.toJson());

class ChatMessageModel {
  ChatMessageModel({
    required this.chatUserJid,
    required this.contactType,
    required this.isItCarbonMessage,
    required this.isItSavedContact,
    required this.isMessageDeleted,
    required this.isMessageRecalled,
    required this.isMessageSentByMe,
    required this.isMessageStarred,
    required this.isThisAReplyMessage,
    required this.messageChatType,
    required this.messageCustomField,
    required this.messageId,
    required this.messageSentTime,
    required this.messageStatus,
    required this.messageTextContent,
    required this.messageType,
    required this.replyParentChatMessage, //
    required this.senderNickName,
    required this.senderUserJid,
    required this.senderUserName,
    required this.contactChatMessage, //
    required this.mediaChatMessage, //
    required this.locationChatMessage, //
    required this.topicId, //
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      ChatMessageModel(
        chatUserJid: json['chatUserJid'] ?? '',
        contactType: json['contactType'] == 'unknown'
            ? 'unknown_contact'
            : json['contactType'] == 'live'
                ? 'live_contact'
                : json['contactType'] == 'local'
                    ? 'local_contact'
                    : json['contactType'] == 'deleted'
                        ? 'deleted_contact'
                        : json['contactType'] ?? '',
        isItCarbonMessage: Platform.isAndroid
            ? json['isItCarbonMessage'] ?? false
            : json['isCarbonMessage'] ?? false,
        isItSavedContact: Platform.isAndroid
            ? json['isItSavedContact'] ?? false
            : json['isSavedContact'] ?? false,
        isMessageDeleted: json['isMessageDeleted'],
        isMessageRecalled: json['isMessageRecalled'].toString().toBool().obs,
        isMessageSentByMe: json['isMessageSentByMe'],
        isMessageStarred: json['isMessageStarred'].toString().toBool().obs,
        isThisAReplyMessage: Platform.isAndroid
            ? json['isThisAReplyMessage']
            : json['isReplyMessage'],
        messageChatType: json['messageChatType'] == 'singleChat'
            ? 'chat'
            : json['messageChatType'].toLowerCase(),
        messageCustomField: json['messageCustomField'] ?? {},
        messageId: json['messageId'],
        messageSentTime: json['messageSentTime'].toInt(),
        messageStatus: Platform.isAndroid
            ? (json['messageStatus']['status']).toString().obs
            : json['messageStatus'] == 2
                ? 'A'.obs
                : json['messageStatus'] == 3
                    ? 'D'.obs
                    : json['messageStatus'] == 4
                        ? 'S'.obs
                        : json['messageStatus'] == 5
                            ? 'R'.obs
                            : 'N'.obs, //"N" for "sent" in iOS
        messageTextContent: json['messageTextContent'].toString(),
        messageType: json['messageType'].toString().toUpperCase() == 'FILE'
            ? 'DOCUMENT'
            : json['messageType'].toString().toUpperCase(),
        replyParentChatMessage: json['replyParentChatMessage'] == null
            ? null
            : ReplyParentChatMessage.fromJson(json['replyParentChatMessage']),
        senderNickName: json['senderNickName'],
        senderUserJid: json['senderUserJid'],
        senderUserName: json['senderUserName'],
        contactChatMessage: json['contactChatMessage'] == null
            ? null
            : ContactChatMessage.fromJson(json['contactChatMessage']),
        mediaChatMessage: json['mediaChatMessage'] == null
            ? null
            : MediaChatMessage.fromJson(json['mediaChatMessage']),
        locationChatMessage: json['locationChatMessage'] == null
            ? null
            : LocationChatMessage.fromJson(json['locationChatMessage']),
          topicId: Platform.isIOS ? json['topicID'] : json['topicId']
      );

  String chatUserJid;
  String? contactType;
  bool? isItCarbonMessage;
  bool? isItSavedContact;
  bool isMessageDeleted;
  RxBool isMessageRecalled;
  bool isMessageSentByMe;
  RxBool isMessageStarred;
  bool isThisAReplyMessage;
  String messageChatType;
  Map<String, dynamic> messageCustomField;
  String messageId;
  dynamic messageSentTime;
  RxString messageStatus;
  String? messageTextContent;
  String messageType;
  ReplyParentChatMessage? replyParentChatMessage;
  String senderNickName;
  String senderUserJid;
  String senderUserName;
  ContactChatMessage? contactChatMessage;
  MediaChatMessage? mediaChatMessage;
  LocationChatMessage? locationChatMessage;
  String? topicId;

  var isSelected = false.obs;

  Map<String, dynamic> toJson() => {
        'chatUserJid': chatUserJid,
        'contactType': contactType,
        'isItCarbonMessage': isItCarbonMessage,
        'isItSavedContact': isItSavedContact,
        'isMessageDeleted': isMessageDeleted,
        'isMessageRecalled': isMessageRecalled.value,
        'isMessageSentByMe': isMessageSentByMe,
        'isMessageStarred': isMessageStarred.value,
        'isThisAReplyMessage': isThisAReplyMessage,
        'messageChatType': messageChatType,
        'messageCustomField': messageCustomField,
        'messageId': messageId,
        'messageSentTime': messageSentTime,
        'messageStatus': messageStatus.value,
        'messageTextContent': messageTextContent,
        'messageType': messageType,
        'replyParentChatMessage':
            replyParentChatMessage ?? replyParentChatMessage?.toJson(),
        'senderNickName': senderNickName,
        'senderUserJid': senderUserJid,
        'senderUserName': senderUserName,
        'contactChatMessage':
            // ignore: prefer_null_aware_operators
            contactChatMessage == null ? null : contactChatMessage!.toJson(),
        'mediaChatMessage':
            // ignore: prefer_null_aware_operators
            mediaChatMessage == null ? null : mediaChatMessage!.toJson(),
        'locationChatMessage':
            // ignore: prefer_null_aware_operators
            locationChatMessage == null ? null : locationChatMessage!.toJson(),
        'topicId': topicId
      };
}

class ContactChatMessage {
  ContactChatMessage({
    required this.contactName,
    required this.contactPhoneNumbers,
    required this.isChatAppUser,
    required this.messageId,
  });

  factory ContactChatMessage.fromJson(Map<String, dynamic> json) =>
      ContactChatMessage(
        contactName: json['contactName'],
        contactPhoneNumbers:
            // ignore: avoid_dynamic_calls
            List<String>.from(json['contactPhoneNumbers'].map((x) => x)),
        isChatAppUser: Platform.isAndroid
            // ignore: avoid_dynamic_calls
            ? List<bool>.from(json['isChatAppUser'].map((x) => x))
            // ignore: avoid_dynamic_calls
            : List<bool>.from(json['isChatUser'].map((x) => x)),
        messageId: json['messageId'],
      );

  String contactName;
  List<String> contactPhoneNumbers;
  List<bool> isChatAppUser;
  String messageId;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'contactName': contactName,
        'contactPhoneNumbers':
            List<dynamic>.from(contactPhoneNumbers.map((String x) => x)),
        'isChatAppUser': List<dynamic>.from(isChatAppUser.map((bool x) => x)),
        'messageId': messageId,
      };
}

class LocationChatMessage {
  LocationChatMessage({
    required this.latitude,
    required this.longitude,
    required this.mapLocationUrl,
    required this.messageId,
  });

  factory LocationChatMessage.fromJson(Map<String, dynamic> json) =>
      LocationChatMessage(
        // ignore: avoid_dynamic_calls
        latitude: json['latitude'].toDouble(),
        // ignore: avoid_dynamic_calls
        longitude: json['longitude'].toDouble(),
        mapLocationUrl: json['mapLocationUrl'],
        messageId: json['messageId'],
      );

  double latitude;
  double longitude;
  String mapLocationUrl;
  String messageId;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'latitude': latitude,
        'longitude': longitude,
        'mapLocationUrl': mapLocationUrl,
        'messageId': messageId,
      };
}

class MediaChatMessage {
  MediaChatMessage({
    required this.isAudioRecorded,
    required this.mediaCaptionText,
    required this.mediaDownloadStatus,
    required this.mediaDuration,
    required this.mediaFileHeight,
    required this.mediaFileName,
    required this.mediaFileSize,
    required this.mediaFileType,
    required this.mediaFileWidth,
    required this.mediaLocalStoragePath,
    required this.mediaProgressStatus,
    required this.mediaThumbImage,
    required this.mediaUploadStatus,
    required this.messageId,
    required this.messageType,
    required this.isPlaying,
    required this.currentPos,
  });

  factory MediaChatMessage.fromJson(Map<String, dynamic> json) =>
      MediaChatMessage(
        isAudioRecorded: Platform.isAndroid
            ? json['isAudioRecorded'] ?? false
            // ignore: avoid_bool_literals_in_conditional_expressions
            : json['audioType'] == 'recording'
                ? true
                : false,
        mediaCaptionText: json['mediaCaptionText'] ?? '',
        mediaDownloadStatus: Platform.isIOS
            ? json['mediaDownloadStatus'] == 4
                ? 5
                : json['mediaDownloadStatus'] == 5
                    ? 3
                    : json['mediaDownloadStatus'] == 6
                        ? 4
                        : json['mediaDownloadStatus'] == 7
                            ? 6
                            : json['mediaDownloadStatus'] == 9
                                ? 401
                                : json['mediaDownloadStatus']
            : json['mediaDownloadStatus'] == 'not_downloaded'
                ? 5
                : json['mediaDownloadStatus'] == 'downloading'
                    ? 3
                    : json['mediaDownloadStatus'] == 'downloaded'
                        ? 4
                        : json['mediaDownloadStatus'] == 'not_available'
                            ? 6
                            : json['mediaDownloadStatus'] == 'failed'
                                ? 401
                                : json['mediaDownloadStatus'],
        mediaDuration: json['mediaDuration'],
        mediaFileHeight: json['mediaFileHeight'] ?? 0,
        mediaFileName: json['mediaFileName'],
        mediaFileSize: json['mediaFileSize'],
        // mediaFileType: json["mediaFileType"],
        mediaFileType: Platform.isAndroid
            ? json['mediaFileType']
            : json['mediaFileType'].toString().toUpperCase() == 'FILE'
                ? 'DOCUMENT'
                : json['mediaFileType'].toString().toUpperCase(),
        mediaFileWidth: json['mediaFileWidth'] ?? 0,
        mediaLocalStoragePath: json['mediaLocalStoragePath'],
        mediaProgressStatus:
            int.parse(json['mediaProgressStatus'].toString()).obs,
        mediaThumbImage: json['mediaThumbImage']
            .toString()
            .replaceAll(r'\\n', r'\n')
            .replaceAll(r'\n', '\n')
            .replaceAll('\n', '')
            .replaceAll(' ', ''),
        mediaUploadStatus: Platform.isIOS
            ? json['mediaUploadStatus'] == 3
                ? 7
                : json['mediaUploadStatus'] == 8
                    ? 401
                    : json['mediaUploadStatus']
            : json['mediaUploadStatus'] == 'not_uploaded'
                ? 0
                : json['mediaUploadStatus'] == 'uploading'
                    ? 1
                    : json['mediaUploadStatus'] == 'uploaded'
                        ? 2
                        : json['mediaUploadStatus'] == 'not_available'
                            ? 7
                            : json['mediaUploadStatus'] == 'failed'
                                ? 401
                                : json['mediaUploadStatus'],
        messageId: json['messageId'],
        messageType: Platform.isAndroid
            ? json['messageType']
            : json['mediaFileType'].toString().toUpperCase() == 'FILE'
                ? 'DOCUMENT'
                : json['mediaFileType'],
        isPlaying: false,
        currentPos: 0,
      );

  bool isAudioRecorded;
  String mediaCaptionText;
  int mediaDownloadStatus;
  int mediaDuration;
  int mediaFileHeight;
  String mediaFileName;
  int mediaFileSize;
  String mediaFileType;
  int mediaFileWidth;
  String mediaLocalStoragePath;
  RxInt mediaProgressStatus;
  String mediaThumbImage;
  int mediaUploadStatus;
  String messageId;
  String messageType;
  bool isPlaying;
  int currentPos;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'isAudioRecorded': isAudioRecorded,
        'mediaCaptionText': mediaCaptionText,
        'mediaDownloadStatus': mediaDownloadStatus,
        'mediaDuration': mediaDuration,
        'mediaFileHeight': mediaFileHeight,
        'mediaFileName': mediaFileName,
        'mediaFileSize': mediaFileSize,
        'mediaFileType': mediaFileType,
        'mediaFileWidth': mediaFileWidth,
        'mediaLocalStoragePath': mediaLocalStoragePath,
        'mediaProgressStatus': mediaProgressStatus.value,
        'mediaThumbImage': mediaThumbImage,
        'mediaUploadStatus': mediaUploadStatus,
        'messageId': messageId,
        'messageType': messageType,
        'isPlaying': isPlaying,
      };
}

class MessageCustomField {
  MessageCustomField();

  // ignore: avoid_unused_constructor_parameters
  factory MessageCustomField.fromJson(Map<String, dynamic> json) =>
      MessageCustomField();

  Map<String, dynamic> toJson() => <String, dynamic>{};
}

class MessageStatus {
  MessageStatus({
    required this.status,
  });

  factory MessageStatus.fromJson(Map<String, dynamic> json) => MessageStatus(
        status: json['status'],
      );

  String status;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'status': status,
      };
}

class ReplyParentChatMessage {
  ReplyParentChatMessage({
    required this.chatUserJid,
    required this.isMessageDeleted,
    required this.isMessageRecalled,
    required this.isMessageSentByMe,
    required this.isMessageStarred,
    required this.messageId,
    required this.messageSentTime,
    required this.messageTextContent,
    required this.messageType,
    required this.senderNickName,
    required this.senderUserName,
    required this.locationChatMessage,
    required this.contactChatMessage,
    required this.mediaChatMessage,
  });

  factory ReplyParentChatMessage.fromJson(Map<String, dynamic> json) =>
      ReplyParentChatMessage(
        chatUserJid: json['chatUserJid'],
        isMessageDeleted: json['isMessageDeleted'],
        isMessageRecalled: json['isMessageRecalled'],
        isMessageSentByMe: json['isMessageSentByMe'],
        isMessageStarred: json['isMessageStarred'],
        messageId: json['messageId'],
        messageSentTime: json['messageSentTime'],
        messageTextContent: json['messageTextContent'],
        messageType: Platform.isAndroid
            ? json['messageType']
            : json['messageTextContent'].toString().isNotEmpty
                ? 'TEXT'
                : json['mediaChatMessage'] != null &&
                        // ignore: avoid_dynamic_calls
                        json['mediaChatMessage']['mediaFileType']
                            .toString()
                            .isNotEmpty
                    // ignore: avoid_dynamic_calls
                    ? json['mediaChatMessage']['mediaFileType']
                                .toString()
                                .toUpperCase() ==
                            'FILE'
                        ? 'DOCUMENT'
                        // ignore: avoid_dynamic_calls
                        : json['mediaChatMessage']['mediaFileType']
                            .toString()
                            .toUpperCase()
                    : json['contactChatMessage'] != null
                        ? 'CONTACT'
                        : json['locationChatMessage'] != null
                            ? 'LOCATION'
                            : null,
        senderNickName: json['senderNickName'],
        senderUserName: json['senderUserName'],
        locationChatMessage: json['locationChatMessage'] == null
            ? null
            : LocationChatMessage.fromJson(json['locationChatMessage']),
        contactChatMessage: json['contactChatMessage'] == null
            ? null
            : ContactChatMessage.fromJson(json['contactChatMessage']),
        mediaChatMessage: json['mediaChatMessage'] == null
            ? null
            : MediaChatMessage.fromJson(json['mediaChatMessage']),
      );

  String chatUserJid;
  bool isMessageDeleted;
  bool isMessageRecalled;
  bool isMessageSentByMe;
  bool isMessageStarred;
  String messageId;
  dynamic messageSentTime;
  String? messageTextContent;
  String messageType;
  String senderNickName;
  String senderUserName;
  LocationChatMessage? locationChatMessage;
  ContactChatMessage? contactChatMessage;
  MediaChatMessage? mediaChatMessage;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'chatUserJid': chatUserJid,
        'isMessageDeleted': isMessageDeleted,
        'isMessageRecalled': isMessageRecalled,
        'isMessageSentByMe': isMessageSentByMe,
        'isMessageStarred': isMessageStarred,
        'messageId': messageId,
        'messageSentTime': messageSentTime,
        'messageTextContent': messageTextContent,
        'messageType': messageType,
        'senderNickName': senderNickName,
        'senderUserName': senderUserName,
        'locationChatMessage':
            locationChatMessage ?? locationChatMessage?.toJson(),
        'contactChatMessage':
            contactChatMessage ?? contactChatMessage?.toJson(),
        'mediaChatMessage': mediaChatMessage ?? mediaChatMessage?.toJson(),
      };
}
