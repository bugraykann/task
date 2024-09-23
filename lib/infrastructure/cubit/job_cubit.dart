import 'package:bloc/bloc.dart';
import '../model/job_model.dart';
import '../repositories/job_repository.dart';

abstract class JobState {}

class JobInitial extends JobState {}

class JobLoading extends JobState {}

class JobLoaded extends JobState {
  final List<JobModel> jobs;

  JobLoaded(this.jobs);
}

class JobError extends JobState {
  final String message;

  JobError(this.message);
}

class JobCubit extends Cubit<JobState> {
  final JobRepository jobRepository;

  JobCubit(this.jobRepository) : super(JobInitial());

  void searchJobs(String query) async {
    try {
      emit(JobLoading());
      final jobs = await jobRepository.searchJobs(query);
      emit(JobLoaded(jobs));
    } catch (e) {
      emit(JobError('Failed to load jobs'));
    }
  }
}
