class CategoryExpensesModel {
  double? moradia;
  double? alimentacao;
  double? transporte;
  double? saude;
  double? entretenimento;
  double? educacao;
  double? dividasEmprestimos;
  double? despesasPessoais;
  double? viagens;
  double? outros;

  CategoryExpensesModel({
    this.moradia,
    this.alimentacao,
    this.transporte,
    this.saude,
    this.entretenimento,
    this.educacao,
    this.dividasEmprestimos,
    this.despesasPessoais,
    this.viagens,
    this.outros,
  });

  factory CategoryExpensesModel.fromJson(Map<String, dynamic> json) {
    return CategoryExpensesModel(
      moradia: (json['Moradia'] as num?)?.toDouble() ?? 0.0,
      alimentacao: (json['Alimentação'] as num?)?.toDouble() ?? 0.0,
      transporte: (json['Transporte'] as num?)?.toDouble() ?? 0.0,
      saude: (json['Saúde'] as num?)?.toDouble() ?? 0.0,
      entretenimento: (json['Entretenimento'] as num?)?.toDouble() ?? 0.0,
      educacao: (json['Educação'] as num?)?.toDouble() ?? 0.0,
      dividasEmprestimos:
          (json['Dívidas e Empréstimos'] as num?)?.toDouble() ?? 0.0,
      despesasPessoais: (json['Despesas Pessoais'] as num?)?.toDouble() ?? 0.0,
      viagens: (json['Viagens'] as num?)?.toDouble() ?? 0.0,
      outros: (json['Outros'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Moradia'] = moradia;
    data['Alimentação'] = alimentacao;
    data['Transporte'] = transporte;
    data['Saúde'] = saude;
    data['Entretenimento'] = entretenimento;
    data['Educação'] = educacao;
    data['Dívidas e Empréstimos'] = dividasEmprestimos;
    data['Despesas Pessoais'] = despesasPessoais;
    data['Viagens'] = viagens;
    data['Outros'] = outros;
    return data;
  }
}
