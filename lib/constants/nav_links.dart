/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: nav_links
*/

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heroicons/heroicons.dart';
import 'package:salepro/constants/keys.dart';
import 'package:salepro/models/nav_link.dart';
import 'package:salepro/screens/HRM/attendance/attendances_list.dart';
import 'package:salepro/screens/HRM/departments/departments_list.dart';
import 'package:salepro/screens/HRM/employees/employees_list.dart';
import 'package:salepro/screens/HRM/payroll/payrolls_list.dart';
import 'package:salepro/screens/HRM/holiday/holidays_list.dart';
import 'package:salepro/screens/accounting/account_statements.dart';
import 'package:salepro/screens/accounting/accounts_list.dart';
import 'package:salepro/screens/accounting/add_account.dart';
import 'package:salepro/screens/accounting/balance_sheet.dart';
import 'package:salepro/screens/accounting/money_transfers/money_transfer_list.dart';
import 'package:salepro/screens/addons/addons_list.dart';
import 'package:salepro/screens/auth/login.dart';
import 'package:salepro/screens/expenses/add_expense.dart';
import 'package:salepro/screens/expenses/categories/categories.dart';
import 'package:salepro/screens/expenses/expenses_list.dart';
import 'package:salepro/screens/home.dart';
import 'package:salepro/screens/incomes/add_income.dart';
import 'package:salepro/screens/incomes/categories/categories.dart';
import 'package:salepro/screens/incomes/incomes_list.dart';
import 'package:salepro/screens/manufacturing/add_production.dart';
import 'package:salepro/screens/manufacturing/production_list.dart';
import 'package:salepro/screens/people/biller/add_biller.dart';
import 'package:salepro/screens/people/biller/billers_list.dart';
import 'package:salepro/screens/people/customers/add_customer.dart';
import 'package:salepro/screens/people/customers/customers_list.dart';
import 'package:salepro/screens/people/suppliers/add_supplier.dart';
import 'package:salepro/screens/people/suppliers/suppliers_list.dart';
import 'package:salepro/screens/people/users/add_user.dart';
import 'package:salepro/screens/people/users/users_list.dart';
import 'package:salepro/screens/products/add_product.dart';
import 'package:salepro/screens/products/adjustments/add_adjustment.dart';
import 'package:salepro/screens/products/adjustments/adjustments_list.dart';
import 'package:salepro/screens/products/categories/categories.dart';
import 'package:salepro/screens/products/count_stocks/count_stocks.dart';
import 'package:salepro/screens/products/print_barcode.dart';
import 'package:salepro/screens/products/product_list.dart';
import 'package:salepro/screens/purchases/add_purchase.dart';
import 'package:salepro/screens/purchases/import_purchases.dart';
import 'package:salepro/screens/purchases/purchase_list.dart';
import 'package:salepro/screens/quotations/add_quotation.dart';
import 'package:salepro/screens/quotations/quotations_list.dart';
import 'package:salepro/screens/reports/best_seller.dart';
import 'package:salepro/screens/reports/biller_report/biller_report_input.dart';
import 'package:salepro/screens/reports/challan_report/challan_report_input.dart';
import 'package:salepro/screens/reports/customer_due_report/customer_due_report_input.dart';
import 'package:salepro/screens/reports/customer_group_report/customer_group_report_input.dart';
import 'package:salepro/screens/reports/customer_report/customer_report_input.dart';
import 'package:salepro/screens/reports/daily_purchase.dart';
import 'package:salepro/screens/reports/daily_sale.dart';
import 'package:salepro/screens/reports/daily_sale_objective_report.dart';
import 'package:salepro/screens/reports/monthly_purchase.dart';
import 'package:salepro/screens/reports/monthly_sale.dart';
import 'package:salepro/screens/reports/payment_report/payment_report_input.dart';
import 'package:salepro/screens/reports/product_expiry_report.dart';
import 'package:salepro/screens/reports/product_quantity_alert.dart';
import 'package:salepro/screens/reports/product_report/product_report_input.dart';
import 'package:salepro/screens/reports/purchase_report/purchase_report_input.dart';
import 'package:salepro/screens/reports/sale_report/sale_report_input.dart';
import 'package:salepro/screens/reports/sale_report_chart.dart';
import 'package:salepro/screens/reports/summary_report/summary_report_input.dart';
import 'package:salepro/screens/reports/supplier_due_report/supplier_due_report_input.dart';
import 'package:salepro/screens/reports/supplier_report/supplier_report_input.dart';
import 'package:salepro/screens/reports/user_report/user_report_input.dart';
import 'package:salepro/screens/reports/warehouse_report.dart';
import 'package:salepro/screens/reports/warehouse_stock_chart.dart';
import 'package:salepro/screens/returns/purchase/purchases_return.dart';
import 'package:salepro/screens/returns/sale/sales_return.dart';
import 'package:salepro/screens/sales/add_sale.dart';
import 'package:salepro/screens/sales/challan_list.dart';
import 'package:salepro/screens/sales/coupons/coupon_list.dart';
import 'package:salepro/screens/sales/couriers/courier_list.dart';
import 'package:salepro/screens/sales/delivery_list.dart';
import 'package:salepro/screens/sales/gift_cards/gift_card_list.dart';
import 'package:salepro/screens/sales/import_sales.dart';
import 'package:salepro/screens/sales/packing_slip_list.dart';
import 'package:salepro/screens/sales/pos/pos_screen.dart';
import 'package:salepro/screens/sales/sales_list.dart';
import 'package:salepro/screens/settings/barcode_settings/list.dart';
import 'package:salepro/screens/settings/brands/list.dart';
import 'package:salepro/screens/settings/create_sms.dart';
import 'package:salepro/screens/settings/currencies/list.dart';
import 'package:salepro/screens/settings/custom_fields/list.dart';
import 'package:salepro/screens/settings/customers_groups/list.dart';
import 'package:salepro/screens/settings/discount_plans/list.dart';
import 'package:salepro/screens/settings/discounts/list.dart';
import 'package:salepro/screens/settings/payment_gateways/gateway_settings.dart';
import 'package:salepro/screens/settings/general_settings.dart';
import 'package:salepro/screens/settings/hrm_settings.dart';
import 'package:salepro/screens/settings/languages/list.dart';
import 'package:salepro/screens/settings/mail_settings.dart';
import 'package:salepro/screens/settings/notifications/list.dart';
import 'package:salepro/screens/settings/notifications/send.dart';
import 'package:salepro/screens/settings/pos_settings.dart';
import 'package:salepro/screens/settings/profile/update_password.dart';
import 'package:salepro/screens/settings/profile/update_profile.dart';
import 'package:salepro/screens/settings/reward_point_settings.dart';
import 'package:salepro/screens/settings/role_permissions/list.dart';
import 'package:salepro/screens/settings/sms_settings.dart';
import 'package:salepro/screens/settings/sms_templates/list.dart';
import 'package:salepro/screens/settings/tables/list.dart';
import 'package:salepro/screens/settings/taxes/list.dart';
import 'package:salepro/screens/settings/theming.dart';
import 'package:salepro/screens/settings/units/list.dart';
import 'package:salepro/screens/settings/warehouse/list.dart';
import 'package:salepro/screens/transfers/add_transfer.dart';
import 'package:salepro/screens/transfers/import_transfers.dart';
import 'package:salepro/screens/transfers/transfers.dart';
import 'package:shared_preferences/shared_preferences.dart';

final navLinks = [
  NavLink(
    title: "Dashboard",
    icon: FontAwesomeIcons.gaugeHigh,
    iconType: NavLink.fontAwesomeIcon,
    group: false,
    screen: const HomeScreen(),
  ),
  NavLink(
    title: "Productos",
    icon: HeroIcons.listBullet,
    iconType: NavLink.heroIcon,
    group: true,
    links: [
      NavLink(
        title: "Categorias",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const CategoriesScreen(),
      ),
      NavLink(
        title: "Productos",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const ProductListScreen(),
      ),
      NavLink(
        title: "Ajuste de stock",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const AdjustmentsListScreen(),
      ),
      NavLink(
        title: "Conteo de stock",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const CountStocksScreen(),
      ),
            NavLink(
        title: "Brand",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const BrandsListScreen(),
      ),
      NavLink(
        title: "Unit",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const UnitsListScreen(),
      ),
    ],
  ),
  NavLink(
    title: "Compra",
    icon: HeroIcons.creditCard,
    iconType: NavLink.heroIcon,
    group: true,
    links: [
      NavLink(
        title: "Compras",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const PurchaseListScreen(),
      ),
      NavLink(
        title: "Devolucion de compra",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const PurchasesReturnScreen(),
      ),
    ],
  ),
  NavLink(
    title: "Venta",
    icon: HeroIcons.shoppingCart,
    iconType: NavLink.heroIcon,
    group: true,
    links: [
      NavLink(
        title: "Ventas",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const SalesListScreen(),
      ),
      NavLink(
        title: "POS",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const POSScreen(),
      ),
      NavLink(
        title: "Cotizaciones",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const QuotationsListScreen(),
      ),
      NavLink(
        title: "Devolucion de venta",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const SalesReturnScreen(),
      ),
      NavLink(
        title: "Packing Slip List",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const PackingSlipListScreen(),
      ),
      NavLink(
        title: "Challan List",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const ChallanListScreen(),
      ),
      NavLink(
        title: "Deliveries",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const DeliveryListScreen(),
      ),
      NavLink(
        title: "Gift Card",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const GiftCardListScreen(),
      ),
      NavLink(
        title: "Coupones",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const CouponListScreen(),
      ),
      NavLink(
        title: "Courier",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const CourierListScreen(),
      ),
    ],
  ),
  NavLink(
    title: "Manufactura",
    icon: FontAwesomeIcons.industry,
    iconType: NavLink.fontAwesomeIcon,
    group: true,
    links: [
      NavLink(
        title: "Produccion",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const ProductionListScreen(),
      ),
    ],
  ),
  NavLink(
    title: "Egresos",
    icon: FontAwesomeIcons.sackXmark,
    iconType: NavLink.fontAwesomeIcon,
    group: true,
    links: [
      NavLink(
        title: "Categoria de egresos",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const ExpenseCategoriesScreen(),
      ),
      NavLink(
        title: "Egresos",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const ExpensesListScreen(),
      ),
    ],
  ),
  NavLink(
    title: "Ingresos",
    icon: HeroIcons.rocketLaunch,
    iconType: NavLink.heroIcon,
    group: true,
    links: [
      NavLink(
        title: "Categoria de ingresos",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const IncomeCategoriesScreen(),
      ),
      NavLink(
        title: "Ingresos",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const IncomesListScreen(),
      ),
    ],
  ),
  NavLink(
    title: "Inventario",
    icon: HeroIcons.arrowUturnRight,
    iconType: NavLink.heroIcon,
    group: true,
    links: [
      NavLink(
        title: "Tranferencias",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const TransfersScreen(),
      ),
    ],
  ),
  NavLink(
    title: "Contabilidad",
    icon: FontAwesomeIcons.briefcase,
    iconType: NavLink.fontAwesomeIcon,
    group: true,
    links: [
      NavLink(
        title: "Cuentas",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const AccountsListScreen(),
      ),
      NavLink(
        title: "Tranferencia de dinero",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const MoneyTransferListScreen(),
      ),
      NavLink(
        title: "Hoja de balance",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const BalanceSheetScreen(),
      ),
      NavLink(
        title: "Extracto de cuenta",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const AccountStatementsScreen(),
      ),
    ],
  ),
  NavLink(
    title: "Personas",
    icon: HeroIcons.user,
    iconType: NavLink.heroIcon,
    group: true,
    links: [
      NavLink(
        title: "Usuarios",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const UsersListScreen(),
      ),
      NavLink(
        title: "Clientes",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const CustomersListScreen(),
      ),
      NavLink(
        title: "Facturador",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const BillersListScreen(),
      ),
      NavLink(
        title: "Proveedor",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const SuppliersListScreen(),
      ),
    ],
  ),
  NavLink(
    title: "Addons",
    icon: FontAwesomeIcons.puzzlePiece,
    iconType: NavLink.fontAwesomeIcon,
    group: false,
    screen: const AddonsListScreen(),
  ),
  NavLink(
    title: "Reports",
    icon: FontAwesomeIcons.fileContract,
    iconType: NavLink.fontAwesomeIcon,
    group: true,
    links: [
      NavLink(
        title: "Summary Report",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const SummaryReportInputScreen(),
      ),
      NavLink(
        title: "Best Seller",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const BestSellerScreen(),
      ),
      NavLink(
        title: "Product Report",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const ProductReportInputScreen(),
      ),
      NavLink(
        title: "Daily Sale",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const DailySaleScreen(),
      ),
      NavLink(
        title: "Monthly Sale",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const MonthlySaleScreen(),
      ),
      NavLink(
        title: "Daily Purchase",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const DailyPurchaseScreen(),
      ),
      NavLink(
        title: "Monthly Purchase",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const MonthlyPurchaseScreen(),
      ),
      NavLink(
        title: "Sale Report",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const SaleReportInputScreen(),
      ),
      NavLink(
        title: "Challan Report",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const ChallanReportInputScreen(),
      ),
      NavLink(
        title: "Sale Report Chart",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const SaleReportChartScreen(),
      ),
      NavLink(
        title: "Payment Report",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const PaymentReportInputScreen(),
      ),
      NavLink(
        title: "Purchase Report",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const PurchaseReportInputScreen(),
      ),
      NavLink(
        title: "Customer Report",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const CustomerReportInputScreen(),
      ),
      NavLink(
        title: "Customer Group Report",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const CustomerGroupReportInputScreen(),
      ),
      NavLink(
        title: "Customer Due Report",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const CustomerDueReportInputScreen(),
      ),
      NavLink(
        title: "Supplier Report",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const SupplierReportInputScreen(),
      ),
      NavLink(
        title: "Supplier Due Report",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const SupplierDueReportInputScreen(),
      ),
      NavLink(
        title: "Warehouse Report",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const WarehouseReportScreen(),
      ),
      NavLink(
        title: "Warehouse Stock Chart",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const WarehouseStockChartScreen(),
      ),
      NavLink(
        title: "Product Expiry Report",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const ProductExpiryReportScreen(),
      ),
      NavLink(
        title: "Product Quantity Alert",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const ProductQuantityAlertScreen(),
      ),
      NavLink(
        title: "Daily Sale Objective Report",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const DailySaleObjectiveReportScreen(),
      ),
      NavLink(
        title: "User Report",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const UserReportInputScreen(),
      ),
      NavLink(
        title: "Biller Report",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const BillerReportInputScreen(),
      ),
    ],
  ),
  NavLink(
    title: "Settings",
    icon: HeroIcons.cog6Tooth,
    iconType: NavLink.heroIcon,
    group: true,
    links: [
      NavLink(
        title: "Theming",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const ThemeSettingsScreen(),
      ),
      NavLink(
        title: "Roles y permisos",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const RolePermissionsListScreen(),
      ),
      NavLink(
        title: "SMS Template",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const SMSListScreen(),
      ),
      NavLink(
        title: "Discount Plan",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const DiscountPlansScreen(),
      ),
      NavLink(
        title: "Discount",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const DiscountsListScreen(),
      ),
      NavLink(
        title: "All Notification",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const AllNotificationScreen(),
      ),
      NavLink(
        title: "Send Notification",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const SendNotificationScreen(),
      ),
/*       NavLink(
        title: "Tables",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const TablesListScreen(),
      ),
      NavLink(
        title: "Customer Group",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const CustomerGroupsListScreen(),
      ), */
      NavLink(
        title: "Currency",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const CurrenciesListScreen(),
      ),
      NavLink(
        title: "Tax",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const TaxesListScreen(),
      ),
      NavLink(
        title: "User Profile",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: true,
        links: [
          NavLink(
            title: "Update Profile",
            icon: HeroIcons.arrowDown,
            iconType: NavLink.heroIcon,
            group: false,
            screen: const UpdateProfileScreen(),
          ),
          NavLink(
            title: "Update Passwords",
            icon: HeroIcons.arrowDown,
            iconType: NavLink.heroIcon,
            group: false,
            screen: const UpdatePasswordScreen(),
          ),
        ],
      ),
      NavLink(
        title: "Create SMS",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const CreateSmsScreen(),
      ),
      NavLink(
        title: "General Settings",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const GeneralSettingsScreen(),
      ),
      NavLink(
        title: "Mail Settings",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const MailSettingsScreen(),
      ),
      NavLink(
        title: "Reward Point Settings",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const RewardPointSettingsScreen(),
      ),
      NavLink(
        title: "SMS Settings",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const SmsSettingsScreen(),
      ),
      NavLink(
        title: "Payment Gateways",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const GatewaySettingsScreen(),
      ),
      NavLink(
        title: "POS Settings",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const PosSettingsScreen(),
      ),
      NavLink(
        title: "HRM Settings",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const HrmSettingsScreen(),
      ),
      NavLink(
        title: "Barcode Settings",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const BarcodeSettingsScreen(),
      ),
      NavLink(
        title: "Languages",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const LanguagesListScreen(),
      ),
    ],
  ),
  NavLink(
    title: "Mi Empresa",
    icon: HeroIcons.buildingOffice,
    iconType: NavLink.heroIcon,
    group: true,
    links: [
      NavLink(
        title: "General",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const WarehouseListScreen(),
      ),
      NavLink(
        title: "Establecimiento",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const WarehouseListScreen(),
      ),
      NavLink(
        title: "Punto de emision",
        icon: HeroIcons.arrowDown,
        iconType: NavLink.heroIcon,
        group: false,
        screen: const WarehouseListScreen(),
      ),
    ],
  ),
  NavLink(
    title: "Logout",
    icon: Icons.logout,
    iconType: NavLink.materialIcon,
    group: false,
    onTap: (context) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(AppKeys.loginKey);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const LoginScreen(),
        ),
      );
    },
  ),
];
// 