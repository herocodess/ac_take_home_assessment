import 'dart:math';

import 'package:acumen_technical_assessment/core/services/navigation_service.dart';
import 'package:acumen_technical_assessment/core/utils/colors.dart';
import 'package:acumen_technical_assessment/core/utils/extensions.dart';
import 'package:acumen_technical_assessment/core/utils/images.dart';
import 'package:acumen_technical_assessment/features/products/data/model/products_model.dart';
import 'package:acumen_technical_assessment/features/products/presentation/bloc/product_bloc.dart';
import 'package:acumen_technical_assessment/features/products/presentation/views/product_summary_view.dart';
import 'package:acumen_technical_assessment/features/products/presentation/widgets/product_item_widget.dart';
import 'package:acumen_technical_assessment/widgets/custom_cross_fade.dart';
import 'package:acumen_technical_assessment/widgets/skeleton_loader.dart';
import 'package:acumen_technical_assessment/widgets/textfields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ProductsView extends HookWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    final tabLength = useState<int>(1);
    final productBloc = BlocProvider.of<ProductBloc>(context);

    final categoriesLoading = useState<bool>(false);
    final productsLoading = useState<bool>(false);
    final categoriesError = useState<String>('');
    final categoriesData = useState<List<String>>(['']);
    final productsData = useState<List<ProductsModel?>>([null]);
    final productsError = useState<String>('');
    final scrollController = useScrollController();

    useEffect(
      () {
        productBloc.add(FetchCategoriesEvent());
        return null;
      },
      [],
    );

    return DefaultTabController(
      length: tabLength.value,
      child: BlocConsumer<ProductBloc, ProductState>(
        bloc: productBloc,
        listener: (context, state) {
          if (state is FetchCategoriesLoadingState) {
            categoriesLoading.value = true;
          }

          if (state is FetchCategoriesFailureState) {
            categoriesLoading.value = false;
            categoriesError.value = state.error;
          }

          if (state is FetchCategoriesSuccessState) {
            categoriesLoading.value = false;
            tabLength.value = state.categories.length;
            categoriesData.value = state.categories;
            final params = {
              "category": categoriesData.value.first,
            };

            productBloc.add(FetchProductsEvent(params: params));
          }

          if (state is FetchProductsLoadingState) {
            productsLoading.value = true;
          }

          if (state is FetchProductsFailureState) {
            productsLoading.value = false;
            productsError.value = state.error;
          }

          if (state is FetchProductsSuccessState) {
            productsLoading.value = false;
            productsData.value = state.products;
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.primaryColor,
            appBar: AppBar(
              backgroundColor: AppColors.primaryColor,
              leading: Image.asset(
                AppImages.iconClose,
                scale: 2.2,
              ),
              title: Text(
                context.l10n.add_product,
                style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Image.asset(
                    AppImages.filterIcon,
                    scale: 1.9,
                  ),
                )
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(170),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(
                      thickness: 1,
                      color: AppColors.greyColor,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: InputFields(
                        controller: searchController,
                        hint: context.l10n.search_text,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        prefixIcon: Icon(
                          Icons.search,
                          size: 22,
                          color: AppColors.whiteColor.withOpacity(0.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomCrossFade(
                        state: !categoriesLoading.value,
                        firstChild: Visibility(
                          visible: categoriesData.value.isNotEmpty,
                          replacement: const Text('EmptyData'),
                          child: TabBar(
                            labelColor: AppColors.whiteColor,
                            unselectedLabelColor: AppColors.greyColor,
                            indicatorColor: AppColors.darkButtonColor,
                            indicatorWeight: 2,
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.whiteColor,
                              fontSize: 16,
                            ),
                            unselectedLabelStyle: const TextStyle(
                              color: AppColors.greyColor,
                              fontSize: 16,
                            ),
                            onTap: (index) {
                              scrollController.jumpTo(
                                  scrollController.position.minScrollExtent);
                              final params = {
                                "category": categoriesData.value[index],
                              };
                              productBloc
                                  .add(FetchProductsEvent(params: params));
                            },
                            tabs: [
                              ...List.generate(
                                categoriesData.value.length,
                                (index) => Tab(
                                  text: categoriesData.value[index]
                                      .toCapitalized(),
                                ),
                              )
                            ],
                          ),
                        ),
                        secondChild: CustomShimmerLoading.tabShimmer(context),
                      ),
                    )
                  ],
                ),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: CustomCrossFade(
                  state: !productsLoading.value,
                  firstChild: Visibility(
                    visible: productsData.value.isNotEmpty,
                    replacement: const Text('Empty data'),
                    child: GridView.builder(
                      shrinkWrap: true,
                      controller: scrollController,
                      itemCount: productsData.value.length,
                      itemBuilder: (context, index) {
                        int product1Index =
                            Random().nextInt(productsData.value.length);
                        int product2Index =
                            Random().nextInt(productsData.value.length) - 1;
                        final product = productsData.value[index];
                        if (product == null) return const SizedBox();
                        return ProductItemWidget(
                          product: product,
                          onTap: () => pushTo(
                            context,
                            ProductSummaryView(
                              products: [
                                productsData.value[product1Index]!,
                                productsData.value[product2Index]!
                              ],
                            ),
                          ),
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.7,
                      ),
                    ),
                  ),
                  secondChild: CustomShimmerLoading.productGridViewShimmer(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
