import 'package:flutter/material.dart';
import 'package:flutter_assesment/screens/auth/provider/auth.provider.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({super.key});

  @override
  State<TermsAndConditionScreen> createState() => _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.getTermsAndConditions();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFF212426),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
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
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width - 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          'assets/images/terms_and_condition.svg',
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              authProvider.terms?.data?.title ?? "Title",
                              style: GoogleFonts.metrophobic(
                                color: const Color(0xFFD9896A),
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Update ${DateFormat('dd/M/yyyy').format(authProvider.terms!.data!.updatedAt!)}',
                              style: GoogleFonts.metrophobic(
                                color: const Color(0xFF7D7E80),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Html(
                    data: authProvider.terms?.data?.content ?? '<h1>Content Is Null</h1>',
                    style: {
                      'h1': Style.fromTextStyle(
                        GoogleFonts.metrophobic(
                          color: const Color(0xFFD9896A),
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                      ),
                      'p': Style(
                        fontSize: FontSize(
                          12.0,
                          Unit.px,
                        ),
                        lineHeight: LineHeight.percent(
                          160,
                        ),
                        color: Colors.white,
                      ),
                      'li': Style(
                        fontSize: FontSize(
                          12.0,
                          Unit.px,
                        ),
                        lineHeight: LineHeight.percent(
                          160,
                        ),
                        color: Colors.white,
                      ),
                    },
                  ),
                ),
                const SizedBox(height: 32.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
