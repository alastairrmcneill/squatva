class WorkoutTemplate {
  String uid;
  String name;
  String userID;
  Map exerciseSets;

  WorkoutTemplate({
    this.uid = '',
    required this.name,
    required this.userID,
    required this.exerciseSets,
  });

  Map<String, dynamic> toJSON() {
    return <String, dynamic>{
      WorkoutTemplateFields.uid: uid,
      WorkoutTemplateFields.name: name,
      WorkoutTemplateFields.userID: userID,
      WorkoutTemplateFields.exerciseSets: exerciseSets,
    };
  }

  static WorkoutTemplate fromJSON(json) {
    return WorkoutTemplate(
      uid: json[WorkoutTemplateFields.uid] as String,
      name: json[WorkoutTemplateFields.name] as String,
      userID: json[WorkoutTemplateFields.userID] as String,
      exerciseSets: json[WorkoutTemplateFields.exerciseSets] as Map,
    );
  }

  WorkoutTemplate copy({
    String? uid,
    String? name,
    String? userID,
    Map? exerciseSets,
  }) {
    return WorkoutTemplate(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      userID: userID ?? this.userID,
      exerciseSets: exerciseSets ?? Map.from(this.exerciseSets),
    );
  }
}

class WorkoutTemplateFields {
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
