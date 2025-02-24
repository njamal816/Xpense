import 'package:budget/database/tables.dart';
import 'package:budget/functions.dart';
import 'package:budget/pages/activityPage.dart';
import 'package:budget/pages/addCategoryPage.dart';
import 'package:budget/pages/creditDebtTransactionsPage.dart';
import 'package:budget/pages/editCategoriesPage.dart';
import 'package:budget/pages/editHomePage.dart';
import 'package:budget/pages/objectivesListPage.dart';
import 'package:budget/pages/settingsPage.dart';
import 'package:budget/pages/walletDetailsPage.dart';
import 'package:budget/struct/settings.dart';
import 'package:budget/widgets/navigationFramework.dart';
import 'package:budget/widgets/openBottomSheet.dart';
import 'package:budget/widgets/framework/popupFramework.dart';
import 'package:budget/widgets/openPopup.dart';
import 'package:budget/widgets/outlinedButtonStacked.dart';
import 'package:budget/widgets/textWidgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'listItem.dart';

// Device legend
// Apple rejected app update because Android was referenced... We use code names now!
// (i) = iOS
// (A) = Android

String getChangelogString() {
  return """
    < 1.0.6
    When All Spending page opened from other means, correct date range applied
    Improve performance of heatmap homepage section
    Adjust popup heights and fix emoji category selection
    Allow pattern unlock instead of just biometrics
    New color picker
    Preview when selecting background color for icons
    When budget/loan/objective archived, it is unpinned
    Add amount of times a transaction will repeat with a set end date
    Heatmap homepage section first weekday setting
    Fix heatmap missing blank days
    Improve performance when switching the primary account if the currency remains unchanged
    Consistent capitalization throughout interface
    Update translations and fix incorrect country specific language loading
    SDK upgrades; stability and performance improvements
    
    First navigation tab can be customized
    Revamped About App page
    FAQ, Tips, and Guide website link on More page
    App animations setting (improve app performance if animations are disabled)
    Custom color picker now prefills with correct selected color
    Long pressing duplicate transaction button creates a duplicate at the current date and time
    Optimized duplicating multiple transactions
    Added haptic feedback setting to number pad
    Currency picker performance improvements
    Improve performance for line graphs
    Include year in add transaction date if not the current year
    Edit username and toggle greeting message for top homepage banner
    Fix translation for All Spending history period
    Fix local backups not saving app settings
    Fix CSV export for entries with a comma
    Fixed app link routing for (A) 12+
    Fix possibility to add blank title when editing a category
    Fix saving category when adding title
    Improve list performance if minimal app animations selected
    Fix lists sometimes not updating changes
    
    Revamped scheduled transactions page: see an extrapolated total average per month or year
    Transaction activity log page: see recently deleted/modified transactions
    Copy transaction details to clipboard by tapping/long pressing transaction count in selected transactions app bar
    Ability to expand category spending goals in a budget even if there is no spending on that category
    Centered bottom navigation bar labels
    Improve biometric lock workflow and biometric unlock error
    Collapsible section for upcoming transactions will appear when 3 or more instead of 5
    Increased decimal precision limit to 12
    New deep link parameters (A)
    Deep links prioritize exact name for categories before applying a search (A)
    Added info point about next repetitive transaction will be generated after current marked as paid 
    Titles with the same category and name are automatically deleted
    Manual adding/editing of associated title can be configured to subcategory
    Add hint text about editing homepage sections
    Fix associated titles order priority when recommending title
    Fix upcoming transactions not marked as paid when notification activated
    Fix if decimal precision limit empty when entering amount, default to 2 instead of 0
    Fix unpaid balance correction when 'no color' had incorrect representation
    Fix adding attachment in initial add transaction steps
    Fix biometric bypass on error - now only bypass if app first launched from restored backup
    Improvements to colors and contrast
    Updated translations
   
    Collapsible future transactions list section (if more than 3 transactions in the future)
    Number pad format setting
    Account selection for homepage pie chart section
    Improved income/expense only selection in homepage pie chart
    Added ability to change only income/expense in homepage transaction list
    Long press transaction list tabs on homepage to edit settings for transactions list
    Homepage transaction list tab income/expense filters are properly applied to the homepage graph
    Collapse wallet list selection if all wallets selected when editing homepage section
    Improved home screen widgets (A)
    Max lines for filter title contains and note contains input
    Optimized and improved performance of transaction list actions
    Collapsed future transaction list shows amount selected when collapsed
    Importing CSV preview parsed custom date format
    Enter amount beginning with negative sign
    Tap amount on range filter to specify exact upper and lower range
    Add extra spacing between edit home page alignment headers (when in full screen)
    Add elevation shadow to scroll to top and bottom FAB
    Rearrange number format settings in popup for consistency
    Add time to date info when deleting cloud backup
    Number of transactions includes unpaid transactions
    Balance correction amount color category setting
    Account spending detail page follows account colorscheme
    Improve colorscheme for budget and goal pages
    Border radius UI and color consistencies
    Translation updates
    Fix font setting always resetting (i)
    Fix exclude amount from budget default value for include amount overall would be incorrect
    Fix (i) biometric lock bypass
    Fix net total date banner initial net total when time period set to all time
    Fix All Spending page swipe to dismiss color when in full screen
    
    New edit selected transactions popup
    Edit title for all selected transactions
    All time date range in search transaction page
    Search multiple title names by separating 'title contains' filter input with a comma
    Homepage transaction list setting - amount of days ahead to list transactions
    When editing goals/loans list, the total amount is listed for each entry
    Removed ability to enter decimal when setting certain values
    Refactor floating action button
    Auto-fill transaction titles in title inputs
    Swipe down to sync on widescreen layout
    Amount polarity for upcoming and overdue transaction totals
    Bill splitter generate loan transaction steps improved - custom date, title recommendations, select subcategory
    Prevent save changes button hide when keyboard opened
    Deep linking API (A): Automatically add multiple transactions per link using JSON (view [About] page for information)
    When importing CSV, if subcategory exists with the CSV entry category name, subcategory will be used
    Improved UI layouts and icons for clarity
    Added full black dark mode for Material You theme (A)
    Increased contrast of selected subcategory chip in add transaction page
    Fix padding for spending graph and space for side labels
    Fix when back swiping, swipe to dismiss is properly cancelled
    
    New account spending summary table
    Improved navigation to respective pages when filters/date ranges set in spending summary table
    Improved custom number format
    Added complete editing text action button in add transaction page
    Fix date range filters for account graph
    Fix line graph double currency icon in label
    Fix currency exchange icons
    Translation updates
    
    Revamped homepage pie chart section
    Custom number format support
    Searching date in search bar shows transactions from that time period
    Date range included when applying filters on transaction search page
    In transaction search page, added ability to jump to the bottom of the list
    Scroll to bottom/top does not animate if list too long
    Excluded budget transactions still show up in the budget list as excluded
    Select all option when selecting transactions
    Long pressing home page tab allows for edit home page
    Number animation setting
    Edit primary wallet currency setting for clarity, even though you can edit the account directly
    Default account labelled in edit accounts page
    Goals now show amount spent above total, if goal total type set to Total Amount
    Short number format setting
    Months list in transaction page cannot be scrolled past the earliest and latest transaction entered date
    Added all outgoing/incoming or just expense/income transactions setting for homepage pie chart
    Added color outlines to transaction filters
    Optimized onboarding page
    When loading backup, backup file name is displayed
    Fix reset the paid state when changing transaction types
    Fix cash flow filters when entering search page from positive/negative cashflow
    Fix polarity of lent and borrowed home screen sections
    Fix decimal precision save changes button for account edits
    Fix clipping of goal tag progress
    Fix default long term loan type when adding via plus button
    
    Improved UI layout when creating a goal/long term loan
    Long term loan offset (useful for adding interest to long term loan totals)
    Deep linking API (A): Automate the adding of transactions using app URL links (view [About] page for information)
    Fix color picker initial color value
    Fix importing of backup and CSV files (A)
    Fix widget launching add transaction route twice
    Fix account list name alignment
    Fix widget action launch timeout on first launch
    Fix adding transaction from subscription/upcoming page defaults to unpaid
    Fix archived long term loan amounts no longer count towards total summary
    Fix long term loan total amounts and collect/settle amounts per day

    Fix currency rates API
    File attachment in-app image preview
    File attachments use device date time instead of UTC
    Custom tab pages, can tap the active tab again to scroll to top
    Most repeated transactions list only show if are of normal transaction type
    Disabled automatic home page section enable when adding first budget/goal
    Remove delete button from app bar for long term loans
    Consistent padding alignment for date picker
    UI alignment fixes
    Border radius tweaks (i)

    Exclude transaction from counting towards reports and totals (in more options)
    Percentage decimal precision setting (in Settings > More Options > Formatting)
    Graph axis label supports locale and short form for > 1,000
    Fixed text focus resume for inactive app
    If accounts all have same currency, currency label is removed in select chips
    Unfocus and remove focus node from cache when navigating
    Fixed confetti canvas size for completed loans/goals
    Removed selectable accent colors that don't change the app theme
 
    Transfer transactions always ordered with transfer out (negative amount) listed first
    Removed last word title autocomplete predictions
    Capitalization inherits from auto completed titles
    Auto refocus only if focus was not lost
    Changed homepage add button icons and added labels
    Added percentage label to widget opacity slider (A)
    Decimal precision icon change and description
    Prevent transfers between same account
    Transfer button hidden if only one account
    When tapping support, Xpense Pro options highlight
    Fixed demo goals amount
    Enabled merging an account from primary account, primary account is changed instead of deleted
    Biometric unavailable popup only shows if lock was once enabled

    If rounded to 0% but not exactly 0%, < 1% is used instead
    Improved help text in view calendar
    Widget automatically updates when settings changed (A)
    Removed ability to select accounts when only one account for net total settings
    Tapping an upcoming transaction opens overdue tab
    Currency total includes percentage
    Long press transaction type when adding transaction opens info popup
    Long press budget options when adding budget opens info popup
    Long press goal/long term loan amount to copy total to clipboard
    Consistent popup enter text confirmation buttons and spacing
    Set date time button when initially adding a transaction
    Warning text color in sidebar when synced more than 1 day ago
    Titles auto complete with partial titles
    If import CSV import fails, use template recommendation shows
    Fixed percentage spent per currency to take exchange rate into account 
    All spending page filter icon when scrolled past bottom
    No transactions found on long term loans page if all deleted
    When adding an account, defaults to device currency
    When restoring a backup, sync operations are cancelled
    If biometrics unavailable on a device, they are disabled
    Optimized fix out of order elements when data page opened
    Search requests focus automatically
    Keyboard focus resumes on app refocus from recent apps
 
    Reorder theme mode settings, system is always first
    If multiple accounts with different currencies, can enable currency total summary in accounts list homepage widget
    Widget light and dark mode (A)
    Widget background opacity (A)
    More category icons
    Fixed sidebar clock not displaying time in 24 hour mode
    Date and time picker follows set color theme type 
    Fixed associated titles join
    Fixed partially collected loan filled in amount not collecting
    Archived items have opacity in selection list
    
    Significantly improved associated title searching
    Search category and subcategory when entering title
    Search categories on edit categories page includes searching subcategories
    12/24 hour clock format setting
    Custom currency for transfers (tap the transfer amount to change the currency to another existing account's currency)
    When full screen, moved notifications to settings page
    After clearing title/note filter, the filter will be removed
    If no room in long term loan or goal total, extra information hidden
    Fixed initial touch unfocus when entering transaction search page
    
    Overspent/over saved text for budgets displays amount total information of the current period
    Fixed rerender lag when opening transaction on search page
    Extra zeroes button new number layout
    Fixed spacing for bottom titles of line graph
    Fixed small separation between amount input buttons
    Translation fixes
    Fix multiple transaction saving events
    Fix delete account action in account picker for transaction

    Fixed padding for full screen devices
    Fixed title searching with category name when adding a transaction (title has priority)
    Fixed wallet details page swipe to dismiss header
    Installment payment setup button follows objective colorscheme
    Hex color picker fixes
    Removed ability to long press and set custom period for loan totals on all spending page that always show all time
    Removed bill splitter deleting item on edit page
    Fixed CSV import error always opening

    You can read the changelog in the About page.

    All past changes will go here, to prevent clutter.
end""";
}

// If they were not already seen by a user, they are shown at the top of the changelog
Map<String, List<MajorChanges>> getMajorChanges() {
  return {
    "< 4.4.1": [
      MajorChanges(
        "major-change-1".tr(),
        Icons.arrow_drop_up_rounded,
        info: [
          "major-change-1-1".tr(),
        ],
      ),
      MajorChanges(
        "major-change-2".tr(),
        Icons.category_rounded,
        info: [
          "major-change-2-1".tr(),
        ],
      ),
      MajorChanges(
        "major-change-3".tr(),
        Icons.savings_rounded,
        info: [
          "major-change-3-1".tr(),
          "major-change-3-2".tr(),
        ],
        onTap: (context) {
          pushRoute(context, ObjectivesListPage(backButton: true));
        },
      ),
      MajorChanges(
        "major-change-4".tr(),
        Icons.home_rounded,
        info: [
          "major-change-4-1".tr(),
          "major-change-4-2".tr(),
        ],
        onTap: (context) {
          pushRoute(context, EditHomePage());
        },
      ),
      MajorChanges(
        "major-change-5".tr(),
        Icons.emoji_emotions_rounded,
        info: [
          "major-change-5-1".tr(),
        ],
        onTap: (context) {
          pushRoute(context, EditCategoriesPage());
        },
      ),
      // MajorChanges(
      //   "major-change-6".tr(),
      //   Icons.bug_report_rounded,
      //   info: [
      //     "major-change-6-1".tr(),
      //   ],
      // ),
    ],
    "< 4.4.6": [
      MajorChanges(
        "major-change-7".tr(),
        Icons.timelapse_rounded,
        info: [
          "major-change-7-1".tr(),
        ],
        onTap: (context) {
          pushRoute(context, WalletDetailsPage(wallet: null));
        },
      ),
      MajorChanges(
        "major-change-8".tr(),
        Icons.price_change_rounded,
      ),
    ],
    "< 4.5.1": [
      MajorChanges(
        "major-change-9".tr(),
        Icons.file_open_rounded,
        info: [
          "major-change-9-1".tr(),
        ],
        onTap: (context) {
          pushRoute(context, SettingsPageFramework());
        },
      ),
      MajorChanges(
        "major-change-10".tr(),
        Icons.edit_rounded,
        info: [
          "major-change-10-1".tr(),
        ],
        onTap: (context) {
          pushRoute(context, EditHomePage());
        },
      ),
    ],
    "< 4.6.6": [
      MajorChanges(
        "major-change-11".tr(),
        Icons.category_rounded,
        info: [
          "major-change-11-1".tr(),
        ],
        onTap: (context) {
          pushRoute(
            context,
            AddCategoryPage(
              routesToPopAfterDelete: RoutesToPopAfterDelete.None,
            ),
          );
        },
      ),
      MajorChanges(
        "major-change-12".tr(),
        Icons.list_rounded,
        info: [
          "major-change-12-1".tr(),
        ],
        onTap: (context) {
          pushRoute(context, EditHomePage());
        },
      ),
      MajorChanges(
        "major-change-6".tr(),
        Icons.bug_report_rounded,
        info: [
          "major-change-6-1".tr(),
        ],
      ),
    ],
    "< 4.7.9": [
      MajorChanges(
        "major-change-14".tr(),
        Icons.attach_file_rounded,
        info: [
          "major-change-14-1".tr(),
        ],
      ),
    ],
    "< 4.8.8": [
      MajorChanges(
        "major-change-15".tr(),
        Icons.add_box_rounded,
        info: [
          "major-change-15-1".tr(),
        ],
        onTap: (context) {
          openBottomSheet(
            context,
            PopupFramework(
              child: AddMoreThingsPopup(),
            ),
          );
        },
      ),
    ],
    "< 4.8.9": [
      MajorChanges(
        "major-change-16".tr(),
        Icons.receipt_long_rounded,
        info: [
          "major-change-16-1".tr(),
        ],
        onTap: (context) {
          pushRoute(context, WalletDetailsPage(wallet: null));
        },
      ),
    ],
    "< 5.0.3": [
      MajorChanges(
        "major-change-17".tr(),
        Icons.av_timer_rounded,
        info: [
          "major-change-17-1".tr(),
        ],
        onTap: (context) {
          pushRoute(
            context,
            CreditDebtTransactions(
              isCredit: null,
            ),
          );
        },
      ),
    ],
    "< 5.3.0": [
      MajorChanges(
        "major-change-18".tr(),
        Icons.ballot_rounded,
        info: [
          "major-change-18-1".tr(),
        ],
        onTap: (context) {
          pushRoute(
            context,
            ActivityPage(),
          );
        },
      ),
    ],
  };
}

bool showChangelog(
  BuildContext context, {
  bool forceShow = false,
  bool majorChangesOnly = false,
  Widget? extraWidget,
}) {
  String version = packageInfoGlobal?.version ?? "";

  List<Widget>? changelogPoints = getChangelogPointsWidgets(
    context,
    forceShow: forceShow,
    majorChangesOnly:
        Localizations.localeOf(context).toString().toLowerCase() != "en"
            ? true
            : majorChangesOnly,
  );

  updateSettings(
    "lastLoginVersion",
    version,
    pagesNeedingRefresh: [],
    updateGlobalState: false,
  );

  //Don't show changelog on first login and only show if english, unless forced
  if (changelogPoints != null &&
      changelogPoints.length > 0 &&
      (forceShow ||
          (appStateSettings["numLogins"] > 1
          //   &&  Localizations.localeOf(context).toString().toLowerCase() == "en"
          ))) {
    openBottomSheet(
      context,
      PopupFramework(
        title: "changelog".tr(),
        subtitle: getVersionString(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [(extraWidget ?? SizedBox.shrink()), ...changelogPoints],
        ),
        showCloseButton: true,
      ),
      showScrollbar: true,
    );
    return true;
  }
  return false;
}

List<Widget>? getChangelogPointsWidgets(BuildContext context,
    {bool forceShow = false, bool majorChangesOnly = false}) {
  String changelog = getChangelogString();
  Map<String, List<MajorChanges>> majorChanges = getMajorChanges();
  String version = packageInfoGlobal?.version ?? "";
  int versionInt = parseVersionInt(version);
  int lastLoginVersionInt =
      parseVersionInt(appStateSettings["lastLoginVersion"]);

  if (forceShow || lastLoginVersionInt != versionInt) {
    List<Widget> changelogPoints = [];
    List<Widget> majorChangelogPointsAtTop = [];

    int versionBookmark = versionInt;
    for (String string in changelog.split("\n")) {
      string = string.replaceFirst("    ", ""); // remove the indent

      // Skip android changes on iOS, skip iOS changes on Android
      if (getPlatform() == PlatformOS.isIOS && string.contains(("(A)"))) {
        continue;
      } else if (getPlatform() == PlatformOS.isAndroid &&
          string.contains(("(i)"))) {
        continue;
      }
      string = string.replaceAll("(A)", "Android");
      string = string.replaceAll("(i)", "iOS");

      if (string.startsWith("< ")) {
        if (forceShow) {
          changelogPoints.addAll(getAllMajorChangeWidgetsForVersion(
                  context, string, majorChanges) ??
              []);
        }

        versionBookmark = parseVersionInt(string.replaceAll("< ", ""));
        if (forceShow == false && versionBookmark <= lastLoginVersionInt) {
          continue;
        }

        majorChangelogPointsAtTop.addAll(
            getAllMajorChangeWidgetsForVersion(context, string, majorChanges) ??
                []);

        if (majorChangesOnly == true) {
          continue;
        }

        changelogPoints.add(Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 5, top: 3),
          child: TextFont(
            text: string.replaceAll("< ", ""),
            fontSize: 25,
            maxLines: 10,
            fontWeight: FontWeight.bold,
          ),
        ));
        continue;
      }

      if (majorChangesOnly == true) {
        continue;
      }

      if (forceShow == false && versionBookmark <= lastLoginVersionInt) {
        continue;
      }

      if (string.trim() == "") {
        // this is an empty line
        changelogPoints.add(SizedBox(
          height: 8,
        ));
      } else if (string.trim() != "end") {
        changelogPoints.add(Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 5.5),
          child: TextFont(
            text: string,
            fontSize: 16.5,
            maxLines: 5,
          ),
        ));
      }
    }
    if (changelogPoints.length > 0)
      changelogPoints.add(
        SizedBox(height: 10),
      );

    if (!forceShow) changelogPoints.insertAll(0, majorChangelogPointsAtTop);
    return changelogPoints;
  }
  return null;
}

int parseVersionInt(String versionString) {
  try {
    int parsedVersion = int.parse(versionString.replaceAll(".", ""));
    return parsedVersion;
  } catch (e) {
    print("Error parsing version number, defaulting to version 0.");
  }
  return 0;
}

String getVersionString() {
  String version = packageInfoGlobal?.version ?? "";
  String buildNumber = packageInfoGlobal?.buildNumber ?? "";
  return "v" +
      version;
}

class MajorChanges {
  MajorChanges(this.title, this.icon, {this.info, this.onTap});

  String title;
  IconData icon;
  List<String>? info;
  Function(BuildContext context)? onTap;
}

List<Widget>? getAllMajorChangeWidgetsForVersion(BuildContext context,
    String version, Map<String, List<MajorChanges>> majorChanges) {
  if (majorChanges[version] == null) return null;
  return [
    SizedBox(height: 5),
    for (MajorChanges majorChange in (majorChanges[version] ?? []))
      Padding(
        padding: const EdgeInsetsDirectional.only(
          bottom: 5,
          top: 5,
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButtonStacked(
                filled: false,
                alignStart: true,
                alignBeside: true,
                padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 20, vertical: 20),
                text: majorChange.title.tr(),
                iconData: majorChange.icon,
                onTap: majorChange.onTap == null
                    ? null
                    : () => majorChange.onTap!(context),
                afterWidget: majorChange.info == null
                    ? null
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (String info in majorChange.info ?? [])
                            ListItem(
                              info.tr(),
                            ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    SizedBox(height: 10),
  ];
}
