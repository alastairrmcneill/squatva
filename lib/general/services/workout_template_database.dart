import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:squatva/general/models/models.dart';
import 'package:squatva/general/services/services.dart';

class WorkoutTemplateDatabase {
  static final _db = FirebaseFirestore.instance;
  static final CollectionReference _collectionRef = _db.collection('workoutTemplates');

  static Future create(BuildContext context, {required WorkoutTemplate workoutTemplate}) async {
    DocumentReference _ref = _collectionRef.doc();

    WorkoutTemplate newWorkoutTemplate = workoutTemplate.copy(uid: _ref.id);

    await _ref.set(newWorkoutTemplate.toJSON());
  }

  static Future<List<WorkoutTemplate>> readMyWorkoutTemplates(BuildContext context) async {
    Query query = _collectionRef.where(ExerciseFields.userID, isEqualTo: AuthService.currentUserId);
    QuerySnapshot querySnapshot = await query.get();

    List<WorkoutTemplate> workoutTemplateList = [];

    for (var doc in querySnapshot.docs) {
      WorkoutTemplate workoutTemplate = WorkoutTemplate.fromJSON(doc.data());
      workoutTemplateList.add(workoutTemplate);
    }

    return workoutTemplateList;
  }

  static Future update(BuildContext context, {required WorkoutTemplate workoutTemplate}) async {
    DocumentReference _docRef = _collectionRef.doc(workoutTemplate.uid);

    await _docRef.update(workoutTemplate.toJSON());
  }

  static Future delete(BuildContext context, {required WorkoutTemplate workoutTemplate}) async {
    DocumentReference _docRef = _collectionRef.doc(workoutTemplate.uid);

    await _docRef.delete();
  }
}
