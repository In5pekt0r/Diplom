import 'package:webrtc_conference/models/event.dart';
import 'package:webrtc_conference/models/news_post.dart';

import '../common/api.dart';
import '../common/web_service.dart';
import '../models/attendee.dart';
import '../models/document.dart';
import '../models/notification.dart';
import '../models/poll.dart';
import '../models/profile.dart';
import '../models/search.dart';
import '../models/speaker.dart';

typedef CreateServiceCallback = WebService Function();

class DatabaseRepository {
  DatabaseRepository({
    CreateServiceCallback? createService,
  }) : _createService = createService ?? createDefaultService;

  late WebService _service;
  final CreateServiceCallback _createService;

  void initializeService() {
    _service = _createService();
  }

  Future<Iterable<NewsPostModel>> loadNews() async {
    var data = await _service.get(API.getNews);
    var listData = data as Iterable<dynamic>;
    return listData.map((e) => NewsPostModel.fromJson(e));
  }

  Future<ProfileModel> loadProfile() async {
    var data = await _service.get(API.getProfile);
    return ProfileModel.fromJson(data);
  }

  Future<Iterable<EventModel>> loadAgenda() async {
    var data = await _service.get(API.getAgenda);
    var listData = data as Iterable<dynamic>;
    return listData.map((e) => EventModel.fromJson(e));
  }

  Future<Iterable<EventModel>> loadAgendaByIds(Iterable<int> eventsIds) async {
    var data = await _service.get(API.eventsByIds(eventsIds));
    var listData = data as Iterable<dynamic>;
    return listData.map((e) => EventModel.fromJson(e));
  }

  Future<Iterable<DocumentModel>> loadDocumentsAgenda() async {
    var data = await _service.get(API.getDocumentsAgenda);
    var listData = data as Iterable<dynamic>;
    return listData.map((e) => DocumentModel.fromJson(e));
  }

  Future<Iterable<DocumentModel>> loadDocumentsSpeeches() async {
    var data = await _service.get(API.getDocumentsSpeeches);
    var listData = data as Iterable<dynamic>;
    return listData.map((e) => DocumentModel.fromJson(e));
  }

  Future<Iterable<SpeakerModel>> loadSpeakers() async {
    var data = await _service.get(API.getSpeakers);
    var listData = data as Iterable<dynamic>;
    return listData.map((e) => SpeakerModel.fromJson(e));
  }

  Future<Iterable<SpeakerModel>> loadSpeakersByIds(Iterable<int> speakersIds) async {
    var data = await _service.get(API.speakersByIds(speakersIds));
    var listData = data as Iterable<dynamic>;
    return listData.map((e) => SpeakerModel.fromJson(e));
  }

  Future<Iterable<SpeakerModel>> loadSpeakersWithQuery(String value) async {
    var data = await _service.get(API.getSpeakers);
    var listData = data as Iterable<dynamic>;
    return listData.map((e) => SpeakerModel.fromJson(e));
  }

  Future<Iterable<AttendeeModel>> loadAttendees() async {
    var data = await _service.get(API.getAttendees);
    var listData = data as Iterable<dynamic>;
    return listData.map((e) => AttendeeModel.fromJson(e));
  }

  Future<Iterable<AttendeeModel>> loadAttendeesWithQuery(String value) async {
    var data = await _service.get(API.getAttendees);
    var listData = data as Iterable<dynamic>;
    return listData.map((e) => AttendeeModel.fromJson(e));
  }

  Future<Iterable<PollModel>> loadPolls() async {
    var data = await _service.get(API.getPolls);
    var listData = data as Iterable<dynamic>;
    return listData.map((e) => PollModel.fromJson(e));
  }

  Future<PollModel> loadRandomPoll() async {
    var data = await _service.get(API.getRandomPoll);
    return PollModel.fromJson(data);
  }

  Future<Iterable<PollModel>> votePoll(int pollId, Iterable<int> answer) async {
    final body = { '"ids"': answer.map((e) => e).toList() }.toString();
    await _service.post(API.pollVote(pollId, body));
    return await loadPolls();
  }

  Future<Iterable<NotificationModel>> loadNotifications() async {
    var data = await _service.get(API.getNotifications);
    var listData = data as Iterable<dynamic>;
    return listData.map((e) => NotificationModel.fromJson(e));
  }

  Future<SearchModel> searchAll(String query) async {
    var data = await _service.get(API.searchWithQuery(query));
    return SearchModel.fromJson(data);
  }

  Future<void> addEventToPersonalAgenda(int eventId) async {
    await _service.post(API.eventAddToPersonalAgenda(eventId));
  }

  Future<void> removeEventFromPersonalAgenda(int eventId) async {
    await _service.post(API.eventRemoveFromPersonalAgenda(eventId));
  }
}

WebService createDefaultService() {
  return const WebService();
}
