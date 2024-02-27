import 'package:acumen_technical_assessment/core/utils/colors.dart';
import 'package:acumen_technical_assessment/core/utils/extensions.dart';
import 'package:acumen_technical_assessment/features/products/data/model/products_model.dart';
import 'package:flutter/material.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    super.key,
    required this.product,
    required this.onTap,
  });

  final ProductsModel product;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: context.height * 0.2,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  product.image,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Flexible(
            child: Text(
              product.name,
              maxLines: 3,
              style: const TextStyle(color: AppColors.whiteColor),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "\$${product.price}",
            style: const TextStyle(
              color: AppColors.lightYellowColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
