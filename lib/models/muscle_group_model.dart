class MuscleGroup {
  final String id;
  final String name;
  final String imagePath;

  MuscleGroup({
    required this.id,
    required this.name,
    required this.imagePath,
  });
}

List<MuscleGroup> muscleGroups = [
  MuscleGroup(id: '1', name: 'Abdominals', imagePath: 'assets/muscle_groups/abs.png'),
  MuscleGroup(id: '2', name: 'Back', imagePath: 'assets/muscle_groups/back.png'),
  MuscleGroup(id: '3', name: 'Biceps', imagePath: 'assets/muscle_groups/biceps.png'),
  MuscleGroup(id: '4', name: 'Chest', imagePath: 'assets/muscle_groups/chest.png'),
  MuscleGroup(id: '5', name: 'Forearms', imagePath: 'assets/muscle_groups/forearms.png'),
  MuscleGroup(id: '6', name: 'Glutes', imagePath: 'assets/muscle_groups/glutes.png'),
  MuscleGroup(id: '7', name: 'Lower Legs', imagePath: 'assets/muscle_groups/lower_legs.png'),
  MuscleGroup(id: '8', name: 'Shoulders', imagePath: 'assets/muscle_groups/shoulders.png'),
  MuscleGroup(id: '9', name: 'Triceps', imagePath: 'assets/muscle_groups/triceps.png'),
  MuscleGroup(id: '10', name: 'Upper Legs', imagePath: 'assets/muscle_groups/upper_legs.png'),
];
