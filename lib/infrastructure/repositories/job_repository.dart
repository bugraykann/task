import '../data_sources/job_data_source.dart';
import '../model/job_model.dart';

class JobRepository {
  final JobDataSource dataSource;

  JobRepository(this.dataSource);

  Future<List<JobModel>> searchJobs(String query) async {
    return await dataSource.searchJobs(query);
  }
}
