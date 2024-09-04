import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'src/ui/home/home_page.dart';
import 'src/ui/style/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: ScreenUtilInit(
        splitScreenMode: false,
        minTextAdapt: true,
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My Skin',
          theme: AppTheme.lightTheme,
          home: const MyHomePage(),
        ),
      ),
    );
  }
}
