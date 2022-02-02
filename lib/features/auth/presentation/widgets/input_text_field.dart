import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? title;
  final bool isObscure;
  final Color? color;
  final String? labelFontFamily;
  final double? labelFontSize;
  final bool isLabelFontSize;
  final bool isAsterisk;
  final Color? titleColor;
  final String? titleFontFamily;
  final bool isTitleFontSize;
  final double? titleFontSize;
  final Color? labelColor;
  final String? hintText;
  final bool isMobileNumber;
  final FocusNode? focusNode;
  final Function? onEditingComplete;
  final TextInputType? keyboardType;
  final bool isOutlineInpurBorder;
  final FontWeight? titleFontWeight;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final bool isSuffix;
  final VoidCallback? onTap;
  final bool isTextArea;
  final bool filled;
  final bool readOnly;
  final dynamic? initialValue;
  final suffixWidget;
  final List<TextInputFormatter>? inputFormatters;
  final bool isFocusedBorder;
  bool obscure;
  bool enabled;
  final FormFieldSetter<String>? onSaved;
  final FormFieldSetter<String>? onChanged;
  final Widget? suffixIcon;
  final Widget? editIcon;
  final Widget? isLabelEdit;
  final String? Function(String?)? validator;

  InputTextField(
      {Key? key,
      this.title,
      this.controller,
      this.isObscure = false,
      this.obscure = false,
      this.color,
      this.labelFontFamily,
      this.labelFontSize,
      this.isLabelFontSize = false,
      this.isAsterisk = false,
      this.titleColor,
      this.titleFontFamily,
      this.isTitleFontSize = false,
      this.titleFontSize,
      this.labelColor,
      this.hintText,
      this.isMobileNumber = false,
      this.onEditingComplete,
      this.focusNode,
      this.keyboardType,
      this.isOutlineInpurBorder = false,
      this.titleFontWeight,
      this.textCapitalization = TextCapitalization.none,
      this.textInputAction,
      this.isSuffix = false,
      this.isTextArea = false,
      this.onChanged,
      this.onSaved,
      this.suffixIcon,
      this.onTap,
      this.suffixWidget,
      this.filled = false,
      this.readOnly = false,
      this.inputFormatters,
      this.enabled = true,
      this.initialValue,
      this.isLabelEdit = const SizedBox(),
      this.isFocusedBorder = true,
      this.editIcon,
      this.validator})
      : super(key: key);
  @override
  _InputTextFieldState createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  bool isFocus = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: widget.isMobileNumber ? '' : widget.title,
            children: <InlineSpan>[
              widget.isAsterisk
                  ? const TextSpan(
                      text: '*',
                      style: const TextStyle(color: Colors.red),
                    )
                  : const WidgetSpan(child: SizedBox()),
              WidgetSpan(child: widget.isLabelEdit!)
              /* TextSpan(
                text: widget.isAsterisk ? '*' : '',
                style: TextStyle(color: Colors.red),
              ),*/
            ],
            style: TextStyle(
                color: widget.titleColor,
                fontFamily: widget.titleFontFamily,
                fontWeight: widget.titleFontWeight,
                fontSize: widget.titleFontSize),
          ),
        ),
        widget.isOutlineInpurBorder
            ? const SizedBox(
                height: 8,
              )
            : Container(),
        FocusScope(
          child: Focus(
            onFocusChange: (focus) => setState(() => isFocus = focus),
            child: TextFormField(
              textDirection: TextDirection.ltr,
              maxLines: widget.isTextArea ? 5 : 1,
              keyboardType: widget.keyboardType,
              inputFormatters: widget.inputFormatters,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              focusNode: widget.focusNode,
              onEditingComplete: () => widget.onEditingComplete!.call(),
              controller: widget.controller,
              obscureText: widget.obscure,
              initialValue: widget.initialValue,
              obscuringCharacter: '*',
              validator: widget.validator,
              enabled: widget.enabled,
              // cursorColor: AppColor.defaultPeach,
              textCapitalization: widget.textCapitalization,
              textInputAction: widget.textInputAction,
              onTap: widget.onTap != null ? () => widget.onTap!() : null,
              onChanged: widget.onChanged,
              onSaved: widget.onSaved,
              readOnly: widget.readOnly,
              style: TextStyle(
                  color: widget.labelColor,
                  fontFamily: widget.labelFontFamily,
                  fontSize: widget.labelFontSize),
              decoration: InputDecoration(
                filled: widget.filled,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: widget.hintText,
                // hintStyle: TextStyles.bookMedium.copyWith(
                //     color: AppColor.defaultBlack.withOpacity(0.32),
                //     fontSize: 1.75 * SizeConfiguration.textsizeMultiplier),
                isDense: true,
                contentPadding: widget.isMobileNumber
                    ? const EdgeInsets.only(bottom: 7.5)
                    : widget.isOutlineInpurBorder
                        ? const EdgeInsets.only(
                            left: 15.0, top: 15.0, bottom: 15.0)
                        : const EdgeInsets.only(top: 10.0, bottom: 7.5),
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 1,
                  minHeight: 1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
