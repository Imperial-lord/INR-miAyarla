import 'package:flutter/material.dart';

// List all String here for easy translation to Turkish
class MyStrings {
  // Widgets -------------------------------------------------------------------------
  // Loader Hud
  String loaderHudLoading = 'Loading';

  // Stores
  // Login_Store
  String loginStoreWrongCode =
      'Wrong code ! Please enter the last code received.';
  String loginStoreWrongPhoneNumber =
      'The phone number format is incorrect. Please enter your number in E.164 format. [+][country code][number]';
  String loginStoreSomethingGoneWrong =
      'Something has gone wrong, please try later';
  String loginStoreInvalidCodeOrAuth = 'Invalid code/invalid authentication';

  // Pages ----------------------------------------------------------------------------
  // Common
  // Auth
  // OtpPage
  String otpPageEnter = 'Enter';
  String otpPageOTP = 'OTP';
  String otpPageEnter6DigitCode =
      'Enter the 6 digit OTP we sent to your mobile';
  String otpPageResendOTP = 'Resend OTP';
  String otpPageConfirm = 'Confirm';

  // SignIn
  String signInEnterMobileNumber = 'Enter your mobile number to get an OTP';
  String signInSign = 'Sign';
  String signInIn = 'In';
  String signInSearchCountryOrCode = 'Search Country or Code';
  String signIn10DigitNumber = '10 digit number';
  String signInGetOTP = 'Get OTP';
  String signInNoPhoneNumber = 'Please enter a phone number';

  // Chat
  // Chat
  String chatWriteMessage = 'Write a message';

  // AboutApp
  String aboutAppHeader = 'About App';

  // Latest Test Results
  String latestTestResultsSizeLimit = 'Please choose a file of size < 2 MB';
  String latestTestResultsHeader = 'Latest Test Results';
  String latestTestResultsUpload = 'Upload';
  String latestTestResultsDownloading = 'Downloading';

  // UserType
  String userTypeTellUsMore = 'Tell us more';
  String userTypeAboutYou = 'about you';
  String userTypeWhoAreYou =
      'Are you a doctor trying to cater to a patient\'s needs or a patient here for connecting with doctors?';
  String userTypeDoctor = 'Doctor';
  String userTypePatient = 'Patient';
  String userTypeSnackBar = 'Please choose a user type';

  // Welcome
  String welcomeHeader = 'Welcome';
  String welcomeTo = 'To';
  String welcomeOneStopSol =
      'The one-stop solution for all your health needs. Get in touch with your doctors right from your phone!';
}
