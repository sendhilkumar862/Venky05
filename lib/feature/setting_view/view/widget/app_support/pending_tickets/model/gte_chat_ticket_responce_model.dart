class ChatTicketResponseModel {

  ChatTicketResponseModel(
      {this.replyId,
        this.message,
        this.isAdminReply,
        this.createdAt,
        this.createdBy,
        this.attachments,
        this.profileImageId});

  ChatTicketResponseModel.fromJson(Map<String, dynamic> json) {
    replyId = json['reply_id'];
    message = json['message'];
    isAdminReply = json['is_admin_reply'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    if (json['attachments'] != null) {
      attachments = <Attachment>[];
      // ignore: avoid_dynamic_calls
      json['attachments'].forEach((v) {
        attachments!.add(Attachment.fromJson(v));
      });
    }
    profileImageId = json['profile_image_id'];
  }
  int? replyId;
  String? message;
  int? isAdminReply;
  int? createdAt;
  String? createdBy;
  List<Attachment>? attachments;
  String? profileImageId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reply_id'] = replyId;
    data['message'] = message;
    data['is_admin_reply'] = isAdminReply;
    data['created_at'] = createdAt;
    data['created_by'] = createdBy;
    if (attachments != null) {
      data['attachments'] = attachments!.map((v) => v.toJson()).toList();
    }
    data['profile_image_id'] = profileImageId;
    return data;
  }
}

class Attachment {

  Attachment({this.attachmentId});

  Attachment.fromJson(Map<String, dynamic> json) {
    attachmentId = json['attachment_id'];
  }
  String? attachmentId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attachment_id'] = attachmentId;
    return data;
  }
}

