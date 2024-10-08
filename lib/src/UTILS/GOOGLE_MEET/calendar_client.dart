import 'package:googleapis/calendar/v3.dart';

class CalendarClient {
  // For storing the CalendarApi object, this can be used
  // for performing all the operations
  static var calendar;

  // For creating a new calendar event
  Future<Map<String, String>> insert({
    required String meetingId,
    required String summary,
    required String description,
    required String location,
    required String repeatCount,
    // required List<EventAttendee> attendeeEmailList,
    required List<String> selectedAttendeesList,
    // required List<DepartmentWiseEmployeeMeetingModel> selectedEmployeeList,
    required bool shouldNotifyAttendees,
    required bool hasConferenceSupport,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    Map<String, String>? eventData;

    // If the account has multiple calendars, then select the "primary" one
    String calendarId = "primary";
    Event event = Event();

    event.id = meetingId;
    event.summary = summary;
    event.location = location;
    event.description = description;
    event.hangoutLink = "";
    event.recurrence = [
      "RRULE:FREQ=DAILY;COUNT=$repeatCount",
    ];

    final List<EventAttendee>? attendeeEmailList = [];

    selectedAttendeesList.forEach((element) {
      if (element != "" && element != "null") {
        print("event.attendees : $element");
        attendeeEmailList!.add(EventAttendee(email: element.toString()));
      }
    });

    event.attendees = attendeeEmailList;

    if (hasConferenceSupport) {
      ConferenceData conferenceData = ConferenceData();
      CreateConferenceRequest conferenceRequest = CreateConferenceRequest();
      conferenceRequest.requestId =
          "${startTime.millisecondsSinceEpoch}-${endTime.millisecondsSinceEpoch}";
      conferenceData.createRequest = conferenceRequest;

      event.conferenceData = conferenceData;
    }

    print("conference ${ConferenceData().signature}");

    EventDateTime start = new EventDateTime();
    start.dateTime = startTime;
    start.timeZone = "GMT+05:30";
    event.start = start;

    EventDateTime end = new EventDateTime();
    end.timeZone = "GMT+05:30";
    end.dateTime = endTime;
    event.end = end;

    print('''
    event.id = ${event.id};
    event.summary = ${event.summary};
    event.location = ${event.location};
    event.description = ${event.description};
    event.hangoutLink = ${event.hangoutLink};
    event.recurrence = ${event.recurrence};
    event.attendees = ${event.attendees};
    event.conferenceData = ${event.conferenceData!.signature};
    event.start = ${event.start};
    event.end = ${event.end};
    ''');

    try {
      await calendar.events
          .insert(event, calendarId,
              conferenceDataVersion: hasConferenceSupport ? 1 : 0,
              sendUpdates: shouldNotifyAttendees ? "all" : "none")
          .then((value) {
        print("Event Status: ${value.status}");
        if (value.status == "confirmed") {
          String? joiningLink;
          String? eventId;

          eventId = value.id;

          if (hasConferenceSupport) {
            joiningLink =
                "https://meet.google.com/${value.conferenceData.conferenceId}";
          }

          eventData = {'id': eventId!, 'link': joiningLink!};

          print('Event added to Google Calendar');
        } else {
          print("Unable to add event to Google Calendar");
        }
      });
    } catch (e) {
      print('Error creating event $e');
    }

    return eventData!;
  }

  // For patching an already created calendar event
  Future<Map<String, String>> modify({
    required String id,
    required String title,
    required String description,
    required String location,
    required List<EventAttendee> attendeeEmailList,
    required bool shouldNotifyAttendees,
    required bool hasConferenceSupport,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    Map<String, String>? eventData;

    String calendarId = "primary";
    Event event = Event();

    event.summary = title;
    event.description = description;
    event.attendees = attendeeEmailList;
    event.location = location;

    EventDateTime start = new EventDateTime();
    start.dateTime = startTime;
    start.timeZone = "GMT+05:30";
    event.start = start;

    EventDateTime end = new EventDateTime();
    end.timeZone = "GMT+05:30";
    end.dateTime = endTime;
    event.end = end;

    try {
      await calendar.events
          .patch(event, calendarId, id,
              conferenceDataVersion: hasConferenceSupport ? 1 : 0,
              sendUpdates: shouldNotifyAttendees ? "all" : "none")
          .then((value) {
        print("Event Status: ${value.status}");
        if (value.status == "confirmed") {
          String? joiningLink;
          String? eventId;

          eventId = value.id;

          if (hasConferenceSupport) {
            joiningLink =
                "https://meet.google.com/${value.conferenceData.conferenceId}";
          }

          eventData = {'id': eventId!, 'link': joiningLink!};

          print('Event updated in google calendar');
        } else {
          print("Unable to update event in google calendar");
        }
      });
    } catch (e) {
      print('Error updating event $e');
    }

    return eventData!;
  }

  // For deleting a calendar event
  Future<void> delete(String eventId, bool shouldNotify) async {
    String calendarId = "primary";

    try {
      await calendar.events
          .delete(calendarId, eventId,
              sendUpdates: shouldNotify ? "all" : "none")
          .then((value) {
        print('Event deleted from Google Calendar');
      });
    } catch (e) {
      print('Error deleting event: $e');
    }
  }
}

class EventInfo {
  final String id;
  final String name;
  final String description;
  final String location;
  final String link;
  final List<dynamic> attendeeEmails;
  final bool shouldNotifyAttendees;
  final bool hasConfereningSupport;
  final int startTimeInEpoch;
  final int endTimeInEpoch;

  EventInfo({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.link,
    required this.attendeeEmails,
    required this.shouldNotifyAttendees,
    required this.hasConfereningSupport,
    required this.startTimeInEpoch,
    required this.endTimeInEpoch,
  });

  EventInfo.fromMap(Map snapshot)
      : id = snapshot['id'] ?? '',
        name = snapshot['name'] ?? '',
        description = snapshot['desc'],
        location = snapshot['loc'],
        link = snapshot['link'],
        attendeeEmails = snapshot['emails'] ?? '',
        shouldNotifyAttendees = snapshot['should_notify'],
        hasConfereningSupport = snapshot['has_conferencing'],
        startTimeInEpoch = snapshot['start'],
        endTimeInEpoch = snapshot['end'];

  toJson() {
    return {
      'id': id,
      'name': name,
      'desc': description,
      'loc': location,
      'link': link,
      'emails': attendeeEmails,
      'should_notify': shouldNotifyAttendees,
      'has_conferencing': hasConfereningSupport,
      'start': startTimeInEpoch,
      'end': endTimeInEpoch,
    };
  }
}
// class CalendarClient {
//   // For storing the CalendarApi object, this can be used
//   // for performing all the operations
//   static var calendar;

//   // For creating a new calendar event
//   Future<Map<String, String>> insert({
//     required String title,
//     required String description,
//     required String location,
//     required List<EventAttendee> attendeeEmailList,
//     required bool shouldNotifyAttendees,
//     required bool hasConferenceSupport,
//     required DateTime startTime,
//     required DateTime endTime,
//   }) async {
//     Map<String, String>? eventData;

//     // If the account has multiple calendars, then select the "primary" one
//     String calendarId = "primary";
//     Event event = Event();

//     event.summary = title;
//     event.description = description;
//     event.attendees = attendeeEmailList;
//     event.location = location;

//     if (hasConferenceSupport) {
//       ConferenceData conferenceData = ConferenceData();
//       CreateConferenceRequest conferenceRequest = CreateConferenceRequest();
//       conferenceRequest.requestId =
//           "${startTime.millisecondsSinceEpoch}-${endTime.millisecondsSinceEpoch}";
//       conferenceData.createRequest = conferenceRequest;

//       event.conferenceData = conferenceData;
//     }

//     EventDateTime start = new EventDateTime();
//     start.dateTime = startTime;
//     start.timeZone = "GMT+05:30";
//     event.start = start;

//     EventDateTime end = new EventDateTime();
//     end.timeZone = "GMT+05:30";
//     end.dateTime = endTime;
//     event.end = end;

//     try {
//       await calendar.events
//           .insert(event, calendarId,
//               conferenceDataVersion: hasConferenceSupport ? 1 : 0,
//               sendUpdates: shouldNotifyAttendees ? "all" : "none")
//           .then((value) {
//         print("Event Status: ${value.status}");
//         if (value.status == "confirmed") {
//           String? joiningLink;
//           String? eventId;

//           eventId = value.id;

//           if (hasConferenceSupport) {
//             joiningLink =
//                 "https://meet.google.com/${value.conferenceData.conferenceId}";
//           }

//           eventData = {'id': eventId!, 'link': joiningLink!};

//           print('Event added to Google Calendar');
//         } else {
//           print("Unable to add event to Google Calendar");
//         }
//       });
//     } catch (e) {
//       print('Error creating event $e');
//     }

//     return eventData!;
//   }

//   // For patching an already created calendar event
//   Future<Map<String, String>> modify({
//     required String id,
//     required String title,
//     required String description,
//     required String location,
//     required List<EventAttendee> attendeeEmailList,
//     required bool shouldNotifyAttendees,
//     required bool hasConferenceSupport,
//     required DateTime startTime,
//     required DateTime endTime,
//   }) async {
//     Map<String, String>? eventData;

//     String calendarId = "primary";
//     Event event = Event();

//     event.summary = title;
//     event.description = description;
//     event.attendees = attendeeEmailList;
//     event.location = location;

//     EventDateTime start = new EventDateTime();
//     start.dateTime = startTime;
//     start.timeZone = "GMT+05:30";
//     event.start = start;

//     EventDateTime end = new EventDateTime();
//     end.timeZone = "GMT+05:30";
//     end.dateTime = endTime;
//     event.end = end;

//     try {
//       await calendar.events
//           .patch(event, calendarId, id,
//               conferenceDataVersion: hasConferenceSupport ? 1 : 0,
//               sendUpdates: shouldNotifyAttendees ? "all" : "none")
//           .then((value) {
//         print("Event Status: ${value.status}");
//         if (value.status == "confirmed") {
//           String? joiningLink;
//           String? eventId;

//           eventId = value.id;

//           if (hasConferenceSupport) {
//             joiningLink =
//                 "https://meet.google.com/${value.conferenceData.conferenceId}";
//           }

//           eventData = {'id': eventId!, 'link': joiningLink!};

//           print('Event updated in google calendar');
//         } else {
//           print("Unable to update event in google calendar");
//         }
//       });
//     } catch (e) {
//       print('Error updating event $e');
//     }

//     return eventData!;
//   }

//   // For deleting a calendar event
//   Future<void> delete(String eventId, bool shouldNotify) async {
//     String calendarId = "primary";

//     try {
//       await calendar.events
//           .delete(calendarId, eventId,
//               sendUpdates: shouldNotify ? "all" : "none")
//           .then((value) {
//         print('Event deleted from Google Calendar');
//       });
//     } catch (e) {
//       print('Error deleting event: $e');
//     }
//   }
// }

// class EventInfo {
//   final String id;
//   final String name;
//   final String description;
//   final String location;
//   final String link;
//   final List<dynamic> attendeeEmails;
//   final bool shouldNotifyAttendees;
//   final bool hasConfereningSupport;
//   final int startTimeInEpoch;
//   final int endTimeInEpoch;

//   EventInfo({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.location,
//     required this.link,
//     required this.attendeeEmails,
//     required this.shouldNotifyAttendees,
//     required this.hasConfereningSupport,
//     required this.startTimeInEpoch,
//     required this.endTimeInEpoch,
//   });

//   EventInfo.fromMap(Map snapshot)
//       : id = snapshot['id'] ?? '',
//         name = snapshot['name'] ?? '',
//         description = snapshot['desc'],
//         location = snapshot['loc'],
//         link = snapshot['link'],
//         attendeeEmails = snapshot['emails'] ?? '',
//         shouldNotifyAttendees = snapshot['should_notify'],
//         hasConfereningSupport = snapshot['has_conferencing'],
//         startTimeInEpoch = snapshot['start'],
//         endTimeInEpoch = snapshot['end'];

//   toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'desc': description,
//       'loc': location,
//       'link': link,
//       'emails': attendeeEmails,
//       'should_notify': shouldNotifyAttendees,
//       'has_conferencing': hasConfereningSupport,
//       'start': startTimeInEpoch,
//       'end': endTimeInEpoch,
//     };
//   }
// }
