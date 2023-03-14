import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:squatva/general/models/models.dart';
import 'package:squatva/general/services/services.dart';

class WorkoutDatabase {
  static final _db = FirebaseFirestore.instance;
  static final CollectionReference _collectionRef = _db.collection('workouts');

  static Future create(BuildContext context, {required Workout workout}) async {
    DocumentReference _ref = _collectionRef.doc();

    Workout newWorkout = workout.copy(uid: _ref.id);

    await _ref.set(newWorkout.toJSON());
  }

  static Future<List<Workout>> readMyWorkouts(BuildContext context) async {
    Query query = _collectionRef.where(ExerciseFields.userID, isEqualTo: AuthService.currentUserId);
    QuerySnapshot querySnapshot = await query.get();

    List<Workout> workoutList = [];

    for (var doc in querySnapshot.docs) {
      Workout workout = Workout.fromJSON(doc.data());
      workoutList.add(workout);
    }

    return workoutList;
  }

  static Future update(BuildContext context, {required Workout workout}) async {
    DocumentReference _docRef = _collectionRef.doc(workout.uid);

    await _docRef.update(workout.toJSON());
  }

  static Future delete(BuildContext context, {required Workout workout}) async {
    DocumentReference _docRef = _collectionRef.doc(workout.uid);

    await _docRef.delete();
  }
}
