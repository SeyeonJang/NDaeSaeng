
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dart_flutter/src/data/custom_cache_manager.dart';
import 'package:flutter/cupertino.dart';

class CachedProfileImage extends StatelessWidget {
  const CachedProfileImage({
    super.key,
    required this.profileUrl,
    this.width = 4.5,
    this.height = 4.5,
    this.cached = true
  });

  final String profileUrl;
  final double width;
  final double height;
  final bool cached;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Center(
          child: profileUrl == "DEFAULT" || !profileUrl.startsWith("https://")
              ? defaultProfile()
              : cached
                ? buildCachedNetworkImage()
                : buildImage()
      ),
    );
  }

  Image defaultProfile() => Image.asset(
    'assets/images/profile-mockup3.png',
    width: width,
    height: height,
    fit: BoxFit.cover,
  );

  Image buildImage() {
    return Image.network(profileUrl,
                  width: width,
                  height: height,
                  fit: BoxFit.cover
              );
  }

  CachedNetworkImage buildCachedNetworkImage() {
    return CachedNetworkImage(
                imageUrl: profileUrl,
                placeholder: (context, url) => defaultProfile(),
                width: width,
                height: height,
                fit: BoxFit.cover,
                cacheManager: CustomCacheManager.instance,
              );
  }
}
