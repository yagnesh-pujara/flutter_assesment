import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_assesment/screens/auth/country_list_screen.dart';
import 'package:flutter_assesment/screens/auth/provider/auth.provider.dart';
import 'package:flutter_assesment/screens/auth/terms_and_conditions_screen.dart';
import 'package:flutter_assesment/widgets/bg_image_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StartUpScreen extends StatefulWidget {
  const StartUpScreen({super.key});

  @override
  State<StartUpScreen> createState() => _StartUpScreenState();
}

class _StartUpScreenState extends State<StartUpScreen> {
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.getTermsAndConditions();
    authProvider.fetchCountries();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          const BgImageWidget(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 360,
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              width: double.maxFinite,
              child: Card(
                margin: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                color: const Color(0XFF292929),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 16.0),
                      Text(
                        'Welcome to Study Lancer',
                        style: GoogleFonts.metrophobic(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Please select your role to get registered',
                        style: GoogleFonts.metrophobic(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const CountryListScreen(isStudent: true);
                                    },
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 122,
                                    width: 158,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(17),
                                      border: Border.all(
                                        width: 5,
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 4.0,
                                          color: Colors.white24,
                                          spreadRadius: 1.0,
                                          offset: Offset(-6, -5),
                                        ),
                                        BoxShadow(
                                          blurRadius: 8.0,
                                          color: Colors.black26,
                                          spreadRadius: 2.0,
                                          offset: Offset(6, 12),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(17),
                                      clipBehavior: Clip.antiAlias,
                                      child: Image.asset(
                                        'assets/images/image_1.jpg',
                                        fit: BoxFit.fill,
                                        isAntiAlias: true,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  Text(
                                    'Student',
                                    style: GoogleFonts.metrophobic(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const CountryListScreen(isStudent: false);
                                    },
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 122,
                                    width: 158,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(17),
                                      border: Border.all(
                                        width: 5,
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 4.0,
                                          color: Colors.white24,
                                          spreadRadius: 1.0,
                                          offset: Offset(-6, -5),
                                        ),
                                        BoxShadow(
                                          blurRadius: 8.0,
                                          color: Colors.black26,
                                          spreadRadius: 2.0,
                                          offset: Offset(6, 12),
                                        )
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(17),
                                      clipBehavior: Clip.antiAlias,
                                      child: Transform.flip(
                                        flipX: true,
                                        child: Image.asset(
                                          'assets/images/image_2.jpg',
                                          fit: BoxFit.fill,
                                          isAntiAlias: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  Text(
                                    'Agent',
                                    style: GoogleFonts.metrophobic(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'By continuing you agree to our ',
                            style: GoogleFonts.metrophobic(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TermsAndConditionScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Terms and Conditions',
                              style: GoogleFonts.metrophobic(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFD9896A),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
