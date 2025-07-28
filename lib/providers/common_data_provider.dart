/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: common_data_provider
*/

import 'package:flutter/foundation.dart';
import 'package:salepro/api/auth.dart';
import 'package:salepro/api/dashboard.dart';
import 'package:salepro/models/dashboard.dart';
import 'package:salepro/models/data.dart';
import 'package:salepro/screens/accounting/api/accounts.dart';
import 'package:salepro/screens/accounting/api/balancesheets.dart';
import 'package:salepro/screens/accounting/api/money_transfers.dart';
import 'package:salepro/screens/accounting/models/account.dart';
import 'package:salepro/screens/accounting/models/balancesheet.dart';
import 'package:salepro/screens/accounting/models/money_transfer.dart';
import 'package:salepro/screens/expenses/api/expenses.dart';
import 'package:salepro/screens/expenses/categories/api/expense_categories.dart';
import 'package:salepro/screens/expenses/categories/models/expense_category.dart';
import 'package:salepro/screens/expenses/models/expense.dart';
import 'package:salepro/screens/incomes/api/incomes.dart';
import 'package:salepro/screens/incomes/categories/api/income_categories.dart';
import 'package:salepro/screens/incomes/categories/models/income_category.dart';
import 'package:salepro/screens/incomes/models/income.dart';
import 'package:salepro/screens/people/biller/api/billers.dart';
import 'package:salepro/screens/quotations/api/quotations.dart';
import 'package:salepro/screens/quotations/models/quotation.dart';
import 'package:salepro/screens/returns/purchase/api/purchase_returns.dart';
import 'package:salepro/screens/returns/purchase/models/purchase_return.dart';
import 'package:salepro/screens/returns/sale/api/sale_returns.dart';
import 'package:salepro/screens/returns/sale/models/sale_return.dart';
import 'package:salepro/screens/sales/models/sale.dart';
import 'package:salepro/screens/people/customers/api/customers.dart';
import 'package:salepro/screens/people/customers/models/customer.dart';
import 'package:salepro/screens/people/suppliers/api/suppliers.dart';
import 'package:salepro/screens/people/suppliers/models/supplier.dart';
import 'package:salepro/screens/products/api/products.dart';
import 'package:salepro/screens/products/models/product.dart';
import 'package:salepro/screens/purchases/api/purchases.dart';
import 'package:salepro/screens/purchases/models/purchase.dart';
import 'package:salepro/screens/sales/api/sales.dart';
import 'package:salepro/screens/settings/brands/api/brands.dart';
import 'package:salepro/api/get_registration_data.dart';
import 'package:salepro/screens/products/categories/api/product_categories.dart';
import 'package:salepro/screens/settings/currencies/api/currencies.dart';
import 'package:salepro/screens/settings/currencies/models/currency.dart';
import 'package:salepro/screens/settings/customers_groups/api/customer_groups.dart';
import 'package:salepro/screens/settings/discount_plans/api/discount_plans.dart';
import 'package:salepro/screens/settings/discount_plans/models/discount_plan.dart';
import 'package:salepro/screens/settings/discounts/api/discounts.dart';
import 'package:salepro/screens/settings/discounts/models/discount.dart';
import 'package:salepro/screens/settings/taxes/api/taxes.dart';
import 'package:salepro/screens/settings/taxes/models/tax.dart';
import 'package:salepro/screens/settings/units/api/unit.dart';
import 'package:salepro/screens/settings/warehouse/api/warehouse.dart';
import 'package:salepro/constants/keys.dart';
import 'package:salepro/screens/people/biller/models/biller.dart';
import 'package:salepro/screens/settings/brands/models/brand.dart';
import 'package:salepro/screens/settings/customers_groups/models/customer_group.dart';
import 'package:salepro/screens/products/categories/models/product_category.dart';
import 'package:salepro/models/role.dart';
import 'package:salepro/screens/settings/units/models/unit.dart';
import 'package:salepro/models/user.dart';
import 'package:salepro/screens/settings/warehouse/models/warehouse.dart';
import 'package:salepro/screens/transfers/api/transfers.dart';
import 'package:salepro/screens/transfers/models/transfer.dart';
import 'package:salepro/utils/create_model_from_map.dart';
import 'package:salepro/utils/create_select_input_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonDataProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String? _token;
  User? _user;
  List<Role> _roles = [];
  List<CustomerGroup> _customerGroups = [];
  List<Biller> _billers = [];
  List<Warehouse> _wareHouses = [];
  DashboardData? _dashboard;
  List<Account> _accounts = [];
  List<Brand> _brands = [];
  List<Unit> _units = [];
  List<Currency> _currencies = [];
  List<Supplier> _suppliers = [];
  List<Tax> _taxes = [];
  List<Customer> _customers = [];
  List<ProductCategory> _productCategories = [];
  List<Product> _products = [];
  List<IncomeCategory> _incomeCategories = [];
  List<Income> _incomes = [];
  List<ExpenseCategory> _expenseCategories = [];
  List<Expense> _expenses = [];
  List<Purchase> _purchases = [];
  List<PurchaseReturn> _purchaseReturns = [];
  List<Sale> _sales = [];
  List<SaleReturn> _saleReturns = [];
  List<DiscountPlan> _discountPlans = [];
  List<Discount> _discounts = [];
  List<BalanceSheet> _balancesheets = [];
  List<MoneyTransfer> _moneyTransfers = [];
  List<Transfer> _transfers = [];
  List<Quotation> _quotations = [];

  List<Map<String, dynamic>> _productTypes = [];
  List<Map<String, dynamic>> _barcodeSymbologies = [];
  List<Map<String, dynamic>> _taxMethods = [];
  List<Map<String, dynamic>> _purchaseStatuses = [];
  List<Map<String, dynamic>> _saleStatuses = [];
  List<Map<String, dynamic>> _salePaymentStatuses = [];
  List<Map<String, dynamic>> _orderDiscountTypes = [];
  List<Map<String, dynamic>> _warrantyTypes = [];
  List<Map<String, dynamic>> _discountTypes = [];
  List<Map<String, dynamic>> _discountApplicable = [];
  List<Map<String, dynamic>> _weekDays = [];
  List<Map<String, dynamic>> _accountTypes = [];

  String? get token => _token;
  User? get user => _user;
  List<Role> get roles => _roles;
  List<CustomerGroup> get customerGroups => _customerGroups;
  List<Biller> get billers => _billers;
  List<Warehouse> get wareHouses => _wareHouses;
  DashboardData? get dashboard => _dashboard;
  List<Account> get accounts => _accounts;
  List<Brand> get brands => _brands;
  List<Unit> get units => _units;
  List<Currency> get currencies => _currencies;
  List<Supplier> get suppliers => _suppliers;
  List<Tax> get taxes => _taxes;
  List<Customer> get customers => _customers;
  List<ProductCategory> get productCategories => _productCategories;
  List<IncomeCategory> get incomeCategories => _incomeCategories;
  List<Income> get incomes => _incomes;
  List<ExpenseCategory> get expenseCategories => _expenseCategories;
  List<Expense> get expenses => _expenses;
  List<Product> get products => _products;
  List<Purchase> get purchases => _purchases;
  List<Sale> get sales => _sales;
  List<SaleReturn> get saleReturns => _saleReturns;
  List<PurchaseReturn> get purchaseReturns => _purchaseReturns;
  List<DiscountPlan> get discountPlans => _discountPlans;
  List<Discount> get discounts => _discounts;
  List<BalanceSheet> get balancesheets => _balancesheets;
  List<MoneyTransfer> get moneyTransfers => _moneyTransfers;
  List<Transfer> get transfers => _transfers;
  List<Quotation> get quotations => _quotations;

  List<Map<String, dynamic>> get selectRolesData => selectData<Role>(
        _roles,
      );
  List<Map<String, dynamic>> get selectCustomersGroupData =>
      selectData<CustomerGroup>(
        _customerGroups,
        fetchMethod: getCustomerGroups,
      );
  List<Map<String, dynamic>> get selectCustomersData => selectData<Customer>(
        _customers,
        labelField: "customer_name",
        fetchMethod: getCustomers,
      );
  List<Map<String, dynamic>> get selectBillersData => selectData<Biller>(
        _billers,
      );
  List<Map<String, dynamic>> get selectWarehousesData =>
      selectData<Warehouse>(_wareHouses, fetchMethod: getWareHouses);
  List<Map<String, dynamic>> get selectBrandsData => selectData<Brand>(
        _brands,
        fetchMethod: getBrands,
        labelField: "title",
      );
  List<Map<String, dynamic>> get selectUnitsData => selectData<Unit>(
        _units,
        labelField: "unit_name",
        valueField: "id",
        fetchMethod: getUnits,
      );
  List<Map<String, dynamic>> get selectBaseUnitsData => selectData<Unit>(
        _units
            .where(
              (u) => u.baseUnit == null,
            )
            .toList(),
        labelField: "unit_name",
        valueField: "id",
        fetchMethod: getUnits,
      );
  List<Map<String, dynamic>> selectUnitsDataWithBase(id) => selectData<Unit>(
        _units.where((u) {
          if (u.baseUnit != null &&
              u.baseUnit!.id.toString() == id.toString()) {
            return true;
          } else {
            return false;
          }
        }).toList(),
        labelField: "unit_name",
        valueField: "id",
        fetchMethod: getUnits,
      );
  List<Map<String, dynamic>> get selectCurrenciesData => selectData<Currency>(
        _currencies,
        fetchMethod: getCurrencies,
      );
  List<Map<String, dynamic>> get selectProductCategoriesData =>
      selectData<ProductCategory>(
        _productCategories,
        fetchMethod: getProductCategories,
      );
  List<Map<String, dynamic>> get selectIncomeCategoriesData =>
      selectData<IncomeCategory>(
        _incomeCategories,
        fetchMethod: getIncomeCategories,
      );
  List<Map<String, dynamic>> get selectExpenseCategoriesData =>
      selectData<ExpenseCategory>(
        _expenseCategories,
        fetchMethod: getExpenseCategories,
      );
  List<Map<String, dynamic>> get selectSuppliersData => selectData<Supplier>(
        _suppliers,
        fetchMethod: getSuppliers,
      );
  List<Map<String, dynamic>> get selectAccountsData => selectData<Account>(
        _accounts,
      );
  List<Map<String, dynamic>> get selectProductsData => selectData<Product>(
        _products,
        fetchMethod: getFullProducts,
        labelField: "name",
        valueField: "code",
      );
  List<Map<String, dynamic>> get selectProductTypesData => _productTypes;
  List<Map<String, dynamic>> get selectBarcodeSymbologiesData =>
      _barcodeSymbologies;
  List<Map<String, dynamic>> get selectTaxMethodsData => _taxMethods;
  List<Map<String, dynamic>> get selectProductTaxesData => selectData<Tax>(
        _taxes,
        fetchMethod: getTaxes,
        labelField: "name",
        valueField: "rate",
      );
  List<Map<String, dynamic>> get selectPurchaseStatusData => _purchaseStatuses;
  List<Map<String, dynamic>> get selectSaleStatusData => _saleStatuses;
  List<Map<String, dynamic>> get selectSalePaymentStatusData =>
      _salePaymentStatuses;
  List<Map<String, dynamic>> get selectOrderDiscountTypes =>
      _orderDiscountTypes;
  List<Map<String, dynamic>> get warrantyTypes => _warrantyTypes;
  List<Map<String, dynamic>> get discountTypes => _discountTypes;
  List<Map<String, dynamic>> get discountApplicable => _discountApplicable;
  List<Map<String, dynamic>> get weekDays => _weekDays;
  List<Map<String, dynamic>> get accountTypes => _accountTypes;

  Future<void> getData() async {
    print('--- Iniciando getData() en CommonDataProvider ---');
    try {
      final Map<String, dynamic> registrationData =
          await getRegistrationFormData();
      _roles = createModelFromMap(
        registrationData['roles'],
        Role.fromJson,
      );
      _customerGroups = createModelFromMap(
        registrationData['customer_groups'],
        CustomerGroup.fromJson,
      );
      _billers = createModelFromMap(
        registrationData['billers'],
        Biller.fromJson,
      );
      _wareHouses = createModelFromMap(
        registrationData['warehouses'],
        Warehouse.fromJson,
      );

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString(AppKeys.loginKey);
      print(
          'Token de Sanctum encontrado: ${token != null ? token.substring(0, 5) + "..." : "null"}');

      if (token != null) {
        _token = token;

        final Map<String, dynamic> responseData = await verifyToken(token);
        print('Respuesta recibida de /api/get-user:');
        print(responseData);

        if (responseData['success'] == true && responseData['user'] != null) {
          print(
              'La respuesta fue exitosa y contiene un usuario. Intentando parsear...');

          _user = User.fromJson(responseData['user']);
          print('Usuario parseado y asignado: ${_user?.name}');

          _brands = createModelFromMap(
            responseData['brands'],
            Brand.fromJson,
          );
          _units = createModelFromMap(
            responseData['units'],
            Unit.fromJson,
          );
          _productCategories = createModelFromMap(
            responseData['categories'],
            ProductCategory.fromJson,
          );
          _accounts = createModelFromMap(
            responseData['accounts'],
            Account.fromJson,
          );
          _productTypes = selectDataFromBody(
            responseData['product_types'],
          );
          _barcodeSymbologies = selectDataFromBody(
            responseData['barcode_symbologies'],
          );
          _taxMethods = selectDataFromBody(
            responseData['tax_methods'],
          );
          _purchaseStatuses = selectDataFromBody(
            responseData['purchase_status'],
          );
          _saleStatuses = selectDataFromBody(
            responseData['sale_status'],
          );
          _salePaymentStatuses = selectDataFromBody(
            responseData['sale_payment_status'],
          );
          _warrantyTypes = selectDataFromBody(
            responseData['warrenty_type'],
          );
          _orderDiscountTypes = selectDataFromBody(
            responseData['order_discount_type'],
          );
          _discountTypes = selectDataFromBody(
            responseData['discount_type'],
          );
          _discountPlans = createModelFromMap(
            responseData['discount_plan'],
            DiscountPlan.fromJson,
          );
          _discountApplicable = selectDataFromBody(
            responseData['discount_applicable'],
          );
          _weekDays = selectDataFromBody(
            responseData['week_days'],
          );
          _accountTypes = selectDataFromBody(
            responseData['account_type'],
          );

          // --- INICIO DE LA SECCIÓN MEJORADA PARA EL DASHBOARD ---
          print('⏳ Obteniendo datos del dashboard desde /api/dashboard...');
          // Usamos una variable temporal para el resultado
          final dashboardData = await DashboardAPI.get(_token);

          // Verificamos si la llamada fue exitosa
          if (dashboardData != null) {
            _dashboard = dashboardData;
            print('✅ Dashboard cargado exitosamente.');
          } else {
            // La API falló, pero NO borramos al usuario. Solo registramos el error.
            print('❌ Fallo al obtener datos del dashboard (la API no respondió con éxito o devolvió un error).');
            _dashboard = null; // Nos aseguramos de que el estado del dashboard sea nulo.
          }
          // --- FIN DE LA SECCIÓN MEJORADA ---

        } else {
          print('La respuesta de /get-user NO fue exitosa o no contenía un usuario.');
          _user = null; // Nos aseguramos de limpiar el estado porque la autenticación inicial falló.
          _token = null;
        }
      } else {
        print('No se encontró token de Sanctum, no se puede obtener el usuario.');
        _token = null;
      }
    } catch (e, stackTrace) { // Atrapamos la excepción y el stack trace para más detalles
      print('!!! Ocurrió un error inesperado en getData(): $e');
      print('Stack Trace: $stackTrace');

      // Si ocurre un error inesperado (ej: de parsing), no borramos al usuario
      // para no sacarlo de la sesión. Solo nos aseguramos que el dashboard falle.
      _dashboard = null;
    } finally {
      print('Llamando a notifyListeners() para actualizar la UI...');
      notifyListeners();
    }
  }

  Future<Data> getUnits() async {
    try {
      final unit = await UnitAPI.get(_token);
      _units = unit.data;
      return unit;
    } finally {
      notifyListeners();
    }
  }

  Future<Data> getBrands() async {
    try {
      final brand = await BrandAPI.get(_token);
      _brands = brand.data;
      return brand;
    } finally {
      notifyListeners();
    }
  }

  Future<Data> getProductCategories() async {
    try {
      final productCategory = await ProductCategoriesAPI.get(_token);
      _productCategories = productCategory.data;
      return productCategory;
    } finally {
      notifyListeners();
    }
  }

  Future<Data> getIncomeCategories() async {
    try {
      final incomeCategory = await IncomeCategoriesAPI.get(_token);
      _incomeCategories = incomeCategory.data;
      return incomeCategory;
    } finally {
      notifyListeners();
    }
  }

  Future<Data> getIncomes() async {
    try {
      final income = await IncomesAPI.get(_token);
      _incomes = income.data;
      return income;
    } finally {
      notifyListeners();
    }
  }

  Future<Data> getExpenseCategories() async {
    try {
      final expenseCategory = await ExpenseCategoriesAPI.get(_token);
      _expenseCategories = expenseCategory.data;
      return expenseCategory;
    } finally {
      notifyListeners();
    }
  }

  Future<Data> getExpenses() async {
    try {
      final expense = await ExpensesAPI.get(_token);
      _expenses = expense.data;
      return expense;
    } finally {
      notifyListeners();
    }
  }

  Future<Data> getWareHouses() async {
    try {
      final wareHouse = await WarehouseAPI.get(_token);
      _wareHouses = wareHouse.data;
      return wareHouse;
    } finally {
      notifyListeners();
    }
  }

  Future<Data> getCurrencies() async {
    try {
      final currency = await CurrencyAPI.get(_token);
      _currencies = currency.data;
      return currency;
    } finally {
      notifyListeners();
    }
  }

  Future<Data> getSuppliers() async {
    try {
      final supplier = await SuppliersAPI.get(_token);
      _suppliers = supplier.data;
      return supplier;
    } finally {
      notifyListeners();
    }
  }

  Future<Data> getCustomerGroups() async {
    try {
      final customerGroup = await CustomerGroupAPI.get(_token);
      _customerGroups = customerGroup.data;
      return customerGroup;
    } finally {
      notifyListeners();
    }
  }

  Future<Data> getTaxes() async {
    try {
      final tax = await TaxAPI.get(_token);
      _taxes = tax.data;
      return tax;
    } finally {
      notifyListeners();
    }
  }

  Future<Data> getCustomers() async {
    try {
      final customer = await CustomerAPI.get(_token);
      _customers = customer.data;
      return customer;
    } finally {
      notifyListeners();
    }
  }

  Future<Data> getBillers() async {
    try {
      final biller = await BillersAPI.get(_token);
      _billers = biller.data;
      return biller;
    } finally {
      notifyListeners();
    }
  }

  Future<Data> getCustomersPaginated(int count) async {
    try {
      final customer = await CustomerAPI.get(_token, count);
      _customers = [..._customers, ...customer.data];
      return customer;
    } finally {
      notifyListeners();
    }
  }

  Future<Data> getProducts() async {
    try {
      final product = await ProductsAPI.get(_token, 1);
      _products = product.data;
      return product;
    } finally {
      notifyListeners();
    }
  }

  Future<Data> getFullProducts() async {
    try {
      final product = await ProductsAPI.get(
        _token,
        1,
        paginate: false,
      );
      _products = product.data;
      return product;
    } finally {
      notifyListeners();
    }
  }

  Future<Data> getProductsPaginated(int count) async {
    try {
      final product = await ProductsAPI.get(_token, count);
      _products = [..._products, ...product.data];
      return product;
    } finally {
      notifyListeners();
    }
  }

  Future<Data> getPurchases() async {
    try {
      final purchase = await PurchaseAPI.get(_token);
      _purchases = purchase.data;
      return purchase;
    } finally {
      notifyListeners();
    }
  }

  Future<Data> getPurchasesPaginated(int count) async {
    try {
      final purchase = await PurchaseAPI.get(_token, count);
      _purchases = [..._purchases, ...purchase.data];
      return purchase;
    } finally {
      notifyListeners();
    }
  }

  Future<Data> getSales() async {
    try {
      final sale = await SaleAPI.get(_token);
      _sales = sale.data;
      return sale;
    } finally {
      notifyListeners();
    }
  }

  Future<Data> getSaleReturns() async {
    try {
      final saleReturn = await SaleReturnAPI.get(_token);
      _saleReturns = saleReturn.data;
      return saleReturn;
    } finally {
      notifyListeners();
    }
  }

  Future<Data> getPurchaseReturns() async {
    try {
      final purchaseReturn = await PurchaseReturnAPI.get(_token);
      _purchaseReturns = purchaseReturn.data;
      return purchaseReturn;
    } finally {
      notifyListeners();
    }
  }

  Future<Data> getSalesPaginated(int count) async {
    try {
      final sale = await SaleAPI.get(_token, count);
      _sales = [..._sales, ...sale.data];
      return sale;
    } finally {
      notifyListeners();
    }
  }

  Future<Data> getDiscountPlans() async {
    try {
      final discountPlan = await DiscountPlansAPI.get(_token);
      _discountPlans = discountPlan.data;
      return discountPlan;
    } finally {
      notifyListeners();
    }
  }

  Future<Data> getDiscounts() async {
    try {
      final discount = await DiscountsAPI.get(_token);
      _discounts = discount.data;
      return discount;
    } finally {
      notifyListeners();
    }
  }

  Future<Data> getAccounts() async {
    try {
      final account = await AccountsAPI.get(_token);
      _accounts = account.data;
      return account;
    } finally {
      notifyListeners();
    }
  }

  Future<Data> balanceSheets() async {
    try {
      final balancesheet = await BalanceSheetsAPI.get(_token);
      _balancesheets = balancesheet.data;
      return balancesheet;
    } finally {
      notifyListeners();
    }
  }

  Future<Data> getMoneyTransfers() async {
    try {
      final moneyTransfer = await MoneyTransfersAPI.get(_token);
      _moneyTransfers = moneyTransfer.data;
      return moneyTransfer;
    } finally {
      notifyListeners();
    }
  }

  Future<Data> getTransfers() async {
    try {
      final transfer = await TransferAPI.get(_token);
      _transfers = transfer.data;
      return transfer;
    } finally {
      notifyListeners();
    }
  }

  Future<Data> getQuotations() async {
    try {
      final quotation = await QuotationsAPI.get(_token);
      _quotations = quotation.data;
      return quotation;
    } finally {
      notifyListeners();
    }
  }
}
