class Exercise {
  final String? id;
  final String name;
  final String equipment;
  final String exerciseCategory;
  final String limbInvolvement;
  final List<String> bodyParts;
  final List<String> tags;
  final String link;
  final String note;
  final String? userID;

  Exercise({
    this.id,
    required this.name,
    required this.exerciseCategory,
    required this.limbInvolvement,
    required this.equipment,
    required this.bodyParts,
    required this.tags,
    required this.link,
    required this.note,
    this.userID,
  });

  Map<String, Object?> toJSON() {
    return {
      ExerciseFields.id: id,
      ExerciseFields.name: name,
      ExerciseFields.exerciseCategory: exerciseCategory,
      ExerciseFields.limbInvolvement: limbInvolvement,
      ExerciseFields.equipment: equipment,
      ExerciseFields.bodyParts: bodyParts,
      ExerciseFields.tags: tags,
      ExerciseFields.link: link,
      ExerciseFields.note: note,
      ExerciseFields.userID: userID,
    };
  }

  static Exercise fromJSON(json) {
    List<dynamic> bodyParts = json[ExerciseFields.bodyParts];
    List<String> listBodyParts = List<String>.from(bodyParts);

    List<dynamic> tags = json[ExerciseFields.tags];
    List<String> listTags = List<String>.from(tags);

    return Exercise(
      id: json[ExerciseFields.id] as String?,
      name: json[ExerciseFields.name] as String,
      exerciseCategory: json[ExerciseFields.exerciseCategory] as String,
      limbInvolvement: json[ExerciseFields.limbInvolvement] as String,
      equipment: json[ExerciseFields.equipment] as String,
      bodyParts: listBodyParts,
      tags: listTags,
      link: json[ExerciseFields.link] as String,
      note: json[ExerciseFields.note] as String,
      userID: json[ExerciseFields.userID] as String?,
    );
  }

  Exercise copy({
    String? id,
    String? name,
    String? exerciseCategory,
    String? limbInvolvement,
    String? equipment,
    List<String>? bodyParts,
    List<String>? tags,
    String? link,
    String? note,
    String? userID,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      exerciseCategory: exerciseCategory ?? this.exerciseCategory,
      limbInvolvement: limbInvolvement ?? this.limbInvolvement,
      equipment: equipment ?? this.equipment,
      bodyParts: bodyParts ?? this.bodyParts,
      tags: tags ?? this.tags,
      link: link ?? this.link,
      note: note ?? this.note,
      userID: userID ?? this.userID,
    );
  }
}

class ExerciseFields {
  static String id = 'id';
  static String name = 'name';
  static String exerciseCategory = 'exerciseCategory';
  static String limbInvolvement = 'limbInvolvement';
  static String equipment = 'equipment';
  static String bodyParts = 'bodyParts';
  static String tags = 'tags';
  static String link = 'link';
  static String note = 'note';
  static String userID = 'userID';
}

class ExerciseCategory {
  static String lowerPush = 'Lower Push';
  static String lowerPull = 'Lower Pull';
  static String upperPush = 'Upper Push';
  static String upperPull = 'Upper Pull';
  static String arms = 'arms';
  static String trunk = 'trunk';
  static String other = 'other';

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
  static String bilateral = 'bilateral';
  static String unilateral = 'unilateral';

  static List<String> all = [
    unilateral,
    bilateral,
  ];
}

class Equipment {
  static String bodyweight = 'bodyweight';
  static String barbell = 'barbell';
  static String dumbbell = 'dumbbell';
  static String resistanceBand = 'resistanceBand';
  static String machine = 'machine';
  static String other = 'other';

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
    name: 'Barbell Overhead Press',
    exerciseCategory: ExerciseCategory.upperPush,
    limbInvolvement: LimbInvolvement.bilateral,
    equipment: Equipment.barbell,
    bodyParts: ['Shoulders', 'triceps'],
    tags: ['Strength'],
    link: '',
    note: '',
  ),
  Exercise(
    name: 'Pec Flys',
    exerciseCategory: ExerciseCategory.upperPush,
    limbInvolvement: LimbInvolvement.unilateral,
    equipment: Equipment.dumbbell,
    bodyParts: ['Chest'],
    tags: ['Strength'],
    link: '',
    note: '',
  ),
];
