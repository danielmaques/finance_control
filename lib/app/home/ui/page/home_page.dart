// ignore_for_file: use_build_context_synchronously

import 'package:clipboard/clipboard.dart';
import 'package:finance_control/app/home/datasource/model/balance_model.dart';
import 'package:finance_control/app/home/datasource/model/transactions_model.dart';
import 'package:finance_control/app/home/ui/controller/balance_bloc.dart';
import 'package:finance_control/app/home/ui/controller/transactions_bloc.dart';
import 'package:finance_control_ui/finance_control_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/core.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late IBalanceBloc balanceBloc;
  late ITransactionsBloc transactionsBloc;

  bool isOpen = false;
  BannerAd? bottomBannerAd;
  InterstitialAd? interstitialAd;
  bool isBannerAdReady = false;

  late bool gastos;
  late bool ganhos;

  @override
  void initState() {
    super.initState();
    balanceBloc = Modular.get();
    transactionsBloc = Modular.get();
    balanceBloc.getBalance();
    transactionsBloc.getTransactions();
    createBottomBannerAd();
    loadInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2F8),
      body: CustomScrollView(
        slivers: [
          BlocBuilder(
            bloc: balanceBloc,
            builder: (context, state) {
              if (state is SuccessState<BalanceModel>) {
                var balance = state.data;
                return FinanceHomeTopBarSliver(
                  money: balance.balance ?? 0.0,
                  addRoute: () {
                    Modular.to.pushNamed('/addTransaction/',
                        arguments: {'add': true});
                  },
                  removeRoute: () {
                    Modular.to.pushNamed('/addTransaction/',
                        arguments: {'add': false});
                  },
                  transactionRoute: () {
                    Modular.to.pushNamed('/transactions/');
                  },
                  menuRoute: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final userId = prefs.getString('house_id');
                    if (userId != null) {
                      await FlutterClipboard.copy(userId);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: AppColors.forestGreen,
                          content: Text('Convite copiado!'),
                        ),
                      );
                    }
                  },
                );
              } else {
                return FinanceHomeTopBarSliver(
                  money: 0.0,
                  addRoute: () {
                    Modular.to.pushNamed('/addTransaction/',
                        arguments: {'add': true});
                  },
                  removeRoute: () {
                    Modular.to.pushNamed('/addTransaction/',
                        arguments: {'add': false});
                  },
                  transactionRoute: () {
                    Modular.to.pushNamed('/transactions/');
                  },
                  menuRoute: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final userId = prefs.getString('house_id');
                    if (userId != null) {
                      await FlutterClipboard.copy(userId);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: AppColors.forestGreen,
                          content: Text('Convite copiado!'),
                        ),
                      );
                    }
                  },
                );
              }
            },
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  // ValueListenableBuilder(
                  //   valueListenable: widget.controller.accountList,
                  //   builder: (context, accountList, child) =>
                  //       FinanceCredtCardTile(
                  //     onTap: () {
                  //       Modular.to.pushNamed('/accountsCards/');
                  //     },
                  //     list: ListView.separated(
                  //       itemCount: accountList.length >= 2
                  //           ? 2
                  //           : accountList.length,
                  //       shrinkWrap: true,
                  //       physics: const NeverScrollableScrollPhysics(),
                  //       separatorBuilder: (context, index) => SizedBox(
                  //         height: 20,
                  //         child: Divider(
                  //           height: 1,
                  //           color: Colors.blueGrey[100],
                  //         ),
                  //       ),
                  //       itemBuilder: (context, index) {
                  //         return Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             Container(
                  //               padding: const EdgeInsets.all(12),
                  //               decoration: BoxDecoration(
                  //                 color: const Color(0xFFEEF2F8),
                  //                 borderRadius: BorderRadius.circular(8),
                  //               ),
                  //               child: const Icon(
                  //                 Icons.account_balance_outlined,
                  //                 color: AppColors.deepBlue,
                  //                 size: 20,
                  //               ),
                  //             ),
                  //             const SizedBox(width: 8),
                  //             Expanded(
                  //               child: Column(
                  //                 mainAxisAlignment:
                  //                     MainAxisAlignment.start,
                  //                 crossAxisAlignment:
                  //                     CrossAxisAlignment.start,
                  //                 children: [
                  //                   FinanceText.p16(
                  //                     accountList[index].bank ?? '',
                  //                     color: Colors.black,
                  //                   ),
                  //                   const SizedBox(height: 4),
                  //                   FinanceText.p16(
                  //                     'Titular: ${accountList[index].use}',
                  //                     color: AppColors.slateGray,
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //             FinanceText.p16(
                  //               formatMoney(accountList[index].balance!),
                  //               color: Colors.black,
                  //             ),
                  //           ],
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 22),
                  // ValueListenableBuilder<Map<String, double>>(
                  //   valueListenable:
                  //       widget.controller.categoryPercentages,
                  //   builder: (context, value, child) =>
                  //       FinanceSpendingTile(
                  //     spending: widget.controller.gastos.value,
                  //     onTap: () {
                  //       showInterstitialAd();
                  //     },
                  //     categoryPercentages: value,
                  //   ),
                  // ),
                  const SizedBox(height: 22),
                  BlocBuilder(
                    bloc: transactionsBloc,
                    builder: (context, state) {
                      if (state is SuccessState<List<TransactionsModel>>) {
                        var transactions = state.data;
                        return FinanceListTile(
                          transactions: transactions.toList(),
                          onTap: () {
                            Modular.to.pushNamed('/transactions/');
                          },
                          lits: ListView.separated(
                            itemCount: transactions.length >= 5
                                ? 5
                                : transactions.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) => const Padding(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              child: Divider(color: Colors.black26),
                            ),
                            itemBuilder: (context, index) {
                              var transaction = transactions[index];
                              DateTime? date = transaction.time;

                              return Container(
                                color: Colors.transparent,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 48,
                                      width: 48,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEEF2F8),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: FinanceText.p18(
                                          getInitial(transaction.descricao),
                                          color: AppColors.deepBlue,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FinanceText.p16(
                                            transaction.descricao,
                                            color: Colors.black,
                                          ),
                                          FinanceText.p16(
                                            date != null
                                                ? formatDate(date)
                                                : '',
                                            color: const Color(0xFF717E95),
                                          ),
                                        ],
                                      ),
                                    ),
                                    FinanceText.p18(
                                      formatMoney(transaction.valor),
                                      color: transaction.add == true
                                          ? AppColors.forestGreen
                                          : AppColors.cherryRed,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text(
                            'Erro ao buscar as transações!',
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
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
        adUnitId: kReleaseMode
            ? 'ca-app-pub-6625580398265467/1218136997'
            : 'ca-app-pub-3940256099942544/6300978111',
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

  loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: kReleaseMode
          ? 'ca-app-pub-6625580398265467/6547703884'
          : 'ca-app-pub-3940256099942544/1033173712',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            interstitialAd = ad;
          });
        },
        onAdFailedToLoad: (error) {
          if (kDebugMode) {
            print('Erro ao carregar o anúncio intersticial: $error');
          }
        },
      ),
    );
  }

  void showInterstitialAd() {
    if (interstitialAd != null) {
      interstitialAd!.show();
    } else {
      if (kDebugMode) {
        print('O anúncio intersticial ainda não foi carregado.');
      }
    }
  }
}
