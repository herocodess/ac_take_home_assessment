import 'package:acumen_technical_assessment/core/services/navigation_service.dart';
import 'package:acumen_technical_assessment/core/utils/colors.dart';
import 'package:acumen_technical_assessment/core/utils/extensions.dart';
import 'package:acumen_technical_assessment/core/utils/images.dart';
import 'package:acumen_technical_assessment/features/products/data/model/products_model.dart';
import 'package:acumen_technical_assessment/features/products/presentation/widgets/increment_decrement_widget.dart';
import 'package:acumen_technical_assessment/main.dart';
import 'package:acumen_technical_assessment/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductSummaryView extends HookWidget {
  ProductSummaryView({super.key, required this.products});
  final List<ProductsModel> products;

  final List<Map<String, String>> summaryDetailList = [
    {
      'key': navigatorKey.currentState!.context.l10n.subtotal,
      'value': '\$125.00'
    },
    {
      'key': navigatorKey.currentState!.context.l10n.your_commission,
      'value': '\$20.00'
    },
    {
      'key': navigatorKey.currentState!.context.l10n.tax('5'),
      'value': '\$5.00'
    },
  ];

  @override
  Widget build(BuildContext context) {
    var quantity = useState<int>(1);
    var isExpanded = useState<bool>(true);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () => pop(context),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: AppColors.whiteColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            context.l10n.back_text,
                            style: GoogleFonts.inter(
                                color: AppColors.whiteColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        context.l10n.summary,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              AnimatedSize(
                duration: const Duration(
                  milliseconds: 500,
                ),
                alignment: Alignment.topCenter,
                curve: Curves.easeIn,
                child: InkWell(
                  onTap: () {
                    isExpanded.value = !isExpanded.value;
                  },
                  radius: 0,
                  child: Container(
                    width: double.maxFinite,
                    color: AppColors.lightPrimaryColor,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                context.l10n.view_breakdown.toUpperCase(),
                                style: GoogleFonts.dmSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                              const Spacer(),
                              Image.asset(
                                AppImages.decrementButton,
                                scale: 1.9,
                              ),
                            ],
                          ),
                        ),
                        if (isExpanded.value)
                          Container(
                            width: double.maxFinite,
                            height: context.height * 0.23,
                            color: AppColors.semiLightPrimaryColor,
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...List.generate(
                                  summaryDetailList.length,
                                  (index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            summaryDetailList[index]['key']
                                                .toString()
                                                .toUpperCase(),
                                            style: GoogleFonts.dmSans(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w800,
                                              color: AppColors.whiteColor
                                                  .withOpacity(0.7),
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            summaryDetailList[index]['value']
                                                .toString(),
                                            style: GoogleFonts.dmSans(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w800,
                                              color: index == 1
                                                  ? AppColors.greenColor
                                                  : AppColors.whiteColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      context.l10n.total.toUpperCase(),
                                      style: GoogleFonts.dmSans(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '\$125.00',
                                      style: GoogleFonts.dmSans(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(
                thickness: 1,
                color: AppColors.greyColor,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.l10n.add_service.toUpperCase(),
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    const Spacer(),
                    Image.asset(
                      AppImages.incrementButton,
                      scale: 1.9,
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
                color: AppColors.greyColor,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.l10n.products_count(2).toUpperCase(),
                          style: GoogleFonts.dmSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.greyColor2,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.add,
                          color: AppColors.darkButtonColor,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          context.l10n.new_product,
                          style: GoogleFonts.dmSans(
                            color: AppColors.darkButtonColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    ...List.generate(
                      products.length,
                      (index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: context.height * 0.19,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: context.height * 0.19,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            NetworkImage(products.first.image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            products.first.name.toTitleCase(),
                                            style: GoogleFonts.dmSans(
                                              fontSize: 14,
                                              color: AppColors.whiteColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "\$${products.first.price.toString()}",
                                            style: GoogleFonts.dmSans(
                                              fontSize: 16,
                                              color: AppColors.lightYellowColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IncrementDecrementWidget(
                                            onTap: () {},
                                            action: QuantityAction.decrement,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            quantity.value.toString(),
                                            style: GoogleFonts.inter(
                                              fontSize: 15,
                                              color: AppColors.whiteColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          IncrementDecrementWidget(
                                            onTap: () {},
                                            action: QuantityAction.increment,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          index == 1
                              ? const SizedBox.shrink()
                              : const SizedBox(
                                  height: 10,
                                ),
                          index == 1
                              ? const SizedBox.shrink()
                              : const Divider(
                                  thickness: 1,
                                  color: AppColors.greyColor,
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
                color: AppColors.greyColor,
              ),
              Text(
                context.l10n.total.toUpperCase(),
                style: GoogleFonts.dmSans(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: AppColors.whiteColor,
                ),
              ).paddingOnly(l: 20, t: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: PrimaryButton(
                    onTap: () {}, text: context.l10n.proceed_to_payment),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
