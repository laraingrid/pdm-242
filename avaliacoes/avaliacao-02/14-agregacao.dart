// Agregação e Composição
import 'dart:convert';

class Dependente {
  late String _nome;

  Dependente(String nome) {
    this._nome = nome;
  }
}

class Funcionario {
  late String _nome;
  late List<Dependente> _dependentes;

  Funcionario(String nome, List<Dependente> dependentes) {
    this._nome = nome;
    this._dependentes = dependentes;
  }
}

class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(String nomeprojeto, List<Funcionario> funcionarios) {
    _nomeProjeto = nomeprojeto;
    _funcionarios = funcionarios;
  }
}

void main() {
  // 1. Criar vários objetos Dependente
  Dependente dep1 = Dependente("Rafael");
  Dependente dep2 = Dependente("Lara");
  Dependente dep3 = Dependente("Ryan");

  // 2. Criar vários objetos Funcionario
  Funcionario func1 = Funcionario("João", [dep1]);
  Funcionario func2 = Funcionario("Pedro", [dep2, dep3]);

  // 3. Associar os Dependentes criados aos respectivos funcionários já foi feito acima

  // 4. Criar uma lista de Funcionarios
  List<Funcionario> funcionarios = [func1, func2];

  // 5. Criar um objeto EquipeProjeto chamando o método construtor
  EquipeProjeto equipe = EquipeProjeto("Projeto Olá", funcionarios);

  // 6. Printar no formato JSON o objeto EquipeProjeto
  String equipeJson = JsonEncoder.withIndent('  ').convert(equipe.toJson());
  print(equipeJson);
}