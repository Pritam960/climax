import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:climax_app/core/themes/themes.dart';

// =============================================================================
// ENUMS
// =============================================================================

enum AppTextFieldType {
  text,
  password,
  email,
  phone,
  number,
  decimal,
  search,
  multiline,
  name,
  url,
  otp,
}

// =============================================================================
// AppTextField
// =============================================================================

/// A fully customizable, production-grade text field.
///
/// Handles all common input types automatically:
/// - Password → shows toggle eye icon
/// - Phone/Number → numeric keyboard, formatters
/// - Email → email keyboard
/// - OTP → single digit, autofill
/// - Multiline → auto-expands
/// - Search → search keyboard action, clear button
///
/// ### Usage
/// ```dart
/// AppTextField(
///   label: 'Mobile Number',
///   type: AppTextFieldType.phone,
///   prefixIcon: Icons.phone_rounded,
///   controller: _phoneController,
///   maxLength: 10,
///   isRequired: true,
///   validator: Validators.phone,
///   onChanged: (v) => print(v),
/// )
/// ```
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.type = AppTextFieldType.text,
    this.controller,
    this.focusNode,
    this.initialValue,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.prefixText,
    this.suffixText,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.validator,
    this.autovalidateMode,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.isRequired = false,
    this.isReadOnly = false,
    this.isEnabled = true,
    this.autofocus = false,
    this.showCounter = false,
    this.showClearButton = false,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.inputFormatters,
    this.autocorrect = true,
    this.fillColor,
    this.borderRadius,
    this.contentPadding,
    this.style,
    this.labelStyle,
    this.hintStyle,
    this.onSuffixIconTap,
    this.autofillHints,
    this.keyboardAppearance,
  });

  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;

  /// Determines keyboard type, formatters, and behavior automatically
  final AppTextFieldType type;

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? initialValue;

  final IconData? prefixIcon;
  final IconData? suffixIcon;

  /// Custom widget prefix (e.g. country flag, currency symbol)
  final Widget? prefix;

  /// Custom widget suffix (e.g. verify button, scan QR)
  final Widget? suffix;

  final String? prefixText;
  final String? suffixText;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;

  /// Form validation function
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;

  final int? maxLength;
  final int? maxLines;
  final int? minLines;

  /// Appends '*' to label and enforces not-empty validation
  final bool isRequired;
  final bool isReadOnly;
  final bool isEnabled;
  final bool autofocus;

  /// Show character count below field
  final bool showCounter;

  /// Shows an X button to clear field (auto-enabled for search type)
  final bool showClearButton;

  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final bool autocorrect;

  final Color? fillColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;

  /// Called when suffixIcon is tapped (overrides default password toggle behavior)
  final VoidCallback? onSuffixIconTap;

  final Iterable<String>? autofillHints;
  final Brightness? keyboardAppearance;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late TextEditingController _controller;
  bool _obscureText = true;
  bool _hasText = false;

  bool get _isPassword => widget.type == AppTextFieldType.password;
  bool get _isSearch =>
      widget.type == AppTextFieldType.search || widget.showClearButton;
  bool get _isOtp => widget.type == AppTextFieldType.otp;
  bool get _isMultiline => widget.type == AppTextFieldType.multiline;

  // ---- Keyboard type ----
  TextInputType get _keyboardType {
    switch (widget.type) {
      case AppTextFieldType.email:
        return TextInputType.emailAddress;
      case AppTextFieldType.phone:
        return TextInputType.phone;
      case AppTextFieldType.number:
        return TextInputType.number;
      case AppTextFieldType.decimal:
        return const TextInputType.numberWithOptions(decimal: true);
      case AppTextFieldType.search:
        return TextInputType.text;
      case AppTextFieldType.multiline:
        return TextInputType.multiline;
      case AppTextFieldType.url:
        return TextInputType.url;
      case AppTextFieldType.otp:
        return TextInputType.number;
      case AppTextFieldType.name:
      case AppTextFieldType.text:
      case AppTextFieldType.password:
        return TextInputType.text;
    }
  }

  // ---- Input formatters ----
  List<TextInputFormatter> get _formatters {
    if (widget.inputFormatters != null) return widget.inputFormatters!;
    switch (widget.type) {
      case AppTextFieldType.phone:
        return [FilteringTextInputFormatter.digitsOnly];
      case AppTextFieldType.number:
        return [FilteringTextInputFormatter.digitsOnly];
      case AppTextFieldType.decimal:
        return [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))];
      case AppTextFieldType.otp:
        return [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ];
      case AppTextFieldType.name:
        return [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))];
      default:
        return [];
    }
  }

  // ---- Autofill hints ----
  Iterable<String> get _autofillHints {
    if (widget.autofillHints != null) return widget.autofillHints!;
    switch (widget.type) {
      case AppTextFieldType.email:
        return [AutofillHints.email];
      case AppTextFieldType.phone:
        return [AutofillHints.telephoneNumber];
      case AppTextFieldType.password:
        return [AutofillHints.password];
      case AppTextFieldType.name:
        return [AutofillHints.name];
      default:
        return [];
    }
  }

  // ---- Action ----
  TextInputAction get _textInputAction {
    if (widget.textInputAction != null) return widget.textInputAction!;
    if (_isMultiline) return TextInputAction.newline;
    if (_isSearch) return TextInputAction.search;
    return TextInputAction.next;
  }

  // ---- TextCapitalization ----
  TextCapitalization get _textCapitalization {
    if (widget.textCapitalization != TextCapitalization.none) {
      return widget.textCapitalization;
    }
    switch (widget.type) {
      case AppTextFieldType.name:
        return TextCapitalization.words;
      case AppTextFieldType.multiline:
        return TextCapitalization.sentences;
      default:
        return TextCapitalization.none;
    }
  }

  // ---- Max lines ----
  int? get _maxLines {
    if (_isPassword) return 1;
    if (_isOtp) return 1;
    if (_isMultiline) return widget.maxLines ?? 5;
    return widget.maxLines ?? 1;
  }

  int? get _minLines {
    if (_isMultiline) return widget.minLines ?? 3;
    return null;
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
      _hasText = widget.initialValue!.isNotEmpty;
    }
    _controller.addListener(_onControllerChange);
  }

  void _onControllerChange() {
    final hasText = _controller.text.isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChange);
    // Only dispose if we created it
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  void _toggleObscure() => setState(() => _obscureText = !_obscureText);

  void _clearField() {
    _controller.clear();
    widget.onChanged?.call('');
  }

  // ---- Build suffix icon ----
  Widget? _buildSuffixIcon() {
    // Password toggle — always shown for password type
    if (_isPassword && widget.suffix == null) {
      return GestureDetector(
        onTap: widget.onSuffixIconTap ?? _toggleObscure,
        child: Icon(
          _obscureText
              ? Icons.visibility_off_rounded
              : Icons.visibility_rounded,
          color: AppColors.textTertiary,
          size: AppSpacing.iconMd,
        ),
      );
    }

    // Clear button for search (shown only when has text)
    if (_isSearch && _hasText) {
      return GestureDetector(
        onTap: _clearField,
        child: const Icon(
          Icons.cancel_rounded,
          color: AppColors.textTertiary,
          size: AppSpacing.iconMd,
        ),
      );
    }

    // Custom suffix icon
    if (widget.suffixIcon != null) {
      return GestureDetector(
        onTap: widget.onSuffixIconTap,
        child: Icon(
          widget.suffixIcon,
          color: AppColors.textSecondary,
          size: AppSpacing.iconMd,
        ),
      );
    }

    return null;
  }

  // ---- Effective label ----
  String? get _effectiveLabel {
    if (widget.label == null) return null;
    return widget.isRequired ? '${widget.label} *' : widget.label;
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius =
        widget.borderRadius ?? AppSpacing.borderRadiusMd;

    return TextFormField(
      controller: _controller,
      focusNode: widget.focusNode,
      keyboardType: _keyboardType,
      textInputAction: _textInputAction,
      obscureText: _isPassword ? _obscureText : false,
      textCapitalization: _textCapitalization,
      maxLength: widget.maxLength,
      maxLines: _maxLines,
      minLines: _minLines,
      inputFormatters: _formatters,
      autofocus: widget.autofocus,
      readOnly: widget.isReadOnly,
      enabled: widget.isEnabled,
      autocorrect: widget.autocorrect && !_isPassword,
      autofillHints: _autofillHints,
      keyboardAppearance: widget.keyboardAppearance,
      style: widget.style ?? AppTextStyles.input,
      validator: (v) {
        if (widget.isRequired && (v == null || v.trim().isEmpty)) {
          return '${widget.label ?? 'This field'} is required';
        }
        return widget.validator?.call(v);
      },
      autovalidateMode:
          widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      buildCounter: widget.showCounter ? null : (_, {required currentLength, required isFocused, maxLength}) => null,
      decoration: InputDecoration(
        labelText: _effectiveLabel,
        hintText: widget.hint,
        helperText: widget.helperText,
        errorText: widget.errorText,
        helperMaxLines: 2,
        errorMaxLines: 2,
        labelStyle: widget.labelStyle,
        hintStyle: widget.hintStyle ?? AppTextStyles.inputHint,
        fillColor: widget.isEnabled
            ? (widget.fillColor ?? AppColors.surface)
            : AppColors.backgroundAlt,
        filled: true,
        contentPadding: widget.contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: AppSpacing.base,
              vertical: AppSpacing.md,
            ),
        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon, size: AppSpacing.iconMd, color: AppColors.textSecondary)
            : widget.prefix != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                    child: widget.prefix,
                  )
                : widget.type == AppTextFieldType.search
                    ? const Icon(Icons.search_rounded, size: AppSpacing.iconMd, color: AppColors.textTertiary)
                    : null,
        prefixText: widget.prefixText,
        prefixStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
        suffixIcon: widget.suffix != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                child: widget.suffix,
              )
            : _buildSuffixIcon(),
        suffixText: widget.suffixText,
        suffixStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: AppColors.borderFocus, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: AppColors.divider),
        ),
      ),
    );
  }
}

// =============================================================================
// AppOtpField — Row of single-digit OTP boxes
// =============================================================================

/// A row of styled OTP input boxes.
///
/// ```dart
/// AppOtpField(length: 6, onCompleted: (code) => verify(code))
/// ```
class AppOtpField extends StatefulWidget {
  const AppOtpField({
    super.key,
    this.length = 6,
    required this.onCompleted,
    this.onChanged,
    this.boxSize = 52,
    this.spacing = 8,
    this.filled = true,
    this.borderRadius,
    this.textStyle,
  });

  final int length;
  final ValueChanged<String> onCompleted;
  final ValueChanged<String>? onChanged;
  final double boxSize;
  final double spacing;
  final bool filled;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;

  @override
  State<AppOtpField> createState() => _AppOtpFieldState();
}

class _AppOtpFieldState extends State<AppOtpField> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.isNotEmpty && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    final otp = _controllers.map((c) => c.text).join();
    widget.onChanged?.call(otp);
    if (otp.length == widget.length) {
      widget.onCompleted(otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    final radius = widget.borderRadius ?? AppSpacing.borderRadiusMd;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (i) {
        final isLast = i == widget.length - 1;
        return Padding(
          padding: EdgeInsets.only(right: isLast ? 0 : widget.spacing),
          child: SizedBox(
            width: widget.boxSize,
            height: widget.boxSize,
            child: TextFormField(
              controller: _controllers[i],
              focusNode: _focusNodes[i],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 1,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: widget.textStyle ??
                  AppTextStyles.titleLarge.copyWith(color: AppColors.primary),
              onChanged: (v) => _onChanged(i, v),
              buildCounter: (_, {required currentLength, required isFocused, maxLength}) =>
                  null,
              decoration: InputDecoration(
                filled: widget.filled,
                fillColor: AppColors.primaryContainer,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: radius,
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: radius,
                  borderSide:
                      const BorderSide(color: AppColors.borderFocus, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: radius,
                  borderSide: const BorderSide(color: AppColors.border),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
