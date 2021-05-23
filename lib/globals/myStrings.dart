/* English Strings

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
  String aboutAppPrivacyPolicy = 'Privacy Policy';
  String aboutAppAppVersion = 'App Version - v1.0.0';

  // Latest Test Results
  String latestTestResultsSizeLimit = 'Please choose a file of size < 2 MB';
  String latestTestResultsHeader = 'Latest Test Results';
  String latestTestResultsUpload = 'Upload';
  String latestTestResultsUploading = 'Uploading';
  String latestTestResultsOpening = 'Opening';

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
  String welcomeTo = 'to ';
  String welcomeOneStopSol =
      'The one-stop solution for all your health needs. Get in touch with your doctors right from your phone!';

  // Doctor
  // Patient Monitor
  // Patient Medications
  // Add Medicine
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
  String addDoctorNotesTitle = 'Doctor Notes';

  // Add Visit Dates
  String addVisitDatesEdit = 'Edit';
  String addVisitDatesSave = 'Save';
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
  String doctorEditProfileSignUpDate = 'Your sign up date';
  String doctorEditProfileEmptyFiledsSnackbar = 'One or more fields are empty';
  String doctorEditProfileButtonUpdate = 'Update Profile';

  // Doctor Home
  String doctorHomeYourPatients = 'Your Patients';
  String doctorHomeSearchNameorNumber = 'Search a name or number';
  String doctorHomeNoResults = 'No results found';

  // Doctor Management
  String doctorManagementHome = 'Home';
  String doctorManagementProfile = 'Profile';
  String doctorManagementAbout = 'About';
  String doctorManagementAddDoctors = 'Add Doctors';

  ///////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////
  // ------------------------_TRANSLATION DONE TILL HERE_--------------------------//
  ///////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////

  // Doctor Patient Interface
  String doctorPatientInterfaceTransferCheck =
      'Are you sure you want to transfer <Patient Name> to <Doctor Name> ?';
  String doctorPatientInterfaceSuccessfulTransfer =
      'The patient has been successfully transferred';
  String doctorPatientInterfaceYes = 'Yes';
  String doctorPatientInterfaceNo = 'No';
  String doctorPatientInterfaceTransferTitle = 'Transfer Patient';
  String doctorPatientInterfaceTransferWarning =
      'By transferring a patient you will lose access to his account.'
      ' You can request the concerned doctor to re-transfer him back to you in the future!';
  String doctorPatientInterfaceBack = 'Back';
  String doctorPatientInterfaceProfile = "<Patient Name's> Profile";
  String doctorPatientInterfaceChat = 'Chat';
  String doctorPatientInterfaceSendNotification = 'Send Notification';
  String doctorPatientInterfacePersonal = 'Personal';
  String doctorPatientInterfaceDOB = 'DOB';
  String doctorPatientInterfaceAge = 'Age';
  String doctorPatientInterfaceGender = 'Gender';
  String doctorPatientInterfacePhoneNumber = 'PhoneNumber';
  String doctorPatientInterfaceEmailAddress = 'Email Address';
  String doctorPatientInterfaceResidentialAddress = 'Residential Address';
  String doctorPatientInterfaceSignUpDate = 'Sign-up Date';
  String doctorPatientInterfaceMedicalHistory = 'Medical History';
  String doctorPatientInterfaceIllness = 'Illness';
  String doctorPatientInterfaceAllergies = 'Allergies';
  String doctorPatientInterfaceGeneticDiseases = 'Genetic Diseases';
  String doctorPatientInterfaceNoDataAvailable = 'No Data Available';
  String doctorPatientInterfaceMonitorPatientHealth = 'Monitor Patient Health';

  // Doctor Profile
  String doctorProfileLogoutSure = 'Are you sure you want to logout?';
  String doctorProfileLogout = 'Logout';
  String doctorProfileNo = 'No';
  String doctorProfileYourProfile = 'Your Profile';
  String doctorProfileNoDataAvailable = 'No data available';
  String doctorProfileProfileDetails = 'Profile Details';
  String doctorProfileName = 'Name';
  String doctorProfilePhoneNumber = 'PhoneNumber';
  String doctorProfileSpecialisation = 'Specialisation';
  String doctorProfileHospitalName = 'Hospital Name';
  String doctorProfileCityName = 'CityName';
  String doctorProfileDepartmentName = 'Department Name';
  String doctorProfileSignUpDate = 'Sign-up Date';
  String doctorProfileEditProfile = 'Edit Profile';
  String doctorProfileLogOut = 'Log Out';

  // Doctor Registration
  String doctorRegHello = 'Hello there!';
  String doctorRegSetUp = "Let's get you all setup";
  String doctorRegNoDataAvailable = 'No data available';
  String doctorRegName = 'Your full name';
  String doctorRegNamePlaceholder = 'Enter your name';
  String doctorRegPhoneNumber = 'Your phone number';
  String doctorRegPhoneNumberPlaceholder = 'Enter your phone number';
  String doctorRegSpecialisation = 'Your specialisation';
  String doctorRegSpecialisationPlaceholder = 'What do you specialise in?';
  String doctorRegHospitalName = 'Hospital Name';
  String doctorRegHospitalNamePlaceholder = 'Which hospital do you work in?';
  String doctorRegCityName = 'Your City Name';
  String doctorRegCityNamePlaceholder = 'Enter your city name';
  String doctorRegDeptName = 'Your Department Name';
  String doctorRegDeptNamePlaceholder = 'Enter your department name';
  String doctorRegEmptyFieldsSnackBar = 'One or more fields are empty';
  String doctorRegButtonSubmit = 'Submit';

  // Doctor Rejected
  String doctorRejectedDB = 'Sorry, you are not in our database!';
  String doctorRejectedSecurity =
      'For security reasons, you need to first ask a colleague to add your phone number to the database.';
  String doctorRejectedYouPatient = 'Are you a patient?';
  String doctorRejectedContinueAsPatient = 'Continue as a patient';

  // Doctor Send Notifications
  String doctorSendNotificationsHeading = 'Send a Notification';
  String doctorSendNotificationsTitle = 'Title';
  String doctorSendNotificationsTitleDesc = 'Add a notification title';
  String doctorSendNotificationsBody = 'Body';
  String doctorSendNotificationsBodyDesc = 'Add a notification body';
  String doctorSendNotificationButtonText = 'Send notification';

  // Doctor Upload Photo
  String doctorUploadPhotoBigPhotoSnackBar = 'Please choose a photo of size < 2 MB';
  String doctorUploadPhotoSmile = 'Smile Please! 😇';
  String doctorUploadPhotoDesc = 'We are almost done! We just need you to upload a profile picture.';
  String doctorUploadPhotoBigPhotoWarning = 'Kindly upload a photo of size < 2 MB';
  String doctorUploadPhotoSave = 'Save and proceed';

  // Patients
  // Patient Medications
  // Current Medications
  String currentMedicationsTimeForMeds = 'Time to take your medicine';
  String currentMedicationsNotificationContent = "Name: <Medicine Name>\nDosage: <Medicine Dosage>\nNotes: <Medicine Notes>";
  String currentMedicationsHeading = 'Current Medications';
  String currentMedicationsNoMedicines = 'Sorry you doctor has not added any medicine for you at the moment.';
  String currentMedicationsEndsOn = 'Ends on: <date>';
  String currentMedicationsSnackBar = '<Medicine Name> has been scheduled';

  // Patient Timings Notes
  String patientTimingsNotesTime = 'Time: ';
  String patientTimingsNotesDosage = 'Dosage: ';
  String patientTimingsNotesNotes = 'Notes: ';
  String patientTimingsNotesNoMeds = 'No medicines for this day';

  // View Medicine
  String viewMedicineEndDate = 'End Date';
  String viewMedicineTitle = 'View medicine details';
  String viewMedicineMedicineName = 'Medicine Name';
  String viewMedicineMedicinePlaceholder = 'Eg. Paracetamol';
  String viewMedicineTimingsAndNotes = 'Timings and Notes';

  // Patient Edit Profile
  String patientEditProfileNoData = 'No data available';
  String patientEditProfileBigPhotoSnackBar = 'Please choose a photo of size < 2 MB';
  String patientEditProfileTitle = 'Edit Profile';
  String patientEditProfileName = 'Your full name';
  String patientEditProfileNamePlaceholder = 'Enter your name';
  String patientEditProfileDOB = 'Your date of birth';
  String patientEditProfileDOBPlaceholder = 'Select a date';
  String patientEditProfileAge = 'Your age';
  String patientEditProfileAgePlaceholder = 'Enter your age';
  String patientEditProfileGender = 'Your gender';
  String patientEditProfileGenderMale = 'Male';
  String patientEditProfileGenderFemale = 'Female';
  String patientEditProfilePhoneNumber = 'Your phone number';
  String patientEditProfilePhoneNumberPlaceholder = 'Enter your phone number';
  String patientEditProfileEmailAddress = 'Your email address';
  String patientEditProfileEmailAddressPlaceholder = 'Enter your email';
  String patientEditProfileResidenceAddress = 'Your residence address';
  String patientEditProfileResidenceAddressPlaceholder = 'Enter your complete address';
  String patientEditProfileAilments = 'Your ailments';
  String patientEditProfileAilmentsPlaceholder = 'What diseases are you suffering from?';
  String patientEditProfileAllergies = 'Your allergies';
  String patientEditProfileAllergiesPlaceholder = 'Do you have any specific allergies?';
  String patientEditProfileGeneticDisorder = 'Your genetic disorders';
  String patientEditProfileGeneticDisorderPlaceholder = 'Do you have any genetic disorders?';
  String patientEditProfileEmptyFields = 'One or more fields are empty';
  String patientEditProfileInvalidDOB = 'Please enter a valid date of birth';
  String patientEditProfileInvalidEmail = 'Please enter a valid email';
  String patientEditProfileUpdateProfile = 'Update Profile';

  // PatientHome
  String patientHomeTitle = 'Home';
  String patientHomeDoctorDetails = 'Doctor Details';
  String patientHomeDepartment = 'Department';
  String patientHomeChat = 'Chat';
  String patientHomeShowNotification = 'Show Notification';
  String patientHomeDoctorNotes = 'Doctor Notes';
  String patientHomeNoDoctorNotes = 'Sorry you doctor has not added any notes at the moment.';
  String patientHomeImportantDates = 'Important Dates';
  String patientHomeLastVisit = '• Last Visit: ';
  String patientHomeNextVisit = '• Next Visit: ';
  String patientHomeNotAvailable = 'Not available';

  // Patient Management
  String patientManagementHome = 'Home';
  String patientManagementNotifications = 'Notifications';
  String patientManagementProfile = 'Profile';
  String patientManagementAbout = 'About';

  // Patient Notifications
  String patientNotificationsTitle = 'Your notifications';
  String patientNotificationsNoNotifications = 'Sorry you have no notifications at the moment!';
  String patientNotificationsNoBody = 'This notification has no body.';

  // Patient Profile
  String patientProfileCheckLogout = 'Are you sure you want to logout?';
  String patientProfileLogout = 'Logout';
  String patientProfileNo = 'No';
  String patientProfileTitle = 'Your Profile';
  String patientProfileNoDataAvailable = 'No data available';
  String patientProfilePersonal = 'Personal';
  String patientProfileName = 'Name';
  String patientProfileDOB = 'DOB';
  String patientProfileAge = 'Age';
  String patientProfileGender = 'Gender';
  String patientProfilePhoneNumber = 'Phone Number';
  String patientProfileEmailAddress = 'Email Address';
  String patientProfileResidentialAddress = 'Residential Address';
  String patientProfileMedicalHistory='Medical History';
  String patientProfileIllness = 'Illness';
  String patientProfileAllergies = 'Allergies';
  String patientProfileGeneticDiseases = 'Genetic Diseases';
  String patientProfileEditProfile = 'Edit Profile';
  String patientProfileLogOut = 'Log Out';

  // Patient Registration
  String patientRegistrationTitle = 'Hello there!';
  String patientRegistrationAllSetUp = "Let's get you all set up!";
  String patientRegistrationName = 'Your full name';
  String patientRegistrationNamePlaceholder = 'Enter your name';
  String patientRegistrationDOB = 'Your date of birth';
  String patientRegistrationDOBPlaceholder = 'Select a date';
  String patientRegistrationAge = 'Your age';
  String patientRegistrationAgePlaceholder = 'Enter your age';
  String patientRegistrationGender = 'Your gender';
  String patientRegistrationGenderMale = 'Male';
  String patientRegistrationGenderFemale = 'Female';
  String patientRegistrationPhoneNumber = 'Your phone number';
  String patientRegistrationPhoneNumberPlaceholder = 'Enter your phone number';
  String patientRegistrationEmailAddress = 'Your email address';
  String patientRegistrationEmailAddressPlaceholder = 'Enter your email';
  String patientRegistrationResidenceAddress = 'Your residence address';
  String patientRegistrationResidenceAddressPlaceholder = 'Enter your complete address';
  String patientRegistrationAilments = 'Your ailments';
  String patientRegistrationAilmentsPlaceholder = 'What diseases are you suffering from?';
  String patientRegistrationAllergies = 'Your allergies';
  String patientRegistrationAllergiesPlaceholder = 'Do you have any specific allergies?';
  String patientRegistrationGeneticDisorder = 'Your genetic disorders';
  String patientRegistrationGeneticDisorderPlaceholder = 'Do you have any genetic disorders?';
  String patientRegistrationEmptyFields = 'One or more fields are empty';
  String patientRegistrationInvalidDOB = 'Please enter a valid date of birth';
  String patientRegistrationInvalidEmail = 'Please enter a valid email';
  String patientRegistrationSubmit = 'Submit';

  // Patient Select Doctor
  String patientSelectDoctorTitle = 'Select a Doctor';
  String patientSelectDoctorNoDoctorSelected = 'Please select at least one doctor';
  String patientSelectDoctorButton = 'Select Doctor';

  // Patient Upload Photo
  String patientUploadPhotoBigPhotoSnackBar = 'Please choose a photo of size < 2 MB';
  String patientUploadPhotoSmile = 'Smile Please! 😇';
  String patientUploadPhotoAlmostDone = 'We are almost done! We just need you to upload a profile picture.';
  String patientUploadPhotoSizeWarning = 'Kindly upload a photo of size < 2 MB';
  String patientUploadPhotoSave = 'Save and proceed';
}

*/



// TODO: Change commented parts after verifying all good wrt to String variables.
// TODO: Add extra variables, and use Google Translate to translate them.

// List all String here for easy translation to Turkish
class MyStrings {
  // Widgets -------------------------------------------------------------------------
  // Loader Hud
  String loaderHudLoading = 'Yükleniyor';

  // Stores
  // Login_Store
  String loginStoreWrongCode =
      'Yanlış kod! Lütfen gönderilen son kodu girin.';
  String loginStoreWrongPhoneNumber =
      'Telefon numarası biçimi yanlış! Lütfen telefon numaranızı [+][ülke kodu][telefon numarası] olarak giriniz.';
  String loginStoreSomethingGoneWrong =
      'Bir şeyler ters gitti! Lütfen daha sonra deneyiniz';
  String loginStoreInvalidCodeOrAuth = 'Geçersiz kod veya kimlik doğrulama';

  // Pages ----------------------------------------------------------------------------
  // Common
  // Auth
  // OtpPage
  String otpPageEnter = 'Giriş';
  String otpPageOTP = 'Kod';
  String otpPageEnter6DigitCode =
      'Cep telefonunuza gönderilen 6 haneli kodu girin';
  String otpPageResendOTP = 'Kodu tekrar gönder';
  String otpPageConfirm = 'Onayla';

  // SignIn
  String signInEnterMobileNumber = 'Kodu almak için cep telefonu numaranızı giriniz';
  String signInSign = 'Oturum ';
  String signInIn = 'aç';
  String signInSearchCountryOrCode = 'Ülke Ara';
  String signIn10DigitNumber = '10 basamaklı sayı';
  String signInGetOTP = 'Kodu al';
  String signInNoPhoneNumber = 'Lütfen bir telefon numarası girin';

  // Chat
  // Chat
  String chatWriteMessage = 'Bir mesaj yazın';

  // AboutApp
  String aboutAppHeader = 'Uygulama Hakkında';
  String aboutAppPrivacyPolicy = 'Gizlilik Politikası';
  String aboutAppAppVersion = 'Uygulama Sürümü - v1.0.0';

  // Latest Test Results
  String latestTestResultsSizeLimit = 'Lütfen boyutu <2 MB olan bir dosya seçin';
  String latestTestResultsHeader = 'En Son Test Sonuçları';
  String latestTestResultsUpload = 'Yükle';
  String latestTestResultsDownloading = 'İndiriliyor';
  String latestTestResultsUploading = 'Yükleniyor';
  String latestTestResultsOpening = 'Açılış';

  // UserType
  String userTypeTellUsMore = 'Bize kendinden';
  String userTypeAboutYou = 'bahseder misin?';
  String userTypeWhoAreYou =
      'Bir hastanın ihtiyaçlarını karşılamaya çalışan doktor musunuz yoksa doktorlarla bağlantı kurmak isteyen bir hasta mısınız?';
  String userTypeDoctor = 'Doktor';
  String userTypePatient = 'Hasta';
  String userTypeSnackBar = 'Lütfen bir kullanıcı türü seçin';

  // Welcome
  String welcomeHeader = 'Hoş geldiniz';
  String welcomeTo = '';
  String welcomeOneStopSol =
      'Sağlık ihtiyaçlarınız için telefonunuzdan doktorlarınız ile iletişime geçin!';

  // Doctor
  // Patient Monitor
  // Patient Medications
  // Add Medicine
  List<String> addMedicineDay = [
    'Pazartesi',
    'Salı',
    'Çarşamba',
    'Perşembe',
    'Cuma',
    'Cumartesi',
    'Pazar'
  ];
  String addMedicineEndDate = 'Son Tarih';
  String addMedicineTitle = 'İlaç Ekle';
  String addMedicineMedicineName = 'İlaç İsmi';
  String addMedicineMedicinePlaceholder = 'Örnek: Coumaran';
  String addMedicineTimingsAndNotes = 'Zamanlama ve Notlar';
  String addMedicineSnackbar = 'Lütfen en az 1 giriş ekleyin';
  String addMedicineButton = 'İlaç Ekle';

  // Edit Medicine
  // Some variables are same as previous Add Medicine
  String editMedicineTitle = 'İlaç ayrıntılarını düzenleyin';
  String editMedicineDelete = 'Sil';
  String editMedicineUpdate = 'Güncelle';

  // Medications
  String medicationsTitle = 'İlaçlar';
  String medicationsEndingDate = 'Son Tarih: ';

  // Timings and Notes
  String timingsAndNotesTime = 'Zaman';
  String timingsAndNotesDosageValue = '1 tablet';
  String timingsAndNotesDosage = 'Doz';
  String timingsAndNotesDosagePlaceholder = 'Örnek: 1 damla';
  String timingsAndNotesNotes = 'Notlar';
  String timingsAndNotesNotesPlaceholder = 'Örnek: Yemekten sonra';
  String timingsAndNotesSave = 'Kaydet';
  String timingsAndNotesAddAnEntry = 'Giriş Ekle';

  // Add Doctor Notes
  String addDoctorNotesHeader = 'Not Ekle';
  String addDoctorNotesPlaceholder = 'Not gir';
  String addDoctorNotesSnackbar = 'Boş not ekleyemezsiniz';
  String addDoctorNotesAdd = 'Ekle';
  String addDoctorNotesTitle = 'Doktor Notları';

  // Add Visit Dates
  String addVisitDatesEdit = 'Düzenle';
  String addVisitDatesImportantDates = 'Önemli Tarihler';
  String addVisitDatesLastVisitDate = 'Son ziyaret tarihi';
  String addVisitDatesNextVisitDate = 'Sonraki ziyaret tarihi';
  String addVisitDatesSave = 'Kayıt etmek';

  // Monitor Patient Health
  String monitorPatientHealthTitle = 'Sağlık';

  // Add More Doctors
  String addMoreDoctorsTitle = 'Doktor Ekle';
  String addMoreDoctorsNotRegistered = 'Doktor kayıtlı değil';
  String addMoreDoctorsPhoneNumber = 'Telefon Numarası';
  String addMoreDoctorsSearchCountry = 'Ülke veya Kod Ara';
  String addMoreDoctorsNumberPlaceholder = 'Doktor Numarası';
  String addMoreDoctorsAddADoc = 'Doktor ekle';
  String addMoreDoctorsInvalidNumber = 'Geçerli bir telefon numarası giriniz';
  String addMoreDoctorsDeleteWarning =
      '{phone Number} numarasını veritabanından silmek istediğinizden emin misiniz?';
  String addMoreDoctorsDeleteWarningLoseAccess =
      'Seçilen doktor, uygulamaya erişimini kaybedecek!';
  String addMoreDoctorsDelete = 'Sil';

  // Doctor Approved
  String doctorApproved = 'Onaylandı!';

  // DoctorEditProfile
  String doctorEditProfileNoDataAvailable = 'Uygun veri yok!';
  String doctorEditProfileBigPicSnackbar =
      'Lütfen <2 MB boyutunda bir fotoğraf seçiniz!';
  String doctorEditProfileTitle = 'Profili Güncelle';
  String doctorEditProfileName = 'Adınız ve Soyadınız';
  String doctorEditProfileNamePlaceholder = 'Adınızı giriniz';
  String doctorEditProfilePhoneNumber = 'Telefon Numaranız';
  String doctorEditProfilePhoneNumberPlaceholder = 'Telefon numaranızı giriniz';
  String doctorEditProfileSpecialisation = 'Uzmanlık Alanınız';
  String doctorEditProfileSpecialisationPlaceholder =
      'Uzmanlık alanınız nedir?';
  String doctorEditProfileHospitalName = 'Hastane İsmi';
  String doctorEditProfileHospitalNamePlaceholder =
      'Hangi hastanede çalışıyorsunuz?';
  String doctorEditProfileCityName = 'Şehriniz';
  String doctorEditProfileCityNamePlaceholder = 'Şehrinizi giriniz';
  String doctorEditProfileDeptName = 'Bölüm Adı';
  String doctorEditProfileDeptNamePlaceholder = 'Bölüm adınızı giriniz';
  String doctorEditProfileEmptyFiledsSnackbar = 'Bir veya daha fazla alan boş';
  String doctorEditProfileButtonUpdate = 'Profili Güncelle';
  String doctorEditProfileSignUpDate = 'Kayıt tarihiniz';

  // Doctor Home
  String doctorHomeYourPatients = 'Hastalarınız';
  String doctorHomeSearchNameorNumber = 'İsim veya numara arayın';
  String doctorHomeNoResults = 'Sonuç bulunamadı';

  // Doctor Management
  String doctorManagementHome = 'Ana Sayfa';
  String doctorManagementProfile = 'Profil';
  String doctorManagementAbout = 'Hakkında';
  String doctorManagementAddDoctors = 'Doktor Ekle';

  ///////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////
  // ------------------------_TRANSLATION DONE TILL HERE_--------------------------//
  ///////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////
  // Doctor Patient Interface
  String doctorPatientInterfaceTransferCheck =
      '<Patient Name> isimli hastayı <Doctor Name> isimli doktora transfer etmek istediğinize emin misiniz?';
  String doctorPatientInterfaceSuccessfulTransfer =
      'Hasta başarıyla transfer edildi.';
  String doctorPatientInterfaceYes = 'Evet';
  String doctorPatientInterfaceNo = 'Hayır';
  String doctorPatientInterfaceTransferTitle = 'Hasta Transfer Et';
  String doctorPatientInterfaceTransferWarning =
      'Bu hastayı transfer ederek erişimi kaybedeceksiniz.'
      ' İlgili doktordan onu daha sonra size geri göndermesini talep edebilirsiniz!';
  String doctorPatientInterfaceBack = 'Geri';
  String doctorPatientInterfaceProfile = "<Patient Name> Profili";
  String doctorPatientInterfaceChat = 'Sohbet';
  String doctorPatientInterfaceSendNotification = 'Bildirim Gönder';
  String doctorPatientInterfacePersonal = 'Kişisel';
  String doctorPatientInterfaceDOB = 'Doğum Tarihi';
  String doctorPatientInterfaceAge = 'Yaş';
  String doctorPatientInterfaceGender = 'Cinsiyet';
  String doctorPatientInterfacePhoneNumber = 'Telefon Numarası';
  String doctorPatientInterfaceEmailAddress = 'Email Adresi';
  String doctorPatientInterfaceResidentialAddress = 'Adres';
  String doctorPatientInterfaceSignUpDate = 'Kayıt Tarihi';
  String doctorPatientInterfaceMedicalHistory = 'Tıbbi Geçmiş';
  String doctorPatientInterfaceIllness = 'Hastalık';
  String doctorPatientInterfaceAllergies = 'Alerjiler';
  String doctorPatientInterfaceGeneticDiseases = 'Genetik Hastalıklar';
  String doctorPatientInterfaceNoDataAvailable = 'Yeterli Veri Yok';
  String doctorPatientInterfaceMonitorPatientHealth = 'Hasta Sağlığını İzleyin';

  // Doctor Profile
  String doctorProfileLogoutSure = 'Çıkış yapmak istediğinizden emin misiniz?';
  String doctorProfileLogout = 'Çıkış Yap';
  String doctorProfileNo = 'Hayır';
  String doctorProfileYourProfile = 'Profilin';
  String doctorProfileNoDataAvailable = 'Uygun veri yok';
  String doctorProfileProfileDetails = 'Profil Detayları';
  String doctorProfileName = 'Adı';
  String doctorProfilePhoneNumber = 'Telefon Numarası';
  String doctorProfileSpecialisation = 'Uzmanlık';
  String doctorProfileHospitalName = 'Hastane';
  String doctorProfileCityName = 'Şehir';
  String doctorProfileDepartmentName = 'Bölüm Adı';
  String doctorProfileSignUpDate = 'Kayıt Tarihi';
  String doctorProfileEditProfile = 'Profili Düzenle';
  String doctorProfileLogOut = 'Çıkış Yap';

  // Doctor Registration
  String doctorRegHello = 'Merhaba !';
  String doctorRegSetUp = "Kurulumunuzu yapmaya başlayalım!";
  String doctorRegNoDataAvailable = 'Yeterli Veri Yok';
  String doctorRegName = 'Adınız ve Soyadınız';
  String doctorRegNamePlaceholder = 'Adınızı giriniz';
  String doctorRegPhoneNumber = 'Telefon numaranız';
  String doctorRegPhoneNumberPlaceholder = 'Telefon numaranızı girin';
  String doctorRegSpecialisation = 'Uzmanlık Alanınız';
  String doctorRegSpecialisationPlaceholder = 'Uzmanlık alanınız nedir?';
  String doctorRegHospitalName = 'Hastane İsmi';
  String doctorRegHospitalNamePlaceholder = 'Hangi hastanede çalışıyorsunuz?';
  String doctorRegCityName = 'Şehriniz';
  String doctorRegCityNamePlaceholder = 'Şehrinizi giriniz';
  String doctorRegDeptName = 'Bölüm Adı';
  String doctorRegDeptNamePlaceholder = 'Bölüm adınızı giriniz';
  String doctorRegEmptyFieldsSnackBar = 'Bir veya daha fazla alan boş';
  String doctorRegButtonSubmit = 'Kaydet';

  // Doctor Rejected
  String doctorRejectedDB = 'Üzgünüz, veritabanımızda değilsiniz!';
  String doctorRejectedSecurity =
      'Güvenlik nedeniyle, önce bir iş arkadaşınızdan telefon numaranızı veritabanına eklemesini istemeniz gerekir.';
  String doctorRejectedYouPatient = 'Hasta mısınız?';
  String doctorRejectedContinueAsPatient = 'Hasta olarak devam et';

  // Doctor Send Notifications
  String doctorSendNotificationsHeading = 'Bildirim Gönderin';
  String doctorSendNotificationsTitle = 'Başlık';
  String doctorSendNotificationsTitleDesc = 'Bildirim başlığı ekleyin';
  String doctorSendNotificationsBody = 'Mesaj';
  String doctorSendNotificationsBodyDesc = 'Bildirim mesajı ekleyin';
  String doctorSendNotificationButtonText = 'Bildirim Gönder';

  // Doctor Upload Photo
  String doctorUploadPhotoBigPhotoSnackBar = 'Lütfen <2 MB boyutunda bir fotoğraf seçiniz!';
  String doctorUploadPhotoSmile = 'Gülümseyin! 😇';
  String doctorUploadPhotoDesc = 'Neredeyse bitti! Sadece bir profil resmi yüklememiz gerekiyor.';
  String doctorUploadPhotoBigPhotoWarning = 'Lütfen boyutu <2 MB olan bir fotoğraf yükleyin';
  String doctorUploadPhotoSave = 'Kaydet ve devam et';

  // Patients
  // Patient Medications
  // Current Medications
  String currentMedicationsTimeForMeds = 'İlacınızı alma zamanı';
  String currentMedicationsNotificationContent = "İsim: <Medicine Name>\nDoz: <Medicine Dosage>\nNotlar: <Medicine Notes>";
  String currentMedicationsHeading = 'Mevcut İlaçlar';
  String currentMedicationsNoMedicines = 'Üzgünüz, doktor şu anda sizin için herhangi bir ilaç eklemedi.';
  String currentMedicationsEndsOn = 'Bitiş Tarihi: <date>';
  String currentMedicationsSnackBar = '<Medicine Name> zamanlandı';

  // Patient Timings Notes
  String patientTimingsNotesTime = 'Zaman: ';
  String patientTimingsNotesDosage = 'Doz: ';
  String patientTimingsNotesNotes = 'Notlar: ';
  String patientTimingsNotesNoMeds = 'Bugün için ilacınız bulunmamakta';

  // View Medicine
  List<String> viewMedicineDay = [
    'Pazartesi',
    'Salı',
    'Çarşamba',
    'Perşembe',
    'Cuma',
    'Cumartesi',
    'Pazar'
  ];
  String viewMedicineEndDate = 'Son Tarih';
  String viewMedicineTitle = 'İlaç ayrıntılarını görüntüleyin';
  String viewMedicineMedicineName = 'İlaç İsmi';
  String viewMedicineMedicinePlaceholder = 'Örnek: Coumaran';
  String viewMedicineTimingsAndNotes = 'Zamanlama ve Notlar';

  // Patient Edit Profile
  String patientEditProfileNoData = 'Uygun veri yok';
  String patientEditProfileBigPhotoSnackBar = 'Lütfen <2 MB boyutunda bir fotoğraf seçiniz!';
  String patientEditProfileTitle = 'Profili Güncelle';
  String patientEditProfileName = 'Adınız ve Soyadınız';
  String patientEditProfileNamePlaceholder = 'Adınızı giriniz';
  String patientEditProfileDOB = 'Doğum tarihiniz';
  String patientEditProfileDOBPlaceholder = 'Bir tarih seçin';
  String patientEditProfileAge = 'Yaşınız';
  String patientEditProfileAgePlaceholder = 'Yaşınızı giriniz';
  String patientEditProfileGender = 'Cinsiyetiniz';
  String patientEditProfileGenderMale = 'Erkek';
  String patientEditProfileGenderFemale = 'Kadın';
  String patientEditProfilePhoneNumber = 'Telefon Numaranız';
  String patientEditProfilePhoneNumberPlaceholder = 'Telefon numaranızı giriniz';
  String patientEditProfileEmailAddress = 'Email Adresiniz';
  String patientEditProfileEmailAddressPlaceholder = 'Email adresinizi giriniz';
  String patientEditProfileResidenceAddress = 'Adresiniz';
  String patientEditProfileResidenceAddressPlaceholder = 'Adresinizi giriniz';
  String patientEditProfileAilments = 'Rahatsızlıklarınız';
  String patientEditProfileAilmentsPlaceholder = 'Hastalıklarınızı giriniz?';
  String patientEditProfileAllergies = 'Alerjileriniz';
  String patientEditProfileAllergiesPlaceholder = 'Herhangi bir şeye karşı alerjiniz var mı?';
  String patientEditProfileGeneticDisorder = 'Genetik Hastalıklarınız';
  String patientEditProfileGeneticDisorderPlaceholder = 'Herhangi bir genetik hastalığınız var mı?';
  String patientEditProfileEmptyFields = 'Bir veya daha fazla alan boş';
  String patientEditProfileInvalidDOB = 'Geçerli bir tarih seçiniz';
  String patientEditProfileInvalidEmail = 'Geçerli bir email adresi giriniz';
  String patientEditProfileUpdateProfile = 'Profili Güncelle';

  // PatientHome
  String patientHomeTitle = 'Ana Sayfa';
  String patientHomeDoctorDetails = 'Doktor Bilgileri';
  String patientHomeDepartment = 'Bölüm';
  String patientHomeChat = 'Sohbet';
  String patientHomeShowNotification = 'Bildirim Gönder';
  String patientHomeDoctorNotes = 'Doktor Notları';
  String patientHomeNoDoctorNotes = 'Üzgünüz, doktor şu anda herhangi bir not eklemedi.';
  String patientHomeImportantDates = 'Önemli Tarihler';
  String patientHomeLastVisit = '• Son Ziyaret: ';
  String patientHomeNextVisit = '• Bir Sonraki Ziyaret: ';
  String patientHomeNotAvailable = 'Bilgi yok';

  // Patient Management
  String patientManagementHome = 'Ana Sayfa';
  String patientManagementNotifications = 'Bildirimler';
  String patientManagementProfile = 'Profil';
  String patientManagementAbout = 'Hakkında';

  // Patient Notifications
  String patientNotificationsTitle = 'Bildirimleriniz';
  String patientNotificationsNoNotifications = 'Maalesef şu anda bildiriminiz yok!';
  String patientNotificationsNoBody = 'Bu bildirim mesaj içermiyor.';

  // Patient Profile
  String patientProfileCheckLogout = 'Çıkış yapmak istediğinizden emin misiniz?';
  String patientProfileLogout = 'Çıkış Yap';
  String patientProfileNo = 'Hayır';
  String patientProfileTitle = 'Profiliniz';
  String patientProfileNoDataAvailable = 'Uygun veri yok';
  String patientProfilePersonal = 'Personal';
  String patientProfileName = 'İsim';
  String patientProfileDOB = 'Doğum Tarihi';
  String patientProfileAge = 'Yaş';
  String patientProfileGender = 'Cinsiyet';
  String patientProfilePhoneNumber = 'Telefon Numarası';
  String patientProfileEmailAddress = 'Email Adresi';
  String patientProfileResidentialAddress = 'Adres';
  String patientProfileMedicalHistory='Tıbbi Geçmiş';
  String patientProfileIllness = 'Hastalık';
  String patientProfileAllergies = 'Alerjiler';
  String patientProfileGeneticDiseases = 'Genetik Hastalıklar';
  String patientProfileEditProfile = 'Profili Düzenle';
  String patientProfileLogOut = 'Çıkış Yap';

  // Patient Registration
  String patientRegistrationTitle = 'Merhaba !';
  String patientRegistrationAllSetUp = "Kurulumunuzu yapmaya başlayalım!";
  String patientRegistrationName = 'Adınız ve Soyadınız';
  String patientRegistrationNamePlaceholder = 'Adınızı giriniz';
  String patientRegistrationDOB = 'Doğum Tarihiniz';
  String patientRegistrationDOBPlaceholder = 'Bir tarih seçiniz';
  String patientRegistrationAge = 'Yaşınız';
  String patientRegistrationAgePlaceholder = 'Yaşınızı giriniz';
  String patientRegistrationGender = 'Cinsiyetiniz';
  String patientRegistrationGenderMale = 'Erkek';
  String patientRegistrationGenderFemale = 'Kadın';
  String patientRegistrationPhoneNumber = 'Telefon Numaranız';
  String patientRegistrationPhoneNumberPlaceholder = 'Telefon numaranızı giriniz';
  String patientRegistrationEmailAddress = 'Email Adresiniz';
  String patientRegistrationEmailAddressPlaceholder = 'Email adresinizi giriniz';
  String patientRegistrationResidenceAddress = 'Adresiniz';
  String patientRegistrationResidenceAddressPlaceholder = 'Adresinizi giriniz';
  String patientRegistrationAilments = 'Rahatsızlıklarınız';
  String patientRegistrationAilmentsPlaceholder = 'Hastalıklarınızı giriniz.';
  String patientRegistrationAllergies = 'Alerjileriniz';
  String patientRegistrationAllergiesPlaceholder = 'Herhangi bir şeye karşı alerjiniz var mı?';
  String patientRegistrationGeneticDisorder = 'Genetik Hastalıklarınız';
  String patientRegistrationGeneticDisorderPlaceholder = 'Herhangi bir genetik hastalığınız var mı?';
  String patientRegistrationEmptyFields = 'Bir veya daha fazla alan boş';
  String patientRegistrationInvalidDOB = 'Geçerli bir tarih seçiniz';
  String patientRegistrationInvalidEmail = 'Geçerli bir email adresi giriniz';
  String patientRegistrationSubmit = 'Kaydet';

  // Patient Select Doctor
  String patientSelectDoctorTitle = 'Doktor seçiniz';
  String patientSelectDoctorNoDoctorSelected = 'Lütfen bir doktor seçin';
  String patientSelectDoctorButton = 'Doktor Seçin';

  // Patient Upload Photo
  String patientUploadPhotoBigPhotoSnackBar = 'Lütfen <2 MB boyutunda bir fotoğraf seçiniz';
  String patientUploadPhotoSmile = 'Gülümseyin! 😇';
  String patientUploadPhotoAlmostDone = 'Neredeyse bitti! Sadece bir profil resmi yüklememiz gerekiyor.';
  String patientUploadPhotoSizeWarning = 'Lütfen boyutu <2 MB olan bir fotoğraf yükleyin';
  String patientUploadPhotoSave = 'Kaydet ve devam et';
}
