import 'package:flutter/material.dart';
import 'package:flutter_assesment/screens/auth/provider/auth.provider.dart';
import 'package:flutter_assesment/screens/home/logout_screen.dart';
import 'package:flutter_assesment/screens/home/model/country_selection.model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StudyCountrySelectionScreen extends StatefulWidget {
  const StudyCountrySelectionScreen({super.key});

  @override
  State<StudyCountrySelectionScreen> createState() => StudyCountrySelectionScreenState();
}

class StudyCountrySelectionScreenState extends State<StudyCountrySelectionScreen> {
  late AuthProvider authProvider;
  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.getStudyCountries();
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFF212426),
      body: SafeArea(
        child: SingleChildScrollView(
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
              const SizedBox(height: 32.0),
              Center(
                child: Text(
                  'Select Country',
                  style: GoogleFonts.metrophobic(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Please select the country where\nyou want to study',
                    style: GoogleFonts.metrophobic(
                      color: const Color(0xFFD9896A),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              Container(
                height: 12,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF101112).withOpacity(0.2),
                      const Color(0xFF212426),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 48),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.54,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: authProvider.studyCountrySelection?.data?.countries?.length ?? 0,
                itemBuilder: (context, index) {
                  Country item = authProvider.studyCountrySelection!.data!.countries![index];
                  return CountryListTile(
                    item: item,
                  );
                },
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 0.0,
                        blurRadius: 10.0,
                        offset: const Offset(6, 6),
                        color: const Color(0xFF000000).withOpacity(0.16),
                      ),
                      BoxShadow(
                        spreadRadius: 0.0,
                        blurRadius: 12.0,
                        offset: const Offset(-2, -6),
                        color: const Color(0xFFFFFFFF).withOpacity(0.1),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF212426),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Proceed',
                        style: GoogleFonts.metrophobic(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFF9D3B4).withOpacity(0.4),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              //  Contact Us SECTION
              Center(
                child: Column(
                  children: [
                    Text(
                      'Can’t see the country of your interest?',
                      style: GoogleFonts.metrophobic(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 25),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Consult with us',
                        style: GoogleFonts.metrophobic(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFD9896A),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CountryListTile extends StatelessWidget {
  const CountryListTile({super.key, required this.item});

  final Country item;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return GestureDetector(
      onTap: () {
        authProvider.setStudyCountry(item.id!).then(
              (value) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              ),
            );
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(8.0),
            // padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.antiAlias,
            child: ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                item.image!,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            item.name!,
            style: GoogleFonts.metrophobic(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
