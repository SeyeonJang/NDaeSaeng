import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../common/admob/ad_helper.dart';

class RewardTestAd extends StatefulWidget {
  const RewardTestAd({super.key});

  @override
  State<RewardTestAd> createState() => _RewardTestAdState();
}

class _RewardTestAdState extends State<RewardTestAd> {
  RewardedAd? _rewardedAd;
  bool isHintUsed = true;

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {
                ad.dispose();
                _rewardedAd = null;
              });
              _loadRewardedAd();
            },
          );

          setState(() {
            _rewardedAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadRewardedAd();
  }

  @override
  void dispose() {
    _rewardedAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildFloatingActionButton() ?? Text("힌트 버튼 로딩 중");
  }

  Widget? _buildFloatingActionButton() {
    return (isHintUsed && _rewardedAd != null)
        ? FloatingActionButton.extended(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Need a hint?'),
              content: Text('Watch an Ad to get a hint!'),
              actions: [
                TextButton(
                  child: Text('cancel'.toUpperCase()),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text('ok'.toUpperCase()),
                  onPressed: () {
                    Navigator.pop(context);
                    _rewardedAd?.show(
                      onUserEarnedReward: (_, reward) {
                        print("hello world");
                      },
                    );
                  },
                ),
              ],
            );
          },
        );
      },
      label: Text('Hint'),
      icon: Icon(Icons.card_giftcard),
    )
        : null;
  }
}
