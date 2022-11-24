import 'dart:collection';

class API {
  static final getNews = Request(url: ApiEndpoints.news);
  static final getProfile = Request(url: ApiEndpoints.profile);
  static final getAgenda = Request(url: ApiEndpoints.agenda);
  static final getSpeakers = Request(url: ApiEndpoints.speakers);
  static final getAttendees = Request(url: ApiEndpoints.attendees);
  static final getPolls = Request(url: ApiEndpoints.polls);
  static final getRandomPoll = Request(url: ApiEndpoints.polls + '/random');
  static final getNotifications = Request(url: ApiEndpoints.notifications);
  static final getDocumentsAgenda = Request(url: ApiEndpoints.documents + '/agenda');
  static final getDocumentsSpeeches = Request(url: ApiEndpoints.documents + '/speeches');

  /// EventsByIds:
  ///   (Iterable<int> eventsIds) -> Request
  /// Arguments:
  ///   path:
  ///     - id: id of the poll to vote
  ///   body:
  ///     - ids: array of ints, stating ids of chosen options
  static eventsByIds(Iterable<int> eventsIds) =>
    Request(
      url: ApiEndpoints.agenda,
      pathArguments: HashMap.fromEntries([MapEntry('ids', eventsIds.join(','))])
    );

  /// SpeakersByIds:
  ///   (Iterable<int> speakersIds) -> Request
  /// Arguments:
  ///   path:
  ///     - id: id of the poll to vote
  ///   body:
  ///     - ids: array of ints, stating ids of chosen options
  static speakersByIds(Iterable<int> speakersIds) =>
    Request(
      url: ApiEndpoints.speakers,
      pathArguments: HashMap.fromEntries([MapEntry('ids', speakersIds.join(','))])
    );

  /// PollVote:
  ///   (int pollId, String body) -> Request
  /// Arguments:
  ///   path:
  ///     - id: id of the poll to vote
  ///   body:
  ///     - ids: array of ints, stating ids of chosen options
  static pollVote(int pollId, String body) =>
    Request(
      url: ApiEndpoints.pollVote,
      pathComponents: HashMap.fromEntries([MapEntry('id', pollId.toString())]),
      body: body
    );

  /// PollPost:
  /// Arguments:
  ///   body:
  ///     - array of 'Poll' objects containing:
  ///       - name: String
  ///       - text: String
  ///       - multi_choice: bool
  ///       - option_names: [String]
  static final pollPost = Request(url: ApiEndpoints.polls);

  /// searchWithQuery:
  ///   (String query) -> Request
  /// Arguments:
  ///   path:
  ///     - query: string of query
  static searchWithQuery(String query) =>
    Request(
      url: ApiEndpoints.search,
      pathArguments: HashMap.fromEntries([MapEntry('query', query)])
    );

  /// EventAddToPersonalAgenda:
  ///   (int eventId) -> Request
  /// Arguments:
  ///   path:
  ///     - id: id of the event to add
  static eventAddToPersonalAgenda(int eventId) =>
    Request(
      url: ApiEndpoints.eventAddToPersonalAgenda,
      pathComponents: HashMap.fromEntries([MapEntry('id', eventId.toString())]),
    );

  /// EventRemoveFromPersonalAgenda:
  ///   (int eventId) -> Request
  /// Arguments:
  ///   path:
  ///     - id: id of the event to add
  static eventRemoveFromPersonalAgenda(int eventId) =>
    Request(
      url: ApiEndpoints.eventRemoveFromPersonalAgenda,
      pathComponents: HashMap.fromEntries([MapEntry('id', eventId.toString())]),
    );
}

class ApiEndpoints {
  static const news = '/news';
  static const profile = '/profile';
  static const agenda = '/agenda';
  static const speakers = '/speaker';
  static const attendees = '/attendee';
  static const polls = '/poll';
  static const notifications = '/notification';
  static const pollVote = '/poll/{id}/vote';
  static const search = '/search';
  static const documents = '/documents';
  static const eventAddToPersonalAgenda = '/agenda/{id}/add';
  static const eventRemoveFromPersonalAgenda = '/agenda/{id}/remove';
}

class Request {
  Request({
    required this.url,
    this.pathComponents,
    this.pathArguments,
    this.header,
    this.body
  });
  final String url;
  Map<String, String>? pathComponents;
  Map<String, String>? pathArguments;
  Map<String, String>? header;
  String? body;

  String get getRequestUrl => () {
    var newUrl = url;
    pathComponents?.forEach((key, value) {
      newUrl = newUrl.replaceFirst('{$key}', value);
    });
    if (pathArguments != null) {
      newUrl += '?' + pathArguments!.entries
          .map((e) => e.key + '='+ e.value)
          .join("&");
    }
    return newUrl;
  }();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Request &&
          runtimeType == other.runtimeType &&
          url == other.url &&
          pathComponents == other.pathComponents &&
          pathArguments == other.pathArguments &&
          header == other.header &&
          body == other.body;

  @override
  int get hashCode =>
      url.hashCode ^
      pathComponents.hashCode ^
      pathArguments.hashCode ^
      header.hashCode ^
      body.hashCode;
}
