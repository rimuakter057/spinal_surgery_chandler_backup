import 'package:get/get.dart';

class HomeModel {
  String? id;
  String? title;
  String? parentId;
  String? type;
  ProductInfo? productInfo;
 // bool? isBookmarked;
  RxBool isBookmarked = false.obs; // 🔥 Rx করো
  String? createdAt;
  String? updatedAt;

  HomeModel(
      {this.id,
        this.title,
        this.parentId,
        this.type,
        this.productInfo,
       // this.isBookmarked,
        bool isBookmarked = false,
        this.createdAt,
        this.updatedAt}){
    this.isBookmarked = isBookmarked.obs; // 🔥
  }

  HomeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    parentId = json['parent_id'];
    type = json['type'];

    // Check if product_info is actually a Map
    if (json['product_info'] != null && json['product_info'] is Map<String, dynamic>) {
      productInfo = ProductInfo.fromJson(json['product_info']);
    } else {
      productInfo = null;
    }

    isBookmarked = RxBool(json['is_bookmarked'] ?? false);
   // isBookmarked = json['is_bookmarked'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['parent_id'] = parentId;
    data['type'] = type;



    if (productInfo != null) {
      data['product_info'] = productInfo!.toJson();
    }

    data['is_bookmarked'] = isBookmarked.value == true;
  //  data['is_bookmarked'] = isBookmarked;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['brochure_file_url'] = brochureFileUrl;
    data['video_file_url'] = videoFileUrl;
    data['banner_image_url'] = bannerImageUrl;
    return data;
  }
}
