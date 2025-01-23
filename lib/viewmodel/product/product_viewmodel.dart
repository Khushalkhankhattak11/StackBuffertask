import 'package:get/get.dart';
import 'package:taskcommerceapp/model/product_model.dart';
import 'package:taskcommerceapp/res/images/images.dart';

class ProductController extends GetxController {
  // Observable list of products
  var productList = <Product>[].obs;

   final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() {
    // Add some sample products with long descriptions
    productList.value = [
      Product(
        name: "Man Watch",
        image:  ImagesUrls.p7,
        price: 29.99,
        description: "This is a very nice product designed to meet all your needs. It features a sleek design, high durability, and top-notch performance. Ideal for both personal and professional use, this product guarantees satisfaction and reliability.",
      ),
      Product(
        name: "Ladies Bag",
        image: ImagesUrls.p5,
        price: 49.99,
        description:
        "Experience premium quality with Product 2. Designed with extended features and cutting-edge technology, this product offers unparalleled performance and elegance. Perfect for those who value quality and sophistication, it is a must-have for your collection.",
      ),
      Product(
        name: "Office Bags",
        image: ImagesUrls.p3,
        price: 19.99,
        description: "Product 3 is your go-to choice for affordability and reliability. Its lightweight design and easy-to-use features make it perfect for everyday use. Whether for work or leisure, this product delivers outstanding value at an unbeatable price.",
      ),
      Product(
        name: "Bags",
        image:  ImagesUrls.p4,
        price: 24.99,
        description: "Product 4 is designed with the modern user in mind. Its innovative features, combined with superior build quality, make it a standout in its category. Enjoy seamless performance and style in one compact package.",
      ),
      Product(
        name: "Shoes",
        image: ImagesUrls.s3,
        price: 39.99,
        description: "Take your experience to the next level with Product 5. This product boasts exceptional features such as high durability, advanced functionality, and a user-friendly design. It is crafted to deliver a premium experience at a competitive price.",
      ),
      Product(
        name: "Man Watch",
        image:  ImagesUrls.w1,
        price: 59.99,
        description:
        "Product 6 is a perfect blend of quality, performance, and aesthetics. With extended features and high-quality materials, it is designed to exceed your expectations. A great choice for anyone who values excellence and attention to detail.",
      ),
       Product(
        name: "Bags",
        image:  ImagesUrls.p4,
        price: 24.99,
        description: "Product 4 is designed with the modern user in mind. Its innovative features, combined with superior build quality, make it a standout in its category. Enjoy seamless performance and style in one compact package.",
      ),
       Product(
        name: "Ladies Watch",
        image:  ImagesUrls.p2,
        price: 20.99,
        description: "Product Ladies watch is designed with the modern user in mind. Its innovative features, combined with superior build quality, make it a standout in its category. Enjoy seamless performance and style in one compact package.",
      ),
    ];
  }
}
