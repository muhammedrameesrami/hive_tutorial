import 'package:uuid/uuid.dart';

class ProductModel{
  final String productName;
  final String productId;
  final double productCount;
  final DateTime createdDate;
  final bool delete;

//<editor-fold desc="Data Methods">
  const ProductModel({
    required this.productName,
    required this.productId,
    required this.productCount,
    required this.createdDate,
    required this.delete,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductModel &&
          runtimeType == other.runtimeType &&
          productName == other.productName &&
          productId == other.productId &&
          productCount == other.productCount &&
          createdDate == other.createdDate &&
          delete == other.delete);

  @override
  int get hashCode =>
      productName.hashCode ^
      productId.hashCode ^
      productCount.hashCode ^
      createdDate.hashCode ^
      delete.hashCode;

  @override
  String toString() {
    return 'ProductModel{' +
        ' productName: $productName,' +
        ' productId: $productId,' +
        ' productCount: $productCount,' +
        ' createdDate: $createdDate,' +
        ' delete: $delete,' +
        '}';
  }

  ProductModel copyWith({
    String? productName,
    String? productId,
    double? productCount,
    DateTime? createdDate,
    bool? delete,
  }) {
    return ProductModel(
      productName: productName ?? this.productName,
      productId: productId ?? this.productId,
      productCount: productCount ?? this.productCount,
      createdDate: createdDate ?? this.createdDate,
      delete: delete ?? this.delete,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': this.productName,
      'productId': this.productId,
      'productCount': this.productCount,
      'createdDate': this.createdDate,
      'delete': this.delete,
    };
  }

  factory ProductModel.fromMap(Map<dynamic, dynamic> map) {
    return ProductModel(
      productName: map['productName']??"",
      productId: map['productId']??"",
      productCount: map['productCount']??0.0,
      createdDate: map['createdDate']??DateTime.now(),
      delete: map['delete']??false,
    );
  }

  static String generateProductId() {
    return Uuid().v4();
  }

//</editor-fold>
}