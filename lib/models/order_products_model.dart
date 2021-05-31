import 'dart:convert';

class OrderProducts {
  final String virtuemartOrderItemId;
  final String virtuemartOrderId;
  final String virtuemartVendorId;
  final String virtuemartProductId;
  final String orderItemSku;
  final String orderItemName;
  final String productQuantity;
  final String productItemPrice;
  final String productPriceWithoutTax;
  final String productTax;
  final String productBasePriceWithTax;
  final String productDiscountedPriceWithoutTax;
  final String productFinalPrice;
  final String productSubtotalDiscount;
  final String productSubtotalWithTax;
  final String orderItemCurrency;
  final String orderStatus;
  final dynamic productAttribute;
  final dynamic deliveryDate;
  final String paid;
  final dynamic oiHash;
  final String createdOn;
  final String createdBy;
  final String modifiedOn;
  final String modifiedBy;
  final String lockedOn;
  final String lockedBy;

  OrderProducts({
    this.virtuemartOrderItemId = '',
    this.virtuemartOrderId = '',
    this.virtuemartVendorId = '',
    this.virtuemartProductId = '',
    this.orderItemSku = '',
    this.orderItemName = '',
    this.productQuantity = '',
    this.productItemPrice = '',
    this.productPriceWithoutTax = '',
    this.productTax = '',
    this.productBasePriceWithTax = '',
    this.productDiscountedPriceWithoutTax = '',
    this.productFinalPrice = '',
    this.productSubtotalDiscount = '',
    this.productSubtotalWithTax = '',
    this.orderItemCurrency = '',
    this.orderStatus = '',
    this.productAttribute = '',
    this.deliveryDate = '',
    this.paid = '',
    this.oiHash = '',
    this.createdOn = '',
    this.createdBy = '',
    this.modifiedOn = '',
    this.modifiedBy = '',
    this.lockedOn = '',
    this.lockedBy = '',
  });

  factory OrderProducts.fromRawJson(String string) => OrderProducts.fromJson(json.decode(string));

  String toRawJson() => json.encode(toJson());

  factory OrderProducts.fromJson(Map<String, dynamic> json) => OrderProducts(
        virtuemartOrderItemId: json["virtuemart_order_item_id"],
        virtuemartOrderId: json["virtuemart_order_id"],
        virtuemartVendorId: json["virtuemart_vendor_id"],
        virtuemartProductId: json["virtuemart_product_id"],
        orderItemSku: json["order_item_sku"],
        orderItemName: json["order_item_name"],
        productQuantity: json["product_quantity"],
        productItemPrice: json["product_item_price"],
        productPriceWithoutTax: json["product_priceWithoutTax"],
        productTax: json["product_tax"],
        productBasePriceWithTax: json["product_basePriceWithTax"],
        productDiscountedPriceWithoutTax: json["product_discountedPriceWithoutTax"],
        productFinalPrice: json["product_final_price"],
        productSubtotalDiscount: json["product_subtotal_discount"],
        productSubtotalWithTax: json["product_subtotal_with_tax"],
        orderItemCurrency: json["order_item_currency"],
        orderStatus: json["order_status"],
        productAttribute: json["product_attribute"],
        deliveryDate: json["delivery_date"],
        paid: json["paid"],
        oiHash: json["oi_hash"],
        createdOn: json["created_on"],
        createdBy: json["created_by"],
        modifiedOn: json["modified_on"],
        modifiedBy: json["modified_by"],
        lockedOn: json["locked_on"],
        lockedBy: json["locked_by"],
      );

  Map<String, dynamic> toJson() => {
        "virtuemart_order_item_id": virtuemartOrderItemId,
        "virtuemart_order_id": virtuemartOrderId,
        "virtuemart_vendor_id": virtuemartVendorId,
        "virtuemart_product_id": virtuemartProductId,
        "order_item_sku": orderItemSku,
        "order_item_name": orderItemName,
        "product_quantity": productQuantity,
        "product_item_price": productItemPrice,
        "product_priceWithoutTax": productPriceWithoutTax,
        "product_tax": productTax,
        "product_basePriceWithTax": productBasePriceWithTax,
        "product_discountedPriceWithoutTax": productDiscountedPriceWithoutTax,
        "product_final_price": productFinalPrice,
        "product_subtotal_discount": productSubtotalDiscount,
        "product_subtotal_with_tax": productSubtotalWithTax,
        "order_item_currency": orderItemCurrency,
        "order_status": orderStatus,
        "product_attribute": productAttribute,
        "delivery_date": deliveryDate,
        "paid": paid,
        "oi_hash": oiHash,
        "created_on": createdOn,
        "created_by": createdBy,
        "modified_on": modifiedOn,
        "modified_by": modifiedBy,
        "locked_on": lockedOn,
        "locked_by": lockedBy,
      };
}
