String formatDateTime(String date) {
  return date.toString().split(' ')[0].split('-').reversed.join('-');
}

String format12To24HrTime(String time) {
  // Time is in form HH:MM <AM/PM>
  String suffix = time.split(' ')[1];
  int hr = int.parse(time.split(' ')[0].split(':')[0]);
  int min = int.parse(time.split(' ')[0].split(':')[1]);
  if (suffix == 'PM') hr += 12;
  String hour = hr.toString();
  if (hour.length == 1) hour = '0' + hour;
  String minute = min.toString();
  if (minute.length == 1) minute = '0' + minute;
  String newTime = hour + ':' + minute;
  return newTime;
}

String format24to12HrTime(String time) {
  // Time is in the form HH:MM
  int hr = int.parse(time.split(':')[0]);
  int min = int.parse(time.split(':')[1]);
  String suffix = 'AM';
  if (hr > 12) {
    hr -= 12;
    suffix = 'PM';
  }
  String hour = hr.toString();
  if (hour.length == 1) hour = '0' + hour;
  String minute = min.toString();
  if (minute.length == 1) minute = '0' + minute;
  String newTime = hour + ':' + minute + ' ' + suffix;
  return newTime;
}
