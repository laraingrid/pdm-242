import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navegação Sequencial',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProdutosScreen(),
    );
  }
}

// Tela de Produtos
class ProdutosScreen extends StatefulWidget {
  @override
  _ProdutosScreenState createState() => _ProdutosScreenState();
}

class _ProdutosScreenState extends State<ProdutosScreen> {
  List<String> produtos = ['Produto 1', 'Produto 2', 'Produto 3', 'Produto 4'];
  Set<String> selectedProducts = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Selecione os produtos')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: produtos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(produtos[index]),
                  trailing: Checkbox(
                    value: selectedProducts.contains(produtos[index]),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          selectedProducts.add(produtos[index]);
                        } else {
                          selectedProducts.remove(produtos[index]);
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: selectedProducts.isEmpty
                ? null
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClientesScreen(
                          selectedProducts: selectedProducts.toList(),
                        ),
                      ),
                    );
                  },
            child: Text('Próximo: Identificar Cliente'),
          ),
        ],
      ),
    );
  }
}

// Tela de Clientes
class ClientesScreen extends StatefulWidget {
  final List<String> selectedProducts;
  ClientesScreen({required this.selectedProducts});

  @override
  _ClientesScreenState createState() => _ClientesScreenState();
}

class _ClientesScreenState extends State<ClientesScreen> {
  String? clienteName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clientes')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Nome do Cliente',
            ),
            onChanged: (text) {
              setState(() {
                clienteName = text;
              });
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: clienteName == null || clienteName!.isEmpty
                ? null
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PedidosScreen(
                          clienteName: clienteName!,
                          produtos: widget.selectedProducts,
                        ),
                      ),
                    );
                  },
            child: Text('Criar Pedido'),
          ),
        ],
      ),
    );
  }
}

// Tela de Pedidos
class PedidosScreen extends StatelessWidget {
  final String clienteName;
  final List<String> produtos;

  PedidosScreen({required this.clienteName, required this.produtos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pedidos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cliente: $clienteName',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Produtos Selecionados:',
              style: TextStyle(fontSize: 18),
            ),
            ...produtos.map((produto) => Text(produto)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text('Voltar ao Início'),
            ),
          ],
        ),
      ),
    );
  }
}
