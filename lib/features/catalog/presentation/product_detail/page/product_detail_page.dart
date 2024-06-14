import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/features/cart/cart.dart';

part 'widgets/detail_header.dart';
part 'widgets/product_info_body.dart';
part 'widgets/add_to_cart_footer.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DetailHeader(product: product),
              ProductInfoBody(product: product),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AddToCartFooter(product: product),
    );
  }
}
