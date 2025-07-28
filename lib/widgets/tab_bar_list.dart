/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: tab_bar_list
*/

import 'dart:convert';

import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/utils/control_loading.dart';
import 'package:salepro/utils/get_screensize.dart';
import 'package:salepro/utils/get_theme_color.dart';
import 'package:salepro/utils/is_dark.dart';
import 'package:salepro/widgets/app_loader.dart';
import 'package:salepro/widgets/app_table_scroller.dart';
import 'package:salepro/widgets/checkbox.dart';
import 'package:salepro/widgets/drawer.dart';
import 'package:salepro/widgets/sortable_table.dart';
import 'package:salepro/widgets/text_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabBarListScreen extends StatefulWidget {
  const TabBarListScreen({
    super.key,
    required this.title,
    this.importPage,
    this.importTooltip,
    this.addPage,
    this.actions,
    required this.rows,
    required this.columns,
    this.tableActions,
    this.onRefresh,
    this.fetchMethod,
    this.requirePagination = false,
    this.dataRowHeight,
    this.pageCount = 1,
    this.loadNewPage,
    this.onTap,
    this.disabledIndexes,
    required this.tabs,
  });

  final String title;
  final Widget? importPage;
  final String? importTooltip;
  final Widget? addPage;
  final List<List<Widget>?>? actions;
  final List<List<List<dynamic>>> rows;
  final List<List<String>> columns;
  final List<String> tabs;
  final List<List<Widget>?>? Function(int id)? tableActions;
  final Future<void> Function()? fetchMethod;
  final Future<void> Function()? onRefresh;
  final Future<void> Function(int count)? loadNewPage;
  final bool requirePagination;
  final List<double?>? dataRowHeight;
  final int pageCount;
  final List<List<int>?>? disabledIndexes;
  final List<void Function(int id)?>? onTap;

  @override
  State<TabBarListScreen> createState() => _TabBarListScreenState();
}

class _TabBarListScreenState extends State<TabBarListScreen> {
  bool loading = false;
  bool infiniteLoading = false;
  List<List>? enabledColumns;
  late int count;
  late ScrollController infiniteScrollController;
  int _activeIndex = 0;

  Future<void> saveState() async {
    String key =
        "${widget.title.toLowerCase().replaceAll(' ', '-')}-${widget.rows.length}";

    var pref = await SharedPreferences.getInstance();

    pref.setString(
      key,
      jsonEncode(enabledColumns),
    );
  }

  Future<void> onFetch() async {
    String key =
        "${widget.title.toLowerCase().replaceAll(' ', '-')}-${widget.rows.length}";
    if (widget.fetchMethod != null) {
      setState(() {
        loading = true;
      });
      await widget.fetchMethod!();
      setState(() {
        loading = false;
      });
    }

    var pref = await SharedPreferences.getInstance();
    if (pref.containsKey(key)) {
      setState(() {
        enabledColumns = jsonDecode(
          pref.getString(
            key,
          )!,
        ) as List<List>;
      });
    } else {
      pref.setString(
        key,
        jsonEncode(
          widget.columns
              .map(
                (c) => List.generate(
                  c.length,
                  (index) {
                    return true;
                  },
                ),
              )
              .toList(),
        ),
      );
      setState(() {
        enabledColumns = widget.columns
            .map(
              (c) => List.generate(
                c.length,
                (index) {
                  return true;
                },
              ),
            )
            .toList();
      });
    }

    if (widget.loadNewPage != null) {
      infiniteScrollController.addListener(() async {
        if (infiniteScrollController.position.maxScrollExtent ==
            infiniteScrollController.offset) {
          Loading.start(context);
          await widget.loadNewPage!(count + 1);
          // ignore: use_build_context_synchronously
          Loading.stop(context);
          setState(() {
            count++;
          });
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      enabledColumns = widget.columns
          .map(
            (c) => List.generate(
              c.length,
              (index) {
                return true;
              },
            ),
          )
          .toList();
      infiniteScrollController = ScrollController();
      count = widget.pageCount;
    });
    onFetch();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  saveState();
                  Navigator.of(context).pop();
                },
                child: Container(
                  color: const Color.fromARGB(255, 0, 0, 0).withValues(
                    alpha: 0.4,
                  ),
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.all(
                    AppSpacing.kDefaultPadding,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.kDefaultPadding,
                    horizontal: AppSpacing.kDefaultPadding * 1.5,
                  ),
                  decoration: BoxDecoration(
                    color: useThemeMode(
                      context,
                      light: AppColors.white,
                      dark: AppColors.slateSwatch,
                    ),
                    borderRadius: BorderRadius.circular(
                      AppSpacing.kDefaultPadding,
                    ),
                  ),
                  child: StatefulBuilder(builder:
                      (BuildContext context, StateSetter setModalState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Enable or Disable Table Columns',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            AppTextButton(
                              child: const Icon(Icons.close),
                              onTap: () {
                                saveState();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: AppSpacing.kDefaultPadding * 0.5,
                        ),
                        ...widget.columns[_activeIndex].map(
                          (col) {
                            return AppCheckBox(
                              hintText: col,
                              value: enabledColumns?[_activeIndex]
                                  [widget.columns[_activeIndex].indexOf(col)],
                              onChanged: (bool? value) {
                                setModalState(
                                  () {
                                    enabledColumns?[_activeIndex][widget
                                        .columns[_activeIndex]
                                        .indexOf(col)] = value;
                                  },
                                );
                                setState(
                                  () {
                                    enabledColumns?[_activeIndex][widget
                                        .columns[_activeIndex]
                                        .indexOf(col)] = value;
                                  },
                                );
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: AppSpacing.kDefaultPadding * 0.5,
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppLoader(
      child: DefaultTabController(
        length: widget.tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text("${widget.title} (${widget.tabs[_activeIndex]})"),
                IconButton(
                  icon: FittedBox(
                    child: Countup(
                      begin: 0,
                      end: widget.rows[_activeIndex].length.toDouble(),
                      prefix: "(",
                      suffix: ")",
                      style: TextStyle(
                        fontSize: AppSpacing.kDefaultPadding * 1.2,
                      ),
                    ),
                  ),
                  onPressed: () {},
                  tooltip: "Total Rows",
                ),
              ],
            ),
            bottom: TabBar(
              onTap: (int index) {
                setState(() {
                  _activeIndex = index;
                });
              },
              tabs: widget.tabs
                  .map(
                    (t) => Tab(
                      text: t,
                    ),
                  )
                  .toList(),
            ),
            actions: [
              SizedBox(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.eye,
                        ),
                        onPressed: () {
                          _showModal(
                            context,
                          );
                        },
                        tooltip: "Enable or Disable Table Column",
                      ),
                      if (widget.importPage != null)
                        IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.fileImport,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => widget.importPage!,
                              ),
                            );
                          },
                          tooltip:
                              widget.importTooltip ?? "Import ${widget.title}",
                        ),
                      const SizedBox(
                        width: AppSpacing.kDefaultPadding,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          drawer: const AppDrawer(),
          body: LiquidPullToRefresh(
            color: useThemeMode(
              context,
              light: getThemeColor(context)?.shade400.withValues(alpha: 0.2),
              dark: getThemeColor(context)?.shade900.withValues(alpha: 0.2),
            ),
            backgroundColor: useThemeMode(
              context,
              light: getThemeColor(context),
              dark: getThemeColor(context)?.shade100,
            ),
            onRefresh: () async {
              if (widget.onRefresh != null) {
                setState(() {
                  loading = true;
                  count = 1;
                });
                await widget.onRefresh!();
                setState(() {
                  loading = false;
                });
              }
            },
            child: TabBarView(
              // controller: _tabController,
              children: widget.tabs
                  .map(
                    (t) => TabView(
                      index: widget.tabs.indexOf(t),
                      loading: loading,
                      widget: widget,
                      infiniteScrollController: infiniteScrollController,
                      enabledColumns: enabledColumns?[widget.tabs.indexOf(t)],
                    ),
                  )
                  .toList(),
            ),
          ),
          floatingActionButton: widget.addPage != null
              ? FloatingActionButton(
                  backgroundColor: getThemeColor(context),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => widget.addPage!,
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.add,
                  ),
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}

class TabView extends StatelessWidget {
  const TabView({
    super.key,
    required this.loading,
    required this.widget,
    required this.infiniteScrollController,
    required this.enabledColumns,
    required this.index,
  });

  final int index;
  final bool loading;
  final TabBarListScreen widget;
  final ScrollController infiniteScrollController;
  final List? enabledColumns;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: loading
          ? Center(
              child: Column(
                children: [
                  Lottie.asset(
                    'assets/animations/loading_data.json',
                    width: AppSpacing.kDefaultPadding * 10,
                    height: AppSpacing.kDefaultPadding * 10,
                  ),
                  Text(
                    "Loading Your Data...",
                    style: TextStyle(
                      fontSize: AppSpacing.kDefaultPadding * 1.8,
                      fontWeight: FontWeight.bold,
                      color: useThemeMode(
                        context,
                        light: getThemeColor(context)?.shade800,
                        dark: getThemeColor(context)?.shade200,
                      ),
                    ),
                  )
                      .animate(onPlay: (controller) => controller.repeat())
                      .shimmer(
                        duration: 4.seconds,
                        color: useThemeMode(
                          context,
                          light: getThemeColor(context)?.shade300,
                          dark: getThemeColor(context)?.shade500,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 2.seconds, curve: Curves.easeOutQuad)
                      .slide(),
                ],
              ).animate(onPlay: (controller) => controller.repeat()).shakeY(
                    duration: 200.ms,
                    curve: Curves.bounceIn,
                    amount: 1.2,
                  ),
            )
          : widget.rows[index].isEmpty
              ? Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.kDefaultPadding * 5,
                  ),
                  width: getScreenSize(
                    context,
                  ),
                  height: getScreenSize(
                    context,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Lottie.asset(
                        'assets/animations/no_data.json',
                        width: AppSpacing.kDefaultPadding * 15,
                        height: AppSpacing.kDefaultPadding * 15,
                      ),
                      Text(
                        "No Data Found...",
                        style: TextStyle(
                          fontSize: AppSpacing.kDefaultPadding * 1.8,
                          fontWeight: FontWeight.bold,
                          color: useThemeMode(
                            context,
                            light: getThemeColor(context)
                                ?.shade900
                                .withValues(alpha: 0.7),
                            dark: getThemeColor(context)?.shade200,
                          ),
                        ),
                      ),
                    ],
                  )
                      .animate(onPlay: (controller) => controller.repeat())
                      .shimmer(delay: 3.seconds, duration: 1800.ms)
                      .shake(hz: 4, curve: Curves.easeInOutCubic)
                      .scaleX(begin: 1.0, end: 1.1, duration: 600.ms)
                      .then(delay: 200.ms)
                      .scaleX(begin: 1.0, end: 1 / 1.1),
                )
              : Container(
                  width: getScreenSize(
                    context,
                    type: "width",
                  ),
                  height: getScreenSize(
                    context,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.kDefaultPadding,
                  ),
                  child: AppTableScroller(
                    controller: infiniteScrollController,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SortableTable(
                          rows: widget.rows[index],
                          columns: widget.columns[index],
                          enabledColumns: enabledColumns,
                          dataRowHeight: widget.dataRowHeight != null
                              ? widget.dataRowHeight![index]
                              : null,
                          disabledIndexes: widget.disabledIndexes != null
                              ? widget.disabledIndexes![index]
                              : null,
                          onTap: widget.onTap != null
                              ? widget.onTap![index]
                              : null,
                        ),
                        SizedBox(
                          height: widget.rows.length > 20
                              ? AppSpacing.kDefaultPadding * 12
                              : AppSpacing.kDefaultPadding * 20,
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
