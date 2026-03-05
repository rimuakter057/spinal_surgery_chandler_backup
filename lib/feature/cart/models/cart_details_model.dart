class CartDetailsModel {
  String? id;
  String? title;
  String? parentId;
  String? type;
  ProductInfo? productInfo;
  bool? isBookmarked;
  String? createdAt;
  String? updatedAt;

  CartDetailsModel(
      {this.id,
        this.title,
        this.parentId,
        this.type,
        this.productInfo,
        this.isBookmarked,
        this.createdAt,
        this.updatedAt});

  CartDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    parentId = json['parent_id'];
    type = json['type'];
    productInfo = json['product_info'] != null
        ? new ProductInfo.fromJson(json['product_info'])
        : null;
    isBookmarked = json['is_bookmarked'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['parent_id'] = this.parentId;
    data['type'] = this.type;
    if (this.productInfo != null) {
      data['product_info'] = this.productInfo!.toJson();
    }
    data['is_bookmarked'] = this.isBookmarked;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class ProductInfo {
  String? id;
  String? description;
  String? brochureFileUrl;
  String? videoFileUrl;
  String? bannerImageUrl;

  ProductInfo(
      {this.id,
        this.description,
        this.brochureFileUrl,
        this.videoFileUrl,
        this.bannerImageUrl});

  ProductInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    brochureFileUrl = json['brochure_file_url'];
    videoFileUrl = json['video_file_url'];
    bannerImageUrl = json['banner_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['brochure_file_url'] = this.brochureFileUrl;
    data['video_file_url'] = this.videoFileUrl;
    data['banner_image_url'] = this.bannerImageUrl;
    return data;
  }
}
