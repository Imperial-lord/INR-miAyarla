String formatDateTime(String date) {
  return date.toString().split(' ')[0].split('-').reversed.join('-');
}

