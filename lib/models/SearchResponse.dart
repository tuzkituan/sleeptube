class SearchResponse {
  String? kind;
  String? etag;
  String? nextPageToken;
  String? regionCode;
  SearchPageInfo? pageInfo;
  List<SearchItems>? items;

  SearchResponse(
      {this.kind,
      this.etag,
      this.nextPageToken,
      this.regionCode,
      this.pageInfo,
      this.items});

  SearchResponse.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    nextPageToken = json['nextPageToken'];
    regionCode = json['regionCode'];
    pageInfo = json['pageInfo'] != null
        ? SearchPageInfo.fromJson(json['pageInfo'])
        : null;
    if (json['items'] != null) {
      items = <SearchItems>[];
      json['items'].forEach((v) {
        items!.add(SearchItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kind'] = kind;
    data['etag'] = etag;
    data['nextPageToken'] = nextPageToken;
    data['regionCode'] = regionCode;
    if (pageInfo != null) {
      data['pageInfo'] = pageInfo!.toJson();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchPageInfo {
  int? totalResults;
  int? resultsPerPage;

  SearchPageInfo({this.totalResults, this.resultsPerPage});

  SearchPageInfo.fromJson(Map<String, dynamic> json) {
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

class SearchItems {
  String? kind;
  String? etag;
  Id? id;
  SearchSnippet? snippet;

  SearchItems({this.kind, this.etag, this.id, this.snippet});

  SearchItems.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    id = json['id'] != null ? Id.fromJson(json['id']) : null;
    snippet = json['snippet'] != null
        ? SearchSnippet.fromJson(json['snippet'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kind'] = kind;
    data['etag'] = etag;
    if (id != null) {
      data['id'] = id!.toJson();
    }
    if (snippet != null) {
      data['snippet'] = snippet!.toJson();
    }
    return data;
  }
}

class Id {
  String? kind;
  String? videoId;

  Id({this.kind, this.videoId});

  Id.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    videoId = json['videoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kind'] = kind;
    data['videoId'] = videoId;
    return data;
  }
}

class SearchSnippet {
  String? publishedAt;
  String? channelId;
  String? title;
  String? description;
  SearchThumbnails? thumbnails;
  String? channelTitle;
  String? liveBroadcastContent;
  String? publishTime;

  SearchSnippet(
      {this.publishedAt,
      this.channelId,
      this.title,
      this.description,
      this.thumbnails,
      this.channelTitle,
      this.liveBroadcastContent,
      this.publishTime});

  SearchSnippet.fromJson(Map<String, dynamic> json) {
    publishedAt = json['publishedAt'];
    channelId = json['channelId'];
    title = json['title'];
    description = json['description'];
    thumbnails = json['thumbnails'] != null
        ? SearchThumbnails.fromJson(json['thumbnails'])
        : null;
    channelTitle = json['channelTitle'];
    liveBroadcastContent = json['liveBroadcastContent'];
    publishTime = json['publishTime'];
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
    data['liveBroadcastContent'] = liveBroadcastContent;
    data['publishTime'] = publishTime;
    return data;
  }
}

class SearchThumbnails {
  SearchThumbnailVariant? def;
  SearchThumbnailVariant? medium;
  SearchThumbnailVariant? high;

  SearchThumbnails({this.def, this.medium, this.high});

  SearchThumbnails.fromJson(Map<String, dynamic> json) {
    def = json['default'] != null
        ? SearchThumbnailVariant.fromJson(json['default'])
        : null;
    medium = json['medium'] != null
        ? SearchThumbnailVariant.fromJson(json['medium'])
        : null;
    high = json['high'] != null
        ? SearchThumbnailVariant.fromJson(json['high'])
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
    return data;
  }
}

class SearchThumbnailVariant {
  String? url;
  int? width;
  int? height;

  SearchThumbnailVariant({this.url, this.width, this.height});

  SearchThumbnailVariant.fromJson(Map<String, dynamic> json) {
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
