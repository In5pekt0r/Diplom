import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:webrtc_conference/models/profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webrtc_conference/repositories/database.dart';

part 'profile.g.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(DatabaseRepository repository)
      : _repository = repository,
        super(ProfileState());

  final DatabaseRepository _repository;

  Future<void> load() async {
    if (state.status == ProfileStatus.loading) return;
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final profile = await _repository.loadProfile();
      emit(state.copyWith(profile: profile, status: ProfileStatus.ready));
    } catch (_) {
      emit(state.copyWith(profile: null, status: ProfileStatus.error));
      rethrow;
    }
  }
}

enum ProfileStatus { initial, loading, error, ready }

@CopyWith()
class ProfileState extends Equatable {
  ProfileState({
    this.profile,
    this.status = ProfileStatus.initial,
  });

  final ProfileModel? profile;
  final ProfileStatus status;

  @override
  List<Object?> get props => [
    profile,
    status,
  ];
}
