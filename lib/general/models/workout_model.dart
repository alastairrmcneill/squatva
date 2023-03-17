class Workout {
  String uid;
  String userID;
  List exerciseSets;

  Workout({
    this.uid = '',
    required this.userID,
    required this.exerciseSets,
  });

  Map<String, dynamic> toJSON() {
    return <String, dynamic>{
      WorkoutFields.uid: uid,
      WorkoutFields.userID: userID,
      WorkoutFields.exerciseSets: exerciseSets,
    };
  }

  static Workout fromJSON(json) {
    return Workout(
      uid: json[WorkoutFields.uid] as String,
      userID: json[WorkoutFields.userID] as String,
      exerciseSets: json[WorkoutFields.exerciseSets] as List,
    );
  }

  Workout copy({
    String? uid,
    String? userID,
    List? exerciseSets,
  }) {
    return Workout(
      uid: uid ?? this.uid,
      userID: userID ?? this.userID,
      exerciseSets: exerciseSets ?? this.exerciseSets,
    );
  }
}

class WorkoutFields {
  static String uid = 'uid';
  static String name = 'name';
  static String userID = 'userID';
  static String exerciseSets = 'exerciseSets';
  static String exerciseIndex = 'exerciseIndex';
  static String exerciseId = 'exerciseId';
  static String sets = 'sets';
  static String reps = 'reps';
  static String weight = 'weight';
}
