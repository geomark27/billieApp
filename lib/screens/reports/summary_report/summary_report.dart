/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: summary_report
*/

import 'package:flutter/material.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/screens/reports/summary_report/models/summary_report.dart';
import 'package:salepro/screens/reports/summary_report/utils/fetch_summary_report.dart';
import 'package:salepro/widgets/drawer.dart';
import 'package:salepro/widgets/form.dart';
import 'package:salepro/widgets/summary_box.dart' as sb;

class SummaryReportScreen extends StatefulWidget {
  const SummaryReportScreen({
    super.key,
    required this.report,
    required this.start,
    required this.end,
  });

  final Data<SummaryReport> report;
  final DateTime start;
  final DateTime end;

  @override
  State<SummaryReportScreen> createState() => _SummaryReportScreenState();
}

class _SummaryReportScreenState extends State<SummaryReportScreen> {
  List<SummaryReport> summaryReports = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      summaryReports = widget.report.data;
    });
  }

  Future<void> fetchData(BuildContext context, {int count = 1}) async {
    final report = await fetchSummaryReport(
      context,
      widget.start,
      widget.end,
      count: count,
    );

    setState(() {
      if (count == 1) {
        summaryReports = report.data;
      } else {
        summaryReports = [
          ...summaryReports,
          ...report.data,
        ];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Summary Report'),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: generateInputGroups(
              padding: EdgeInsets.all(
                AppSpacing.kDefaultPadding * 0.5,
              ),
              [
                SizedBox(),
                ...summaryReports.map(
                  (r) => sb.SummaryBox(
                    title: r.title ?? "",
                    children: r.items
                            ?.map(
                              (i) => sb.SummaryItem(
                                title: i.label,
                                value: i.value,
                              ),
                            )
                            .toList() ??
                        [],
                  ),
                ),
                SizedBox(
                  height: AppSpacing.kDefaultPadding * 2,
                ),
              ]),
        ),
      ),
    );
  }
}
