class Exercise {
  final String id;
  final String name;
  final String note;
  final bool userMade;
  final String muscleGroupID;
  final ExerciseType exerciseType;

  Exercise({
    required this.id,
    required this.name,
    required this.note,
    required this.userMade,
    required this.muscleGroupID,
    required this.exerciseType,
  });
}

enum ExerciseType {
  cardio,
  strength,
  plyometrics,
}

List<Exercise> exercises = [
  Exercise(
    id: '1',
    name: 'Overhead press',
    note: 'Push head forwards once bar is up.',
    userMade: false,
    muscleGroupID: '8',
    exerciseType: ExerciseType.strength,
  ),
  Exercise(
    id: '2',
    name: 'Peck Fly',
    note: 'Keep arms straight',
    userMade: false,
    muscleGroupID: '4',
    exerciseType: ExerciseType.strength,
  ),
];
