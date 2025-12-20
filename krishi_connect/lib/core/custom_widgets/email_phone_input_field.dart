import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:krishi_connect/core/custom_widgets/custom_formatters.dart';
import 'package:krishi_connect/core/theme/theme_extenstion.dart';

class EmailPhoneInputField extends StatefulWidget {
  final TextEditingController controller;
  final String? errorText;
  final bool initialIsPhone;
  final ValueChanged<bool>? onModeChanged; // notify parent if email <-> phone
  final ValueChanged<String>? onChanged;

  const EmailPhoneInputField({
    super.key,
    required this.controller,
    this.errorText,
    this.initialIsPhone = false,
    this.onModeChanged,
    this.onChanged,
  });

  @override
  State<EmailPhoneInputField> createState() => _EmailPhoneInputFieldState();
}

class _EmailPhoneInputFieldState extends State<EmailPhoneInputField> {
  late bool isPhone;

  @override
  void initState() {
    super.initState();
    isPhone = widget.initialIsPhone;
  }

  void _handleInput(String value) {
    if (value.isEmpty) {
      if (isPhone) {
        setState(() => isPhone = false);
        widget.onModeChanged?.call(false);
      }
      widget.onChanged?.call(value);
      return;
    }

    // If starts with number → switch to phone mode
    if (RegExp(r'^[0-9]').hasMatch(value) && !isPhone) {
      setState(() => isPhone = true);
      widget.onModeChanged?.call(true);

      widget.controller.text = value;
      widget.controller.selection = TextSelection.fromPosition(
        TextPosition(offset: value.length),
      );
    }

    // While in phone mode → restrict alphabets
    if (isPhone && RegExp(r'[^0-9 ]').hasMatch(value)) {
      final clean = value.replaceAll(RegExp(r'[^0-9]'), "");
      widget.controller.text = clean;
      widget.controller.selection = TextSelection.fromPosition(
        TextPosition(offset: clean.length),
      );
    }

    // If starts with letter → switch to email mode
    if (!RegExp(r'^[0-9]').hasMatch(value) && isPhone) {
      setState(() => isPhone = false);
      widget.onModeChanged?.call(false);
    }

    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: isPhone ? TextInputType.number : TextInputType.emailAddress,

      inputFormatters: isPhone
          ? [FilteringTextInputFormatter.digitsOnly, IndianPhoneFormatter()]
          : [],

      decoration: InputDecoration(
        labelText: isPhone ? "Phone Number" : "Email or Phone",
        hintText: isPhone ? "98765 43210" : "example@gmail.com or 9876543210",

        prefixIcon: isPhone
            ? Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("🇮🇳", style: TextStyle(fontSize: 20)),
                    const SizedBox(width: 6),
                    Text("+91", style: context.textTheme.titleMedium),
                    const SizedBox(width: 8),
                  ],
                ),
              )
            : null,

        prefixIconConstraints: isPhone
            ? const BoxConstraints(minWidth: 0, minHeight: 0)
            : null,

        errorText: widget.errorText,
      ),

      onChanged: _handleInput,
    );
  }
}
