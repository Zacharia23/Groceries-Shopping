import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_application/providers/cart_counter.dart';
import 'package:grocery_application/screens/splash_screen.dart';
import 'package:grocery_application/utilities/database_utils.dart';
import 'package:provider/provider.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MesulaApplication(),
  );
}

class MesulaApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ChangeNotifierProvider(
      create: (context) => CartCounter(),
      child: MaterialApp(
        title: 'Mesula Food E-Commerce',
        theme: ThemeData(
          primaryColor: Color(0xFF2c6e49),
          accentColor: Color(0xFFf6ae2d),
          visualDensity: VisualDensity.adaptivePlatformDensity
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
