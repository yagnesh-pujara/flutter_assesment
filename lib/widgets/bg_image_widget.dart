import 'package:flutter/material.dart';

class BgImageWidget extends StatelessWidget {
  const BgImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height - 120,
      width: double.maxFinite,
      margin: const EdgeInsets.only(bottom: 32.0),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/startup_image.gif',
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
