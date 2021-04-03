String formatDateTime(String date) {
  var dateArray = date.split('-');
  String year = dateArray[0];
  String month = dateArray[1];
  String day = dateArray[2];
  String formattedDate = day + "\\" + month + "\\" + year;
  return formattedDate;
}
