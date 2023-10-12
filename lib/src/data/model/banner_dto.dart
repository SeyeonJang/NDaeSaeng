import 'package:dart_flutter/src/domain/entity/banner_image.dart';

class BannerImageDto {
  final int? id;
  final String? title;
  final String? desc;
  final String? imageUrl;
  final String? linkUrl;
  final String? enabledYn;

  BannerImageDto({this.id, this.title, this.desc, this.imageUrl, this.linkUrl, this.enabledYn});

  static BannerImageDto fromJson(Map<String, dynamic> json) {
    return BannerImageDto(
        id: json['id'],
        title: json['title'],
        desc: json['desc'],
        imageUrl: json['image_url'],
        linkUrl: json['link_url'],
        enabledYn: json['enabled_yn']
    );
  }

  BannerImage toBannerImage() {
    return BannerImage(
        id: id ?? 0,
        title: title ?? "(알수없음)",
        desc: desc ?? "(알수없음)",
        imageUrl: imageUrl ?? "DEFAULT",
        linkUrl: linkUrl ?? "DEFAULT"
    );
  }

  @override
  String toString() {
    return 'BannerImageDto{id: $id, title: $title, desc: $desc, imageUrl: $imageUrl, linkUrl: $linkUrl, enabledYn: $enabledYn}';
  }
}