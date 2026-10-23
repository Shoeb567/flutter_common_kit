import 'package:flutter/material.dart';
import '../constants/app_dimensions.dart';
import '../theme/common_colors.dart';
import '../theme/common_text_styles.dart';

/// Highly customizable production-ready AppBar.
class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;
  final VoidCallback? onBack;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final PreferredSizeWidget? bottom;
  final double toolbarHeight;
  final Widget? flexibleSpace;

  const CommonAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.centerTitle = true,
    this.actions,
    this.leading,
    this.showBackButton = true,
    this.onBack,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.bottom,
    this.toolbarHeight = kToolbarHeight,
    this.flexibleSpace,
  });

  @override
  Size get preferredSize =>
      Size.fromHeight(toolbarHeight + (bottom?.preferredSize.height ?? 0.0));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Widget? leadingWidget = leading;
    if (leadingWidget == null && showBackButton) {
      final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
      final canPop = parentRoute?.canPop ?? false;
      if (canPop) {
        leadingWidget = IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: AppDimensions.iconSmall),
          onPressed: onBack ?? () => Navigator.of(context).maybePop(),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        );
      }
    }

    final resolvedTitle = titleWidget ??
        (title != null
            ? Text(
                title!,
                style: CommonTextStyles.titleLarge.copyWith(
                  color: foregroundColor ??
                      (isDark ? Colors.white : CommonColors.slate900),
                  fontWeight: FontWeight.w600,
                ),
              )
            : null);

    return AppBar(
      title: resolvedTitle,
      centerTitle: centerTitle,
      actions: actions,
      leading: leadingWidget,
      backgroundColor: backgroundColor ?? theme.appBarTheme.backgroundColor,
      foregroundColor: foregroundColor ?? theme.appBarTheme.foregroundColor,
      elevation: elevation,
      scrolledUnderElevation: elevation > 0 ? elevation : 1,
      bottom: bottom,
      toolbarHeight: toolbarHeight,
      flexibleSpace: flexibleSpace,
    );
  }
}
