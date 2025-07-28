/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: home
*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:salepro/constants/colors.dart';
import 'package:salepro/constants/spacing.dart';
import 'package:salepro/providers/common_data_provider.dart';
import 'package:salepro/utils/get_theme_color.dart';
import 'package:salepro/utils/is_dark.dart';
import 'package:salepro/widgets/app_table.dart';
import 'package:salepro/widgets/drawer.dart';
import 'package:salepro/widgets/form.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<CommonDataProvider>().user;
    // ✅ AÑADE ESTAS LÍNEAS PARA DEPURAR
    print('--- CONSTRUYENDO HomeScreen ---');
    print('Objeto User desde el Provider: ${user}');
    print('Nombre del usuario: ${user?.name}');
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${user?.name}"),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: context.watch<CommonDataProvider>().dashboard != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: generateInputGroups(
                  [
                    Stats(),
                    SizedBox(
                      height: AppSpacing.kDefaultPadding,
                    ),
                    SizedBox(
                      height: AppSpacing.kDefaultPadding * 35,
                      child: TransactionTable(
                        title: "Recent Transaction",
                      ),
                    ),
                    StatTable(
                      title:
                          "Best Seller ${DateFormat("MMMM").format(DateTime.now())}",
                      rows: context
                          .watch<CommonDataProvider>()
                          .dashboard!
                          .bestSellerMonth
                          .map(
                            (p) => [
                              {
                                "type": "custom",
                                "child": Row(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: p.image,
                                      height: AppSpacing.kDefaultPadding * 4,
                                    ),
                                    SizedBox(
                                      width: AppSpacing.kDefaultPadding * 0.5,
                                    ),
                                    Text(
                                      "${p.name} [${p.code}]",
                                    ),
                                  ],
                                )
                              },
                              p.qty,
                            ],
                          )
                          .toList(),
                      columns: [
                        "Product Details",
                        "Qty",
                      ],
                    ),
                    StatTable(
                      title:
                          "Best Seller ${DateFormat("yyyy").format(DateTime.now())}(Qty)",
                      rows: context
                          .watch<CommonDataProvider>()
                          .dashboard!
                          .yearlyBestSellingByQty
                          .map(
                            (p) => [
                              {
                                "type": "custom",
                                "child": Row(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: p.image,
                                      height: AppSpacing.kDefaultPadding * 4,
                                    ),
                                    SizedBox(
                                      width: AppSpacing.kDefaultPadding * 0.5,
                                    ),
                                    Text(
                                      "${p.name} [${p.code}]",
                                    ),
                                  ],
                                )
                              },
                              p.qty,
                            ],
                          )
                          .toList(),
                      columns: [
                        "Product Details",
                        "Qty",
                      ],
                    ),
                    StatTable(
                      title:
                          "Best Seller ${DateFormat("yyyy").format(DateTime.now())}(Price)",
                      rows: context
                          .watch<CommonDataProvider>()
                          .dashboard!
                          .yearlyBestSellingByPrice
                          .map(
                            (p) => [
                              {
                                "type": "custom",
                                "child": Row(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: p.image,
                                      height: AppSpacing.kDefaultPadding * 4,
                                    ),
                                    SizedBox(
                                      width: AppSpacing.kDefaultPadding * 0.5,
                                    ),
                                    Text(
                                      "${p.name} [${p.code}]",
                                    ),
                                  ],
                                )
                              },
                              p.grandTotal,
                            ],
                          )
                          .toList(),
                      columns: [
                        "Product Details",
                        "Grand Total",
                      ],
                    ),
                    SizedBox(
                      height: AppSpacing.kDefaultPadding * 2,
                    ),
                  ],
                ),
              )
            : SizedBox(),
      ),
    );
  }
}

class TransactionTable extends StatefulWidget {
  const TransactionTable({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<TransactionTable> createState() => _TransactionTableState();
}

class _TransactionTableState extends State<TransactionTable>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: useThemeMode(
          context,
          light: getThemeColor(context)?.shade50,
          dark: getThemeColor(context)?.shade900.withValues(
                alpha: 0.3,
              ),
        ),
        borderRadius: BorderRadius.circular(
          AppSpacing.kDefaultPadding,
        ),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.kDefaultPadding,
      ),
      padding: const EdgeInsets.all(
        AppSpacing.kDefaultPadding,
      ),
      height: AppSpacing.kDefaultPadding * 100,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: AppSpacing.kDefaultPadding * 1.4,
              fontWeight: FontWeight.bold,
            ),
          ),
          TabBar(
            isScrollable: true,
            padding: EdgeInsets.zero,
            tabAlignment: TabAlignment.start,
            unselectedLabelColor: useThemeMode(
              context,
              light: AppColors.slateSwatch,
              dark: AppColors.white,
            ),
            labelColor: useThemeMode(
              context,
              light: getThemeColor(context),
              dark: getThemeColor(context)?.shade100,
            ),
            indicatorColor: useThemeMode(
              context,
              light: getThemeColor(context),
              dark: getThemeColor(context)?.shade300,
            ),
            tabs: [
              Tab(
                text: 'Sale',
              ),
              Tab(
                text: 'Purchase',
              ),
              Tab(
                text: 'Quotation',
              ),
              Tab(
                text: 'Payment',
              )
            ],
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                AppTable(
                  rows: context
                      .watch<CommonDataProvider>()
                      .dashboard!
                      .recentSales
                      .map(
                        (s) => [
                          s.date,
                          s.referenceNo,
                          s.customer,
                          s.status,
                          s.grandTotal,
                        ],
                      )
                      .toList(),
                  columns: [
                    "Date",
                    "Reference",
                    "Customer",
                    "Status",
                    "Grand Total"
                  ],
                ),
                AppTable(
                  rows: context
                      .watch<CommonDataProvider>()
                      .dashboard!
                      .recentPurchases
                      .map(
                        (s) => [
                          s.date,
                          s.referenceNo,
                          s.supplier,
                          s.status,
                          s.grandTotal,
                        ],
                      )
                      .toList(),
                  columns: [
                    "Date",
                    "Reference",
                    "Supplier",
                    "Status",
                    "Grand Total"
                  ],
                ),
                AppTable(
                  rows: context
                      .watch<CommonDataProvider>()
                      .dashboard!
                      .recentQuotations
                      .map(
                        (s) => [
                          s.date,
                          s.referenceNo,
                          s.customer,
                          s.status,
                          s.grandTotal,
                        ],
                      )
                      .toList(),
                  columns: [
                    "Date",
                    "Reference",
                    "Customer",
                    "Status",
                    "Grand Total"
                  ],
                ),
                AppTable(
                  rows: context
                      .watch<CommonDataProvider>()
                      .dashboard!
                      .recentPayments
                      .map(
                        (s) => [
                          s.date,
                          s.referenceNo,
                          s.amount,
                          s.paidBy,
                        ],
                      )
                      .toList(),
                  columns: [
                    "Date",
                    "Reference",
                    "Amount",
                    "Paid By",
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StatTable extends StatelessWidget {
  const StatTable({
    super.key,
    required this.title,
    required this.rows,
    required this.columns,
  });

  final String title;
  final List<List<dynamic>> rows;
  final List<String> columns;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: useThemeMode(
          context,
          light: getThemeColor(context)?.shade50,
          dark: getThemeColor(context)?.shade900.withValues(
                alpha: 0.3,
              ),
        ),
        borderRadius: BorderRadius.circular(
          AppSpacing.kDefaultPadding,
        ),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.kDefaultPadding,
      ),
      padding: const EdgeInsets.all(
        AppSpacing.kDefaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: AppSpacing.kDefaultPadding * 1.4,
              fontWeight: FontWeight.bold,
            ),
          ),
          AppTable(
            rows: rows,
            columns: columns,
          )
        ],
      ),
    );
  }
}

class Stats extends StatelessWidget {
  const Stats({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StatCard(
          title: "Revenue",
          value: context.watch<CommonDataProvider>().dashboard?.revenue ?? "0",
          icon: HeroIcons.chartBar,
          color: AppColors.purpleSwatch,
        ),
        StatCard(
          title: "Sale Return",
          value:
              context.watch<CommonDataProvider>().dashboard?.saleReturn ?? "0",
          icon: HeroIcons.backward,
          color: AppColors.orangeSwatch,
        ),
        StatCard(
          title: "Purchase Return",
          value:
              context.watch<CommonDataProvider>().dashboard?.purchaseReturn ??
                  "0",
          icon: HeroIcons.forward,
          color: AppColors.greenSwatch,
        ),
        StatCard(
          title: "Profit",
          value: context.watch<CommonDataProvider>().dashboard?.profit ?? "0",
          icon: HeroIcons.trophy,
          color: AppColors.blueSwatch,
        ),
      ],
    );
  }
}

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final HeroIcons icon;
  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: AppSpacing.kDefaultPadding,
        left: AppSpacing.kDefaultPadding,
        right: AppSpacing.kDefaultPadding,
      ),
      padding: EdgeInsets.all(
        AppSpacing.kDefaultPadding,
      ),
      decoration: BoxDecoration(
        color: useThemeMode(
          context,
          light: getThemeColor(context)?.shade50,
          dark: getThemeColor(context)?.shade900.withValues(
                alpha: 0.3,
              ),
        ),
        borderRadius: BorderRadius.circular(
          AppSpacing.kDefaultPadding,
        ),
      ),
      child: Row(
        children: [
          HeroIcon(
            icon,
            size: AppSpacing.kDefaultPadding * 3,
            color: useThemeMode(
              context,
              light: color,
              dark: color.shade300,
            ),
          ),
          SizedBox(
            width: AppSpacing.kDefaultPadding,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: AppSpacing.kDefaultPadding * 1.6,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: AppSpacing.kDefaultPadding * 0.25,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: AppSpacing.kDefaultPadding * 1.4,
                  color: useThemeMode(
                    context,
                    light: color,
                    dark: color.shade300,
                  ),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
