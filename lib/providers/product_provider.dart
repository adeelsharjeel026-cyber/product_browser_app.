import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';

enum ProductState { initial, loading, loaded, error }

class ProductProvider with ChangeNotifier {
  final ApiService apiService;

  ProductProvider({required this.apiService});

  List<Product> products = [];
  ProductState state = ProductState.initial;
  String errorMessage = '';

  Future<void> fetchProducts() async {
    state = ProductState.loading;
    notifyListeners();
    try {
      products = await apiService.fetchProducts();
      state = ProductState.loaded;
    } catch (e) {
      state = ProductState.error;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  void searchProducts(String value) {}
}
