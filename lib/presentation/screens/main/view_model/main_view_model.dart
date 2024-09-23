import 'package:task/infrastructure/cubit/job_cubit.dart';
import 'package:task/infrastructure/cubit/navigation_view_model.dart';

class MainViewModel {
  final JobCubit jobCubit;
  final NavigationCubit navigationCubit;

  MainViewModel(this.jobCubit, this.navigationCubit);

  void searchJobs(String query) {
    jobCubit.searchJobs(query);
  }

  void changePage(int pageIndex) {
    navigationCubit.changePage(pageIndex);
  }
}
