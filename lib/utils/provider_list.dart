import 'package:flutter_assesment/screens/auth/provider/auth.provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProviderList {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    // ChangeNotifierProvider(create: (_) => HomeProvider()),
  ];
}
