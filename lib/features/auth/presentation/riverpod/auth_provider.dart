import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kharcha/features/auth/data/models/auth_model.dart';
import '../../di/auth_di.dart';
import '../../domain/usecases/auth_usecase.dart';

class AuthNotifier extends StateNotifier<AsyncValue<AuthModel>> {
  final AuthUseCase useCase;

  AuthNotifier(this.useCase) : super(const AsyncValue.loading());

  Future<void> login(String phone,String pass) async {
    state = const AsyncValue.loading();
    try {
      final result = await useCase.login(phone, pass);
      result.fold((l){
        state = AsyncValue.error(l.toString(),.current);
      }, (r){
        state = AsyncValue.data(r.data);
      });

    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> register(String name,String phone,String pass) async {
    state = const AsyncValue.loading();
    try {
      final result = await useCase.register(name,phone, pass);
      result.fold((l){
        state = AsyncValue.error(l.toString(),.current);
      }, (r){
        state = AsyncValue.data(r.data);
      });

    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateProfile(String name,String phone,String pass,File? photo) async {
    state = const AsyncValue.loading();
    try {
      final result = await useCase.update(name,phone, pass,photo);
      result.fold((l){
        state = AsyncValue.error(l.toString(),.current);
      }, (r){
        state = AsyncValue.data(r.data);
      });

    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> fetchProfile() async {
    state = const AsyncValue.loading();
    try {
      final result = await useCase.fetch();
      result.fold((l){
        state = AsyncValue.error(l.toString(),.current);
      }, (r){
        state = AsyncValue.data(r.data);
      });

    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

}

final authNotifierProvider =
    StateNotifierProvider.autoDispose<AuthNotifier, AsyncValue<AuthModel>>((ref) {
  final useCase = AuthDI.provideAuthUseCase();
  return AuthNotifier(useCase);
});
