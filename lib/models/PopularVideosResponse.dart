class PopularVideosResponse {
  String? kind;
  String? etag;
  List<Items>? items;
  String? nextPageToken;
  PageInfo? pageInfo;

  PopularVideosResponse(
      {this.kind, this.etag, this.items, this.nextPageToken, this.pageInfo});

  PopularVideosResponse.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    nextPageToken = json['nextPageToken'];
    pageInfo =
        json['pageInfo'] != null ? PageInfo.fromJson(json['pageInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kind'] = kind;
    data['etag'] = etag;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['nextPageToken'] = nextPageToken;
    if (pageInfo != null) {
      data['pageInfo'] = pageInfo!.toJson();
    }
    return data;
  }
}

class Items {
  String? kind;
  String? etag;
  String? id;
  Snippet? snippet;

  Items({this.kind, this.etag, this.id, this.snippet});

  Items.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    id = json['id'];
    snippet =
        json['snippet'] != null ? Snippet.fromJson(json['snippet']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kind'] = kind;
    data['etag'] = etag;
    data['id'] = id;
    if (snippet != null) {
      data['snippet'] = snippet!.toJson();
    }
    return data;
  }
}

class Snippet {
  String? publishedAt;
  String? channelId;
  String? title;
  String? description;
  Thumbnails? thumbnails;
  String? channelTitle;
  List<String>? tags;
  String? categoryId;
  String? liveBroadcastContent;
  Localized? localized;
  String? defaultAudioLanguage;
  String? defaultLanguage;

  Snippet(
      {this.publishedAt,
      this.channelId,
      this.title,
      this.description,
      this.thumbnails,
      this.channelTitle,
      this.tags,
      this.categoryId,
      this.liveBroadcastContent,
      this.localized,
      this.defaultAudioLanguage,
      this.defaultLanguage});

  Snippet.fromJson(Map<String, dynamic> json) {
    publishedAt = json['publishedAt'];
    channelId = json['channelId'];
    title = json['title'];
    description = json['description'];
    thumbnails = json['thumbnails'] != null
        ? Thumbnails.fromJson(json['thumbnails'])
        : null;
    channelTitle = json['channelTitle'];
    if (json['tags'] != null) {
      tags = json['tags'].cast<String>();
    }
    categoryId = json['categoryId'];
    liveBroadcastContent = json['liveBroadcastContent'];
    localized = json['localized'] != null
        ? Localized.fromJson(json['localized'])
        : null;
    defaultAudioLanguage = json['defaultAudioLanguage'];
    defaultLanguage = json['defaultLanguage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['publishedAt'] = publishedAt;
    data['channelId'] = channelId;
    data['title'] = title;
    data['description'] = description;
    if (thumbnails != null) {
      data['thumbnails'] = thumbnails!.toJson();
    }
    data['channelTitle'] = channelTitle;
    data['tags'] = tags;
    data['categoryId'] = categoryId;
    data['liveBroadcastContent'] = liveBroadcastContent;
    if (localized != null) {
      data['localized'] = localized!.toJson();
    }
    data['defaultAudioLanguage'] = defaultAudioLanguage;
    data['defaultLanguage'] = defaultLanguage;
    return data;
  }
}

class Thumbnails {
  ThumbnailVariant? def;
  ThumbnailVariant? medium;
  ThumbnailVariant? high;
  ThumbnailVariant? standard;
  ThumbnailVariant? maxres;

  Thumbnails({this.def, this.medium, this.high, this.standard, this.maxres});

  Thumbnails.fromJson(Map<String, dynamic> json) {
    def = json['default'] != null
        ? ThumbnailVariant.fromJson(json['default'])
        : null;
    medium = json['medium'] != null
        ? ThumbnailVariant.fromJson(json['medium'])
        : null;
    high =
        json['high'] != null ? ThumbnailVariant.fromJson(json['high']) : null;
    standard = json['standard'] != null
        ? ThumbnailVariant.fromJson(json['standard'])
        : null;
    maxres = json['maxres'] != null
        ? ThumbnailVariant.fromJson(json['maxres'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (def != null) {
      data['default'] = def!.toJson();
    }
    if (medium != null) {
      data['medium'] = medium!.toJson();
    }
    if (high != null) {
      data['high'] = high!.toJson();
    }
    if (standard != null) {
      data['standard'] = standard!.toJson();
    }
    if (maxres != null) {
      data['maxres'] = maxres!.toJson();
    }
    return data;
  }
}

class ThumbnailVariant {
  String? url;
  int? width;
  int? height;

  ThumbnailVariant({this.url, this.width, this.height});

  ThumbnailVariant.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['width'] = width;
    data['height'] = height;
    return data;
  }
}

class Localized {
  String? title;
  String? description;

  Localized({this.title, this.description});

  Localized.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}

class PageInfo {
  int? totalResults;
  int? resultsPerPage;

  PageInfo({this.totalResults, this.resultsPerPage});

  PageInfo.fromJson(Map<String, dynamic> json) {
    totalResults = json['totalResults'];
    resultsPerPage = json['resultsPerPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalResults'] = totalResults;
    data['resultsPerPage'] = resultsPerPage;
    return data;
  }
}
