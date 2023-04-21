import 'package:squatva/general/models/models.dart';

class WorkoutTemplate {
  String uid;
  String name;
  String userID;
  List<ExerciseSet> exerciseSets;

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
      WorkoutTemplateFields.exerciseSets: List<dynamic>.from(exerciseSets.map((exerciseSet) => exerciseSet.toJSON())),
    };
  }

  static WorkoutTemplate fromJSON(json) {
    List data = json[WorkoutTemplateFields.exerciseSets] as List;
    List<ExerciseSet> exerciseSets = data.map((exerciseSet) => ExerciseSet.fromJSON(exerciseSet)).toList();

    return WorkoutTemplate(
      uid: json[WorkoutTemplateFields.uid] as String,
      name: json[WorkoutTemplateFields.name] as String,
      userID: json[WorkoutTemplateFields.userID] as String,
      exerciseSets: exerciseSets,
    );
  }

  WorkoutTemplate copy({
    String? uid,
    String? name,
    String? userID,
    List<ExerciseSet>? exerciseSets,
  }) {
    return WorkoutTemplate(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      userID: userID ?? this.userID,
      exerciseSets: exerciseSets ?? List.from(this.exerciseSets),
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
