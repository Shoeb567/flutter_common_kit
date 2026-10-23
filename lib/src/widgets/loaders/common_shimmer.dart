import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../constants/app_dimensions.dart';
import '../../theme/common_colors.dart';

/// Shimmer loader wrapper providing placeholder skeleton animations.
class CommonShimmer extends StatelessWidget {
  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;

  const CommonShimmer({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final defaultBase = isDark ? CommonColors.slate800 : CommonColors.slate200;
    final defaultHighlight = isDark ? CommonColors.slate700 : CommonColors.slate100;

    return Shimmer.fromColors(
      baseColor: baseColor ?? defaultBase,
      highlightColor: highlightColor ?? defaultHighlight,
      child: child,
    );
  }
}

/// Rectangular shimmer placeholder box.
class CommonShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const CommonShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = AppDimensions.radiusSmall,
  });

  @override
  Widget build(BuildContext context) {
    return CommonShimmer(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

/// Shimmer skeleton simulating a card.
class CommonShimmerCard extends StatelessWidget {
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const CommonShimmerCard({
    super.key,
    this.height = 120.0,
    this.borderRadius = AppDimensions.radiusLarge,
    this.padding = AppDimensions.paddingCard,
  });

  @override
  Widget build(BuildContext context) {
    return CommonShimmer(
      child: Container(
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

/// Shimmer skeleton simulating a ListTile item with avatar, title, and subtitle.
class CommonShimmerListTile extends StatelessWidget {
  const CommonShimmerListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonShimmer(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.space16,
          vertical: AppDimensions.space8,
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: AppDimensions.space16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.space8),
                  Container(
                    width: 140,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
