
class Job {
  String id;
  String status;
  num outputLength;
  Job.fromJson(Map<String, dynamic> map) {
    this.id = map["id"];
    this.status = map["status"];
    this.outputLength = map["output_length"];
  }
}