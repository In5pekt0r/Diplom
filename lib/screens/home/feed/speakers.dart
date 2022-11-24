import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webrtc_conference/common/helpers.dart';
import 'package:webrtc_conference/common/route.dart';
import 'package:flutter/material.dart';
import 'package:webrtc_conference/screens/home.dart';
import 'package:webrtc_conference/screens/common/speaker.dart';
import 'package:webrtc_conference/widgets/rounded_list_tile.dart';
import 'package:webrtc_conference/widgets/search_bar.dart';

import '../../../cubits/speakers.dart';
import '../../../models/speaker.dart';

class SpeakersScreen extends StatelessWidget {
  SpeakersScreen({
    this.customTitle,
    this.speakersList
  });

  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/' + (customTitle ?? 'Speakers'),
      builder: (_) => this,
    );
  }

  final String? customTitle;
  final Iterable<SpeakerModel>? speakersList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SpeakersList(speakersList: speakersList),
    );
  }
}

class SpeakersList extends StatefulWidget {
  SpeakersList({
    this.speakersList
  });
  final Iterable<SpeakerModel>? speakersList;
  @override
  State<SpeakersList> createState() => _SpeakersListState(speakersList: speakersList);
}

class _SpeakersListState extends State<SpeakersList> {
  _SpeakersListState({
    this.speakersList
  });
  final Iterable<SpeakerModel>? speakersList;
  final TextEditingController _searchFieldController = TextEditingController();

  bool get standaloneScreen => speakersList == null;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    if (!standaloneScreen) return;
    load(() => context.read<SpeakersCubit>().load());
  }

  void _search(String value) {
    if (!standaloneScreen) return;
    if (value.isNotEmpty) {
      load(() => context.read<SpeakersCubit>().loadWithQuery(value));
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
    if (!standaloneScreen) {
      return ListView(
        children: [
          SpeakersListImpl(speakers: speakersList!)
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
        BlocBuilder<SpeakersCubit, SpeakersState>(
          builder: (BuildContext context, SpeakersState state) {
            final cases = {
              SpeakersStatus.initial: () => Container(),
              SpeakersStatus.loading: () =>
                const Padding(
                  padding: EdgeInsets.only(top: 32),
                  child: Center(
                      child: CircularProgressIndicator()
                  ),
                ),
              SpeakersStatus.error: () =>
                  Center(
                      child: FloatingActionButton(
                        onPressed: () {
                          BotToast.cleanAll();
                          _load();
                        },
                        child: const Icon(Icons.replay),
                      )
                  ),
              SpeakersStatus.ready: () =>
                  SpeakersListImpl(speakers: state.speakers),
            };
            assert(cases.length == SpeakersStatus.values.length);
            return cases[state.status]!();
          },
        )
      ],
    );
  }
}

class SpeakersListImpl extends StatelessWidget {
  SpeakersListImpl({
    required this.speakers,
  });
  final Iterable<SpeakerModel> speakers;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 16 + 48),
      itemCount: speakers.length,
      separatorBuilder: (context, index) =>
      const Divider(
          height: 10,
          color: Colors.transparent
      ),
      itemBuilder: (context, index) {
        final speaker = speakers.elementAt(index);
        final title = speaker.fullName;
        final subtitle = speaker.bio;

        return RoundedListTile(
            title: title,
            subtitle: subtitle,
            subtitleMaxLines: 2,
            leading: Transform.translate(
              offset: const Offset(0, -6),
              child: CircleAvatar(
                backgroundColor: Colors.lightBlue,
                foregroundColor: Colors.white,
                backgroundImage:
                  speaker.avatarUrl != null
                  ? CachedNetworkImageProvider(speaker.avatarUrl!)
                  : null
                // NetworkImage(speaker.avatarUrl)
                ,
                radius: 28,
              ),
            ),
            onTap: () {
              Navigator.push(context, SpeakerScreen(speaker: speaker).getRoute());
            },
        );
      },
    );
  }
}
