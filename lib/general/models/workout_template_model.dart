class WorkoutTemplate {
  String uid;
  String name;
  String userID;
  List exercises;

  WorkoutTemplate({
    this.uid = '',
    required this.name,
    required this.userID,
    required this.exercises,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'userID': userID,
      'exercises': exercises,
    };
  }
}
