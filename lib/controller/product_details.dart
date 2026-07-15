import 'package:get/get.dart';
import 'package:shopping_demo/model/product_model.dart';
import 'package:shopping_demo/services/api_service.dart';

class ProductDetailController extends GetxController {
  final ApiService apiService = ApiService();

  var isLoading = true.obs;

  var product = Rxn<Product>();

  var errorMessage = ''.obs;

  Future<void> fetchProduct(int id) async {
    try {
      isLoading(true);

      errorMessage('');

      product.value = await apiService.fetchProductDetail(id);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
