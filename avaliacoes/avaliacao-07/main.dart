import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'book_details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var dados;
  bool _isLoading = false;
  String _termoPesquisa = '';

  @override
  void initState() {
    super.initState();
  }

  _carregarDados(String termo) async {
    setState(() {
      _isLoading = true;
      _termoPesquisa = termo; // Armazena o termo de pesquisa atual
    });

    const chaveApi = 'AIzaSyCzzCwhwki2H8hj2aM38tPKtesD0q70EVo'; // Substitua pela sua chave real
    final url = Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=$termo&key=$chaveApi');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          dados = jsonDecode(response.body);
        });
      } else {
        throw Exception('Falha ao carregar dados da API: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao carregar dados: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dados da API'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                onChanged: (text) {
                  _carregarDados(text);
                },
                decoration: const InputDecoration(
                  hintText: 'Digite o nome do livro',
                ),
              ),
              const SizedBox(height: 16),
              _isLoading
                  ? const CircularProgressIndicator()
                  : Expanded(
                      child: dados != null && dados['items'] != null
                          ? ListView.builder(
                              itemCount: dados['items'].length,
                              itemBuilder: (context, index) {
                                final book = dados['items'][index];
                                return Card(
                                  child: ListTile(
                                    title: Text(
                                        book['volumeInfo']['title'] ??
                                            'Título não disponível'),
                                    subtitle: Text(
                                        book['volumeInfo']['authors']
                                                ?.join(', ') ??
                                            'Autor não disponível'),
                                    onTap: () {
                                      // Navegar para a tela de detalhes do livro
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BookDetailsScreen(book: book),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            )
                          : _termoPesquisa.isNotEmpty // Verifica se o usuário pesquisou
                              ? const Text('Nenhum livro encontrado')
                              : const Text(
                                  'Pesquise um livro para ver os resultados'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
