import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webrtc_conference/common/helpers.dart';
import 'package:webrtc_conference/common/route.dart';
import 'package:flutter/material.dart';
import 'package:webrtc_conference/screens/home.dart';
import 'package:webrtc_conference/screens/common/attendee.dart';
import 'package:webrtc_conference/widgets/rounded_list_tile.dart';
import 'package:webrtc_conference/widgets/search_bar.dart';

import '../../../cubits/attendees.dart';
import '../../../models/attendee.dart';

class AttendeesScreen extends StatelessWidget {
  AttendeesScreen({
    this.customTitle,
    this.attendeesList
  });

  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/' + (customTitle ?? 'Attendees'),
      builder: (_) => this,
    );
  }

  final String? customTitle;
  final Iterable<AttendeeModel>? attendeesList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AttendeesList(attendeesList: attendeesList),
    );
  }
}

class AttendeesList extends StatefulWidget {
  AttendeesList({this.attendeesList});
  final Iterable<AttendeeModel>? attendeesList;
  @override
  State<StatefulWidget> createState() => _AttendeesListState(attendeesList: attendeesList);
}

class _AttendeesListState extends State<AttendeesList> {
  _AttendeesListState({this.attendeesList});
  final Iterable<AttendeeModel>? attendeesList;

  bool get standaloneScreen => attendeesList == null;

  final TextEditingController _searchFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    if (!standaloneScreen) return;
    load(() => context.read<AttendeesCubit>().load());
  }

  void _search(String value) {
    if (!standaloneScreen) return;
    if (value.isNotEmpty) {
      load(() => context.read<AttendeesCubit>().loadWithQuery(value));
    } else {
      _load();
    }
  }

  @override
  void dispose() {
    _searchFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (attendeesList != null) {
      return ListView(
        children: [
          AttendeesListImpl(attendees: attendeesList!)
        ],
      );
    }
    return ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 4, 24, 12),
          child: SearchBar(
            searchFieldController: _searchFieldController,
            onSubmit: _search,
            onClear: _load,
          ),
        ),
        BlocBuilder<AttendeesCubit, AttendeesState>(
          builder: (BuildContext context, AttendeesState state) {
            final cases = {
              AttendeesStatus.initial: () => Container(),
              AttendeesStatus.loading: () =>
                const Padding(
                  padding: EdgeInsets.only(top: 32),
                  child: Center(
                      child: CircularProgressIndicator()
                  ),
                ),
              AttendeesStatus.error: () =>
                  Center(
                      child: FloatingActionButton(
                        onPressed: () {
                          BotToast.cleanAll();
                          _load();
                        },
                        child: const Icon(Icons.replay),
                      )
                  ),
              AttendeesStatus.ready: () =>
                  AttendeesListImpl(attendees: state.attendees),
            };
            assert(cases.length == AttendeesStatus.values.length);
            return cases[state.status]!();
          },
        )
      ],
    );
  }
}

class AttendeesListImpl extends StatelessWidget {
  AttendeesListImpl({
    required this.attendees,
  });
  final Iterable<AttendeeModel> attendees;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 16 + 48),
      itemCount: attendees.length,
      separatorBuilder: (context, index) =>
        const Divider(
            height: 10,
            color: Colors.transparent
        ),
      itemBuilder: (context, index) {
        final attendee = attendees.elementAt(index);
        final title = attendee.fullName;
        final subtitle = attendee.email;

        return RoundedListTile(
          title: title,
          subtitle: subtitle,
          leading: Transform.translate(
            offset: const Offset(0, -6),
            child: const CircleAvatar(
              backgroundColor: Colors.lightBlue,
              foregroundColor: Colors.white,
              radius: 28,
              child: Icon(Icons.person),
            ),
          ),
          onTap: () { Navigator.push(context, AttendeeScreen(attendee: attendee).getRoute()); },
        );
      },
    );
  }
}
