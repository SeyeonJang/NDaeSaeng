import 'package:dart_flutter/res/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../common/admob/ad_helper.dart';

class RewardProposalAd extends StatefulWidget {
  const RewardProposalAd({super.key});

  @override
  State<RewardProposalAd> createState() => _RewardProposalAdState();
}

class _RewardProposalAdState extends State<RewardProposalAd> {
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
    return _buildFloatingActionButton() ?? Text("준비중");
  }

  Widget? _buildFloatingActionButton() {
    return FloatingActionButton.extended(
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
      label: Text('광고보고 호감보내기'),
      icon: Icon(Icons.video_collection),
    );
  }
}

class _ButtonUI extends StatelessWidget {
  final String text;
  final Color color;

  const _ButtonUI({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.defaultSize * 4.5,
      width: SizeConfig.defaultSize * 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Center(child: Text(text, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),)),
    );
  }
}
