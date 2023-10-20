import 'package:carousel_slider/carousel_slider.dart';
import 'package:dart_flutter/res/config/size_config.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';
import 'package:dart_flutter/src/common/util/toast_util.dart';
import 'package:dart_flutter/src/domain/entity/banner_image.dart';
import 'package:dart_flutter/src/presentation/component/webview_fullscreen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BannerImageSlider extends StatefulWidget {
  final dynamic bannerList; // List<BannerImage> 또는 Future<List<BannerImage>>를 전달할 수 있도록 dynamic으로 변경거

  const BannerImageSlider({Key? key, required this.bannerList}) : super(key: key);

  @override
  State<BannerImageSlider> createState() => _BannerImageSliderState();
}

class _BannerImageSliderState extends State<BannerImageSlider> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final defaultHeight = SizeConfig.defaultSize * 12;
  final autoSlideInterval = const Duration(seconds: 4);

  List<BannerImage>? _resolvedBannerList; // Future가 해결되면 저장될 변수

  @override
  void initState() {
    super.initState();
    if (widget.bannerList is Future<List<dynamic>>) {
      widget.bannerList.then((bannerList) { // Future가 해결되면 콜백 함수가 호출됨
        setState(() {
          _resolvedBannerList = bannerList;
        });
      }).catchError((error) {
        ToastUtil.showToast("일시적인 통신 오류가 발생하였습니다.");
        Navigator.pop(context);
      });
    } else if (widget.bannerList is List<dynamic>) {
      _resolvedBannerList = widget.bannerList;
    } else {
      throw Exception("banner는 List<BannerImage> 또는 Future<List<BannerImage>> 타입이어야 합니다. ${widget.bannerList}");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_resolvedBannerList == null) { // Future가 아직 해결되지 않았으면 로딩 또는 대기 상태를 표시할 수 있음
      return SizedBox(
        width: SizeConfig.screenWidth * 0.95,
        height: SizeConfig.defaultSize * 12,
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade400,
          highlightColor: Colors.white,
          child: Expanded(child: Container(color: Colors. grey.shade400)),
        ),
      );
    }

    if (_resolvedBannerList?.isEmpty ?? true) {
      return const SizedBox.shrink();
    }

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
      items: _resolvedBannerList!.map((bannerImage) { // _resolvedBannerList 사용
        return Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () {
                AnalyticsUtil.logEvent('홈_배너_터치', properties: {
                  '배너 이름': bannerImage.title,
                  '배너 url': bannerImage.linkUrl,
                  '배너 이미지 url': bannerImage.imageUrl
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewFullScreen(url: bannerImage.linkUrl, title: bannerImage.title)));
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image(
                  fit: BoxFit.fill,
                  image: NetworkImage(bannerImage.imageUrl),
                ),
              ),
            );
          },
        );
      }).toList(),
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
        children: _resolvedBannerList!.asMap().entries.map((entry) { // _resolvedBannerList 사용
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
