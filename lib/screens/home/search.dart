part of '../home.dart';


final searchNavigatorKey = GlobalKey<NavigatorState>();
NavigatorState? get searchNavigator => searchNavigatorKey.currentState;

class HomeSearch extends StatelessWidget {
  const HomeSearch({Key? key}) : super(key: key);
  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/Search',
      builder: (_) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _HomeSearchList();
  }
}

class _HomeSearchList extends StatefulWidget {
  @override
  State<_HomeSearchList> createState() => _HomeSearchListState();
}

class _HomeSearchListState extends State<_HomeSearchList> {
  final TextEditingController _searchFieldController = TextEditingController();
  String query = '';

  @override
  void initState() {
    super.initState();
    _onClear();
  }

  void _onClear() {
    query = '';
    load(() => context.read<SearchCubit>().clear());
    setState(() {});
  }

  void _search(String value) {
    if (value.isNotEmpty) {
      query = value;
      load(() => context.read<SearchCubit>().loadWithQuery(value));
    }
  }

  @override
  void dispose() {
    _searchFieldController.dispose();
    super.dispose();
  }

  Iterable<_SearchListSectionData> getDataForResult(SearchModel searchModel) {
    List<_SearchListSectionData> result = [];

    if (searchModel.agenda.isNotEmpty) {
      result.add(_SearchListSectionData(
        title: 'Agenda',
        getSeeMoreRoute: () => MyAgendaScreen(
          customTitle: 'Search result for "$query"',
          agendaList: searchModel.agenda
        ).getRoute(),
        items: searchModel.agenda.map((e) =>
            _SearchListItemData(
              title: e.title,
              subtitle: e.description,
              getRoute: () => EventScreen(event: e).getRoute(),
            )
        ),
      ));
    }
    if (searchModel.speakers.isNotEmpty) {
      result.add(_SearchListSectionData(
        title: 'Speakers',
        getSeeMoreRoute: () => SpeakersScreen(
          customTitle: 'Search result for "$query"',
          speakersList: searchModel.speakers
        ).getRoute(),
        items: searchModel.speakers.map((e) =>
            _SearchListItemData(
              title: e.fullName,
              subtitle: e.job,
              getRoute: () => SpeakerScreen(speaker: e).getRoute(),
            )
        ),
      ));
    }
    if (searchModel.attendees.isNotEmpty) {
      result.add(_SearchListSectionData(
        title: 'Attendees',
        getSeeMoreRoute: () => AttendeesScreen(
          customTitle: 'Search result for "$query"',
          attendeesList: searchModel.attendees,
        ).getRoute(),
        items: searchModel.attendees.map((e) =>
            _SearchListItemData(
              title: e.fullName,
              subtitle: e.email,
              getRoute: () => AttendeeScreen(attendee: e).getRoute(),
            )
        ),
      ));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 4, 24, 12),
          child: SearchBar(
            searchFieldController: _searchFieldController,
            onSubmit: _search,
            onClear: _onClear,
          ),
        ),
        BlocBuilder<SearchCubit, SearchState>(
          builder: (BuildContext context, SearchState state) {
            final cases = {
              SearchStatus.initial: () => Container(),
              SearchStatus.loading: () =>
              const Padding(
                padding: EdgeInsets.only(top: 32),
                child: Center(
                    child: CircularProgressIndicator()
                ),
              ),
              SearchStatus.error: () =>
                  Center(
                      child: FloatingActionButton(
                        onPressed: () {
                          BotToast.cleanAll();
                          _onClear();
                        },
                        child: const Icon(Icons.replay),
                      )
                  ),
              SearchStatus.ready: () =>
                Expanded(
                  child: _SearchListImpl(
                    data: getDataForResult(state.searchModel!),
                    query: query
                  ),
                ),
            };
            assert(cases.length == SearchStatus.values.length);
            return cases[state.status]!();
          },
        )
      ],
    );
  }
}

class _SearchListSectionData<T> {
  _SearchListSectionData({
    required this.title,
    required this.items,
    required this.getSeeMoreRoute,
  });
  final String title;
  final Iterable<_SearchListItemData> items;
  final Route<T> Function() getSeeMoreRoute;
}

class _SearchListItemData<T> {
  _SearchListItemData({
    required this.title,
    required this.subtitle,
    required this.getRoute,
  });
  final String title;
  final String subtitle;
  final Route<T> Function() getRoute;
}

class _SearchListImpl extends StatelessWidget {
  _SearchListImpl({
    required this.data,
    required this.query
  });

  static const int itemsPerSection = 3;
  final String query;
  final Iterable<_SearchListSectionData> data;

  @override
  Widget build(BuildContext context) {
    if (data.every((element) => element.items.isEmpty)) {
      if (query.isEmpty) {
        return const Text('Please enter your search query');
      } else {
        return const Text('There are no objects found');
      }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView.separated(
          itemCount: data.length,
          separatorBuilder: (c, i) => const Divider(
              height: 1,
              color: Colors.transparent
          ),
          itemBuilder: (context, index) {
            final section = data.elementAt(index);
            final hasMoreToOffer = section.items.length > itemsPerSection;
            return Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: InkWell(
                      onTap: hasMoreToOffer ? () => Navigator.push(context, section.getSeeMoreRoute()) : null,
                      child: UnderlinedLabel(
                        title: section.title,
                        valueText: hasMoreToOffer ? 'See more...' : null,
                      ),
                    )
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: min(section.items.length, itemsPerSection),
                  separatorBuilder: (c, i) => const Divider(
                      height: 1,
                      color: Colors.transparent
                  ),
                  itemBuilder: (context, index) {
                    final item = section.items.elementAt(index);
                    return ListTile(
                      title: Text(
                          item.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold
                          )
                      ),
                      subtitle: Text(
                        item.subtitle,
                        maxLines: 2,
                      ),
                      onTap: () => Navigator.push(context, item.getRoute()),
                    );
                  },
                ),
              ],
            );
          }
      ),
    );
  }
}
