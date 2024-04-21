import 'package:flutter/material.dart';
import 'package:flutter_assesment/screens/auth/mobile_screen.dart';
import 'package:flutter_assesment/screens/auth/model/country_list.model.dart';
import 'package:flutter_assesment/screens/auth/provider/auth.provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({
    super.key,
    required this.item,
  });

  final Country item;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return GestureDetector(
      onTap: () {
        authProvider.selectedCountry = item;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EnterMobileScreen(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 34,
                  width: 34,
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(right: 16.0),
                  child: SvgPicture.network(
                    item.flag ?? '',
                    placeholderBuilder: (BuildContext context) => const CircularProgressIndicator(),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10.0),
                SizedBox(
                  width: 160,
                  child: Text(
                    item.name ?? '',
                    style: GoogleFonts.metrophobic(
                      color: const Color(0xFFFFFFFF),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            Text(
              item.telCode ?? '',
              style: GoogleFonts.metrophobic(
                color: const Color(0xFFFFFFFF),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
