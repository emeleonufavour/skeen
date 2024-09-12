import 'package:intl/intl.dart';
import 'package:myskin_flutterbytes/src/features/scan_product/presentation/notifiers/skin_product_notifier.dart';
import 'package:myskin_flutterbytes/src/features/scan_product/presentation/ui/components/add_product_bm.dart';
import 'package:myskin_flutterbytes/src/features/skin_goal/skin_goal.dart';

class ScanProductView extends ConsumerWidget {
  const ScanProductView({super.key});

  static const String route = 'scan_product';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(skinCareProductProvider);
    return BaseScaffold(
        appBar: const CustomAppBar(title: "Track your product"),
        body: products.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (screenHeight * .2).h.verticalSpace,
                  const Center(
                    child: TextWidget(
                      "You are yet to add a product click the + button ",
                      fontSize: kfsTiny,
                      fontWeight: w500,
                      textColor: Color(0xff999999),
                    ),
                  )
                ],
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  String formattedDate = DateFormat('d, MMM yyyy')
                      .format(products[index].expiryDate);
                  return Container(
                    padding: const EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 10.h),
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
                              text: "Expires: ",
                              text2: formattedDate,
                              textColor: Palette.grey,
                              textColor2: Colors.black,
                            )
                          ],
                        ),
                        const Icon(Icons.more_horiz)
                      ],
                    ),
                  );
                }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showAddProductBottomSheet(context),
          child: const Icon(Icons.add),
        ),
        useSingleScroll: true);
  }
}
