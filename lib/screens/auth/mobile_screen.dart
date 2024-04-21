import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assesment/screens/auth/provider/auth.provider.dart';
import 'package:flutter_assesment/screens/auth/verify_otp_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EnterMobileScreen extends StatefulWidget {
  const EnterMobileScreen({super.key});

  @override
  State<EnterMobileScreen> createState() => _EnterMobileScreenState();
}

class _EnterMobileScreenState extends State<EnterMobileScreen> {
  late AuthProvider authProvider;
  final _mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String errorText = "";

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212426),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                    'Enter phone number',
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
                      'Please enter your 10 digit mobile\nnumber to receive OTP',
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
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 55),
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFF7D7E80), width: 1.0),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 32,
                        width: 32,
                        child: SvgPicture.network(
                          authProvider.selectedCountry!.flag!,
                        ),
                      ),
                      const SizedBox(width: 24.0),
                      Text(
                        authProvider.selectedCountry!.telCode!,
                        style: GoogleFonts.metrophobic(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: TextFormField(
                          controller: _mobileController,
                          decoration: InputDecoration(
                            hintText: '1234567890',
                            hintStyle: GoogleFonts.metrophobic(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF656366),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              errorText = 'Please enter a valid mobile number';
                              setState(() {});
                            } else if (value.length < 10) {
                              errorText = 'Please enter a valid mobile number';
                              setState(() {});
                            }
                            return null;
                          },
                          style: GoogleFonts.metrophobic(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                errorText != ""
                    ? Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          errorText,
                          style: GoogleFonts.metrophobic(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFFF05252),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 236),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(8.0),
                  child: Center(
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
                          if (_formKey.currentState!.validate()) {
                            if (_mobileController.text.length < 11) {
                              authProvider.userLogin(_mobileController.text.trim()).then((value) {
                                if (authProvider.userLoginResponse?.status ?? false) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const OtpVerificationScreen(),
                                    ),
                                  );
                                }
                              });
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF212426),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Get OTP',
                            style: GoogleFonts.metrophobic(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFF9D3B4).withOpacity(0.4),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
