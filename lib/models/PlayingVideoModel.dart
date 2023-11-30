class PlayingVideoModal {
  String? id;
  String? title;
  String? author;
  String? channelId;
  String? uploadDate;
  String? description;
  String? thumbnail;

  PlayingVideoModal(
      {this.id,
      this.title,
      this.author,
      this.channelId,
      this.uploadDate,
      this.description,
      this.thumbnail});

  PlayingVideoModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    channelId = json['channelId'];
    uploadDate = json['uploadDate'];
    description = json['description'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['author'] = author;
    data['channelId'] = channelId;
    data['uploadDate'] = uploadDate;
    data['description'] = description;
    data['thumbnail'] = thumbnail;
    return data;
  }
}
