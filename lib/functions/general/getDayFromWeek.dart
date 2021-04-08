int getDayFromWeek(String weekDayName) {
  if (weekDayName == 'Monday')
    return 0;
  else if (weekDayName == 'Tuesday')
    return 1;
  else if (weekDayName == 'Wednesday')
    return 2;
  else if (weekDayName == 'Thursday')
    return 3;
  else if (weekDayName == 'Friday')
    return 4;
  else if (weekDayName == 'Saturday')
    return 5;
  else
    return 6;
}
