// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class ExerciseSet {
  Map<String, dynamic> toJSON();

  static ExerciseSet fromJSON(Map<String, dynamic> json) {
    if (json[ExerciseSetFields.type] == ExerciseSetFields.singleExerciseSet) {
      return SingleExerciseSet.fromJSON(json);
    } else if (json[ExerciseSetFields.type] == ExerciseSetFields.superSet) {
      return Superset.fromJSON(json);
    } else {
      throw Exception('Unknown exercise type');
    }
  }
}

class SingleExerciseSet extends ExerciseSet {
  String exerciseID;
  List sets;
  SingleExerciseSet({
    required this.exerciseID,
    required this.sets,
  });

  @override
  Map<String, dynamic> toJSON() {
    return {
      ExerciseSetFields.type: ExerciseSetFields.singleExerciseSet,
      ExerciseSetFields.exerciseID: exerciseID,
      ExerciseSetFields.sets: sets,
    };
  }

  factory SingleExerciseSet.fromJSON(Map<String, dynamic> json) {
    return SingleExerciseSet(
      exerciseID: json[ExerciseSetFields.exerciseID] as String,
      sets: json[ExerciseSetFields.sets] as List,
    );
  }
}

class Superset extends ExerciseSet {
  List<SingleExerciseSet> exercises;
  Superset({
    required this.exercises,
  });

  @override
  Map<String, dynamic> toJSON() {
    return {
      ExerciseSetFields.exercises: List<dynamic>.from(exercises.map((exercise) => exercise.toJSON())),
    };
  }

  factory Superset.fromJSON(Map<String, dynamic> json) {
    return Superset(
      exercises: List<SingleExerciseSet>.from(json[ExerciseSetFields.exercises].map((exercise) => SingleExerciseSet.fromJSON(exercise))),
    );
  }
}

class ExerciseSetFields {
  static String exerciseID = 'exerciseID';
  static String exercises = 'exercises';
  static String sets = 'sets';
  static String type = 'type';
  static String singleExerciseSet = 'singleExerciseSet';
  static String superSet = 'superSet';
}
