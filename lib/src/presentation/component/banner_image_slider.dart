import 'package:carousel_slider/carousel_slider.dart';
import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/domain/entity/banner_image.dart';
import 'package:dart_flutter/src/presentation/component/webview_fullscreen.dart';
import 'package:flutter/material.dart';

class BannerImageSlider extends StatefulWidget {
  final List bannerList;  // List<BannerImage>를 전달할 것

  const BannerImageSlider({super.key, required this.bannerList});

  @override
  State<BannerImageSlider> createState() => _BannerImageSliderState();
}

class _BannerImageSliderState extends State<BannerImageSlider> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final defaultHeight = SizeConfig.defaultSize * 12;
  final autoSlideInterval = const Duration(seconds: 4);

  @override
  void initState() {
    super.initState();
    if (widget.bannerList.isNotEmpty && widget.bannerList[0] is BannerImage) {
      return;
    }

    ToastUtil.showToast("일시적인 통신 오류가 발생하였습니다.");
    Navigator.pop(context);
    throw Exception("banner는 List<BannerImage> type이여야 합니다. ${widget.bannerList}");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: defaultHeight,
        child: Stack(
          children: [
            sliderWidget(),
            sliderIndicator(),
          ],
        ),
    );
  }

  Widget sliderWidget() {
    return CarouselSlider(
      carouselController: _controller,
      items: widget.bannerList.map((bannerImage) {
          return Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewFullScreen(url: bannerImage.linkUrl, title: bannerImage.title)));
                  // ToastUtil.showToast(bannerImage.linkUrl);
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      bannerImage.imageUrl,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ).toList(),
      options: CarouselOptions(
        height: defaultHeight,
        viewportFraction: 1.0,
        autoPlay: true,
        autoPlayInterval: autoSlideInterval,
        onPageChanged: (index, reason) {
          setState(() {
            _current = index;
          });
        },
      ),
    );
  }

  Widget sliderIndicator() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.bannerList.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: SizeConfig.defaultSize * 1,
              height: SizeConfig.defaultSize * 1,
              margin:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                Colors.white.withOpacity(_current == entry.key ? 0.9 : 0.4),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
