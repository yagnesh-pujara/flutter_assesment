import 'package:flutter/material.dart';
import 'package:flutter_assesment/screens/auth/provider/auth.provider.dart';
import 'package:flutter_assesment/utils/preference_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFF212426),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Welcome',
                style: GoogleFonts.metrophobic(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 36),
            Container(
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
                  authProvider.logoutUser().then((value) {
                    PreferenceManager.clearData();
                    Navigator.popUntil(context, (route) => route.isFirst);
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF212426),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Logout',
                    style: GoogleFonts.metrophobic(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFF9D3B4).withOpacity(0.4),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 36.0),
            Container(
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
                  authProvider.deleteUser().then((value) {
                    PreferenceManager.clearData();
                  });
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF212426),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Delete User',
                    style: GoogleFonts.metrophobic(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFF9D3B4).withOpacity(0.4),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
