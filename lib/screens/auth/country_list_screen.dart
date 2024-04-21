import 'package:flutter/material.dart';
import 'package:flutter_assesment/screens/auth/model/country_list.model.dart';
import 'package:flutter_assesment/screens/auth/provider/auth.provider.dart';
import 'package:flutter_assesment/widgets/country_list_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({super.key, required this.isStudent});

  final bool isStudent;
  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  late AuthProvider authProvider;
  final _scrollController = ScrollController();
  final _searchFieldController = TextEditingController();

  List<Country> searchResult = [];

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.isStudent = widget.isStudent;
    // authProvider.fetchCountries();
    Future.delayed(
      const Duration(seconds: 3),
      () => searchResult = authProvider.countryListResponse!.data!,
    );
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent == _scrollController.offset) {
        fetch();
      }
    });
  }

  Future fetch() async {
    int total = 0;
    total = authProvider.country.length + authProvider.limit;
    for (int i = authProvider.country.length; i < total; i++) {
      authProvider.country.add(authProvider.countryListResponse!.data![i]);
    }
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFF212426),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 0,
                      blurRadius: 10.0,
                      offset: const Offset(-4, -3),
                      color: const Color(0xFFBDBDBD).withOpacity(0.3),
                    ),
                    BoxShadow(
                      spreadRadius: 0,
                      blurRadius: 10.0,
                      offset: const Offset(8, 5),
                      color: const Color(0xFF000000).withOpacity(0.36),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    elevation: 24,
                    backgroundColor: const Color(0xFF212426),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: Text(
                  'Select your country',
                  style: GoogleFonts.metrophobic(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _searchFieldController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF4B4E4F),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFFD9896A),
                    ),
                    hintText: 'Search',
                    hintStyle: GoogleFonts.metrophobic(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  style: GoogleFonts.metrophobic(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                  onChanged: searchCountry,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: _searchFieldController.text.isNotEmpty || _searchFieldController.text != ""
                      ? ListView.builder(
                          controller: _scrollController,
                          itemCount: searchResult.length,
                          itemBuilder: (context, index) {
                            final item = searchResult[index];
                            return ListItemWidget(item: item);
                          },
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount: authProvider.country.length + 1,
                          itemBuilder: (context, index) {
                            if (index < authProvider.country.length) {
                              final item = authProvider.country[index];
                              return ListItemWidget(item: item);
                            } else {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 32),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void searchCountry(String query) {
    final searchedCountries = authProvider.countryListResponse!.data!.where((country) {
      final countryName = country.name!.toLowerCase();
      final countryCode = country.telCode!;

      return countryName.contains(query.toLowerCase()) || countryCode.contains(query);
    }).toList();
    debugPrint('Searched Items : ${searchedCountries.length}');
    setState(() => searchResult = searchedCountries);
  }
}
