class Exercise {
  final String? id;
  final String name;
  final String equipment;
  final List<String> musclesUsed;
  final String exerciseCategory;
  final String limbInvolvement;
  final String link;
  final String note;
  final String? userID;

  Exercise({
    this.id,
    required this.name,
    required this.equipment,
    required this.musclesUsed,
    required this.exerciseCategory,
    required this.limbInvolvement,
    required this.link,
    required this.note,
    this.userID,
  });

  Map<String, Object?> toJSON() {
    return {
      ExerciseFields.id: id,
      ExerciseFields.name: name,
      ExerciseFields.equipment: equipment,
      ExerciseFields.musclesUsed: musclesUsed,
      ExerciseFields.exerciseCategory: exerciseCategory,
      ExerciseFields.limbInvolvement: limbInvolvement,
      ExerciseFields.link: link,
      ExerciseFields.note: note,
      ExerciseFields.userID: userID,
    };
  }

  static Exercise fromJSON(json) {
    List<dynamic> musclesUsed = json[ExerciseFields.musclesUsed];
    List<String> listMusclesUsed = List<String>.from(musclesUsed);

    return Exercise(
      id: json[ExerciseFields.id] as String?,
      name: json[ExerciseFields.name] as String,
      equipment: json[ExerciseFields.equipment] as String,
      musclesUsed: listMusclesUsed,
      exerciseCategory: json[ExerciseFields.exerciseCategory] as String,
      limbInvolvement: json[ExerciseFields.limbInvolvement] as String,
      link: json[ExerciseFields.link] as String,
      note: json[ExerciseFields.note] as String,
      userID: json[ExerciseFields.userID] as String?,
    );
  }

  Exercise copy({
    String? id,
    String? name,
    String? equipment,
    List<String>? musclesUsed,
    String? exerciseCategory,
    String? limbInvolvement,
    String? link,
    String? note,
    String? userID,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      equipment: equipment ?? this.equipment,
      musclesUsed: musclesUsed ?? this.musclesUsed,
      exerciseCategory: exerciseCategory ?? this.exerciseCategory,
      limbInvolvement: limbInvolvement ?? this.limbInvolvement,
      link: link ?? this.link,
      note: note ?? this.note,
      userID: userID ?? this.userID,
    );
  }
}

class ExerciseFields {
  static String id = 'id';
  static String name = 'name';
  static String equipment = 'equipment';
  static String musclesUsed = 'musclesUsed';
  static String exerciseCategory = 'exerciseCategory';
  static String limbInvolvement = 'limbInvolvement';
  static String link = 'link';
  static String note = 'note';
  static String userID = 'userID';
}

class ExerciseCategory {
  static String lowerPush = 'Lower Push';
  static String lowerPull = 'Lower Pull';
  static String upperPush = 'Upper Push';
  static String upperPull = 'Upper Pull';
  static String arms = 'Arms';
  static String trunk = 'Trunk';
  static String other = 'Other';

  static List<String> all = [
    lowerPull,
    upperPull,
    lowerPush,
    upperPush,
    arms,
    trunk,
    other,
  ];
}

class LimbInvolvement {
  static String bilateral = 'Bilateral';
  static String unilateral = 'Unilateral';

  static List<String> all = [
    unilateral,
    bilateral,
  ];
}

class Equipment {
  static String bodyweight = 'Bodyweight';
  static String barbell = 'Barbell';
  static String dumbbell = 'Dumbbell';
  static String resistanceBand = 'ResistanceBand';
  static String machine = 'Machine';
  static String other = 'Other';

  static List<String> all = [
    bodyweight,
    barbell,
    dumbbell,
    resistanceBand,
    machine,
    other,
  ];
}

List<Exercise> defaultExercises = [
  Exercise(
    id: '1',
    name: 'Barbell Overhead Press',
    equipment: Equipment.barbell,
    musclesUsed: ['Shoulders', 'Triceps'],
    exerciseCategory: ExerciseCategory.upperPush,
    limbInvolvement: LimbInvolvement.bilateral,
    link: '',
    note: '',
  ),
  Exercise(
    id: '2',
    name: 'Pec Flys',
    equipment: Equipment.dumbbell,
    musclesUsed: ['Chest'],
    exerciseCategory: ExerciseCategory.upperPush,
    limbInvolvement: LimbInvolvement.unilateral,
    link: '',
    note: '',
  ),
];
