import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:http/http.dart' as http;
import 'package:webrtc_conference/common/const.dart';
import 'package:webrtc_conference/models/event.dart';
import 'package:webrtc_conference/models/profile.dart';
import '../models/agenda.dart';
import '../models/attendee.dart';
import '../models/document.dart';
import '../models/news_post.dart';
import '../models/notification.dart';
import '../models/poll.dart';
import '../models/poll_option.dart';
import '../models/speaker.dart';
import 'api.dart';
import 'api_errors.dart';

class WebService {
  const WebService();

  Future<dynamic> get(Request document) async {
    var host = Uri.parse(kBackendEndpoint + document.getRequestUrl);
    var r = await http.get(host, headers: document.header);

    print(r.statusCode);
    print(r);

    if (r.statusCode == 200) {
      return r.body;
    } else if (r.statusCode == 401) {
      throw BadCredentials();
    } else {
      throw BadResponseCode(statusCode: r.statusCode);
    }
  }

  Future<dynamic> post(Request document) async {
    var host = Uri.parse(kBackendEndpoint + document.getRequestUrl);
    var r = await http.post(
      host,
      headers: document.header,
      body: document.body,
    );

    print(r.statusCode);
    print(r);

    if (r.statusCode == 200) {
      return r.body;
    } else if (r.statusCode == 401) {
      throw BadCredentials();
    } else {
      throw BadResponseCode(statusCode: r.statusCode);
    }
  }
}

class MockWebService extends WebService {
  MockWebService() {
    var _fakeProfile = ProfileModel.getRandom(n: 1, faker: faker).first;
    var _fakeAgenda = AgendaModel.getRandom(faker: faker);
    var _fakeSpeakers = SpeakerModel.getRandom(faker: faker);
    var _fakeAttendees = AttendeeModel.getRandom(faker: faker);
    var _fakePolls = PollModel.getRandom(faker: faker);
    var _fakeNotifications = NotificationModel.getRandom(faker: faker);
    var _fakeNews = NewsPostModel.getRandom(faker: faker);
    var _fakeDocumentsAgenda = DocumentModel.getRandom(faker: faker);
    var _fakeDocumentsSpeeches = DocumentModel.getRandom(faker: faker);

    // print('start configuring fake agenda');
    _fakeAgenda = _fakeAgenda.map((e) {
      var agendaForDay = e;
      // print('\tstart configuring fake agenda ${e.id}');
      agendaForDay.events = agendaForDay.events.map((event) {
        // print('\t\tshuffle fake speakers');
        _fakeSpeakers.shuffle();
        final selectedFakeSpeakers = _fakeSpeakers
            .take(faker.randomGenerator.integer(5, min: 1));

        event.speakers = selectedFakeSpeakers.map((e) => e.id);
        // print('\t\tselected ${selectedFakeSpeakers.length} fake speakers (${event.speakers.join(',')})');

        _fakeSpeakers = _fakeSpeakers.map((s) {
          // print('\t\t\tstart configuring fake speaker events');
          var fakeSpeaker = s;
          if (event.speakers.contains(fakeSpeaker.id)) {
            // print('\t\t\t\t${fakeSpeaker.id} leads session ${event.id}');
            fakeSpeaker.sessions = [...fakeSpeaker.sessions, event.id];
            // print('\t\t\t\t${fakeSpeaker.id} leads sessions ${fakeSpeaker.sessions.join(',')}');
          }
          return fakeSpeaker;
        }).toList();
        return event;
      }).toList();
      // print('\tend configuring fake agenda ${e.id}');
      return agendaForDay;
    }).toList();
    // print('end configuring fake agenda');

    // print('generating random personal agenda');
    _fakeProfile.personalAgenda = _fakeAgenda.take(
        5
    ).map((e) => e.id);
    // print('finished generating random personal agenda: ' + _fakeProfile.personalAgenda.toString());

    fakeProfile = _fakeProfile.toJson();
    fakeAgenda = _fakeAgenda.expand((e) => e.events).toJson();
    fakeSpeakers = _fakeSpeakers.toJson();
    fakeAttendees = _fakeAttendees.toJson();
    fakePolls = _fakePolls.toJson();
    fakeNotifications = _fakeNotifications.toJson();
    fakeNews = _fakeNews.toJson();
    fakeDocumentsAgenda = _fakeDocumentsAgenda.toJson();
    fakeDocumentsSpeeches = _fakeDocumentsSpeeches.toJson();
  }

  static var faker = Faker(seed: 42);
  Map<String, dynamic> fakeProfile = {};
  Iterable<Map<String, dynamic>> fakeAgenda = [];
  Iterable<Map<String, dynamic>> fakeSpeakers = [];
  Iterable<Map<String, dynamic>> fakeAttendees = [];
  Iterable<Map<String, dynamic>> fakePolls = [];
  Iterable<Map<String, dynamic>> fakeNotifications = [];
  Iterable<Map<String, dynamic>> fakeNews = [];
  Iterable<Map<String, dynamic>> fakeDocumentsAgenda = [];
  Iterable<Map<String, dynamic>> fakeDocumentsSpeeches = [];

  @override
  Future<dynamic> get(Request document) async {
    print('Mock get request to ${document.url} (${document.getRequestUrl})');
    await Future.delayed(const Duration(milliseconds: 500));
    if (document.pathArguments == null && document.pathComponents == null) {
      // Data presented fully without limits
      if (document == API.getAgenda) {
        return fakeAgenda;
      } else if (document == API.getSpeakers) {
        return fakeSpeakers;
      } else if (document == API.getAttendees) {
        return fakeAttendees;
      } else if (document == API.getPolls) {
        return fakePolls;
      } else if (document == API.getNotifications) {
        return fakeNotifications;
      } else if (document == API.getProfile) {
        return fakeProfile;
      } else if (document == API.getNews) {
        return fakeNews;
      } else if (document == API.getDocumentsAgenda) {
        return fakeDocumentsAgenda;
      } else if (document == API.getDocumentsSpeeches) {
        return fakeDocumentsSpeeches;
      } else if (document == API.getRandomPoll) {
        return fakePolls.elementAt(faker.randomGenerator.integer(fakePolls.length));
      }
    } else {
      // Data should be limited by something
      if (document.pathArguments != null) {
        // asks for ids
        if (document.pathArguments!.containsKey('ids')) {
          // Request for list of things by id
          final idsArgument = document.pathArguments!['ids']!;
          final ids = idsArgument.split(',').where((v) => v.isNotEmpty);
          if (document.url == ApiEndpoints.agenda) {
            return fakeAgenda.where((s) => ids.contains(s['id'].toString()));
          } else if (document.url == ApiEndpoints.speakers) {
            return fakeSpeakers.where((s) => ids.contains(s['id'].toString()));
          } else if (document.url == ApiEndpoints.polls) {
            return fakePolls.where((s) => ids.contains(s['id'].toString()));
          }
        } else if (document.url == ApiEndpoints.search) {
          return search(document.pathArguments!['query']!);
        }
      }
    }
    // else if (document == API.getData) {}
  }

  @override
  Future<dynamic> post(Request document) async {
    print('Mock post request to ${document.url} (${document.getRequestUrl})');
    await Future.delayed(const Duration(milliseconds: 500));
    if (document.url == ApiEndpoints.pollVote) {
      pollVote(document);
      return '200 OK';
    } else if (document.url == ApiEndpoints.eventAddToPersonalAgenda) {
      addEventToPersonalAgenda(document);
      return '200 OK';
    } else if (document.url == ApiEndpoints.eventRemoveFromPersonalAgenda) {
      removeEventFromPersonalAgenda(document);
      return '200 OK';
    }
    // else if (document == API.getData) {}
    return '404 Not Found';
  }

  Map<String, Iterable<dynamic>> search(String query) {
    return {
      'agenda': fakeAgenda.where((event) => (event['title'] as String).toLowerCase().contains(query.toLowerCase())).toList(),
      'speakers': fakeSpeakers.where((event) => (event['full_name'] as String).toLowerCase().contains(query.toLowerCase())).toList(),
      'attendees': fakeAttendees.where((event) => (event['full_name'] as String).toLowerCase().contains(query.toLowerCase())).toList()
    };
  }

  void pollVote(Request document) {
    final pollId = int.parse(document.pathComponents!['id']!);
    final votedOptionsIds = jsonDecode(document.body!)['ids'] as List<dynamic>;
    var polls = fakePolls.map((e) => PollModel.fromJson(e));
    final modifiedPoll = polls.firstWhere((element) => element.id == pollId);
    List<PollOptionModel> changedPollOptions = [];
    for (var chosenOptionId in votedOptionsIds) {
      final chosenPollOption = modifiedPoll.options.firstWhere((option) => option.id == chosenOptionId);
      chosenPollOption.isChosen = true;
      chosenPollOption.count++;
      changedPollOptions.add(chosenPollOption);
      modifiedPoll.votersCount++;
    }
    modifiedPoll.options = modifiedPoll.options.map((e) {
      if (!changedPollOptions.contains(e)) {
        return e;
      }
      final t = changedPollOptions.firstWhere((element) => element.id == e.id);
      return t;
    });
    polls = polls.map((e) {
      if (e.id != modifiedPoll.id) {
        return e;
      }
      return modifiedPoll;
    });
    fakePolls = polls.toJson().toList();
  }

  void addEventToPersonalAgenda(Request document) {
    final eventId = int.parse(document.pathComponents!['id']!);
    final events = fakeProfile['personal_agenda'] as Iterable<int>? ?? [];
    fakeProfile['personal_agenda'] = [...events, eventId];
  }
  void removeEventFromPersonalAgenda(Request document) {
    final eventId = int.parse(document.pathComponents!['id']!);
    final events = fakeProfile['personal_agenda'] as Iterable<int>? ?? [];
    fakeProfile['personal_agenda'] = events.where((element) => element != eventId);
  }
}
