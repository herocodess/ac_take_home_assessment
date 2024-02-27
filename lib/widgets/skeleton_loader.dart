import 'package:acumen_technical_assessment/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
    this.backgroundColor,
  });
  final double? height, width;
  final BorderRadiusGeometry? borderRadius;
  final Color? baseColor, highlightColor, backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.withOpacity(.1),
      highlightColor: highlightColor ?? Colors.white60,
      child: Container(
        height: height ?? 35,
        margin: const EdgeInsets.only(top: 8),
        width: width ?? 150,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.grey.withOpacity(.7),
          borderRadius: borderRadius ?? BorderRadius.circular(5),
        ),
      ),
    );
  }
}

class CustomShimmerLoading {
  static Widget productGridViewShimmer() {
    return SizedBox(
      child: GridView.builder(
        itemCount: 6,
        shrinkWrap: true,
        padding: const EdgeInsets.only(bottom: 39),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 180,
          childAspectRatio: 4 / 6,
          crossAxisSpacing: 20,
          mainAxisSpacing: 21,
        ),
        itemBuilder: (context, index) {
          return const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: CustomShimmer(height: 154, width: 200)),
              CustomShimmer(),
            ],
          ).paddingOnly(r: 15);
        },
      ),
    ).paddingOnly(l: 20);
  }

  static Widget tabShimmer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(
          4,
          (index) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomShimmer(
                height: 3,
                width: context.width * 0.18,
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        )
      ],
    );
  }
}
