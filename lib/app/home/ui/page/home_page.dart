// ignore_for_file: use_build_context_synchronously

import 'package:finance_control/app/accounts_cards/datasource/model/account_model.dart';
import 'package:finance_control/app/home/datasource/model/balance_model.dart';
import 'package:finance_control/app/home/datasource/model/transactions_model.dart';
import 'package:finance_control/app/home/ui/controller/accounts_bloc.dart';
import 'package:finance_control/app/home/ui/controller/balance_bloc.dart';
import 'package:finance_control/app/home/ui/controller/transactions_home_bloc.dart';
import 'package:finance_control_ui/finance_control_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

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
  late ITransactionsHomeBloc transactionsHomeBloc;
  late IAccountsBloc accountsBloc;

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
    transactionsHomeBloc = Modular.get();
    accountsBloc = Modular.get();
    balanceBloc.getBalance();
    transactionsHomeBloc.getTransactions();
    accountsBloc.getAccounts();
    createBottomBannerAd();
    loadInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2F8),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              BlocBuilder(
                bloc: balanceBloc,
                builder: (context, state) {
                  if (state is SuccessState<BalanceModel>) {
                    var balance = state.data;
                    return FinanceBalance(
                      onVisibilityGained: () {
                        balanceBloc.getBalance();
                      },
                      route: () {
                        showInterstitialAd();
                        Modular.to.pushNamed(
                          '/transactions/',
                        );
                      },
                      money: balance.balance!,
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.deepBlue,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 40),
              BlocBuilder(
                bloc: accountsBloc,
                builder: (context, state) {
                  if (state is SuccessState<List<AccountModel>>) {
                    var accounts = state.data;
                    return FinanceCredtCardTile(
                      onTap: () {
                        showInterstitialAd();
                        Modular.to.pushNamed('/accountsCards/true');
                      },
                      list: FocusDetector(
                        onForegroundGained: () {
                          accountsBloc.getAccounts();
                        },
                        child: ListView.separated(
                          itemCount: accounts.length >= 2 ? 2 : accounts.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 20,
                            child: Divider(
                              height: 1,
                              color: Colors.blueGrey[100],
                            ),
                          ),
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8F9FA),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: AppColors.lightSkyBlue,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/icons/bank.svg',
                                      height: 22,
                                      width: 22,
                                      // ignore: deprecated_member_use
                                      color: AppColors.deepBlue,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FinanceText.p14(
                                          accounts[index].bank ?? '',
                                          color: const Color(0xFF495057),
                                        ),
                                        FinanceText.p12(
                                          accounts[index].use!,
                                          color: const Color(0xFF848C93),
                                        ),
                                      ],
                                    ),
                                  ),
                                  FinanceText.p16(
                                    formatMoney(accounts[index].balance!),
                                    color: AppColors.deepBlue,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'Nenhuma conta encontrada',
                      ),
                    );
                  }
                },
              ),
              isBannerAdReady && bottomBannerAd != null
                  ? SizedBox(
                      height: bottomBannerAd!.size.height.toDouble() + 20,
                      width: bottomBannerAd!.size.width.toDouble(),
                      child: AdWidget(
                        ad: bottomBannerAd!,
                      ),
                    )
                  : const SizedBox(height: 40),
              BlocBuilder(
                bloc: transactionsHomeBloc,
                builder: (context, state) {
                  if (state is SuccessState<List<TransactionsModel>>) {
                    var transactions = state.data;
                    return FinanceListTile(
                      transactions: transactions.toList(),
                      onTap: () {
                        showInterstitialAd();
                        Modular.to.pushNamed('/transactions/');
                      },
                      lits: FocusDetector(
                        onVisibilityLost: () {
                          transactionsHomeBloc.getTransactions();
                        },
                        child: ListView.separated(
                          itemCount: transactions.length >= 6
                              ? 6
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
                                      child: FinanceText.h4(
                                        getInitial(transaction.descricao),
                                        color: AppColors.deepBlue,
                                        fontWeight: FontWeight.w500,
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
                                          date != null ? formatDate(date) : '',
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
