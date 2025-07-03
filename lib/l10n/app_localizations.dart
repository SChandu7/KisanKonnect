import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_kn.dart';
import 'app_localizations_mr.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_te.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('kn'),
    Locale('mr'),
    Locale('ta'),
    Locale('te'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Kisan Connect'**
  String get appTitle;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search crops, equipment, produce...'**
  String get searchHint;

  /// No description provided for @carouselTitle1.
  ///
  /// In en, this message translates to:
  /// **'Explore Our Crops'**
  String get carouselTitle1;

  /// No description provided for @carouselTitle2.
  ///
  /// In en, this message translates to:
  /// **'Top Quality Equipment'**
  String get carouselTitle2;

  /// No description provided for @carouselTitle3.
  ///
  /// In en, this message translates to:
  /// **'Fresh Produce Delivered'**
  String get carouselTitle3;

  /// No description provided for @exploreNow.
  ///
  /// In en, this message translates to:
  /// **'Explore Now'**
  String get exploreNow;

  /// No description provided for @contractFarmingTitle.
  ///
  /// In en, this message translates to:
  /// **'What is Contract Farming?'**
  String get contractFarmingTitle;

  /// No description provided for @contractFarmingDescription.
  ///
  /// In en, this message translates to:
  /// **'Contract farming is an agreement between farmers and buyers to produce specific crops at predetermined prices...'**
  String get contractFarmingDescription;

  /// No description provided for @exploreCategories.
  ///
  /// In en, this message translates to:
  /// **'Explore Categories'**
  String get exploreCategories;

  /// No description provided for @categoryCropsTitle.
  ///
  /// In en, this message translates to:
  /// **'Crops'**
  String get categoryCropsTitle;

  /// No description provided for @categoryCropsDesc.
  ///
  /// In en, this message translates to:
  /// **'Discover a variety of crops.'**
  String get categoryCropsDesc;

  /// No description provided for @categoryEquipmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Equipment'**
  String get categoryEquipmentTitle;

  /// No description provided for @categoryEquipmentDesc.
  ///
  /// In en, this message translates to:
  /// **'Find the best agricultural tools.'**
  String get categoryEquipmentDesc;

  /// No description provided for @categoryProduceTitle.
  ///
  /// In en, this message translates to:
  /// **'Fresh Produce'**
  String get categoryProduceTitle;

  /// No description provided for @categoryProduceDesc.
  ///
  /// In en, this message translates to:
  /// **'Order fresh fruits and vegetables.'**
  String get categoryProduceDesc;

  /// No description provided for @whatUsersSay.
  ///
  /// In en, this message translates to:
  /// **'What Our Users Say'**
  String get whatUsersSay;

  /// No description provided for @testimonial1.
  ///
  /// In en, this message translates to:
  /// **'Kisan Connect has revolutionized my farming experience!'**
  String get testimonial1;

  /// No description provided for @testimonial1Author.
  ///
  /// In en, this message translates to:
  /// **'Ramanaiah, Farmer'**
  String get testimonial1Author;

  /// No description provided for @testimonial2.
  ///
  /// In en, this message translates to:
  /// **'I can easily order fresh produce online. Highly recommend!'**
  String get testimonial2;

  /// No description provided for @testimonial2Author.
  ///
  /// In en, this message translates to:
  /// **'Sanjay, Customer'**
  String get testimonial2Author;

  /// No description provided for @testimonial3.
  ///
  /// In en, this message translates to:
  /// **'The support from Kisan Connect is exceptional!'**
  String get testimonial3;

  /// No description provided for @testimonial3Author.
  ///
  /// In en, this message translates to:
  /// **'Suresh Patel, Farmer'**
  String get testimonial3Author;

  /// No description provided for @footerCopyright.
  ///
  /// In en, this message translates to:
  /// **'© 2025 Kisan Connect. All rights reserved.'**
  String get footerCopyright;

  /// No description provided for @drawerProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get drawerProfile;

  /// No description provided for @drawerHelp.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get drawerHelp;

  /// No description provided for @drawerQuery.
  ///
  /// In en, this message translates to:
  /// **'Raise Query'**
  String get drawerQuery;

  /// No description provided for @drawerSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get drawerSettings;

  /// No description provided for @popupLogin.
  ///
  /// In en, this message translates to:
  /// **'Log-in'**
  String get popupLogin;

  /// No description provided for @popupFarmer.
  ///
  /// In en, this message translates to:
  /// **'Farmer'**
  String get popupFarmer;

  /// No description provided for @popupBuyer.
  ///
  /// In en, this message translates to:
  /// **'Buyer'**
  String get popupBuyer;

  /// No description provided for @popupLogout.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get popupLogout;

  /// No description provided for @popupHelp.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get popupHelp;

  /// No description provided for @logoutSuccess.
  ///
  /// In en, this message translates to:
  /// **'Logout succesfully ....'**
  String get logoutSuccess;

  /// No description provided for @helpSelected.
  ///
  /// In en, this message translates to:
  /// **'Help selected....'**
  String get helpSelected;

  /// No description provided for @voiceAssistantGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hi, how can I assist you?'**
  String get voiceAssistantGreeting;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'en',
    'hi',
    'kn',
    'mr',
    'ta',
    'te',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'kn':
      return AppLocalizationsKn();
    case 'mr':
      return AppLocalizationsMr();
    case 'ta':
      return AppLocalizationsTa();
    case 'te':
      return AppLocalizationsTe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
