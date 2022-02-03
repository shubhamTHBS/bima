import 'package:bima/core/theme/color.dart';
import 'package:bima/core/theme/text_styles.dart';
import 'package:bima/features/auth/presentation/widgets/input_text_field.dart';
import 'package:bima/features/auth/presentation/widgets/search_country.dart';
import 'package:country_pickers/countries.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:io' show Platform;

class TextInputCountry extends StatefulWidget {
  final FocusNode? nextFocusNode;
  final bool isSubtitled;
  final bool isHeader;
  final bool isMobileNumber;
  final String? subtitle;
  final double horizontalSpace;
  final double verticalSpace;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final InputDecoration decoration;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool autofocus;
  final bool obscureText;
  final bool autocorrect;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  static const int noMaxLength = -1;
  final int? maxLength;
  final bool maxLengthEnforced;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final double? cursorWidth;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final DragStartBehavior dragStartBehavior;
  final TextEditingController? mobileController;
  final String? Function(String?)? validator;
  // bool get selectionEnabled {
  //   return enableInteractiveSelection ?? !obscureText;
  // }

  final GestureTapCallback? onTap;
  final InputCounterWidgetBuilder? buildCounter;
  Country? phoneNumber;
  final ScrollPhysics? scrollPhysics;

  TextInputCountry({
    Key? key,
    this.nextFocusNode,
    this.isSubtitled = false,
    this.isHeader = false,
    this.isMobileNumber = false,
    this.subtitle,
    this.horizontalSpace = 0,
    this.verticalSpace = 0,
    this.controller,
    this.mobileController,
    this.focusNode,
    this.decoration = const InputDecoration(),
    required this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.autofocus = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforced = true,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection = true,
    this.onTap,
    this.validator,
    this.buildCounter,
    this.scrollPhysics,
    this.phoneNumber,
  })  : assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          'minLines can\'t be greater than maxLines',
        ),
        assert(
          !expands || (maxLines == null && minLines == null),
          'minLines and maxLines must be null when expands is true.',
        ),
        super(key: key);

  @override
  TextInputCountryState createState() => TextInputCountryState();
}

class TextInputCountryState extends State<TextInputCountry> {
  Country? _selectedCountry;
  bool isFocus = false;
  Widget _buildCountryPicker() => Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // CountryPickerUtils.getDefaultFlagImage(_selectedCountry!),
          Text('+${_selectedCountry?.phoneCode} ',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: AppColor.primaryGreen,
                  fontFamily: Font.ROBOTO_CONDENSED_BOLD,
                  fontSize: /*_selectedCountry.phoneCode.length>3?11:*/ 22)),
          // const SizedBox(width: 5),
          const SizedBox(
            width: 20,
            child: Icon(
              Icons.keyboard_arrow_down,
              color: AppColor.primaryGreen,
            ),
          ),
        ],
      );

  String get number {
    String text = widget.controller!.text.trim();
    return text.replaceAll(' ', '');
  }

  String get countryCode {
    return _selectedCountry!.phoneCode;
  }

  String get mobileNumber {
    return '+$countryCode$number';
  }

  String get selectedCountry {
    return _selectedCountry!.phoneCode;
  }

  String get selectedCountryIsoCode {
    return _selectedCountry!.isoCode;
  }

  // Widget _header() => Text(widget.title,
  //     style: const TextStyle(fontSize: 14, color: Colors.grey));

  // ignore: unused_element
  // Widget _headerWithSubtitle() => Padding(
  //     padding: EdgeInsets.symmetric(
  //         vertical: widget.verticalSpace, horizontal: widget.horizontalSpace),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Text(widget.title,
  //             style: TextStyles.bookBold.copyWith(fontSize: 25.0)),
  //         Padding(
  //           padding: EdgeInsets.only(top: 10.0),
  //           child: Text(widget.subtitle,
  //               style: TextStyles.bookBold.copyWith(fontSize: 18.0)),
  //         )
  //       ],
  //     ));

  Widget _textInput() => TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        decoration: widget.decoration,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        textCapitalization: widget.textCapitalization,
        /*style: widget.style != null // alignCenter issue
        ? widget.style
        : TextStyles.bookBlue.copyWith(fontSize: 14),*/
        strutStyle: widget.strutStyle,
        textAlign: widget.textAlign,
        textDirection: widget.textDirection,
        autofocus: widget.autofocus,
        obscureText: widget.obscureText,
        autocorrect: widget.autocorrect,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        expands: widget.expands,
        onFieldSubmitted: (String text) => widget.onSubmitted!(text),
        maxLength: widget.maxLength,
        onChanged: (String text) => widget.onChanged!(text),
        onEditingComplete: () => widget.onEditingComplete!(),
        inputFormatters: widget.inputFormatters,
        enabled: widget.enabled,
        cursorWidth: widget.cursorWidth!,
        cursorRadius: widget.cursorRadius,
        cursorColor: widget.cursorColor,
        keyboardAppearance: widget.keyboardAppearance,
        scrollPadding: widget.scrollPadding,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        onTap: () => widget.onTap,
        buildCounter: widget.buildCounter,
        scrollPhysics: widget.scrollPhysics,
      );

  Widget _countriesPicker() => GestureDetector(
        onTap: () =>
            showSearch(context: context, delegate: SearchCountryScreen())
                .then((country) {
          if (country != null) {
            setState(() => _selectedCountry = country);
            if (widget.onChanged != null) {
              widget.controller!.text = _selectedCountry!.phoneCode;
              widget.onChanged!(_selectedCountry!.phoneCode);
            }
          }
        }),
        child: _buildCountryPicker(),
      );

  Widget _textInputWithCountryList() => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: _countriesPicker()),
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: InputTextField(
              focusNode: widget.focusNode,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              // title: 'Mobile number',
              controller: widget.mobileController,
              // validator: widget.validator,
              // titleColor: Colors.grey,
              // titleFontFamily: Font.CTRBOOK,
              labelFontSize: 22.5,
              labelColor: AppColor.accentColor,
              // labelFontFamily: Font.CTRMEDIUM,
              hintText: 'Mobile number',
              labelFontFamily: Font.ROBOTO_CONDENSED_BOLD,
              isSuffix: true,
              suffixIcon: SizedBox(
                width: 20,
                height: 20,
                child: IconButton(
                  padding: const EdgeInsets.all(0.0),
                  icon: const Icon(
                    Icons.cancel_outlined,
                    color: AppColor.accentColor,
                    size: 18,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.mobileController?.clear();
                    });
                  },
                ),
              ),
              inputFormatters: widget.inputFormatters,
              isMobileNumber: true,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(widget.nextFocusNode);
              },
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    if (widget.phoneNumber != null) {
      _selectedCountry = widget.phoneNumber!;
    } else if (_selectedCountry == null) {
      if (widget.controller!.text != null &&
          widget.controller!.text.isNotEmpty) {
        String phonecode = widget.controller!.text.replaceAll('+', '');

        _selectedCountry = getCountryByPhoneCode(phonecode);
      } else {
        /*
        Crashed while fetching countrycode based on Localizations
      _selectedCountry = CountryPickerUtils.getCountryByIsoCode(
            Localizations.localeOf(context).countryCode!);*/
        if ((Localizations.localeOf(context).countryCode) == null) {
          _selectedCountry =
              CountryPickerUtils.getCountryByName('united states');
        } else
          _selectedCountry = CountryPickerUtils.getCountryByIsoCode(
              Localizations.localeOf(context).countryCode!);
      }
    }

    // underline for whole place holder
    return GestureDetector(
      onTap: () => showSearch(context: context, delegate: SearchCountryScreen())
          .then((country) {
        if (country != null) {
          setState(() => _selectedCountry = country);
          if (widget.onChanged != null) {
            widget.controller!.text = _selectedCountry!.phoneCode;
            widget.onChanged!(_selectedCountry!.phoneCode);
          }
        }
      }),
      child: FocusScope(
        child: Focus(
          onFocusChange: (focus) => setState(() => isFocus = focus),
          child: Container(
              decoration: BoxDecoration(
                  border: BorderDirectional(
                      bottom: !widget.isHeader
                          ? BorderSide(
                              color: Colors.white.withOpacity(0.6),
                              width: 1.0,
                              style: BorderStyle.solid)
                          : BorderSide.none)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // _header(),
                  !widget.isHeader
                      ? !widget.isMobileNumber
                          ? _textInput()
                          : _textInputWithCountryList()
                      : Container(),
                ],
              )),
        ),
      ),
    );
  }

  Country getCountryByPhoneCode(String phoneCode) {
    try {
      return countryList.firstWhere(
        (country) => country.phoneCode == phoneCode,
      );
    } catch (error) {
      throw Exception(
          'The initialValue provided is not a supported phone code!');
    }
  }
}
