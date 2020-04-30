class FeedbackModel {
  int id;
  String feedbackName;
  String feedbackEmail;
  String feedbackDescription;

  FeedbackModel(
      this.feedbackName, this.feedbackEmail, this.feedbackDescription);

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["feedbackN"] = feedbackName;
    map["feedbackE"] = feedbackEmail;
    map["feedbackD"] = feedbackDescription;

    if (id != null) {
      map["feedbackID"] = id;
    }
    return map;
  }

  FeedbackModel.fromMap(Map<String, dynamic> map) {
    this.id = map["feedbackID"];
    this.feedbackName = map["feedbackN"];
    this.feedbackEmail = map["feedbackE"];
    this.feedbackDescription = map["feedbackD"];
  }
}
