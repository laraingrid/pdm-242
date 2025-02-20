import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulário de Validação',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Formulário de Validação'),
        ),
        body: ValidationForm(),
      ),
    );
  }
}

class ValidationForm extends StatefulWidget {
  @override
  _ValidationFormState createState() => _ValidationFormState();
}

class _ValidationFormState extends State<ValidationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira uma data.';
    }
    try {
      DateFormat('dd-MM-yyyy').parseStrict(value);
    } catch (e) {
      return 'Data inválida. Formato deve ser dd-mm-aaaa.';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira um email.';
    }
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(value)) {
      return 'Email inválido.';
    }
    return null;
  }

  String? _validateCPF(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira um CPF.';
    }
    if (!CPFValidator.isValid(value)) {
      return 'CPF inválido.';
    }
    return null;
  }

  String? _validateValue(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira um valor.';
    }
    final doubleValue = double.tryParse(value);
    if (doubleValue == null || doubleValue < 0) {
      return 'Valor inválido. Deve ser um número positivo.';
    }
    return null;
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Se o formulário for válido, você pode processar os dados aqui.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Formulário com informações válidas!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Data (dd-mm-aaaa)'),
              validator: _validateDate,
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: _validateEmail,
            ),
            TextFormField(
              controller: _cpfController,
              decoration: InputDecoration(labelText: 'CPF'),
              validator: _validateCPF,
            ),
            TextFormField(
              controller: _valueController,
              decoration: InputDecoration(labelText: 'Valor'),
              validator: _validateValue,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}