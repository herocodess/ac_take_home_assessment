import 'package:acumen_technical_assessment/config.dart';
import 'package:acumen_technical_assessment/core/utils/bloc_observer.dart';
import 'package:acumen_technical_assessment/core/utils/extensions.dart';
import 'package:acumen_technical_assessment/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:acumen_technical_assessment/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  GoogleFonts.config.allowRuntimeFetching = true;
  await dotenv.load(fileName: Config.fileName);

  /// Calling the [AppBlocObserver] which is a concrete impl of the abstract class [BlocObserver]
  /// which is used to monitor the state changes throughout the app.
  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends HookWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...providers],
      child: OverlaySupport.global(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          onGenerateTitle: (context) => context.l10n.appName,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          supportedLocales: L10n.supportedLocales,
          localizationsDelegates: L10n.localizationsDelegates,
          home: const OnboardingView(),
        ),
      ),
    );
  }
}
