import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youmr_v2/features/auth/data/dtos/create_user_dto.dart';
import 'package:youmr_v2/features/auth/data/dtos/user_response_dto.dart';

abstract class AuthDataSource {

  Future<UserCredential> signInWithGoogle({required AuthCredential credential});

  Future<void> signOut();

  Future<void> saveUserProfile({required String uid, required CreateUserDto createUserDto});

  Future<UserResponseDto?> fetchUserProfile({required String uid});

  Future<String> uploadProfileImage({required String uid, required File imageFile});

  Future<void> deleteProfileImage({required String imageUrl});

  Future<void> deleteAllProfileImages({required String uid});
}