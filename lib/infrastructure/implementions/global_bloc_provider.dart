import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/infrastructure/cubit/job_cubit.dart';
import 'package:task/infrastructure/cubit/language_cubit.dart';
import 'package:task/infrastructure/cubit/navigation_view_model.dart';
import 'package:task/infrastructure/cubit/theme_cubit.dart';
import 'package:task/infrastructure/data_sources/job_data_source.dart';
import 'package:task/infrastructure/repositories/job_repository.dart';

class GlobalBlocProviders {
  static List<BlocProvider> all() {
    final jobRepository = JobRepository(JobDataSource());

    return [
      BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
      BlocProvider<LanguageCubit>(create: (_) => LanguageCubit()),
      BlocProvider<JobCubit>(create: (_) => JobCubit(jobRepository)),
      BlocProvider<NavigationCubit>(create: (_) => NavigationCubit())
    ];
  }
}
