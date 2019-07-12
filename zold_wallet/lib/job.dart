/// The Job model
class Job {
  /// ctor
  Job.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    status = map['status'];
    outputLength = map['output_length'];
    errorMessage = map['error_message'];
  }

  /// id of the job
  String id;

  /// status of job (running, ok, cancelled)
  String status;

  /// length of output
  num outputLength;

  /// error message if any
  String errorMessage;
}
