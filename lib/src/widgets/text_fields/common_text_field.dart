import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/app_dimensions.dart';
import 'common_input_decoration.dart';

/// Highly customizable text input field with validation, clear button, and prefix/suffix support.
class CommonTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final bool autofocus;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool showClearButton;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final double borderRadius;

  const CommonTextField({
    super.key,
    this.controller,
    this.initialValue,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.validator,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.showClearButton = false,
    this.focusNode,
    this.contentPadding,
    this.fillColor,
    this.borderRadius = AppDimensions.radiusMedium,
  });

  @override
  Widget build(BuildContext context) {
    Widget? effectiveSuffix = suffixIcon;

    if (showClearButton && controller != null) {
      effectiveSuffix = ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller!,
        builder: (context, value, _) {
          if (value.text.isEmpty) {
            return suffixIcon ?? const SizedBox.shrink();
          }
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.clear, size: 18),
                onPressed: () {
                  controller!.clear();
                  if (onChanged != null) onChanged!('');
                },
              ),
              if (suffixIcon != null) suffixIcon!,
            ],
          );
        },
      );
    }

    final decoration = CommonInputDecoration.create(
      labelText: label,
      hintText: hint,
      helperText: helperText,
      errorText: errorText,
      prefixIcon: prefixIcon,
      suffixIcon: effectiveSuffix,
      fillColor: fillColor,
      borderRadius: borderRadius,
      contentPadding: contentPadding,
    );

    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      focusNode: focusNode,
      obscureText: obscureText,
      readOnly: readOnly,
      enabled: enabled,
      autofocus: autofocus,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      inputFormatters: inputFormatters,
      decoration: decoration,
    );
  }
}

/// Password input field with built-in visibility toggle.
class CommonPasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final double borderRadius;

  const CommonPasswordField({
    super.key,
    this.controller,
    this.label = 'Password',
    this.hint = 'Enter your password',
    this.errorText,
    this.onChanged,
    this.validator,
    this.textInputAction = TextInputAction.done,
    this.onFieldSubmitted,
    this.prefixIcon = const Icon(Icons.lock_outline, size: 20),
    this.focusNode,
    this.borderRadius = AppDimensions.radiusMedium,
  });

  @override
  State<CommonPasswordField> createState() => _CommonPasswordFieldState();
}

class _CommonPasswordFieldState extends State<CommonPasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return CommonTextField(
      controller: widget.controller,
      label: widget.label,
      hint: widget.hint,
      errorText: widget.errorText,
      obscureText: _obscure,
      prefixIcon: widget.prefixIcon,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      focusNode: widget.focusNode,
      borderRadius: widget.borderRadius,
      suffixIcon: IconButton(
        icon: Icon(
          _obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          size: 20,
        ),
        onPressed: () {
          setState(() {
            _obscure = !_obscure;
          });
        },
      ),
    );
  }
}
