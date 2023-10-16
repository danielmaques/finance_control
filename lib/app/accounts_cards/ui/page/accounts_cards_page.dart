import 'package:finance_control/app/accounts_cards/ui/controller/accounts_cards_controller.dart';
import 'package:finance_control_ui/finance_control_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AccountCardsPage extends StatefulWidget {
  const AccountCardsPage({
    super.key,
    required this.controller,
    required this.appBar,
  });

  final AccountCardsController controller;
  final String appBar;

  @override
  State<AccountCardsPage> createState() => _AccountCardsPageState();
}

class _AccountCardsPageState extends State<AccountCardsPage> {
  int selectedTabIndex = 0;
  bool isValid = false;
  BannerAd? bottomBannerAd;
  bool isBannerAdReady = false;
  RewardedAd? rewardedAd;

  @override
  void initState() {
    super.initState();
    widget.controller.getAccountBanks();
    widget.controller.getCards();
    createBottomBannerAd();
    _loadRewardedAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2F8),
      appBar: FinanceAppBar(
        title: 'Contas',
        icon: widget.appBar == 'true' ? true : false,
        onTap: () {
          Modular.to.pop();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // FinanceToolBar(
            //   selectBank: selectedTabIndex == 0,
            //   selectCard: selectedTabIndex == 1,
            //   onTapBank: () {
            //     setState(() {
            //       selectedTabIndex = 0;
            //     });
            //   },
            //   onTapCard: () {
            //     setState(() {
            //       selectedTabIndex = 1;
            //     });
            //   },
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ValueListenableBuilder(
                valueListenable: widget.controller.accountList,
                builder: (context, accountList, child) => GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 35,
                    crossAxisSpacing: 35,
                    childAspectRatio: 1.0,
                  ),
                  itemCount:
                      accountList.length >= 2 ? 3 : accountList.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Material(
                        elevation: 1,
                        borderRadius: BorderRadius.circular(25),
                        child: InkWell(
                          onTap: () {
                            rewardedAd?.show(
                              onUserEarnedReward: (_, reward) {
                                Modular.to.pushNamed('/addBank', arguments: {
                                  'isCriate': false,
                                  'update': widget.controller.getAccountBanks(),
                                });
                              },
                            );
                          },
                          borderRadius: BorderRadius.circular(25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.add_circle_outline_rounded,
                                size: 40,
                                color: AppColors.deepBlue,
                              ),
                              const SizedBox(height: 16),
                              FinanceText.p18(
                                'Add Conta',
                                color: AppColors.deepBlue,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return FinanceAccountCardItem(
                        selectedTabIndex: selectedTabIndex,
                        name: accountList[index - 1].bank!,
                        saldo: accountList[index - 1].balance!,
                        accountType: accountList[index - 1].accountType!,
                        colorCircle: Color(int.parse(
                                accountList[index - 1].color.substring(2),
                                radix: 16) +
                            0xFF000000),
                        edit: true,
                        delete: () {
                          widget.controller.deleteBank(
                            accountList[index - 1].id!,
                          );
                          Modular.to.pop();
                        },
                      );
                    }
                  },
                ),
              ),
            ),
            // selectedTabIndex == 0
            //     ? Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 20),
            //         child: ValueListenableBuilder(
            //           valueListenable: widget.controller.accountList,
            //           builder: (context, accountList, child) =>
            //               GridView.builder(
            //             shrinkWrap: true,
            //             physics: const NeverScrollableScrollPhysics(),
            //             gridDelegate:
            //                 const SliverGridDelegateWithFixedCrossAxisCount(
            //               crossAxisCount: 2,
            //               mainAxisSpacing: 35,
            //               crossAxisSpacing: 35,
            //               childAspectRatio: 1.0,
            //             ),
            //             itemCount: accountList.length >= 2
            //                 ? 3
            //                 : accountList.length + 1,
            //             itemBuilder: (BuildContext context, int index) {
            //               if (index == 0) {
            //                 return Material(
            //                   elevation: 1,
            //                   borderRadius: BorderRadius.circular(25),
            //                   child: InkWell(
            //                     onTap: () {
            //                       rewardedAd?.show(
            //                         onUserEarnedReward: (_, reward) {
            //                           Modular.to
            //                               .pushNamed('/addBank', arguments: {
            //                             'isCriate': false,
            //                             'update':
            //                                 widget.controller.getAccountBanks(),
            //                           });
            //                         },
            //                       );
            //                     },
            //                     borderRadius: BorderRadius.circular(25),
            //                     child: Column(
            //                       mainAxisAlignment: MainAxisAlignment.center,
            //                       crossAxisAlignment: CrossAxisAlignment.center,
            //                       children: [
            //                         const Icon(
            //                           Icons.add_circle_outline_rounded,
            //                           size: 40,
            //                           color: AppColors.deepBlue,
            //                         ),
            //                         const SizedBox(height: 16),
            //                         FinanceText.p18(
            //                           'Add Conta',
            //                           color: AppColors.deepBlue,
            //                           fontWeight: FontWeight.w500,
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 );
            //               } else {
            //                 return FinanceAccountCardItem(
            //                   selectedTabIndex: selectedTabIndex,
            //                   name: accountList[index - 1].bank!,
            //                   saldo: accountList[index - 1].balance!,
            //                   accountType: accountList[index - 1].accountType!,
            //                   colorCircle: Color(int.parse(
            //                           accountList[index - 1].color.substring(2),
            //                           radix: 16) +
            //                       0xFF000000),
            //                   edit: true,
            //                   delete: () {
            //                     widget.controller.deleteBank(
            //                       accountList[index - 1].id!,
            //                     );
            //                     Modular.to.pop();
            //                   },
            //                 );
            //               }
            //             },
            //           ),
            //         ),
            //       )
            //     : Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 20),
            //         child: ValueListenableBuilder(
            //           valueListenable: widget.controller.cardList,
            //           builder: (context, cardList, child) => ListView.separated(
            //             itemCount: cardList.length + 1,
            //             shrinkWrap: true,
            //             physics: const NeverScrollableScrollPhysics(),
            //             separatorBuilder: (context, index) =>
            //                 const SizedBox(height: 35),
            //             itemBuilder: (context, index) {
            //               if (index == 0) {
            //                 return Material(
            //                   elevation: 1,
            //                   borderRadius: BorderRadius.circular(25),
            //                   child: InkWell(
            //                     onTap: () {
            //                       showDialog(
            //                         context: context,
            //                         builder: (context) => ShowAddCard(
            //                           controller: widget.controller,
            //                         ),
            //                       );
            //                     },
            //                     borderRadius: BorderRadius.circular(25),
            //                     child: Container(
            //                       height: 200,
            //                       padding: const EdgeInsets.all(16),
            //                       child: Column(
            //                         crossAxisAlignment:
            //                             CrossAxisAlignment.center,
            //                         mainAxisAlignment: MainAxisAlignment.center,
            //                         children: [
            //                           const Icon(
            //                             Icons.add_circle_outline_rounded,
            //                             size: 40,
            //                             color: AppColors.deepBlue,
            //                           ),
            //                           const SizedBox(height: 16),
            //                           FinanceText.p18(
            //                             'Add Cartão',
            //                             color: AppColors.deepBlue,
            //                             fontWeight: FontWeight.w500,
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ),
            //                 );
            //               } else {
            //                 double disponivel = cardList[index - 1].limit! -
            //                     cardList[index - 1].availableLimit!;

            //                 return FinanceCard(
            //                   cardList: cardList,
            //                   index: index,
            //                   disponivel: disponivel,
            //                 );
            //               }
            //             },
            //           ),
            //         ),
            //       ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: isBannerAdReady && bottomBannerAd != null
          ? SizedBox(
              height: bottomBannerAd!.size.height.toDouble(),
              width: bottomBannerAd!.size.width.toDouble(),
              child: AdWidget(
                ad: bottomBannerAd!,
              ),
            )
          : null,
    );
  }

  createBottomBannerAd() {
    try {
      bottomBannerAd = BannerAd(
        adUnitId: 'ca-app-pub-6625580398265467/1218136997',
        size: AdSize.banner,
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (_) {
            setState(() {
              isBannerAdReady = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
          },
        ),
      );
      bottomBannerAd!.load();
    } catch (e) {
      bottomBannerAd = null;
    }
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-6625580398265467/8534415425',
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {
                ad.dispose();
                rewardedAd = null;
              });
              _loadRewardedAd();
            },
          );

          setState(() {
            rewardedAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
        },
      ),
    );
  }
}
