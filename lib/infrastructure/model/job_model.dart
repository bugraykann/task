class JobModel {
  final String createdAt;
  final String jobTitle;
  final String jobDesc;
  final String id;

  JobModel(
      {required this.createdAt,
      required this.jobTitle,
      required this.jobDesc,
      required this.id});

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      createdAt: json['createdAt'],
      jobTitle: json['jobTitle'],
      jobDesc: json['jobDesc'],
      id: json['id'],
    );
  }
}
