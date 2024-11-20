import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/cores/shared/app_bar.dart';
import 'package:skeen/features/track_product/presentation/notifiers/skin_product_notifier.dart';
import 'package:skeen/features/track_product/presentation/ui/components/add_product_bm.dart';

final FocusNode productItemFocusNode =
    FocusNode(debugLabel: 'Product Item Delete Button');

class TrackProductView extends ConsumerWidget {
  const TrackProductView({super.key});

  static const String route = 'scan_product';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(skinCareProductProvider);
    final productsNotifier = ref.read(skinCareProductProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
                  ).copyWith(top: 15.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color:
                              isDark ? Palette.darkGrey : Palette.borderColor)),
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
                            textColor: isDark ? Colors.white : null,
                          ).padding(bottom: 7.h),
                          RichTextWidget(
                            text: "Expires:   ",
                            text2: formattedDate,
                            textColor: Palette.text1,
                            textColor2: isDark ? Palette.text1 : Colors.black,
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
