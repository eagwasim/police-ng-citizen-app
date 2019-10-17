import 'package:flutter/widgets.dart';

class ReportCategory {
  final String title;
  final String description;
  final Color color;

  ReportCategory({@required this.title, @required this.description, @required this.color});

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ReportCategory && runtimeType == other.runtimeType && title == other.title && description == other.description && color == other.color;

  @override
  int get hashCode => title.hashCode ^ description.hashCode ^ color.hashCode;

  @override
  String toString() {
    return title;
  }
}
