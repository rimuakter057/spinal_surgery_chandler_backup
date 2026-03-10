class HistoryModel {
  List<Orders>? orders;
  int? totalOrders;

  HistoryModel({this.orders, this.totalOrders});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
    totalOrders = json['totalOrders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    data['totalOrders'] = this.totalOrders;
    return data;
  }
}

class Orders {
  String? id;
  String? userId;
  String? orderStatus;
  String? paymentMethod;
  String? paymentStatus;
  String? billingAddress;
  String? shippingAddress;
  String? notes;
  String? deliveryDate;
  String? createdAt;
  String? updatedAt;
  List<Items>? items;

  Orders(
      {this.id,
        this.userId,
        this.orderStatus,
        this.paymentMethod,
        this.paymentStatus,
        this.billingAddress,
        this.shippingAddress,
        this.notes,
        this.deliveryDate,
        this.createdAt,
        this.updatedAt,
        this.items});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    orderStatus = json['order_status'];
    paymentMethod = json['payment_method'];
    paymentStatus = json['payment_status'];
    billingAddress = json['billing_address'];
    shippingAddress = json['shipping_address'];
    notes = json['notes'];
    deliveryDate = json['delivery_date'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['order_status'] = this.orderStatus;
    data['payment_method'] = this.paymentMethod;
    data['payment_status'] = this.paymentStatus;
    data['billing_address'] = this.billingAddress;
    data['shipping_address'] = this.shippingAddress;
    data['notes'] = this.notes;
    data['delivery_date'] = this.deliveryDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? id;
  String? orderId;
  String? productId;
  String? productTitle;
  String? productImage;
  int? quantity;
  String? createdAt;
  String? updatedAt;

  Items(
      {this.id,
        this.orderId,
        this.productId,
        this.productTitle,
        this.productImage,
        this.quantity,
        this.createdAt,
        this.updatedAt});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    productTitle = json['product_title'];
    productImage = json['product_image'];
    quantity = json['quantity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['product_title'] = this.productTitle;
    data['product_image'] = this.productImage;
    data['quantity'] = this.quantity;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
