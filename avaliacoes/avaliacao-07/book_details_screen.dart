// book_details_screen.dart
import 'package:flutter/material.dart';

class BookDetailsScreen extends StatelessWidget {
  final dynamic book;

  const BookDetailsScreen({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Livro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Adicione SingleChildScrollView para permitir a rolagem da tela
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                book['volumeInfo']['title'] ?? 'Título não disponível',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                book['volumeInfo']['authors']?.join(', ') ?? 'Autor não disponível',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              if (book['volumeInfo']['publishedDate'] != null) // Exibe o ano de publicação
                Text(
                  'Ano de publicação: ${book['volumeInfo']['publishedDate'].substring(0, 4)}',
                  style: const TextStyle(fontSize: 14),
                ),
              const SizedBox(height: 8),
              if (book['volumeInfo']['publisher'] != null) // Exibe a editora
                Text(
                  'Editora: ${book['volumeInfo']['publisher']}',
                  style: const TextStyle(fontSize: 14),
                ),
              const SizedBox(height: 16),
              if (book['volumeInfo']['description'] != null) // Exibe a descrição
                Text(
                  book['volumeInfo']['description'],
                  style: const TextStyle(fontSize: 14),
                ),
              const SizedBox(height: 16),
              if (book['volumeInfo']['imageLinks'] != null && // Exibe a capa
                  book['volumeInfo']['imageLinks']['thumbnail'] != null)
                Image.network(
                  book['volumeInfo']['imageLinks']['thumbnail'],
                  height: 200,
                ),
              // Adicione mais informações aqui
            ],
          ),
        ),
      ),
    );
  }
}