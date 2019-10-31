import 'package:police_citizen_app/models/media.dart';

class CitizensReport {
  int id;
  String title;
  String description;
  String reportType;
  List<Media> media;
  bool keepAnonymous;
  String address;
  String dateModified;
  String dateCreated;

  CitizensReport.fromJson(Map<String, dynamic> json)
      : description = json['description'] ?? "",
        reportType = json['report_type'] ?? "",
        media = List<Media>.from((json['media'] ?? []).map((m) => Media.fromJson(m)).toList()),
        keepAnonymous = json['keep_anonymous'] ?? false,
        address = json['address'] ?? "",
        id = json['id'] ?? 0,
        dateCreated = json['date_created'],
        dateModified = json['date_modified'],
        title = json['title'] ?? "";
}
