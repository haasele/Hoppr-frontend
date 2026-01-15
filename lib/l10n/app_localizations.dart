import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';

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
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr')
  ];

  /// The application title
  ///
  /// In en, this message translates to:
  /// **'Hoppr'**
  String get appTitle;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @materialYouDynamicColors.
  ///
  /// In en, this message translates to:
  /// **'Material You Dynamic Colors'**
  String get materialYouDynamicColors;

  /// No description provided for @useSystemAccentColors.
  ///
  /// In en, this message translates to:
  /// **'Use system accent colors'**
  String get useSystemAccentColors;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @german.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get german;

  /// No description provided for @french.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get french;

  /// No description provided for @spanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get spanish;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @loginRequired.
  ///
  /// In en, this message translates to:
  /// **'Login Required'**
  String get loginRequired;

  /// No description provided for @youNeedToBeLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'You need to be logged in to perform this action.'**
  String get youNeedToBeLoggedIn;

  /// No description provided for @loginWithKeycloak.
  ///
  /// In en, this message translates to:
  /// **'Login with Keycloak'**
  String get loginWithKeycloak;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @signInToChat.
  ///
  /// In en, this message translates to:
  /// **'Sign in to chat'**
  String get signInToChat;

  /// No description provided for @createAccountToStartConversations.
  ///
  /// In en, this message translates to:
  /// **'Create an account to start conversations with ticket owners'**
  String get createAccountToStartConversations;

  /// No description provided for @signInToSaveTickets.
  ///
  /// In en, this message translates to:
  /// **'Sign in to save tickets'**
  String get signInToSaveTickets;

  /// No description provided for @createAccountToSaveTickets.
  ///
  /// In en, this message translates to:
  /// **'Create an account to save tickets to your wishlist'**
  String get createAccountToSaveTickets;

  /// No description provided for @signInToViewProfile.
  ///
  /// In en, this message translates to:
  /// **'Sign in to view profile'**
  String get signInToViewProfile;

  /// No description provided for @createAccountToManage.
  ///
  /// In en, this message translates to:
  /// **'Create an account to manage your tickets and preferences'**
  String get createAccountToManage;

  /// No description provided for @createAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get createAnAccount;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get getStarted;

  /// No description provided for @welcomeToHoppr.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Hoppr'**
  String get welcomeToHoppr;

  /// No description provided for @signInOrCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Sign in or create an account to save tickets, chat with sellers, and manage your profile'**
  String get signInOrCreateAccount;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @wishlist.
  ///
  /// In en, this message translates to:
  /// **'Wishlist'**
  String get wishlist;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @registerWithKeycloak.
  ///
  /// In en, this message translates to:
  /// **'Register with Keycloak'**
  String get registerWithKeycloak;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Login'**
  String get alreadyHaveAccount;

  /// No description provided for @needAccount.
  ///
  /// In en, this message translates to:
  /// **'Need an account? Register'**
  String get needAccount;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed. Please try again.'**
  String get loginFailed;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @couldNotOpenRegistrationPage.
  ///
  /// In en, this message translates to:
  /// **'Could not open registration page. Please visit the Keycloak admin console.'**
  String get couldNotOpenRegistrationPage;

  /// No description provided for @errorOpeningRegistration.
  ///
  /// In en, this message translates to:
  /// **'Error opening registration'**
  String get errorOpeningRegistration;

  /// No description provided for @searchTickets.
  ///
  /// In en, this message translates to:
  /// **'Search tickets...'**
  String get searchTickets;

  /// No description provided for @noRecentTickets.
  ///
  /// In en, this message translates to:
  /// **'No recent tickets'**
  String get noRecentTickets;

  /// No description provided for @startSearching.
  ///
  /// In en, this message translates to:
  /// **'Start searching to see tickets here'**
  String get startSearching;

  /// No description provided for @errorLoadingTickets.
  ///
  /// In en, this message translates to:
  /// **'Error loading tickets'**
  String get errorLoadingTickets;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @dismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get dismiss;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @accentColor.
  ///
  /// In en, this message translates to:
  /// **'Accent Color'**
  String get accentColor;

  /// No description provided for @customColorApplied.
  ///
  /// In en, this message translates to:
  /// **'Custom color applied'**
  String get customColorApplied;

  /// No description provided for @tapToCustomize.
  ///
  /// In en, this message translates to:
  /// **'Tap to customize'**
  String get tapToCustomize;

  /// No description provided for @resetToDefault.
  ///
  /// In en, this message translates to:
  /// **'Reset to default'**
  String get resetToDefault;

  /// No description provided for @chooseAccentColor.
  ///
  /// In en, this message translates to:
  /// **'Choose Accent Color'**
  String get chooseAccentColor;

  /// No description provided for @enterSearchQuery.
  ///
  /// In en, this message translates to:
  /// **'Enter search query to find tickets'**
  String get enterSearchQuery;

  /// No description provided for @noTicketsFound.
  ///
  /// In en, this message translates to:
  /// **'No tickets found'**
  String get noTicketsFound;

  /// No description provided for @clearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get clearFilters;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get clearAll;

  /// No description provided for @ticketType.
  ///
  /// In en, this message translates to:
  /// **'Ticket Type'**
  String get ticketType;

  /// No description provided for @ticketTypeHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Monthly, Single, Day Pass'**
  String get ticketTypeHint;

  /// No description provided for @provider.
  ///
  /// In en, this message translates to:
  /// **'Provider'**
  String get provider;

  /// No description provided for @providerHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., DB, BVG, S-Bahn'**
  String get providerHint;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @locationHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Berlin, Munich'**
  String get locationHint;

  /// No description provided for @applyFilters.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get applyFilters;

  /// No description provided for @yourWishlistIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your wishlist is empty'**
  String get yourWishlistIsEmpty;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @errorLoadingWishlist.
  ///
  /// In en, this message translates to:
  /// **'Error loading wishlist'**
  String get errorLoadingWishlist;

  /// No description provided for @removedFromWishlist.
  ///
  /// In en, this message translates to:
  /// **'Removed from wishlist'**
  String get removedFromWishlist;

  /// No description provided for @noConversations.
  ///
  /// In en, this message translates to:
  /// **'No conversations'**
  String get noConversations;

  /// No description provided for @errorLoadingConversations.
  ///
  /// In en, this message translates to:
  /// **'Error loading conversations'**
  String get errorLoadingConversations;

  /// No description provided for @blockUser.
  ///
  /// In en, this message translates to:
  /// **'Block user'**
  String get blockUser;

  /// No description provided for @reportUser.
  ///
  /// In en, this message translates to:
  /// **'Report user'**
  String get reportUser;

  /// No description provided for @noMessagesYet.
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get noMessagesYet;

  /// No description provided for @errorLoadingMessages.
  ///
  /// In en, this message translates to:
  /// **'Error loading messages'**
  String get errorLoadingMessages;

  /// No description provided for @typeAMessage.
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get typeAMessage;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @providerLabel.
  ///
  /// In en, this message translates to:
  /// **'Provider'**
  String get providerLabel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'es', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
