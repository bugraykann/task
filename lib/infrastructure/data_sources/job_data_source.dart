import 'package:task/core/network/network_manager.dart';
import 'package:task/infrastructure/model/job_model.dart';

class JobDataSource {
  Future<List<JobModel>> searchJobs(String query) async {
    try {
      final response = await NetworkManager.instance.get(
        '/jobs',
        queryParameters: {'search': query},
      );
      final List<dynamic> data = response.data;
      return data.map((job) => JobModel.fromJson(job)).toList();
    } catch (e) {
      throw Exception('Failed to load jobs: $e');
    }
  }
}
