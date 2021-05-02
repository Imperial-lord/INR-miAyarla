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

  // Doctor
  // Patient Monitor
  // Patient Medications
  // Add Medicine
  List<String> addMedicineday = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  String addMedicineEndDate = 'End Date';
  String addMedicineTitle = 'Add a medicine';
  String addMedicineMedicineName = 'Medicine Name';
  String addMedicineMedicinePlaceholder = 'Eg. Paracetamol';
  String addMedicineTimingsAndNotes = 'Timings and Notes';
  String addMedicineSnackbar = 'Please add at least 1 timing entry';
  String addMedicineButton = 'Add medicine';

  // Edit Medicine
  // Some variables are same as previous Add Medicine
  String editMedicineTitle = 'Edit medicine details';
  String editMedicineDelete = 'Delete';
  String editMedicineUpdate = 'Update';

  // Medications
  String medicationsTitle = 'Medications';
  String medicationsEndingDate = 'Ending Date: ';

  // Timings and Notes
  String timingsAndNotesTime = 'Time';
  String timingsAndNotesDosageValue = '1 tablet';
  String timingsAndNotesDosage = 'Dosage';
  String timingsAndNotesDosagePlaceholder = 'Eg. 1 drop';
  String timingsAndNotesNotes = 'Notes';
  String timingsAndNotesNotesPlaceholder = 'Eg. After meal';
  String timingsAndNotesSave = 'Save';
  String timingsAndNotesAddAnEntry = 'Add an entry';

  // Add Doctor Notes
  String addDoctorNotesHeader = 'Add a note';
  String addDoctorNotesPlaceholder = 'Enter a note';
  String addDoctorNotesSnackbar = "Can't add a blank note";
  String addDoctorNotesAdd = 'Add';

  // Add Visit Dates
  String addVisitDatesEdit = 'Edit';
  String addVisitDatesImportantDates = 'Important Dates';
  String addVisitDatesLastVisitDate = 'Last visit date';
  String addVisitDatesNextVisitDate = 'Next visit date';

  // Monitor Patient Health
  String monitorPatientHealthTitle = 'Health';

  // Add More Doctors
  String addMoreDoctorsTitle = 'Add Doctors';
  String addMoreDoctorsNotRegistered = 'Doctor not registered';
  String addMoreDoctorsPhoneNumber = 'Phone number';
  String addMoreDoctorsSearchCountry = 'Search Country or Code';
  String addMoreDoctorsNumberPlaceholder = "Doctor's Number";
  String addMoreDoctorsAddADoc = 'Add a doctor';
  String addMoreDoctorsInvalidNumber = 'Please enter a valid phone number';
  String addMoreDoctorsDeleteWarning =
      'Are you sure you want to delete {phoneNumber} from the database?';
  String addMoreDoctorsDeleteWarningLoseAccess =
      'The selected doctor will lose access to the application';

  // Doctor Approved
  String doctorApproved = 'Approved!';

  // DoctorEditProfile
  String doctorEditProfileNoDataAvailable = 'No data available';
  String doctorEditProfileBigPicSnackbar =
      'Please choose a photo of size < 2 MB';
  String doctorEditProfileTitle = 'Edit Profile!';
  String doctorEditProfileName = 'Your full name';
  String doctorEditProfileNamePlaceholder = 'Enter your name';
  String doctorEditProfilePhoneNumber = 'Your phone number';
  String doctorEditProfilePhoneNumberPlaceholder = 'Enter your phone number';
  String doctorEditProfileSpecialisation = 'Your specialisation';
  String doctorEditProfileSpecialisationPlaceholder =
      'What do you specialise in?';
  String doctorEditProfileHospitalName = 'Hospital Name';
  String doctorEditProfileHospitalNamePlaceholder =
      'Which hospital do you work in?';
  String doctorEditProfileCityName = 'Your City Name';
  String doctorEditProfileCityNamePlaceholder = 'Enter your city name';
  String doctorEditProfileDeptName = 'Your Department Name';
  String doctorEditProfileDeptNamePlaceholder = 'Enter your department name';
  String doctorEditProfileEmptyFiledsSnackbar = 'One or more fields are empty';
  String doctorEditProfileButtonUpdate = 'Update Profile';

  // Doctor Home
  String doctorHomeYourPatients = 'Your Patients';
  String doctorHomeSearchNameorNumber = 'Search a name or number';
  String doctorHomeNoResults = 'No results found';

  // Doctor Management
  String doctorManagementHome = 'Home';
  String doctorManagementProfile = 'Profile';
  String doctorManagamentAbout = 'About';
}
