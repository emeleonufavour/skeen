import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:myskin_flutterbytes/src/cores/cores.dart';

import '../../../scan_product.dart';

final FocusNode productItemFocusNode =
    FocusNode(debugLabel: 'Product Item Delete Button');

class ScanProductView extends ConsumerWidget {
  const ScanProductView({super.key});

  static const String route = 'scan_product';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(skinCareProductProvider);
    final productsNotifier = ref.read(skinCareProductProvider.notifier);
    return Scaffold(
      appBar: const CustomAppBar(title: "Track your product"),
      body: products.isEmpty
          ? const Center(
              child: TextWidget(
                "You are yet to add a product click the + button ",
                fontSize: kfsTiny,
                fontWeight: w500,
                textColor: Color(0xff999999),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: products.length,
              itemBuilder: (context, index) {
                String formattedDate = DateFormat('d, MMM yyyy')
                    .format(products[index].expiryDate);
                return Container(
                  padding: EdgeInsets.all(10.h),
                  margin: const EdgeInsets.symmetric(
                    horizontal: kGlobalPadding,
                  ).copyWith(bottom: 10.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Palette.lightGrey)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and expiry date
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            products[index].name,
                            fontWeight: w500,
                          ).padding(bottom: 7.h),
                          RichTextWidget(
                            text: "Expires:   ",
                            text2: formattedDate,
                            textColor: Palette.grey,
                            textColor2: Colors.black,
                          )
                        ],
                      ),
                      MenuAnchor(
                        childFocusNode: productItemFocusNode,
                        style: MenuStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.white),
                          elevation: const WidgetStatePropertyAll(0),
                        ),
                        menuChildren: [
                          MenuItemButton(
                            leadingIcon: const Icon(
                              CupertinoIcons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () =>
                                productsNotifier.deleteProduct(index),
                            child: const TextWidget(
                              "Delete",
                              fontWeight: w500,
                              textColor: Colors.red,
                            ),
                          ),
                        ],
                        builder: (context, controller, _) {
                          return IconButton(
                            icon: const Icon(Icons.more_horiz),
                            onPressed: () {
                              productItemFocusNode.requestFocus();
                              if (controller.isOpen) {
                                controller.close();
                              } else {
                                controller.open();
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddProductBottomSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
