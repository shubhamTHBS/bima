import 'package:country_pickers/countries.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';

class SearchCountryScreen extends SearchDelegate<Country> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: Colors.black),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  String searchFieldLabel = 'Search...';
  @override
  TextStyle searchFieldStyle =
      const TextStyle(fontSize: 14, decoration: TextDecoration.none);
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      tooltip: 'Back',
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      backgroundColor: Colors.grey,
      // accentColor:
      //     AppColor.defaultPeach, // to change underline color default blue
      textTheme: const TextTheme(
          headline6: TextStyle(fontSize: 14, decoration: TextDecoration.none)),
    );
  }

  @override
  Widget buildResults(BuildContext context) => Container();

  Widget _error(String? errorMessage) => Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Center(
          child: Text(
            errorMessage ?? '',
            style: const TextStyle(fontSize: 17.0, color: Colors.red),
          ),
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    final countries = countryList.where((country) =>
        country.name.toLowerCase().contains(query.toLowerCase()) ||
        country.phoneCode
            .toLowerCase()
            .contains(query.toLowerCase().replaceFirst('+', '')));

    if (countries != null && countries.isNotEmpty) {
      return ListView.separated(
        separatorBuilder: (context, index) => Divider(height: 1.0),
        itemCount: countries.length,
        itemBuilder: (context, index) {
          final country = countries.elementAt(index);
          return Container(
            child: ListTile(
              onTap: () => close(context, country),
              leading: CountryPickerUtils.getDefaultFlagImage(country),
              title: Text(
                country.name,
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
              trailing: Text('+${country.phoneCode}',
                  style: const TextStyle(fontSize: 14)),
            ),
          );
        },
      );
    } else {
      return Container(
        child: _error('No record(s) found!'),
      );
    }
  }
}
