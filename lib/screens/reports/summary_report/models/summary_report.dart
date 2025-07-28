/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: summary_report
*/

import 'package:salepro/models/mappable.dart';

class SummaryReport implements Mappable {
  final String? startDate;
  final String? endDate;

  final String? title;
  final String? type;
  final List<SummaryItem>? items;

  SummaryReport({
    this.startDate,
    this.endDate,
    this.title,
    this.type,
    this.items,
  });

  factory SummaryReport.fromJson(Map json) {
    return SummaryReport(
      title: json['title'],
      type: json['type'],
      items: (json['data'] as List)
          .map(
            (d) => SummaryItem.fromJson(
              d,
            ),
          )
          .toList(),
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => SummaryReport.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'type': type,
      'data': items
          ?.map(
            (i) => i.toMap(),
          )
          .toList(),
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {
      'start_date': startDate,
      'end_date': endDate,
    };
  }
}

class SummaryItem implements Mappable {
  final String label;
  final String value;

  SummaryItem({required this.label, required this.value});

  factory SummaryItem.fromJson(Map json) {
    return SummaryItem(
      label: json['label'],
      value: json['value'].toString(),
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) => SummaryItem.fromJson(json);

  @override
  Map<String, dynamic> toFormData() {
    return {};
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "label": label,
      "value": value,
    };
  }
}
