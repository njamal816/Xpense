import 'package:budget/functions.dart';
import 'package:budget/pages/accountsPage.dart';
import 'package:budget/pages/autoTransactionsPageEmail.dart';
import 'package:budget/struct/currencyFunctions.dart';
import 'package:budget/struct/iconObjects.dart';
import 'package:budget/struct/keyboardIntents.dart';
import 'package:budget/widgets/fadeIn.dart';
import 'package:budget/struct/languageMap.dart';
import 'package:budget/struct/initializeBiometrics.dart';
import 'package:budget/widgets/util/appLinks.dart';
import 'package:budget/widgets/util/onAppResume.dart';
import 'package:budget/widgets/util/watchForDayChange.dart';
import 'package:budget/widgets/watchAllWallets.dart';
import 'package:budget/database/tables.dart';
import 'package:budget/struct/databaseGlobal.dart';
import 'package:budget/struct/settings.dart';
import 'package:budget/struct/notificationsGlobal.dart';
import 'package:budget/widgets/navigationSidebar.dart';
import 'package:budget/widgets/globalLoadingProgress.dart';
import 'package:budget/struct/scrollBehaviorOverride.dart';
import 'package:budget/widgets/globalSnackbar.dart';
import 'package:budget/struct/initializeNotifications.dart';
import 'package:budget/widgets/navigationFramework.dart';
import 'package:budget/widgets/restartApp.dart';
import 'package:budget/struct/customDelayedCurve.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:budget/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_preview/device_preview.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';

bool enableDevicePreview = false && kDebugMode;
bool allowDebugFlags = true || kIsWeb;
bool allowDangerousDebugFlags = kDebugMode;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  database = await constructDb('db');
  notificationPayload = await initializeNotifications();
  entireAppLoaded = false;
  await loadCurrencyJSON();
  await loadLanguageNamesJSON();
  await initializeSettings();
  tz.initializeTimeZones();
  final String? locationName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(locationName ?? "America/New_York"));
  iconObjects.sort((a, b) => (a.mostLikelyCategoryName ?? a.icon)
      .compareTo((b.mostLikelyCategoryName ?? b.icon)));
  setHighRefreshRate();

  runApp(
    DevicePreview(
      enabled: enableDevicePreview,
      builder: (context) => InitializeLocalizations(
        child: RestartApp(
          child: InitializeApp(key: appStateKey),
        ),
      ),
    ),
  );
}

GlobalKey<_InitializeAppState> appStateKey = GlobalKey();
GlobalKey<PageNavigationFrameworkState> pageNavigationFrameworkKey =
GlobalKey();

class InitializeApp extends StatefulWidget {
  InitializeApp({Key? key}) : super(key: key);

  @override
  State<InitializeApp> createState() => _InitializeAppState();
}

class _InitializeAppState extends State<InitializeApp> {
  AppOpenAd? _appOpenAd;
  bool _isAdAvailable = false;
  bool _hasOnboarded = false;

  void refreshAppState() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    checkOnboardingStatus(); // This will handle ad loading
  }

  Future<void> checkOnboardingStatus() async {
    _hasOnboarded = appStateSettings["hasOnboarded"];

    print("Has Onboarded: $_hasOnboarded"); // Debugging output

    if (_hasOnboarded) {
      loadAppOpenAd(); // Only load ads if onboarding is completed
    }
  }

  void loadAppOpenAd() {
    AppOpenAd.load(
      adUnitId: 'ca-app-pub-2035149885634118/6175604106',
      request: AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          _isAdAvailable = true;
        },
        onAdFailedToLoad: (error) {
          print('App Open Ad failed to load: $error');
          _isAdAvailable = false;
        },
      ),
    );
  }

  void showAdIfAvailable() {
    if (_isAdAvailable && _appOpenAd != null && _hasOnboarded) {
      _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          loadAppOpenAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _isAdAvailable = false;
          loadAppOpenAd();
        },
      );
      _appOpenAd!.show();
      _appOpenAd = null;
      _isAdAvailable = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return App(
      key: ValueKey("Main App"),
      showAppOpenAd: showAdIfAvailable, // Pass function to App widget
    );
  }
}

class App extends StatelessWidget {
  final VoidCallback showAppOpenAd;
  const App({Key? key, required this.showAppOpenAd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Rebuilt Material App");
    return MaterialApp(
      showPerformanceOverlay: kProfileMode,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale:
      enableDevicePreview ? DevicePreview.locale(context) : context.locale,
      shortcuts: shortcuts,
      actions: keyboardIntents,
      themeAnimationDuration: Duration(milliseconds: 400),
      themeAnimationCurve: CustomDelayedCurve(),
      key: ValueKey('XpenslyAppMain'),
      title: 'Xpensly',
      theme: getLightTheme(),
      darkTheme: getDarkTheme(),
      scrollBehavior: ScrollBehaviorOverride(),
      themeMode: getSettingConstants(appStateSettings)["theme"],
      home: HandleWillPopScope(
        child: Stack(
          children: [
            Row(
              children: [
                NavigationSidebar(key: sidebarStateKey),
                Expanded(
                  child: Stack(
                    children: [
                      InitialPageRouteNavigator(),
                      GlobalSnackbar(key: snackbarKey),
                    ],
                  ),
                ),
              ],
            ),
            EnableSignInWithGoogleFlyIn(),
            GlobalLoadingIndeterminate(key: loadingIndeterminateKey),
            GlobalLoadingProgress(key: loadingProgressKey),
          ],
        ),
      ),
      builder: (context, child) {
        if (kReleaseMode) {
          ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
            return Container(color: Colors.transparent);
          };
        }

        Widget mainWidget = OnAppResume(
          updateGlobalAppLifecycleState: true,
          onAppResume: () async {
            await setHighRefreshRate();
            showAppOpenAd(); // Show Ad on Resume
          },
          child: InitializeBiometrics(
            child: InitializeNotificationService(
              child: InitializeAppLinks(
                child: WatchForDayChange(
                  child: WatchSelectedWalletPk(
                    child: WatchAllWallets(
                      child: child ?? SizedBox.shrink(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );

        if (kIsWeb) {
          return FadeIn(duration: Duration(milliseconds: 1000), child: mainWidget);
        } else {
          return mainWidget;
        }
      },
    );
  }
}
