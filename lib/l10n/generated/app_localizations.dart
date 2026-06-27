import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
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
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to RentalHub'**
  String get welcome;

  /// No description provided for @welcomeDescription.
  ///
  /// In en, this message translates to:
  /// **'Your one-stop solution for all your rental needs. Find, book, and manage your rentals with ease.'**
  String get welcomeDescription;

  /// No description provided for @rentAndEarn.
  ///
  /// In en, this message translates to:
  /// **'Rent what you need, earn from what you own.'**
  String get rentAndEarn;

  /// No description provided for @trustedStore.
  ///
  /// In en, this message translates to:
  /// **'Get high-quality equipment and unique items from a trusted store.'**
  String get trustedStore;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @connectWith.
  ///
  /// In en, this message translates to:
  /// **'CONNECT WITH'**
  String get connectWith;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signup;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @nationalId.
  ///
  /// In en, this message translates to:
  /// **'Natinal Id'**
  String get nationalId;

  /// No description provided for @enterTheNationalNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter the national number'**
  String get enterTheNationalNumber;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @personalIDCard.
  ///
  /// In en, this message translates to:
  /// **'Personal ID card'**
  String get personalIDCard;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @searchRentals.
  ///
  /// In en, this message translates to:
  /// **'Search rentals'**
  String get searchRentals;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @popular.
  ///
  /// In en, this message translates to:
  /// **'Popular'**
  String get popular;

  /// No description provided for @myListings.
  ///
  /// In en, this message translates to:
  /// **'My listings'**
  String get myListings;

  /// No description provided for @bookings.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get bookings;

  /// No description provided for @messages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

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

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @getEverythingYouWant.
  ///
  /// In en, this message translates to:
  /// **'Get everything you want'**
  String get getEverythingYouWant;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search requests...'**
  String get searchHint;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @community.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get community;

  /// No description provided for @addCommunityRequest.
  ///
  /// In en, this message translates to:
  /// **'Add Community Request'**
  String get addCommunityRequest;

  /// No description provided for @communityRequests.
  ///
  /// In en, this message translates to:
  /// **'Community Requests'**
  String get communityRequests;

  /// No description provided for @incomingOffers.
  ///
  /// In en, this message translates to:
  /// **'Incoming Offers'**
  String get incomingOffers;

  /// No description provided for @myActivity.
  ///
  /// In en, this message translates to:
  /// **'My Activity'**
  String get myActivity;

  /// No description provided for @noRequestsYet.
  ///
  /// In en, this message translates to:
  /// **'No requests yet'**
  String get noRequestsYet;

  /// No description provided for @noOffersYet.
  ///
  /// In en, this message translates to:
  /// **'No offers yet'**
  String get noOffersYet;

  /// No description provided for @noIncomingOffers.
  ///
  /// In en, this message translates to:
  /// **'No incoming offers'**
  String get noIncomingOffers;

  /// No description provided for @beFirstToAddRequest.
  ///
  /// In en, this message translates to:
  /// **'Be the first to add a community request'**
  String get beFirstToAddRequest;

  /// No description provided for @beFirstToSubmitOffer.
  ///
  /// In en, this message translates to:
  /// **'Be the first to submit an offer'**
  String get beFirstToSubmitOffer;

  /// No description provided for @submitOffer.
  ///
  /// In en, this message translates to:
  /// **'Submit Offer'**
  String get submitOffer;

  /// No description provided for @acceptOffer.
  ///
  /// In en, this message translates to:
  /// **'Accept Offer'**
  String get acceptOffer;

  /// No description provided for @rejectOffer.
  ///
  /// In en, this message translates to:
  /// **'Reject Offer'**
  String get rejectOffer;

  /// No description provided for @confirmAcceptOffer.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to accept this offer? The offerer will be notified.'**
  String get confirmAcceptOffer;

  /// No description provided for @confirmRejectOffer.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reject this offer? This action cannot be undone.'**
  String get confirmRejectOffer;

  /// No description provided for @confirmAction.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmAction;

  /// No description provided for @requestDetails.
  ///
  /// In en, this message translates to:
  /// **'Request Details'**
  String get requestDetails;

  /// No description provided for @offersList.
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get offersList;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @loadingFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load. Please try again.'**
  String get loadingFailed;

  /// No description provided for @openStatus.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get openStatus;

  /// No description provided for @closedStatus.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closedStatus;

  /// No description provided for @pendingStatus.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pendingStatus;

  /// No description provided for @acceptedStatus.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get acceptedStatus;

  /// No description provided for @rejectedStatus.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejectedStatus;

  /// No description provided for @offersCount.
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get offersCount;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @subcategory.
  ///
  /// In en, this message translates to:
  /// **'Subcategory'**
  String get subcategory;

  /// No description provided for @budget.
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get budget;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @createRequest.
  ///
  /// In en, this message translates to:
  /// **'Create Request'**
  String get createRequest;

  /// No description provided for @publishRequest.
  ///
  /// In en, this message translates to:
  /// **'Publish Request'**
  String get publishRequest;

  /// No description provided for @requestTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get requestTitle;

  /// No description provided for @requestDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get requestDescription;

  /// No description provided for @requestBudget.
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get requestBudget;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDate;

  /// No description provided for @endDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get endDate;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select Category'**
  String get selectCategory;

  /// No description provided for @selectSubcategory.
  ///
  /// In en, this message translates to:
  /// **'Select Subcategory'**
  String get selectSubcategory;

  /// No description provided for @loadingSubcategories.
  ///
  /// In en, this message translates to:
  /// **'Loading subcategories...'**
  String get loadingSubcategories;

  /// No description provided for @locationInfo.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get locationInfo;

  /// No description provided for @images.
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get images;

  /// No description provided for @addImage.
  ///
  /// In en, this message translates to:
  /// **'Add Image'**
  String get addImage;

  /// No description provided for @imageSelected.
  ///
  /// In en, this message translates to:
  /// **'Image selected'**
  String get imageSelected;

  /// No description provided for @noRequests.
  ///
  /// In en, this message translates to:
  /// **'No requests'**
  String get noRequests;

  /// No description provided for @noOffers.
  ///
  /// In en, this message translates to:
  /// **'No offers'**
  String get noOffers;

  /// No description provided for @offersCountLabel.
  ///
  /// In en, this message translates to:
  /// **'offers'**
  String get offersCountLabel;

  /// No description provided for @requestDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Request Details'**
  String get requestDetailsTitle;

  /// No description provided for @filterComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon...'**
  String get filterComingSoon;

  /// No description provided for @communityFeedTitle.
  ///
  /// In en, this message translates to:
  /// **'Community Feed'**
  String get communityFeedTitle;

  /// No description provided for @myRequests.
  ///
  /// In en, this message translates to:
  /// **'My Requests'**
  String get myRequests;

  /// No description provided for @myOffers.
  ///
  /// In en, this message translates to:
  /// **'My Offers'**
  String get myOffers;

  /// No description provided for @egpCurrency.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get egpCurrency;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get userName;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfile;

  /// No description provided for @manageAccount.
  ///
  /// In en, this message translates to:
  /// **'Manage Account'**
  String get manageAccount;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @deals.
  ///
  /// In en, this message translates to:
  /// **'Deals'**
  String get deals;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @robot.
  ///
  /// In en, this message translates to:
  /// **'Robot'**
  String get robot;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @addListing.
  ///
  /// In en, this message translates to:
  /// **'Add your listing'**
  String get addListing;

  /// No description provided for @addQuestion.
  ///
  /// In en, this message translates to:
  /// **'Add your question'**
  String get addQuestion;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfile;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @activeRentals.
  ///
  /// In en, this message translates to:
  /// **'Active Rentals'**
  String get activeRentals;

  /// No description provided for @rentalHub.
  ///
  /// In en, this message translates to:
  /// **'Rental Hub'**
  String get rentalHub;

  /// No description provided for @welcomeBackLogin.
  ///
  /// In en, this message translates to:
  /// **'Welcome back. Your next premium stay is just a few taps away.'**
  String get welcomeBackLogin;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'hello@gmail.com'**
  String get emailHint;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Email'**
  String get enterYourEmail;

  /// No description provided for @enterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Password'**
  String get enterYourPassword;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMinLength;

  /// No description provided for @loginToHub.
  ///
  /// In en, this message translates to:
  /// **'Login to Hub'**
  String get loginToHub;

  /// No description provided for @googleSignInNotImplemented.
  ///
  /// In en, this message translates to:
  /// **'Google sign in is not implemented yet'**
  String get googleSignInNotImplemented;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @termsOfServicePageComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service page coming soon'**
  String get termsOfServicePageComingSoon;

  /// No description provided for @joinRentalHub.
  ///
  /// In en, this message translates to:
  /// **'Join Rental Hub'**
  String get joinRentalHub;

  /// No description provided for @createAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create an account to start exploring premium properties today.'**
  String get createAccountSubtitle;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @fullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Ali Mohamed'**
  String get fullNameHint;

  /// No description provided for @enterYourFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Full Name'**
  String get enterYourFullName;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we will send a verification code to reset your password.'**
  String get forgotPasswordSubtitle;

  /// No description provided for @sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get sendCode;

  /// No description provided for @verifyCode.
  ///
  /// In en, this message translates to:
  /// **'Verify Code'**
  String get verifyCode;

  /// No description provided for @verifyCodeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code sent to {email}'**
  String verifyCodeSubtitle(String email);

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resendCode;

  /// No description provided for @codeResent.
  ///
  /// In en, this message translates to:
  /// **'Code resent successfully'**
  String get codeResent;

  /// No description provided for @verificationCodeSent.
  ///
  /// In en, this message translates to:
  /// **'Verification code sent successfully'**
  String get verificationCodeSent;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordTitle;

  /// No description provided for @resetPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your new password below'**
  String get resetPasswordSubtitle;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get confirmPasswordHint;

  /// No description provided for @enterConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter confirm password'**
  String get enterConfirmPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @passwordUpdated.
  ///
  /// In en, this message translates to:
  /// **'Password Updated'**
  String get passwordUpdated;

  /// No description provided for @passwordUpdateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your password has been reset successfully. You can now log in with your new password.'**
  String get passwordUpdateSuccess;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get backToLogin;

  /// No description provided for @facebook.
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get facebook;

  /// No description provided for @google.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get google;

  /// No description provided for @loginSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Login successful'**
  String get loginSuccessful;

  /// No description provided for @sendVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Send Verification Code'**
  String get sendVerificationCode;

  /// No description provided for @validEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get validEmail;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @updatePassword.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get updatePassword;

  /// No description provided for @confirmPasswordMessage.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get confirmPasswordMessage;

  /// No description provided for @iAgreeToThe.
  ///
  /// In en, this message translates to:
  /// **'I agree to the '**
  String get iAgreeToThe;

  /// No description provided for @termsAgreementPrefix.
  ///
  /// In en, this message translates to:
  /// **'By joining, you agree to our '**
  String get termsAgreementPrefix;

  /// No description provided for @termsOfServiceLink.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfServiceLink;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **' and '**
  String get and;

  /// No description provided for @privacyPolicyLink.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyLink;

  /// No description provided for @termsAgreementSuffix.
  ///
  /// In en, this message translates to:
  /// **'.'**
  String get termsAgreementSuffix;

  /// No description provided for @myRentals.
  ///
  /// In en, this message translates to:
  /// **'My Rentals'**
  String get myRentals;

  /// No description provided for @balanceAndWallet.
  ///
  /// In en, this message translates to:
  /// **'Balance and wallet'**
  String get balanceAndWallet;

  /// No description provided for @totalBalance.
  ///
  /// In en, this message translates to:
  /// **'Total balance'**
  String get totalBalance;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get currency;

  /// No description provided for @pendingBalance.
  ///
  /// In en, this message translates to:
  /// **'Pending balance'**
  String get pendingBalance;

  /// No description provided for @availableBalance.
  ///
  /// In en, this message translates to:
  /// **'Available balance'**
  String get availableBalance;

  /// No description provided for @withdrawableBalance.
  ///
  /// In en, this message translates to:
  /// **'Withdrawable balance'**
  String get withdrawableBalance;

  /// No description provided for @rechargeBalance.
  ///
  /// In en, this message translates to:
  /// **'Recharge balance'**
  String get rechargeBalance;

  /// No description provided for @withdrawBalance.
  ///
  /// In en, this message translates to:
  /// **'Withdraw balance'**
  String get withdrawBalance;

  /// No description provided for @facebookSignInNotImplemented.
  ///
  /// In en, this message translates to:
  /// **'Facebook sign in is not implemented yet'**
  String get facebookSignInNotImplemented;

  /// No description provided for @latestTransactions.
  ///
  /// In en, this message translates to:
  /// **'Latest transactions'**
  String get latestTransactions;

  /// No description provided for @addYourListing.
  ///
  /// In en, this message translates to:
  /// **'Add your listing'**
  String get addYourListing;

  /// No description provided for @productMedia.
  ///
  /// In en, this message translates to:
  /// **'Product photos and videos'**
  String get productMedia;

  /// No description provided for @chooseCategory.
  ///
  /// In en, this message translates to:
  /// **'Choose category'**
  String get chooseCategory;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @condition.
  ///
  /// In en, this message translates to:
  /// **'Condition'**
  String get condition;

  /// No description provided for @itemName.
  ///
  /// In en, this message translates to:
  /// **'Item name'**
  String get itemName;

  /// No description provided for @itemDescription.
  ///
  /// In en, this message translates to:
  /// **'Item description'**
  String get itemDescription;

  /// No description provided for @rentalPricePerDay.
  ///
  /// In en, this message translates to:
  /// **'Rental price/day'**
  String get rentalPricePerDay;

  /// No description provided for @securityDeposit.
  ///
  /// In en, this message translates to:
  /// **'Security deposit'**
  String get securityDeposit;

  /// No description provided for @productConditionReport.
  ///
  /// In en, this message translates to:
  /// **'Product condition report'**
  String get productConditionReport;

  /// No description provided for @uploadPhotosNote.
  ///
  /// In en, this message translates to:
  /// **'Upload photos or video showing scratches or defects to protect your rights and those of the renter'**
  String get uploadPhotosNote;

  /// No description provided for @addProduct.
  ///
  /// In en, this message translates to:
  /// **'إضافة المنتج'**
  String get addProduct;

  /// No description provided for @noSubscription.
  ///
  /// In en, this message translates to:
  /// **'لم تحصل على اشتراك بعد !'**
  String get noSubscription;

  /// No description provided for @subscriptionPromo.
  ///
  /// In en, this message translates to:
  /// **'تابع احدث باقات الاشتراكات واحصل على اول شهر مجاناَ'**
  String get subscriptionPromo;

  /// No description provided for @subscribeNow.
  ///
  /// In en, this message translates to:
  /// **'Subscribe now!'**
  String get subscribeNow;

  /// No description provided for @contactSeller.
  ///
  /// In en, this message translates to:
  /// **'Contact Seller'**
  String get contactSeller;

  /// No description provided for @conversations.
  ///
  /// In en, this message translates to:
  /// **'Conversations'**
  String get conversations;

  /// No description provided for @noConversationsYet.
  ///
  /// In en, this message translates to:
  /// **'No conversations yet'**
  String get noConversationsYet;

  /// No description provided for @startConversationHint.
  ///
  /// In en, this message translates to:
  /// **'Contact a seller from a product to start chatting'**
  String get startConversationHint;

  /// No description provided for @failedToLoadConversations.
  ///
  /// In en, this message translates to:
  /// **'Failed to load conversations'**
  String get failedToLoadConversations;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @startConversation.
  ///
  /// In en, this message translates to:
  /// **'Start a conversation'**
  String get startConversation;

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// No description provided for @noMessagesYet.
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get noMessagesYet;

  /// No description provided for @typingIndicator.
  ///
  /// In en, this message translates to:
  /// **'is typing...'**
  String get typingIndicator;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @typeMessage.
  ///
  /// In en, this message translates to:
  /// **'Type a message'**
  String get typeMessage;

  /// No description provided for @openingChat.
  ///
  /// In en, this message translates to:
  /// **'Opening chat...'**
  String get openingChat;

  /// No description provided for @myListingsOrders.
  ///
  /// In en, this message translates to:
  /// **'My Listings Orders'**
  String get myListingsOrders;

  /// No description provided for @editProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfileTitle;

  /// No description provided for @personalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInfo;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrders;

  /// No description provided for @noOrders.
  ///
  /// In en, this message translates to:
  /// **'No orders'**
  String get noOrders;

  /// No description provided for @statusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get statusLabel;

  /// No description provided for @renterLabel.
  ///
  /// In en, this message translates to:
  /// **'Renter'**
  String get renterLabel;

  /// No description provided for @productDetails.
  ///
  /// In en, this message translates to:
  /// **'Product Details'**
  String get productDetails;

  /// No description provided for @selectDates.
  ///
  /// In en, this message translates to:
  /// **'Select Dates'**
  String get selectDates;

  /// No description provided for @pickupDate.
  ///
  /// In en, this message translates to:
  /// **'Pickup Date'**
  String get pickupDate;

  /// No description provided for @returnDate.
  ///
  /// In en, this message translates to:
  /// **'Return Date'**
  String get returnDate;

  /// No description provided for @returnDateAfterPickup.
  ///
  /// In en, this message translates to:
  /// **'Return date must be after pickup date'**
  String get returnDateAfterPickup;

  /// No description provided for @deliveryDetails.
  ///
  /// In en, this message translates to:
  /// **'Delivery Details'**
  String get deliveryDetails;

  /// No description provided for @governorate.
  ///
  /// In en, this message translates to:
  /// **'Governorate'**
  String get governorate;

  /// No description provided for @streetAddress.
  ///
  /// In en, this message translates to:
  /// **'Street / Address'**
  String get streetAddress;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get requiredField;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @productNumber.
  ///
  /// In en, this message translates to:
  /// **'Product #'**
  String get productNumber;

  /// No description provided for @egp.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get egp;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @loadingProfile.
  ///
  /// In en, this message translates to:
  /// **'Loading profile...'**
  String get loadingProfile;

  /// No description provided for @guestUser.
  ///
  /// In en, this message translates to:
  /// **'Guest User'**
  String get guestUser;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountSettings;

  /// No description provided for @accountData.
  ///
  /// In en, this message translates to:
  /// **'Account Data'**
  String get accountData;

  /// No description provided for @notificationSettings.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationSettings;

  /// No description provided for @pushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get pushNotifications;

  /// No description provided for @emailUpdates.
  ///
  /// In en, this message translates to:
  /// **'Email Updates'**
  String get emailUpdates;

  /// No description provided for @smsNotifications.
  ///
  /// In en, this message translates to:
  /// **'SMS Notifications'**
  String get smsNotifications;

  /// No description provided for @privacySecurity.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get privacySecurity;

  /// No description provided for @termsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get termsOfUse;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupport;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @rateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate App'**
  String get rateApp;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutApp;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get appVersion;

  /// No description provided for @checkUpdates.
  ///
  /// In en, this message translates to:
  /// **'Check for Updates'**
  String get checkUpdates;

  /// No description provided for @disableAccount.
  ///
  /// In en, this message translates to:
  /// **'Deactivate Account'**
  String get disableAccount;

  /// No description provided for @confirmLogout.
  ///
  /// In en, this message translates to:
  /// **'Confirm Logout'**
  String get confirmLogout;

  /// No description provided for @logoutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logoutConfirmation;

  /// No description provided for @fullNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Full name is required'**
  String get fullNameRequired;

  /// No description provided for @fullNameMinLength.
  ///
  /// In en, this message translates to:
  /// **'Name must be at least 3 characters'**
  String get fullNameMinLength;

  /// No description provided for @phoneNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get phoneNumberRequired;

  /// No description provided for @phoneNumberInvalid.
  ///
  /// In en, this message translates to:
  /// **'Phone number must be digits only (minimum 11 digits)'**
  String get phoneNumberInvalid;

  /// No description provided for @genderRequired.
  ///
  /// In en, this message translates to:
  /// **'Gender is required'**
  String get genderRequired;

  /// No description provided for @cityRequired.
  ///
  /// In en, this message translates to:
  /// **'City is required'**
  String get cityRequired;

  /// No description provided for @governorateRequired.
  ///
  /// In en, this message translates to:
  /// **'Governorate is required'**
  String get governorateRequired;

  /// No description provided for @countryRequired.
  ///
  /// In en, this message translates to:
  /// **'Country is required'**
  String get countryRequired;

  /// No description provided for @currentPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Current password is required'**
  String get currentPasswordRequired;

  /// No description provided for @newPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'New password is required'**
  String get newPasswordRequired;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// No description provided for @confirmNewPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password is required'**
  String get confirmNewPasswordRequired;

  /// No description provided for @passwordMinRequirements.
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters with uppercase letter, number and special character'**
  String get passwordMinRequirements;

  /// No description provided for @passwordsNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsNotMatch;

  /// No description provided for @phoneNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumberLabel;

  /// No description provided for @genderLabel.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get genderLabel;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @retryLabel.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryLabel;

  /// No description provided for @searchOrders.
  ///
  /// In en, this message translates to:
  /// **'Search orders...'**
  String get searchOrders;

  /// No description provided for @noSearchResults.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noSearchResults;

  /// No description provided for @rentalPeriod.
  ///
  /// In en, this message translates to:
  /// **'Rental Period'**
  String get rentalPeriod;

  /// No description provided for @orderTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get orderTotal;

  /// No description provided for @deliveryMethodLabel.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get deliveryMethodLabel;

  /// No description provided for @errorLoadingOrders.
  ///
  /// In en, this message translates to:
  /// **'Failed to load orders. Please try again.'**
  String get errorLoadingOrders;

  /// No description provided for @orderDetailLabel.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get orderDetailLabel;

  /// No description provided for @ownerLabel.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get ownerLabel;

  /// No description provided for @dayLabel.
  ///
  /// In en, this message translates to:
  /// **'day(s)'**
  String get dayLabel;

  /// No description provided for @pricingSummary.
  ///
  /// In en, this message translates to:
  /// **'Pricing Summary'**
  String get pricingSummary;

  /// No description provided for @rentalPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Rental Price'**
  String get rentalPriceLabel;

  /// No description provided for @insurancePriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Insurance Deposit'**
  String get insurancePriceLabel;

  /// No description provided for @serviceFeeLabel.
  ///
  /// In en, this message translates to:
  /// **'Service Fee'**
  String get serviceFeeLabel;

  /// No description provided for @approveOrderLabel.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approveOrderLabel;

  /// No description provided for @rejectOrderLabel.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get rejectOrderLabel;

  /// No description provided for @shipOrderLabel.
  ///
  /// In en, this message translates to:
  /// **'Mark as Shipped'**
  String get shipOrderLabel;

  /// No description provided for @cancelOrderLabel.
  ///
  /// In en, this message translates to:
  /// **'Cancel Order'**
  String get cancelOrderLabel;

  /// No description provided for @confirmReceiptLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Receipt'**
  String get confirmReceiptLabel;

  /// No description provided for @returnOrderLabel.
  ///
  /// In en, this message translates to:
  /// **'Return'**
  String get returnOrderLabel;

  /// No description provided for @rejectReasonTitle.
  ///
  /// In en, this message translates to:
  /// **'Rejection Reason'**
  String get rejectReasonTitle;

  /// No description provided for @rejectReasonHint.
  ///
  /// In en, this message translates to:
  /// **'Enter reason for rejection'**
  String get rejectReasonHint;

  /// No description provided for @returnReasonTitle.
  ///
  /// In en, this message translates to:
  /// **'Return Reason'**
  String get returnReasonTitle;

  /// No description provided for @returnReasonHint.
  ///
  /// In en, this message translates to:
  /// **'Enter reason for return'**
  String get returnReasonHint;

  /// No description provided for @cancelOrderTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel Order?'**
  String get cancelOrderTitle;

  /// No description provided for @cancelOrderMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this order? This action cannot be undone.'**
  String get cancelOrderMessage;

  /// No description provided for @returnOrderTitle.
  ///
  /// In en, this message translates to:
  /// **'Return Order?'**
  String get returnOrderTitle;

  /// No description provided for @returnOrderMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to return this item? Please ensure it is in the same condition.'**
  String get returnOrderMessage;

  /// No description provided for @orderStatusTimeline.
  ///
  /// In en, this message translates to:
  /// **'Status Timeline'**
  String get orderStatusTimeline;

  /// No description provided for @orderPlaced.
  ///
  /// In en, this message translates to:
  /// **'Order Placed'**
  String get orderPlaced;

  /// No description provided for @orderPlacedDesc.
  ///
  /// In en, this message translates to:
  /// **'Your order has been placed and is awaiting owner approval.'**
  String get orderPlacedDesc;

  /// No description provided for @pendingApproval.
  ///
  /// In en, this message translates to:
  /// **'Pending Approval'**
  String get pendingApproval;

  /// No description provided for @pendingApprovalDesc.
  ///
  /// In en, this message translates to:
  /// **'Waiting for the owner to approve your rental request.'**
  String get pendingApprovalDesc;

  /// No description provided for @orderApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get orderApproved;

  /// No description provided for @orderApprovedDesc.
  ///
  /// In en, this message translates to:
  /// **'The owner has approved your order. Preparing for shipment.'**
  String get orderApprovedDesc;

  /// No description provided for @orderShipped.
  ///
  /// In en, this message translates to:
  /// **'Shipped'**
  String get orderShipped;

  /// No description provided for @orderShippedDesc.
  ///
  /// In en, this message translates to:
  /// **'Your order has been shipped and is on the way.'**
  String get orderShippedDesc;

  /// No description provided for @confirmedReceipt.
  ///
  /// In en, this message translates to:
  /// **'Confirmed Receipt'**
  String get confirmedReceipt;

  /// No description provided for @confirmedReceiptDesc.
  ///
  /// In en, this message translates to:
  /// **'You have confirmed receipt of the item.'**
  String get confirmedReceiptDesc;

  /// No description provided for @orderReturned.
  ///
  /// In en, this message translates to:
  /// **'Returned'**
  String get orderReturned;

  /// No description provided for @orderReturnedDesc.
  ///
  /// In en, this message translates to:
  /// **'The item has been returned to the owner.'**
  String get orderReturnedDesc;

  /// No description provided for @cancelledLabel.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelledLabel;
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
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
