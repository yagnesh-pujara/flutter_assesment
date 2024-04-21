import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_assesment/screens/auth/provider/auth.provider.dart';
import 'package:flutter_assesment/screens/home/study_country_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late AuthProvider authProvider;
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Duration _duration = const Duration(seconds: 30);
  Timer? _timer;
  int _countdownValue = 0;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    if (!_isRunning) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_duration.inSeconds <= 0) {
          _timer?.cancel();
          _isRunning = false;
          setState(() {});
        } else {
          setState(() {
            _isRunning = true;
            _countdownValue = _duration.inSeconds;
            _duration = _duration - const Duration(seconds: 1);
          });
        }
      });
    }
  }

  String errorText = "";

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);
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
                    'Verify Number',
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
                      'Please enter the OTP received to\nverify your number',
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
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 25.0),
                  alignment: Alignment.center,
                  child: Center(
                    child: Pinput(
                      controller: _otpController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          errorText = 'Please enter a valid OTP';
                          setState(() {});
                        } else if (value.length < 4) {
                          errorText = 'Please enter a valid OTP';
                          setState(() {});
                        }
                        return null;
                      },
                      length: 4,
                      keyboardType: TextInputType.number,
                      defaultPinTheme: PinTheme(
                        height: 32.0,
                        width: 32.0,
                        margin: const EdgeInsets.only(
                          right: 12.0,
                          left: 12.0,
                        ),
                        textStyle: GoogleFonts.metrophobic(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFF7D7E80),
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
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
                const SizedBox(height: 90),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Didn’t receive OTP?',
                      style: GoogleFonts.metrophobic(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                _isRunning
                    ? Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Resending OTP in',
                              style: GoogleFonts.metrophobic(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              ' ${_countdownValue.toString()} seconds',
                              style: GoogleFonts.metrophobic(
                                color: const Color(0xFFD9896A),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          authProvider.resendOtp();
                          startTimer();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Resend OTP',
                              style: GoogleFonts.metrophobic(
                                color: const Color(0xFFD9896A),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 78),
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
                            authProvider.verifyOtp(_otpController.text.trim()).then((_) {
                              if (authProvider.verifyOtpResponse?.status ?? false) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const StudyCountrySelectionScreen(),
                                  ),
                                );
                              }
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF212426),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Verify',
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
