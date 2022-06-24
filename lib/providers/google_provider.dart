import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;

class GoogleProvider extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId:
    //     '855883079806-f605ka3euedgff42kd9tffmk980l73ok.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/calendar',
    ],
  );

  GoogleSignInAccount? _user;
  GoogleSignInAccount? get user => _user;

  int _numberOfWeeks = 0;
  int get numberOfWeeks => _numberOfWeeks;

  double _money = 0;
  double get money => _money;

  List<calendar.Event>? _events = [];
  List<calendar.Event>? get events => _events;

  DateTime _firstDay = DateTime.now();
  DateTime _lastDay = DateTime.now();
  List<DateTime> _lastDays = [];

  bool toggle = false;
  String buttonText = "Show All";

  bool _gettingEvents = false;
  bool get gettingEvents => _gettingEvents;

  GoogleProvider() {
    _googleSignIn.signInSilently();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      _user = account;
      notifyListeners();
    });
  }

  signIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  signOut() async {
    try {
      await _googleSignIn.disconnect();
      reset();
    } catch (error) {
      print(error);
    }
  }

  void ToggleView() {
    if (toggle) {
      toggle = false;
      buttonText = "Show All";
    } else {
      toggle = true;
      buttonText = "Show Orange Only";
    }
    notifyListeners();
  }

  void reset() {
    _events = [];
    _numberOfWeeks = 0;
    notifyListeners();
  }

  void toggleCircularProgressbar() {
    _gettingEvents = !_gettingEvents;
    notifyListeners();
  }

  DateTime getNextDayOfWeek(DateTime date, int dayOfWeek) {
    // dayOfWeek
    // 0-Sunday
    // 1-monday
    // 2-tuesday
    // etc...

    var resultDate = new DateTime(date.year, date.month, date.day);
    Duration duration =
        Duration(days: ((7 + dayOfWeek - resultDate.weekday)) % 7);
    DateTime newDate = resultDate.add(duration);
    return newDate;
  }

  Future<void> getCalenderEvents(int numberOfWeeks) async {
    if (numberOfWeeks > 0) {
      toggleCircularProgressbar();

      _numberOfWeeks = numberOfWeeks;
      var httpClient = (await _googleSignIn.authenticatedClient())!;
      var calendarAPI = calendar.CalendarApi(httpClient);

      // calendar.Events retreivedEvents = await calendarAPI.events.list('primary',
      //     timeMin: DateTime.now(),
      //     showDeleted: false,
      //     singleEvents: true,
      //     maxResults: numberOfWeeks,
      //     orderBy: 'startTime');

      // _events = retreivedEvents.items;
      // notifyListeners();

      _events = [];
      _lastDays = [];
      notifyListeners();
      _firstDay = DateTime.now();
      _lastDay = getNextDayOfWeek(_firstDay, 6); //get next saturday
      _lastDay = DateTime(
          _lastDay.year, _lastDay.month, _lastDay.day, 23, 59, 59, 999);
      _lastDays.add(new DateTime(
          _lastDay.year,
          _lastDay.month,
          _lastDay.day,
          _lastDay.hour,
          _lastDay.minute,
          _lastDay.second,
          _lastDay.millisecond));

      calendar.Events retreivedEvents = await calendarAPI.events.list(
        'primary',
        timeMin: _firstDay,
        timeMax: _lastDay,
        showDeleted: false,
        singleEvents: true,
        orderBy: 'startTime',
      );

      // console.log(events);
      _events?.addAll(retreivedEvents.items!.toList());

      _firstDay = new DateTime(
          _lastDay.year,
          _lastDay.month,
          _lastDay.day,
          _lastDay.hour,
          _lastDay.minute,
          _lastDay.second,
          _lastDay.millisecond);
      _firstDay = _firstDay.add(Duration(days: 1));
      _firstDay = new DateTime(
          _firstDay.year, _firstDay.month, _firstDay.day, 0, 0, 0, 0);
      _lastDay = _lastDay.add(Duration(days: 7));
      _lastDays.add(new DateTime(
          _lastDay.year,
          _lastDay.month,
          _lastDay.day,
          _lastDay.hour,
          _lastDay.minute,
          _lastDay.second,
          _lastDay.millisecond));

      for (var i = 0; i < numberOfWeeks - 1; i++) {
        calendar.Events retreivedEvents = await calendarAPI.events.list(
          'primary',
          timeMin: _firstDay,
          timeMax: _lastDay,
          showDeleted: false,
          singleEvents: true,
          orderBy: 'startTime',
        );

        _events?.addAll(retreivedEvents.items!.toList());

        _firstDay = new DateTime(
            _lastDay.year,
            _lastDay.month,
            _lastDay.day,
            _lastDay.hour,
            _lastDay.minute,
            _lastDay.second,
            _lastDay.millisecond);
        _firstDay = _firstDay.add(Duration(days: 1));
        _firstDay = new DateTime(
            _firstDay.year, _firstDay.month, _firstDay.day, 0, 0, 0, 0);
        _lastDay = _lastDay.add(Duration(days: 7));
        _lastDays.add(new DateTime(
            _lastDay.year,
            _lastDay.month,
            _lastDay.day,
            _lastDay.hour,
            _lastDay.minute,
            _lastDay.second,
            _lastDay.millisecond));
      }

      _firstDay = new DateTime.now();
      _lastDay = getNextDayOfWeek(_firstDay, 6); //get next saturday
      _lastDay = DateTime(
          _lastDay.year, _lastDay.month, _lastDay.day, 23, 59, 59, 999);
      notifyListeners();
      toggleCircularProgressbar();
    }
  }
}
