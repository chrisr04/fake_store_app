import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:fake_api/fake_api.dart';
import 'package:fake_store_ds/fake_store_ds.dart';
import 'package:fake_store_app/common/common.dart';
import 'package:fake_store_app/accessibility/accessibility.dart';
import 'package:fake_store_app/features/cart/presentation/viewmodel/cart_viewmodel.dart';

part 'widgets/total_cart_footer.dart';
part 'widgets/cart_product_list.dart';
part 'widgets/cart_title_row.dart';
part 'widgets/empty_cart_message.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CartTitleRow(),
            CartProductList(),
          ],
        ),
      ),
      bottomNavigationBar: TotalCartFooter(),
    );
  }
}
