import 'package:app_seu_madeu_sucos/Controller/Monitor/Product/ProductMonitorBloc.dart';
import 'package:app_seu_madeu_sucos/Controller/Monitor/Product/ProductMonitorState.dart';
import 'package:app_seu_madeu_sucos/Controller/Requester/ProductRequester/ProductRequesterEvent.dart';
import 'package:app_seu_madeu_sucos/Controller/Screen/Bloc/CartController/CartBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Controller/Requester/ProductRequester/ProductRequesterBloc.dart';
import '../Controller/Requester/RequestState.dart';
import '../Controller/Screen/Bloc/CartController/CartEvent.dart';
import '../../Model/Product.dart';
import '../Data/ProductData.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product> allProducts = ProductData.instance.allProducts;

  @override
  Widget build(BuildContext context) {
    var productMonitorBloc = BlocProvider.of<ProductMonitorBloc>(context);
    var productRequesterBloc = BlocProvider.of<ProductRequesterBloc>(context);
    if (allProducts.isEmpty) {
      productRequesterBloc.add(GetAllProductsRequest());
    }
    return BlocBuilder<ProductMonitorBloc, ProductMonitorState>(
        builder: (context, state) {
      return productRequesterBloc.state is ProcessingRequest
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: const Color.fromRGBO(67, 160, 71, 1),
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(state.productColletion.length, (index) {
                  return productTile(state.productColletion[index]);
                }),
              ),
            );
    });
  }

  Widget productTile(Product product) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        //color: Colors.red,
        child: Center(child: Text(product.name!)),
      ),
    );
  }

  SnackBar addedToCartSnackbar(Product product) {
    return SnackBar(
      duration: const Duration(seconds: 2),
      content: Text("${product.name} adicionado ao carrinho!"),
      action: SnackBarAction(
        label: "Desfazer",
        onPressed: () {
          BlocProvider.of<CartBloc>(context).add(
            RemoveFromCart(product: product),
          );
        },
      ),
    );
  }

  Widget productImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Image.asset(
        'lib/Assets/SeuMadeuLogo.png',
      ),
    );
  }

  Widget addToCartButton(Product product) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.shade800,
          padding: const EdgeInsets.all(17),
          shape: const CircleBorder(),
        ),
        onPressed: () {
          BlocProvider.of<CartBloc>(context).add(AddToCart(product: product));
          //CartInfo.addToCart(product);
          ScaffoldMessenger.of(context)
              .showSnackBar(addedToCartSnackbar(product));
        },
        child: const Icon(
          Icons.add_shopping_cart_sharp,
          size: 22,
        ));
  }
}
