class CoachSchedule {
  String scheduleDate;
  String scheduleTimeFrom;
  String scheduleTimeTo;
  String studentName;
  String clubDetails;
  String clubCourt;

  CoachSchedule(this.scheduleDate, this.scheduleTimeFrom, this.scheduleTimeTo,
      this.studentName, this.clubDetails, this.clubCourt);
  static List<CoachSchedule> scheduleList = [
    CoachSchedule(
        '23.11.2021', '10h', '12h', 'Roger Federer', 'Roland Garros', 'Clay 1'),
    CoachSchedule(
        '10.11.2021', '10h', '11h', 'Rafa Nadal', 'Roland Garros', 'Clay 2'),
    CoachSchedule(
        '09.11.2021', '10h', '13h', 'Dominic Thiem', 'Roland Garros', 'Clay 3'),
  ];
}
