import 'dart:math';
import 'package:budget/functions.dart';
import 'package:budget/main.dart';
import 'package:budget/pages/accountsPage.dart';
import 'package:budget/pages/addTransactionPage.dart';
import 'package:budget/pages/debugPage.dart';
import 'package:budget/pages/detailedChangelogPage.dart';
import 'package:budget/pages/onBoardingPage.dart';
import 'package:budget/struct/databaseGlobal.dart';
import 'package:budget/struct/languageMap.dart';
import 'package:budget/struct/settings.dart';
import 'package:budget/widgets/button.dart';
import 'package:budget/widgets/framework/popupFramework.dart';
import 'package:budget/widgets/moreIcons.dart';
import 'package:budget/widgets/navigationSidebar.dart';
import 'package:budget/widgets/openBottomSheet.dart';
import 'package:budget/widgets/openPopup.dart';
import 'package:budget/widgets/framework/pageFramework.dart';
import 'package:budget/widgets/ratingPopup.dart';
import 'package:budget/widgets/showChangelog.dart';
import 'package:budget/widgets/tappable.dart';
import 'package:budget/widgets/textWidgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:budget/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    bool fullScreenLayout = enableDoubleColumn(context);
    Color containerColor = appStateSettings["materialYou"]
        ? dynamicPastel(
        context, Theme.of(context).colorScheme.secondaryContainer,
        amountLight: 0.2, amountDark: 0.6)
        : getColor(context, "lightDarkAccent");

    Widget cashewInformation = Wrap(
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: [
        Image(
          image: AssetImage("assets/icon/icon-small.png"),
          height: 70,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Tappable(
              borderRadius: getPlatform() == PlatformOS.isIOS ? 10 : 15,
              onLongPress: () {
                if (allowDebugFlags)
                  pushRoute(
                    context,
                    DebugPage(),
                  );
              },
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                    vertical: 3, horizontal: 10),
                child: TextFont(
                  text: globalAppName,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                  vertical: 0, horizontal: 10),
              child: TextFont(
                text: getVersionString(),
                fontSize: 14,
                textAlign: TextAlign.center,
                maxLines: 5,
              ),
            ),
          ],
        )
      ],
    );

    List<Widget> developmentTeam = [
      Padding(
        padding:
        const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 7),
      ),
    ];

    List<Widget> graphics = [

    ];

    List<Widget> majorTools = [

    ];

    List<Widget> translators = [

    ];

    return PageFramework(
      dragDownToDismiss: true,
      title: "about".tr(),
      getExtraHorizontalPadding: (context) {
        double maxWidth = 900;
        double widthOfScreen = MediaQuery.sizeOf(context).width -
            getWidthNavigationSidebar(context);
        return enableDoubleColumn(context)
            ? max(0, (widthOfScreen - maxWidth) / 2)
            : getHorizontalPaddingConstrained(context);
      },
      sliversBefore: false,
      slivers: [

        SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
      listWidgets: fullScreenLayout
          ? [

        HorizontalBreak(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 10, vertical: 20)),
        Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 7.5),
          child: SpreadExpandFlex(majorTools: majorTools, maxPerRow: 3),
        ),
        HorizontalBreak(
          padding: EdgeInsetsDirectional.only(
              start: 10, end: 10, top: 25, bottom: 10),
        ),
      ]
          : [
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 15, vertical: 7),
          child: cashewInformation,
        ),
        SizedBox(height: 5),
        AboutLinks(containerColor: containerColor),
        SizedBox(height: 10),
        HorizontalBreak(),
        SizedBox(height: 10),
        ...developmentTeam,
        SizedBox(height: 5),
        if (getPlatform(ignoreEmulation: true) == PlatformOS.isAndroid ||
            kIsWeb)
          Padding(
            padding:
            const EdgeInsetsDirectional.only(top: 10, bottom: 10),
            child: HorizontalBreakAbove(
                child: Column(
                  children: [
                  ],
                )),
          ),
      ],
    );
  }
}

class SpreadExpandFlex extends StatelessWidget {
  final List<Widget> majorTools;
  final int maxPerRow;

  SpreadExpandFlex({required this.majorTools, this.maxPerRow = 3});

  @override
  Widget build(BuildContext context) {
    List<Row> rows = [];
    List<Widget> currentRow = [];

    for (int i = 0; i < majorTools.length; i++) {
      currentRow.add(Expanded(child: majorTools[i]));

      // If the current row is full or it's the last widget, add the row to the rows list
      if ((i + 1) % maxPerRow == 0 || i == majorTools.length - 1) {
        rows.add(Row(
          children: currentRow,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ));
        currentRow = [];
      }
    }

    return Column(
      children: rows,
    );
  }
}

void showChangelogForce(BuildContext context) {
  showChangelog(
    context,
    forceShow: true,
    majorChangesOnly: true,
    extraWidget: Padding(
      padding: const EdgeInsetsDirectional.only(
        bottom: 10,
      ),
      child: Button(
        label: "view-detailed-changelog".tr(),
        onTap: () {
          popRoute(context);
          pushRoute(context, DetailedChangelogPage());
        },
      ),
    ),
  );
}

void openOnBoarding(BuildContext context) {
  pushRoute(
    context,
    OnBoardingPage(
      popNavigationWhenDone: true,
      showPreviewDemoButton: false,
    ),
  );
}

void openLicensesPage(BuildContext context) {
  showLicensePage(
      context: context,
      applicationVersion: getVersionString(),
      applicationLegalese:
      "" +
          "\n\n" +
          "exchange-rate-notice-description".tr());
}

void deleteAllDataFlow(BuildContext context) {
  openPopup(
    context,
    title: "erase-everything".tr(),
    description: "erase-everything-description".tr(),
    icon: appStateSettings["outlinedIcons"]
        ? Icons.warning_outlined
        : Icons.warning_rounded,
    onExtraLabel2: "erase-synced-data-and-cloud-backups".tr(),
    onExtra2: () {
      popRoute(context);
      openBottomSheet(
        context,
        PopupFramework(
          title: "erase-cloud-data".tr(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  bottom: 18,
                  start: 5,
                  end: 5,
                ),
                child: TextFont(
                  text: "erase-cloud-data-description".tr(),
                  fontSize: 16.5,
                  textAlign: TextAlign.center,
                  maxLines: 10,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: SyncCloudBackupButton(
                      onTap: () async {
                        popRoute(context);
                        pushRoute(context, AccountsPage());
                      },
                    ),
                  ),
                  SizedBox(width: 18),
                  Expanded(
                    child: BackupsCloudBackupButton(
                      onTap: () async {
                        popRoute(context);
                        pushRoute(context, AccountsPage());
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
    onSubmit: () async {
      popRoute(context);
      openPopup(
        context,
        title: "erase-everything-warning".tr(),
        description: "erase-everything-warning-description".tr(),
        icon: appStateSettings["outlinedIcons"]
            ? Icons.warning_amber_outlined
            : Icons.warning_amber_rounded,
        onSubmit: () async {
          popRoute(context);
          clearDatabase(context);
        },
        onSubmitLabel: "erase".tr(),
        onCancelLabel: "cancel".tr(),
        onCancel: () {
          popRoute(context);
        },
      );
    },
    onSubmitLabel: "erase".tr(),
    onCancelLabel: "cancel".tr(),
    onCancel: () {
      popRoute(context);
    },
  );
}

class AboutLinks extends StatelessWidget {
  const AboutLinks({required this.containerColor, Key? key}) : super(key: key);
  final Color containerColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          getPlatform() == PlatformOS.isIOS ? 10 : 15,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTappable(
              context: context,
              isExternalLink: true,
              onTap: () => openUrl("https://xpensly.adamapps.in/policy.html"),
              icon: MoreIcons.chart_pie,
              text: "app-is-open-source".tr(namedArgs: {"app": globalAppName}),
            ),
            const HorizontalBreak(padding: EdgeInsetsDirectional.zero),
            _buildTappable(
              context: context,
              isExternalLink: true,
              onTap: () => openUrl("https://xpensly.adamapps.in/faq.html"),
              icon: appStateSettings["outlinedIcons"]
                  ? Icons.live_help_outlined
                  : Icons.live_help_rounded,
              text: "guide-and-faq".tr(),
            ),
            const HorizontalBreak(padding: EdgeInsetsDirectional.zero),
            _buildTappable(
              context: context,
              isExternalLink: false,
              onTap: () =>
                  openBottomSheet(context, RatingPopup(), fullSnap: true),
              icon: appStateSettings["outlinedIcons"]
                  ? Icons.rate_review_outlined
                  : Icons.rate_review_rounded,
              text: "feedback".tr(),
            ),
            const HorizontalBreak(padding: EdgeInsetsDirectional.zero),
            _buildTappable(
              context: context,
              isExternalLink: false,
              onTap: () => openOnBoarding(context),
              icon: appStateSettings["outlinedIcons"]
                  ? Icons.door_front_door_outlined
                  : Icons.door_front_door_rounded,
              text: "view-app-intro".tr(),
            ),
            const HorizontalBreak(padding: EdgeInsetsDirectional.zero),
            _buildTappable(
              context: context,
              isExternalLink: true,
              onTap: () => openUrl("http://xpensly.adamapps.in/policy.html"),
              icon: appStateSettings["outlinedIcons"]
                  ? Icons.policy_outlined
                  : Icons.policy_rounded,
              text: "privacy-policy".tr(),
            ),
            const HorizontalBreak(padding: EdgeInsetsDirectional.zero),
            _buildTappable(
              context: context,
              isExternalLink: false,
              onTap: () => openLicensesPage(context),
              icon: appStateSettings["outlinedIcons"]
                  ? Icons.account_balance_outlined
                  : Icons.account_balance_rounded,
              text: "view-licenses-and-legalese".tr(),
            ),
            const HorizontalBreak(padding: EdgeInsetsDirectional.zero),
            _buildTappable(
              context: context,
              isExternalLink: false,
              onTap: () => deleteAllDataFlow(context),
              icon: appStateSettings["outlinedIcons"]
                  ? Icons.delete_sweep_outlined
                  : Icons.delete_sweep_rounded,
              text: "delete-all-data".tr(),
              color: Colors.red.withOpacity(0.4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTappable(
      {required BuildContext context,
        required VoidCallback onTap,
        required IconData icon,
        required String text,
        required bool isExternalLink,
        Color? color}) {
    return Tappable(
      onTap: onTap,
      borderRadius: 0,
      color: color ?? containerColor,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
            start: 18, end: 18, top: 11, bottom: 11),
        child: Row(
          children: [
            Icon(
              icon,
              size: 25,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFont(
                text: text,
                fontSize: 17,
                maxLines: 5,
              ),
            ),
            Icon(
              isExternalLink
                  ? appStateSettings["outlinedIcons"]
                  ? Icons.open_in_new_outlined
                  : Icons.open_in_new_rounded
                  : appStateSettings["outlinedIcons"]
                  ? Icons.keyboard_arrow_right_outlined
                  : Icons.keyboard_arrow_right_rounded,
              size: 22,
              color: getColor(context, "black").withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutDeepLinking extends StatelessWidget {
  const AboutDeepLinking({super.key});

  @override
  Widget build(BuildContext context) {
    return AboutInfoBox(
      title: "deep-linking".tr(),
      showLink: false,
      link:
      "https://xpensly.adamapps.in",
      list: [
        "deep-linking-description".tr(),
      ],
    );
  }
}

// Note that this is different than forceDeleteDB()
Future clearDatabase(BuildContext context) async {
  openLoadingPopup(context);
  await Future.wait([database.deleteEverything(), sharedPreferences.clear()]);
  await database.close();
  popRoute(context);
  restartAppPopup(context);
}

class TranslationInfoBox extends StatelessWidget {
  const TranslationInfoBox({
    Key? key,
    required this.title,
    this.list,
  }) : super(key: key);

  final String title;
  final List<String>? list;

  @override
  Widget build(BuildContext context) {
    return AboutInfoBox(
      title: title,
      list: list,
      listTextColor: getColor(context, "black").withOpacity(0.5),
      padding: EdgeInsetsDirectional.symmetric(horizontal: 7.5, vertical: 5),
    );
  }
}

class AboutInfoBox extends StatelessWidget {
  const AboutInfoBox({
    Key? key,
    required this.title,
    this.link,
    this.list,
    this.color,
    this.listTextColor,
    this.padding,
    this.showLink = true,
  }) : super(key: key);

  final String title;
  final String? link;
  final List<String>? list;
  final Color? color;
  final Color? listTextColor;
  final EdgeInsetsGeometry? padding;
  final bool showLink;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 5),
      child: Tappable(
        onTap: () async {
          if (link != null) openUrl(link ?? "");
        },
        onLongPress: () {
          if (link != null) copyToClipboard(link ?? "");
        },
        color: color ??
            (appStateSettings["materialYou"]
                ? dynamicPastel(
                context, Theme.of(context).colorScheme.secondaryContainer,
                amountLight: 0.2, amountDark: 0.6)
                : getColor(context, "lightDarkAccent")),
        borderRadius: getPlatform() == PlatformOS.isIOS ? 10 : 15,
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 13, vertical: 15),
          child: Column(
            children: [
              TextFont(
                text: title,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
                maxLines: 5,
              ),
              SizedBox(height: 6),
              if (link != null && showLink)
                TextFont(
                  text: link ?? "",
                  fontSize: 14,
                  textAlign: TextAlign.center,
                  textColor: getColor(context, "textLight"),
                  maxLines: 1,
                ),
              for (String item in list ?? [])
                TextFont(
                  text: item,
                  fontSize: 14,
                  textAlign: TextAlign.center,
                  textColor: listTextColor ?? getColor(context, "textLight"),
                  maxLines: 10,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
