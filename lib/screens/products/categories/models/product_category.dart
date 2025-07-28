/*
  Author Name: Zarif Sadman
  Company: ZS Software Studio
  Website: https://zarifprogrammer.com/
  File Name: product_category
*/

import 'package:salepro/models/mappable.dart';

class ProductCategory implements Mappable {
  final int id;
  final String name;
  final String? image;
  final int? parentId;
  final ProductCategory? parent;
  final int numberOfProducts;
  final int stockQuantity;
  final String stockWorth;
  final bool? disableWoocommerce;

  ProductCategory({
    required this.id,
    required this.name,
    this.image,
    this.parentId,
    this.parent,
    this.disableWoocommerce,
    required this.numberOfProducts,
    required this.stockQuantity,
    required this.stockWorth,
  });

  factory ProductCategory.fromJson(Map json) {
    return ProductCategory(
      id: json['id'],
      name: json['name'],
      image: json['image_url'],
      parentId: json['parent_id'],
      parent: json['parent'] != null
          ? ProductCategory.fromJson(json['parent'])
          : null,
      numberOfProducts: json['number_of_products'] ?? 0,
      stockQuantity: json['stock_quantity'] ?? 0,
      stockWorth: json['stock_worth'] ?? "",
    );
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) =>
      ProductCategory.fromJson(json);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'parent_id': parentId,
    };
  }

  @override
  Map<String, dynamic> toFormData() {
    return {
      'id': id,
      'name': name,
      'parent_id': parentId,
      'disable_woocommerce': disableWoocommerce,
      'is_active': true,
    };
  }
}
