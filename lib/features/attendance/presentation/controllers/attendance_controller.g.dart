// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$attendanceControllerHash() =>
    r'd1e94152f35d4c55a9b958cb20488033795315ab';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$AttendanceController
    extends BuildlessAutoDisposeAsyncNotifier<AttendanceEntity?> {
  late final String weekKey;
  late final String userId;

  FutureOr<AttendanceEntity?> build({
    required String weekKey,
    required String userId,
  });
}

/// 출석 상태 관리 컨트롤러
///
/// Copied from [AttendanceController].
@ProviderFor(AttendanceController)
const attendanceControllerProvider = AttendanceControllerFamily();

/// 출석 상태 관리 컨트롤러
///
/// Copied from [AttendanceController].
class AttendanceControllerFamily extends Family<AsyncValue<AttendanceEntity?>> {
  /// 출석 상태 관리 컨트롤러
  ///
  /// Copied from [AttendanceController].
  const AttendanceControllerFamily();

  /// 출석 상태 관리 컨트롤러
  ///
  /// Copied from [AttendanceController].
  AttendanceControllerProvider call({
    required String weekKey,
    required String userId,
  }) {
    return AttendanceControllerProvider(weekKey: weekKey, userId: userId);
  }

  @override
  AttendanceControllerProvider getProviderOverride(
    covariant AttendanceControllerProvider provider,
  ) {
    return call(weekKey: provider.weekKey, userId: provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'attendanceControllerProvider';
}

/// 출석 상태 관리 컨트롤러
///
/// Copied from [AttendanceController].
class AttendanceControllerProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          AttendanceController,
          AttendanceEntity?
        > {
  /// 출석 상태 관리 컨트롤러
  ///
  /// Copied from [AttendanceController].
  AttendanceControllerProvider({
    required String weekKey,
    required String userId,
  }) : this._internal(
         () => AttendanceController()
           ..weekKey = weekKey
           ..userId = userId,
         from: attendanceControllerProvider,
         name: r'attendanceControllerProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$attendanceControllerHash,
         dependencies: AttendanceControllerFamily._dependencies,
         allTransitiveDependencies:
             AttendanceControllerFamily._allTransitiveDependencies,
         weekKey: weekKey,
         userId: userId,
       );

  AttendanceControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.weekKey,
    required this.userId,
  }) : super.internal();

  final String weekKey;
  final String userId;

  @override
  FutureOr<AttendanceEntity?> runNotifierBuild(
    covariant AttendanceController notifier,
  ) {
    return notifier.build(weekKey: weekKey, userId: userId);
  }

  @override
  Override overrideWith(AttendanceController Function() create) {
    return ProviderOverride(
      origin: this,
      override: AttendanceControllerProvider._internal(
        () => create()
          ..weekKey = weekKey
          ..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        weekKey: weekKey,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    AttendanceController,
    AttendanceEntity?
  >
  createElement() {
    return _AttendanceControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AttendanceControllerProvider &&
        other.weekKey == weekKey &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, weekKey.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AttendanceControllerRef
    on AutoDisposeAsyncNotifierProviderRef<AttendanceEntity?> {
  /// The parameter `weekKey` of this provider.
  String get weekKey;

  /// The parameter `userId` of this provider.
  String get userId;
}

class _AttendanceControllerProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          AttendanceController,
          AttendanceEntity?
        >
    with AttendanceControllerRef {
  _AttendanceControllerProviderElement(super.provider);

  @override
  String get weekKey => (origin as AttendanceControllerProvider).weekKey;
  @override
  String get userId => (origin as AttendanceControllerProvider).userId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
