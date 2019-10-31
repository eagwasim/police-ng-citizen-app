class Media {
  String url;
  String mimeType;

  @override
  String toString() {
    return 'Media{url: $url, mimeType: $mimeType}';
  }

  Media.fromJson(Map<String, dynamic> json)
      : url = json['url'] ?? null,
        mimeType = json['mime_type'] ?? null;
}
