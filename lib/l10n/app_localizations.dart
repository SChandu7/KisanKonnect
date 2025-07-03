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
  /// **'Kisan Connect has transformed my shopping experience. The quality of produce is exceptional!'**
  String get testimonial1;

  /// No description provided for @testimonial1Author.
  ///
  /// In en, this message translates to:
  /// **'— Prabhas, Buyer'**
  String get testimonial1Author;

  /// No description provided for @testimonial2.
  ///
  /// In en, this message translates to:
  /// **'I love the convenience of ordering fresh fruits and vegetables online. Highly recommend!'**
  String get testimonial2;

  /// No description provided for @testimonial2Author.
  ///
  /// In en, this message translates to:
  /// **'— Krishna Babu, Customer'**
  String get testimonial2Author;

  /// No description provided for @testimonial3.
  ///
  /// In en, this message translates to:
  /// **'The support from Kisan Connect has been invaluable. They truly care about customers!'**
  String get testimonial3;

  /// No description provided for @testimonial3Author.
  ///
  /// In en, this message translates to:
  /// **'— Jason Desabathula, Buyer'**
  String get testimonial3Author;

  /// No description provided for @footerCopyright.
  ///
  /// In en, this message translates to:
  /// **'© 2025 Kisan Connect. All rights reserved.'**
  String get footerCopyright;

  /// No description provided for @footerSupport.
  ///
  /// In en, this message translates to:
  /// **'Customer Support: 1800 267 0997 | Email: customercare@kisanconnect.in'**
  String get footerSupport;

  /// No description provided for @drawerProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get drawerProfile;

  /// No description provided for @drawerHelp.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get drawerHelp;

  /// No description provided for @drawerQuery.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
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

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Kisan Connect'**
  String get welcomeMessage;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Empowering Buyers with Quality Produce'**
  String get welcomeSubtitle;

  /// No description provided for @equipmentRentals.
  ///
  /// In en, this message translates to:
  /// **'Equipment Rentals'**
  String get equipmentRentals;

  /// No description provided for @marketTrends.
  ///
  /// In en, this message translates to:
  /// **'Market Trends'**
  String get marketTrends;

  /// No description provided for @weatherUpdates.
  ///
  /// In en, this message translates to:
  /// **'Weather Updates'**
  String get weatherUpdates;

  /// No description provided for @testimonialTitle.
  ///
  /// In en, this message translates to:
  /// **'Testimonials'**
  String get testimonialTitle;

  /// No description provided for @testimonial11.
  ///
  /// In en, this message translates to:
  /// **'Kisan Connect has transformed my farming experience. The quality of produce is exceptional!'**
  String get testimonial11;

  /// No description provided for @testimonial11Author.
  ///
  /// In en, this message translates to:
  /// **'— Rajesh Kumar, Farmer'**
  String get testimonial11Author;

  /// No description provided for @testimonial22.
  ///
  /// In en, this message translates to:
  /// **'I love the convenience of ordering fresh fruits and vegetables online. Highly recommend!'**
  String get testimonial22;

  /// No description provided for @testimonial22Author.
  ///
  /// In en, this message translates to:
  /// **'— Anita Sharma, Customer'**
  String get testimonial22Author;

  /// No description provided for @testimonial33.
  ///
  /// In en, this message translates to:
  /// **'The support from Kisan Connect has been invaluable. They truly care about farmers!'**
  String get testimonial33;

  /// No description provided for @testimonial33Author.
  ///
  /// In en, this message translates to:
  /// **'— Suresh Patel, Farmer'**
  String get testimonial33Author;

  /// No description provided for @agricultureTitle.
  ///
  /// In en, this message translates to:
  /// **'Agriculture Industry in India'**
  String get agricultureTitle;

  /// No description provided for @agricultureContent.
  ///
  /// In en, this message translates to:
  /// **'The Indian agriculture industry plays a critical role in the nation\'s economy...'**
  String get agricultureContent;

  /// No description provided for @importanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Importance of Agriculture'**
  String get importanceTitle;

  /// No description provided for @importanceContent.
  ///
  /// In en, this message translates to:
  /// **'Agriculture contributes significantly to GDP and supports various industries...'**
  String get importanceContent;

  /// No description provided for @challengesTitle.
  ///
  /// In en, this message translates to:
  /// **'Challenges Faced'**
  String get challengesTitle;

  /// No description provided for @challengesContent.
  ///
  /// In en, this message translates to:
  /// **'Challenges include climate change, water scarcity, and price fluctuations...'**
  String get challengesContent;

  /// No description provided for @fruitsButton.
  ///
  /// In en, this message translates to:
  /// **'Fruits'**
  String get fruitsButton;

  /// No description provided for @vegetablesButton.
  ///
  /// In en, this message translates to:
  /// **'Vegetables'**
  String get vegetablesButton;

  /// No description provided for @searchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search for a fruit or vegetable...'**
  String get searchPlaceholder;

  /// No description provided for @fruitsAndPrices.
  ///
  /// In en, this message translates to:
  /// **'Fruits and Their Prices'**
  String get fruitsAndPrices;

  /// No description provided for @vegetablesAndPrices.
  ///
  /// In en, this message translates to:
  /// **'Vegetables and Their Prices'**
  String get vegetablesAndPrices;

  /// No description provided for @tableName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get tableName;

  /// No description provided for @tablePrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get tablePrice;

  /// No description provided for @tableSeason.
  ///
  /// In en, this message translates to:
  /// **'Season'**
  String get tableSeason;

  /// No description provided for @tableBenefit.
  ///
  /// In en, this message translates to:
  /// **'Benefit'**
  String get tableBenefit;

  /// No description provided for @samplePriceTrends.
  ///
  /// In en, this message translates to:
  /// **'Price Trends (Sample)'**
  String get samplePriceTrends;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @trends.
  ///
  /// In en, this message translates to:
  /// **'Trends'**
  String get trends;

  /// No description provided for @weatherPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Kisan Connect'**
  String get weatherPageTitle;

  /// No description provided for @searchCropHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a crop...'**
  String get searchCropHint;

  /// No description provided for @currentWeatherTitle.
  ///
  /// In en, this message translates to:
  /// **'Current Weather Conditions'**
  String get currentWeatherTitle;

  /// No description provided for @seasonalForecastTitle.
  ///
  /// In en, this message translates to:
  /// **'Seasonal Forecast'**
  String get seasonalForecastTitle;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @temperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get temperature;

  /// No description provided for @humidity.
  ///
  /// In en, this message translates to:
  /// **'Humidity'**
  String get humidity;

  /// No description provided for @rainfall.
  ///
  /// In en, this message translates to:
  /// **'Rainfall'**
  String get rainfall;

  /// No description provided for @windSpeed.
  ///
  /// In en, this message translates to:
  /// **'Wind Speed'**
  String get windSpeed;

  /// No description provided for @uvIndex.
  ///
  /// In en, this message translates to:
  /// **'UV Index'**
  String get uvIndex;

  /// No description provided for @expectedTemperature.
  ///
  /// In en, this message translates to:
  /// **'Expected Temperature'**
  String get expectedTemperature;

  /// No description provided for @rainfallForecast.
  ///
  /// In en, this message translates to:
  /// **'Rainfall Forecast'**
  String get rainfallForecast;

  /// No description provided for @frostRisk.
  ///
  /// In en, this message translates to:
  /// **'Frost Risk'**
  String get frostRisk;

  /// No description provided for @cropTomatoDesc.
  ///
  /// In en, this message translates to:
  /// **'Tomatoes are widely grown in India. They require warm weather and well-drained soil.'**
  String get cropTomatoDesc;

  /// No description provided for @cropRiceDesc.
  ///
  /// In en, this message translates to:
  /// **'Rice is a staple food in India. It requires a lot of water and grows well in tropical climates.'**
  String get cropRiceDesc;

  /// No description provided for @cropWheatDesc.
  ///
  /// In en, this message translates to:
  /// **'Wheat is a major crop in India. It grows well in cool climates and requires moderate rainfall.'**
  String get cropWheatDesc;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @equipmentFaqTitle.
  ///
  /// In en, this message translates to:
  /// **'Equipment FAQ\'s'**
  String get equipmentFaqTitle;

  /// No description provided for @equipmentSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search FAQs...'**
  String get equipmentSearchHint;

  /// No description provided for @equipmentQ1.
  ///
  /// In en, this message translates to:
  /// **'What is the best tractor for small-scale farming?'**
  String get equipmentQ1;

  /// No description provided for @equipmentA1.
  ///
  /// In en, this message translates to:
  /// **'Compact tractors like the John Deere 1025R or Kubota BX Series are popular choices. They combine reliability with flexible attachments and are designed for small acreage or hobby farms.'**
  String get equipmentA1;

  /// No description provided for @equipmentQ2.
  ///
  /// In en, this message translates to:
  /// **'How do I maintain my agricultural tools?'**
  String get equipmentQ2;

  /// No description provided for @equipmentA2.
  ///
  /// In en, this message translates to:
  /// **'Keep your tools clean after each use, oil any moving parts, and store them in a cool, dry space. Regular maintenance ensures longevity and optimal performance.'**
  String get equipmentA2;

  /// No description provided for @equipmentQ3.
  ///
  /// In en, this message translates to:
  /// **'What is the lifespan of a plowing blade?'**
  String get equipmentQ3;

  /// No description provided for @equipmentA3.
  ///
  /// In en, this message translates to:
  /// **'Plowing blades last between 3 to 5 years under regular use. Their durability depends on soil type, operational care, and timely inspections for wear and tear.'**
  String get equipmentA3;

  /// No description provided for @equipmentQ4.
  ///
  /// In en, this message translates to:
  /// **'Can I use the same equipment for different crops?'**
  String get equipmentQ4;

  /// No description provided for @equipmentA4.
  ///
  /// In en, this message translates to:
  /// **'Yes, many machines are designed for versatility. However, adjustments or recalibrations may be necessary to meet the requirements of specific crops.'**
  String get equipmentA4;

  /// No description provided for @equipmentQ5.
  ///
  /// In en, this message translates to:
  /// **'What safety precautions should I take when using power tools?'**
  String get equipmentQ5;

  /// No description provided for @equipmentA5.
  ///
  /// In en, this message translates to:
  /// **'Always wear protective gear such as gloves, goggles, and boots. Avoid distractions, follow the manufacturer\'s guide, and inspect the tools before every use.'**
  String get equipmentA5;

  /// No description provided for @equipmentQ6.
  ///
  /// In en, this message translates to:
  /// **'How often should I service my tractor?'**
  String get equipmentQ6;

  /// No description provided for @equipmentA6.
  ///
  /// In en, this message translates to:
  /// **'Tractors need servicing every 200-250 operational hours or once annually. Routine checks include oil changes, belt inspections, and filter replacements.'**
  String get equipmentA6;

  /// No description provided for @equipmentQ7.
  ///
  /// In en, this message translates to:
  /// **'What is the best way to sharpen a sickle or scythe?'**
  String get equipmentQ7;

  /// No description provided for @equipmentA7.
  ///
  /// In en, this message translates to:
  /// **'Use a fine-grit sharpening stone and maintain consistent blade angles. Regular sharpening after each use ensures precise and efficient cuts in the field.'**
  String get equipmentA7;

  /// No description provided for @equipmentQ8.
  ///
  /// In en, this message translates to:
  /// **'Are electric tools better than manual ones for gardening?'**
  String get equipmentQ8;

  /// No description provided for @equipmentA8.
  ///
  /// In en, this message translates to:
  /// **'Electric tools save time and reduce effort in larger tasks, but manual tools often offer better control. Choose based on the specific demands of your gardening project.'**
  String get equipmentA8;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUs;

  /// No description provided for @guidelines.
  ///
  /// In en, this message translates to:
  /// **'Guidelines'**
  String get guidelines;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get myProfile;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Kisan Connect'**
  String get welcomeTitle;

  /// No description provided for @searchAnything.
  ///
  /// In en, this message translates to:
  /// **'Search for anything...'**
  String get searchAnything;

  /// No description provided for @buyerDashboard.
  ///
  /// In en, this message translates to:
  /// **'Buyer Dashboard'**
  String get buyerDashboard;

  /// No description provided for @itemOrganicFruits.
  ///
  /// In en, this message translates to:
  /// **'Organic Fruits'**
  String get itemOrganicFruits;

  /// No description provided for @itemFreshVegetables.
  ///
  /// In en, this message translates to:
  /// **'Fresh Vegetables'**
  String get itemFreshVegetables;

  /// No description provided for @itemDairyProducts.
  ///
  /// In en, this message translates to:
  /// **'Dairy Products'**
  String get itemDairyProducts;

  /// No description provided for @itemPoultryProducts.
  ///
  /// In en, this message translates to:
  /// **'Poultry Products'**
  String get itemPoultryProducts;

  /// No description provided for @itemExoticVegetables.
  ///
  /// In en, this message translates to:
  /// **'Exotic Vegetables'**
  String get itemExoticVegetables;

  /// No description provided for @equipmentRentalTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Equipment Rental'**
  String get equipmentRentalTitle;

  /// No description provided for @equipmentRentalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Rent farming machinery at affordable prices.'**
  String get equipmentRentalSubtitle;

  /// No description provided for @selectCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get selectCategoryLabel;

  /// No description provided for @selectDurationLabel.
  ///
  /// In en, this message translates to:
  /// **'Rental Duration'**
  String get selectDurationLabel;

  /// No description provided for @selectLocationLabel.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get selectLocationLabel;

  /// No description provided for @availableEquipmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Available Equipment'**
  String get availableEquipmentTitle;

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get bookNow;

  /// No description provided for @bookingTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking Confirmation'**
  String get bookingTitle;

  /// No description provided for @bookingSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'You have successfully booked the {equipmentName}.'**
  String bookingSuccessMessage(Object equipmentName);

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @equipmentTractor.
  ///
  /// In en, this message translates to:
  /// **'Tractor'**
  String get equipmentTractor;

  /// No description provided for @equipmentHarvester.
  ///
  /// In en, this message translates to:
  /// **'Harvester'**
  String get equipmentHarvester;

  /// No description provided for @equipmentSprayer.
  ///
  /// In en, this message translates to:
  /// **'Sprayer'**
  String get equipmentSprayer;

  /// No description provided for @equipmentSeeder.
  ///
  /// In en, this message translates to:
  /// **'Seeder'**
  String get equipmentSeeder;

  /// No description provided for @durationDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get durationDaily;

  /// No description provided for @durationWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get durationWeekly;

  /// No description provided for @durationSeasonal.
  ///
  /// In en, this message translates to:
  /// **'Seasonal'**
  String get durationSeasonal;

  /// No description provided for @categoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get categoryAll;

  /// No description provided for @categoryTractors.
  ///
  /// In en, this message translates to:
  /// **'Tractors'**
  String get categoryTractors;

  /// No description provided for @categoryHarvesters.
  ///
  /// In en, this message translates to:
  /// **'Harvesters'**
  String get categoryHarvesters;

  /// No description provided for @categorySprayers.
  ///
  /// In en, this message translates to:
  /// **'Sprayers'**
  String get categorySprayers;

  /// No description provided for @categorySeeders.
  ///
  /// In en, this message translates to:
  /// **'Seeders'**
  String get categorySeeders;

  /// No description provided for @categoryIrrigation.
  ///
  /// In en, this message translates to:
  /// **'Irrigation'**
  String get categoryIrrigation;

  /// No description provided for @availabilityAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get availabilityAvailable;

  /// No description provided for @locationMaharashtra.
  ///
  /// In en, this message translates to:
  /// **'Maharashtra'**
  String get locationMaharashtra;

  /// No description provided for @locationUttarPradesh.
  ///
  /// In en, this message translates to:
  /// **'Uttar Pradesh'**
  String get locationUttarPradesh;

  /// No description provided for @locationKarnataka.
  ///
  /// In en, this message translates to:
  /// **'Karnataka'**
  String get locationKarnataka;

  /// No description provided for @locationGujarat.
  ///
  /// In en, this message translates to:
  /// **'Gujarat'**
  String get locationGujarat;

  /// No description provided for @equipmentWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Equipment Rental'**
  String get equipmentWelcomeTitle;

  /// No description provided for @equipmentWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Rent farming machinery at affordable prices.'**
  String get equipmentWelcomeSubtitle;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @categoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categoryLabel;

  /// No description provided for @locationLabel.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get locationLabel;

  /// No description provided for @rentalDurationLabel.
  ///
  /// In en, this message translates to:
  /// **'Rental Duration'**
  String get rentalDurationLabel;

  /// No description provided for @availableEquipment.
  ///
  /// In en, this message translates to:
  /// **'Available Equipment'**
  String get availableEquipment;

  /// No description provided for @bookingConfirmationTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking Confirmation'**
  String get bookingConfirmationTitle;

  /// No description provided for @bookingConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'You have successfully booked the {equipmentName}.'**
  String bookingConfirmationMessage(Object equipmentName);

  /// No description provided for @availabilityLabel.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get availabilityLabel;

  /// No description provided for @durationAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get durationAll;

  /// No description provided for @produceFaqTitle.
  ///
  /// In en, this message translates to:
  /// **'Fresh Produce FAQ\'s'**
  String get produceFaqTitle;

  /// No description provided for @searchFaqHint.
  ///
  /// In en, this message translates to:
  /// **'Search FAQs...'**
  String get searchFaqHint;

  /// No description provided for @noFaqsFound.
  ///
  /// In en, this message translates to:
  /// **'No FAQs found for your search.'**
  String get noFaqsFound;

  /// No description provided for @faqQ1.
  ///
  /// In en, this message translates to:
  /// **'What is the best tractor for small-scale farming?'**
  String get faqQ1;

  /// No description provided for @faqA1.
  ///
  /// In en, this message translates to:
  /// **'Compact tractors like the John Deere 1025R or Kubota BX Series are great options.'**
  String get faqA1;

  /// No description provided for @faqQ2.
  ///
  /// In en, this message translates to:
  /// **'How do I maintain my agricultural tools?'**
  String get faqQ2;

  /// No description provided for @faqA2.
  ///
  /// In en, this message translates to:
  /// **'Clean tools after every use, store them in a dry place, and regularly oil moving parts to prevent rust.'**
  String get faqA2;

  /// No description provided for @faqQ3.
  ///
  /// In en, this message translates to:
  /// **'What is the lifespan of a plowing blade?'**
  String get faqQ3;

  /// No description provided for @faqA3.
  ///
  /// In en, this message translates to:
  /// **'A plowing blade typically lasts 3-5 years, depending on soil conditions and usage.'**
  String get faqA3;

  /// No description provided for @faqQ4.
  ///
  /// In en, this message translates to:
  /// **'Can I use the same equipment for different crops?'**
  String get faqQ4;

  /// No description provided for @faqA4.
  ///
  /// In en, this message translates to:
  /// **'Yes, many tools are versatile, but ensure they are properly adjusted to suit the crop requirements.'**
  String get faqA4;

  /// No description provided for @faqQ5.
  ///
  /// In en, this message translates to:
  /// **'What safety precautions should I take when using power tools?'**
  String get faqQ5;

  /// No description provided for @faqA5.
  ///
  /// In en, this message translates to:
  /// **'Always wear protective gear, follow manufacturer instructions, and inspect tools for damage before use.'**
  String get faqA5;

  /// No description provided for @faqQ6.
  ///
  /// In en, this message translates to:
  /// **'How often should I service my tractor?'**
  String get faqQ6;

  /// No description provided for @faqA6.
  ///
  /// In en, this message translates to:
  /// **'Tractors should be serviced every 200-250 hours of use or annually, whichever comes first.'**
  String get faqA6;

  /// No description provided for @faqQ7.
  ///
  /// In en, this message translates to:
  /// **'What is the best way to sharpen a sickle or scythe?'**
  String get faqQ7;

  /// No description provided for @faqA7.
  ///
  /// In en, this message translates to:
  /// **'Use a sharpening stone or file, maintaining a consistent angle, and hone the edge regularly during use.'**
  String get faqA7;

  /// No description provided for @faqQ8.
  ///
  /// In en, this message translates to:
  /// **'Are electric tools better than manual ones for gardening?'**
  String get faqQ8;

  /// No description provided for @faqA8.
  ///
  /// In en, this message translates to:
  /// **'Electric tools are more efficient for larger tasks, while manual tools offer more precision and control for delicate work.'**
  String get faqA8;

  /// No description provided for @cropsFaqTitle.
  ///
  /// In en, this message translates to:
  /// **'Buyer and Farmer FAQs'**
  String get cropsFaqTitle;

  /// No description provided for @faqsForBuyers.
  ///
  /// In en, this message translates to:
  /// **'FAQs for Buyers'**
  String get faqsForBuyers;

  /// No description provided for @faqsForFarmers.
  ///
  /// In en, this message translates to:
  /// **'FAQs for Farmers'**
  String get faqsForFarmers;

  /// No description provided for @cropsFaqQ1.
  ///
  /// In en, this message translates to:
  /// **'What crops are available on the website?'**
  String get cropsFaqQ1;

  /// No description provided for @cropsFaqA1.
  ///
  /// In en, this message translates to:
  /// **'We offer a variety of crops, including fruits (mangoes, apples), vegetables (potatoes, tomatoes), dairy products, poultry products, and exotic vegetables like broccoli and lettuce.'**
  String get cropsFaqA1;

  /// No description provided for @cropsFaqQ2.
  ///
  /// In en, this message translates to:
  /// **'How do I place an order?'**
  String get cropsFaqQ2;

  /// No description provided for @cropsFaqA2.
  ///
  /// In en, this message translates to:
  /// **'To place an order, browse through our product catalog, add items to your cart, and proceed to checkout with your shipping and payment details.'**
  String get cropsFaqA2;

  /// No description provided for @cropsFaqQ3.
  ///
  /// In en, this message translates to:
  /// **'Are products on the website organic?'**
  String get cropsFaqQ3;

  /// No description provided for @cropsFaqA3.
  ///
  /// In en, this message translates to:
  /// **'We provide both organic and non-organic options. Organic products are clearly labeled, and you can filter for them in the product catalog.'**
  String get cropsFaqA3;

  /// No description provided for @cropsFaqQ4.
  ///
  /// In en, this message translates to:
  /// **'What if I receive damaged or low-quality produce?'**
  String get cropsFaqQ4;

  /// No description provided for @cropsFaqA4.
  ///
  /// In en, this message translates to:
  /// **'If you receive damaged or unsatisfactory produce, please contact customer support within 24 hours of delivery. We offer refunds or replacements.'**
  String get cropsFaqA4;

  /// No description provided for @cropsFaqQ5.
  ///
  /// In en, this message translates to:
  /// **'Do you deliver nationwide?'**
  String get cropsFaqQ5;

  /// No description provided for @cropsFaqA5.
  ///
  /// In en, this message translates to:
  /// **'Yes, we deliver across India. Delivery times vary based on location and product type. Estimated delivery dates are provided at checkout.'**
  String get cropsFaqA5;

  /// No description provided for @cropsFaqQ6.
  ///
  /// In en, this message translates to:
  /// **'How do I list my crops on the website?'**
  String get cropsFaqQ6;

  /// No description provided for @cropsFaqA6.
  ///
  /// In en, this message translates to:
  /// **'To list your crops, create a farmer account, upload details about your produce, including type, quantity, and price, and wait for approval from our team.'**
  String get cropsFaqA6;

  /// No description provided for @cropsFaqQ7.
  ///
  /// In en, this message translates to:
  /// **'Are there any fees for selling on this platform?'**
  String get cropsFaqQ7;

  /// No description provided for @cropsFaqA7.
  ///
  /// In en, this message translates to:
  /// **'We charge a small commission on each sale. There are no upfront fees for listing your products, and detailed terms are shared during onboarding.'**
  String get cropsFaqA7;

  /// No description provided for @cropsFaqQ8.
  ///
  /// In en, this message translates to:
  /// **'How will I get paid for my sales?'**
  String get cropsFaqQ8;

  /// No description provided for @cropsFaqA8.
  ///
  /// In en, this message translates to:
  /// **'Payments are made directly to your registered bank account within 7 days of successful delivery and customer satisfaction.'**
  String get cropsFaqA8;

  /// No description provided for @cropsFaqQ9.
  ///
  /// In en, this message translates to:
  /// **'What kind of crops are in high demand?'**
  String get cropsFaqQ9;

  /// No description provided for @cropsFaqA9.
  ///
  /// In en, this message translates to:
  /// **'Fruits like mangoes and apples, vegetables like tomatoes and potatoes, and exotic vegetables like lettuce are often in high demand across markets.'**
  String get cropsFaqA9;

  /// No description provided for @cropsFaqQ10.
  ///
  /// In en, this message translates to:
  /// **'Can I connect with buyers directly?'**
  String get cropsFaqQ10;

  /// No description provided for @cropsFaqA10.
  ///
  /// In en, this message translates to:
  /// **'Yes, our platform facilitates communication between buyers and farmers through a secure messaging feature for any queries or custom orders.'**
  String get cropsFaqA10;

  /// No description provided for @organicFruitMarketplace.
  ///
  /// In en, this message translates to:
  /// **'Organic Fruit Marketplace'**
  String get organicFruitMarketplace;

  /// No description provided for @organicFruitSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Connect directly with farmers for fresh, organic fruits'**
  String get organicFruitSubtitle;

  /// No description provided for @searchFruitsHint.
  ///
  /// In en, this message translates to:
  /// **'Search for fruits...'**
  String get searchFruitsHint;

  /// No description provided for @variety.
  ///
  /// In en, this message translates to:
  /// **'Variety'**
  String get variety;

  /// No description provided for @season.
  ///
  /// In en, this message translates to:
  /// **'Season'**
  String get season;

  /// Shows the number of available farmers
  ///
  /// In en, this message translates to:
  /// **'{count} Farmers Available'**
  String farmersAvailable(Object count);

  /// No description provided for @freshVegetablesMarketplace.
  ///
  /// In en, this message translates to:
  /// **'Fresh Vegetables Marketplace'**
  String get freshVegetablesMarketplace;

  /// No description provided for @freshVegetablesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Connect directly with farmers for fresh, organic vegetables'**
  String get freshVegetablesSubtitle;

  /// No description provided for @searchVegetablesHint.
  ///
  /// In en, this message translates to:
  /// **'Search for vegetables...'**
  String get searchVegetablesHint;

  /// No description provided for @dairyMarketplaceTitle.
  ///
  /// In en, this message translates to:
  /// **'Dairy Products'**
  String get dairyMarketplaceTitle;

  /// No description provided for @dairyMarketplaceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Connect directly with farmers for fresh, organic dairy products'**
  String get dairyMarketplaceSubtitle;

  /// No description provided for @searchDairyHint.
  ///
  /// In en, this message translates to:
  /// **'Search for dairy products...'**
  String get searchDairyHint;

  /// No description provided for @varietyLabel.
  ///
  /// In en, this message translates to:
  /// **'Variety'**
  String get varietyLabel;

  /// No description provided for @seasonLabel.
  ///
  /// In en, this message translates to:
  /// **'Season'**
  String get seasonLabel;

  /// No description provided for @descriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionLabel;

  /// No description provided for @availableFarmers.
  ///
  /// In en, this message translates to:
  /// **'Available Farmers'**
  String get availableFarmers;

  /// No description provided for @quantityLabel.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantityLabel;

  /// No description provided for @ratingLabel.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get ratingLabel;

  /// No description provided for @chatButton.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chatButton;

  /// No description provided for @makeDealButton.
  ///
  /// In en, this message translates to:
  /// **'Make a Deal'**
  String get makeDealButton;

  /// No description provided for @poultryMarketplaceTitle.
  ///
  /// In en, this message translates to:
  /// **'Poultry Marketplace'**
  String get poultryMarketplaceTitle;

  /// No description provided for @poultryMarketplaceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Connect directly with farmers for fresh, organic poultry products'**
  String get poultryMarketplaceSubtitle;

  /// No description provided for @searchPoultryHint.
  ///
  /// In en, this message translates to:
  /// **'Search for poultry products...'**
  String get searchPoultryHint;

  /// No description provided for @exoticVegetablesMarketplaceTitle.
  ///
  /// In en, this message translates to:
  /// **'Exotic Vegetables Marketplace'**
  String get exoticVegetablesMarketplaceTitle;

  /// No description provided for @exoticVegetablesMarketplaceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Connect directly with farmers for fresh, organic exotic vegetables'**
  String get exoticVegetablesMarketplaceSubtitle;

  /// No description provided for @searchExoticVegetablesHint.
  ///
  /// In en, this message translates to:
  /// **'Search for exotic vegetables...'**
  String get searchExoticVegetablesHint;

  /// No description provided for @aboutUsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Learn more about Kisan Connect'**
  String get aboutUsSubtitle;

  /// No description provided for @aboutKisanKonnect.
  ///
  /// In en, this message translates to:
  /// **'About Kisan Konnect'**
  String get aboutKisanKonnect;

  /// No description provided for @aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'We are dedicated to connecting farmers and buyers in a seamless marketplace. Our platform provides a variety of agricultural products and services to meet the needs of our users.'**
  String get aboutDescription;

  /// No description provided for @ourMission.
  ///
  /// In en, this message translates to:
  /// **'Our Mission'**
  String get ourMission;

  /// No description provided for @missionDescription.
  ///
  /// In en, this message translates to:
  /// **'To empower farmers and provide buyers with access to quality agricultural products.'**
  String get missionDescription;

  /// No description provided for @ourVision.
  ///
  /// In en, this message translates to:
  /// **'Our Vision'**
  String get ourVision;

  /// No description provided for @visionDescription.
  ///
  /// In en, this message translates to:
  /// **'To be the leading online marketplace for agricultural products, fostering sustainable practices and supporting local farmers.'**
  String get visionDescription;

  /// No description provided for @ourValues.
  ///
  /// In en, this message translates to:
  /// **'Our Values'**
  String get ourValues;

  /// No description provided for @valueIntegrity.
  ///
  /// In en, this message translates to:
  /// **'Integrity: We uphold the highest standards of integrity in all our actions.'**
  String get valueIntegrity;

  /// No description provided for @valueCustomerFocus.
  ///
  /// In en, this message translates to:
  /// **'Customer Focus: We value our customers and strive to meet their needs.'**
  String get valueCustomerFocus;

  /// No description provided for @valueInnovation.
  ///
  /// In en, this message translates to:
  /// **'Innovation: We embrace change and seek new ways to improve our services.'**
  String get valueInnovation;

  /// No description provided for @valueSustainability.
  ///
  /// In en, this message translates to:
  /// **'Sustainability: We are committed to promoting sustainable agricultural practices.'**
  String get valueSustainability;

  /// No description provided for @voiceCommandNotImplemented.
  ///
  /// In en, this message translates to:
  /// **'Voice command feature not yet implemented'**
  String get voiceCommandNotImplemented;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @messageLabel.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get messageLabel;

  /// No description provided for @your.
  ///
  /// In en, this message translates to:
  /// **'Your'**
  String get your;

  /// No description provided for @pleaseEnter.
  ///
  /// In en, this message translates to:
  /// **'Please enter your'**
  String get pleaseEnter;

  /// No description provided for @pleaseEnterMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter a message'**
  String get pleaseEnterMessage;

  /// No description provided for @sendMessageButton.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get sendMessageButton;

  /// No description provided for @successMessage.
  ///
  /// In en, this message translates to:
  /// **'Your message has been sent successfully! We will respond soon.'**
  String get successMessage;
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
