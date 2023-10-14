import 'package:finance_control/app/add_bank/ui/controller/add_bank_controller.dart';
import 'package:finance_control_ui/finance_control_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddBankPage extends StatefulWidget {
  const AddBankPage({
    super.key,
    required this.controller,
    required this.isCriate,
    this.update,
  });

  final AddBankController controller;
  final bool isCriate;
  final dynamic update;

  @override
  State<AddBankPage> createState() => _AddBankPageState();
}

class _AddBankPageState extends State<AddBankPage> {
  Color pickerColor = AppColors.deepBlue;
  Color currentColor = AppColors.deepBlue;
  SearchController searchController = SearchController();
  String? bankSelect;

  final List<dynamic> categoriesList = [
    "Conta corrente",
    "Conta poupança",
    "Conta empresarial",
  ];

  List<String> banks = [
    "American Express",
    "Mastercard",
    "Visa",
    "Credicard",
    "Diners",
    "Elo",
    "Nubank",
    "Aura",
    "Inter",
    "Banco do Brasil",
    "Bradesco",
    "Caixa",
    "Hipercard",
    "Itaú",
    "Neon",
    "Next",
    "Nuconta",
    "Santander",
    "Agibank",
    "Amazonia",
    "Ame Digital",
    "BMG",
    "BRB",
    "BRDE",
    "BS2",
    "BTG Pactual",
    "Cacique",
    "PAN",
    "Votorantim",
    "Banco do Nordeste",
    "Banese",
    "Banestes",
    "Banif",
    "Banpara",
    "Banrisul",
    "Bbm",
    "Cetelem",
    "Citibank",
    "Clear",
    "Cruzeirodosul",
    "Daycoval",
    "Digi+",
    "Digio",
    "Diin",
    "Nuinvest",
    "Elliot",
    "Fortbrasil",
    "Genial Investimentos",
    "HSBC",
    "IQ Option",
    "Iti",
    "Magnetis",
    "Mais!",
    "Mercadopago",
    "ModalMais",
    "Moip",
    "Monetus",
    "N26",
    "Nova Futura",
    "Original",
    "Pag!",
    "PagBank",
    "Pagseguro",
    "PayU Brasil",
    "Paypal",
    "PicPay",
    "Recargapay",
    "Rico",
    "Safra",
    "Sicoob",
    "Sicredi",
    "Sodexo",
    "Sofisa direto",
    "Submarino",
    "Toro Investimentos",
    "Unicred",
    "Uniprime",
    "Urbe.Me",
    "Viacredi",
    "ABN AMRO",
    "AGBank",
    "AKBank",
    "AMP Personal Banking",
    "ANZ",
    "ASN",
    "Absolut Bank",
    "Agribank",
    "Aktia",
    "Alfa",
    "Alpha",
    "Americanas",
    "Ameriprise Financial",
    "Attica",
    "BBVA",
    "BCA",
    "BIDV",
    "BMO",
    "BNI",
    "BNL",
    "BNP Paribas",
    "BOQ",
    "BPER Banca",
    "BPI",
    "BRI",
    "Banamex",
    "Banca Carige",
    "Banca DItalia",
    "Banca MPS",
    "Banca Mediolanum",
    "Banca Populare di Sondrio",
    "BPM",
    "Banco de Bogotá",
    "Banco de Occident",
    "Banco del Bajio",
    "Posta",
    "lombia",
    "Bangkok Bank",
    "Bank Norwegian",
    "Bank Rakyat",
    "Bank of Aland",
    "Bank of America",
    "Bank of China",
    "Bankia",
    "Bankwest",
    "Banorte",
    "Barclays",
    "Ben Visa Vale",
    "Bendigo",
    "C6 Bank",
    "CDB",
    "CDP",
    "CIBC",
    "CIMB Bank",
    "CIMB Niaga",
    "CTT",
    "Caisse dEpargne",
    "Caixa Geral",
    "CaixaBank",
    "Capital One",
    "Carteira",
    "Cassa Depositi e Prestiti",
    "Charles Schwab",
    "China Construction",
    "CommBank",
    "Commerzbank",
    "Credit Bank of Moscow",
    "Credit agricole",
    "Credito Emiliano",
    "Crédit Agricole",
    "Crédit du Nord",
    "DNB",
    "DZ Bank",
    "Danske",
    "Davivienda",
    "Default",
    "Deutsche Bank",
    "Eurobank",
    "Evli",
    "Forex",
    "Galicia",
    "Garanti",
    "Gazprombank",
    "Goldman Sachs",
    "Handelsbanken",
    "Hipotecario",
    "Hong Leong",
    "HypoVereinsbank",
    "ICBC",
    "ICCREA Banca",
    "ING",
    "Inbursa",
    "Intesa Sanpaolo",
    "Isbank",
    "JP",
    "JP Morgan Chase",
    "Jyske",
    "KB Kookmin",
    "KBank",
    "KDB",
    "KEB Hana",
    "KFW",
    "Krung Thai Bank",
    "Lloyds Banking Group",
    "MUFG",
    "Macquarie",
    "Macro",
    "Mandiri",
    "Maybank",
    "MedioBanca",
    "Millenium BCP",
    "Mizuho",
    "Morgan Stanley",
    "NAB",
    "NH",
    "Nación",
    "National Bank of Greece",
    "Nochu",
    "Nordea",
    "Nordnet",
    "Novo Banco",
    "Nykredit",
    "OP",
    "Otkritie",
    "PNC Financial Services",
    "Patagonia",
    "Piraeus",
    "Porto Seguro",
    "Promsvyazbank",
    "Public Bank",
    "RBC Royal",
    "RBS",
    "RHB",
    "Rabobank",
    "Raiffeisen Bank",
    "Revolut",
    "SCB",
    "SEB",
    "SMBC",
    "SMP Bank",
    "SNS",
    "Sabadell",
    "Santander Espanha",
    "Santander México",
    "Sberbank",
    "Scotiabank",
    "Senff",
    "Shinhan",
    "Société Générale",
    "Sparebank 1 SMN",
    "Standard Chartered",
    "Storebrand",
    "Suncorp",
    "Superdigital",
    "Swedbank",
    "SydBank",
    "TD Bank",
    "TMB Bank",
    "Techcombank",
    "Tesouro Direto",
    "Tesouro Nacional",
    "Ticket",
    "Tinkoff",
    "TransferWise",
    "Trigg",
    "UBI Banca",
    "US Bank",
    "Unicredit Bank",
    "Unipol Banca",
    "UrPay",
    "VTB",
    "Vietcombank",
    "VietinBank",
    "Warren",
    "Wells Fargo",
    "Westpac",
    "Woop",
    "Xdex",
    "Xp Investimentos",
    "Yapi Kredi Bank",
    "Ziraat",
    "alelo",
    "bunq",
    "Órama",
    "Flash",
    "Cora",
    "Will",
    "UTIL",
    "Caju",
    "Outros"
  ];

  @override
  void initState() {
    super.initState();
    widget.controller.getUsersInHouse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FinanceAppBar(
        title: 'Adicionar Conta',
        icon: true,
        onTap: () {
          Modular.to.pop();
        },
        color: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              width: double.infinity,
              child: FinanceAccountCardItem(
                selectedTabIndex: 0,
                saldo: 0,
                name: bankSelect ?? 'Nome do banco',
                accountType: 'accountType',
                colorCircle: currentColor,
                delete: () {},
                showDialogs: false,
              ),
            ),
            const SizedBox(height: 40),
            SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  shape:
                      MaterialStateProperty.all(const ContinuousRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  )),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  elevation: MaterialStateProperty.all(1),
                  controller: controller,
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(
                      color: AppColors.midnightBlack,
                    ),
                  ),
                  hintText: bankSelect ?? "Selecione seu banco",
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.openView();
                  },
                  leading: const Icon(Icons.account_balance_outlined),
                );
              },
              suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
                final searchText = controller.text;

                final filteredBanks = banks.where((bank) {
                  return bank.toLowerCase().contains(searchText.toLowerCase());
                }).toList();

                return filteredBanks.map<Widget>(
                  (bank) {
                    return ListTile(
                      title: FinanceText.b16(bank),
                      onTap: () {
                        setState(() {
                          bankSelect = bank;
                        });
                        searchController.text = bank;
                        widget.controller.bank.value = bank;
                        controller.closeView(bankSelect);
                      },
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            FinanceDropDown(
              hint: "Tipo de conta",
              categoriesList: categoriesList,
              onItemSelected: (p0) {
                widget.controller.account.value = p0;
              },
            ),
            const SizedBox(height: 20),
            FinanceDropDown(
              hint: "Selecione o proprietário",
              categoriesList: [],
              onItemSelected: (p0) {
                widget.controller.userSelect.value = p0;
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentColor,
                  ),
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Select a color'),
                            content: SingleChildScrollView(
                              child: MaterialPicker(
                                pickerColor: pickerColor,
                                onColorChanged: changeColor,
                              ),
                            ),
                            actions: <Widget>[
                              FinanceButton(
                                onTap: () {
                                  setState(() {
                                    currentColor = pickerColor;
                                    widget.controller.color.value =
                                        pickerColor.value.toRadixString(16);
                                  });
                                  Modular.to.pop();
                                },
                                small: true,
                                title: 'Selecionar',
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.color_lens_outlined,
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                const Icon(
                  Icons.arrow_back_rounded,
                  size: 20,
                ),
                const SizedBox(width: 5),
                FinanceText.b16('Selecione uma cor'),
              ],
            ),
            const Spacer(),
            FinanceButton(
              title: 'Adicionar Conta',
              onTap: () async {
                if (widget.controller.bank.value.isNotEmpty) {
                  widget.controller.addBank();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: AppColors.forestGreen,
                      content: Text('Conta adicionada'),
                    ),
                  );
                  if (widget.isCriate == true) {
                    Modular.to.pushReplacementNamed('/home/');
                  } else {
                    setState(() {
                      widget.update();
                    });
                    Modular.to.pop();
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }
}
