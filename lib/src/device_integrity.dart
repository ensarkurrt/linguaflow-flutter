abstract interface class LinguaFlowDeviceIntegrityProvider {
  /// Obtains a short-lived server grant after native App Attest or Play
  /// Integrity verification. Native implementations own key storage and APIs.
  Future<LinguaFlowIntegrityGrant> obtainGrant({required String branchKey});
}

class LinguaFlowIntegrityGrant {
  const LinguaFlowIntegrityGrant(
      {required this.token, required this.expiresAt});

  final String token;
  final DateTime expiresAt;

  bool get isUsable => expiresAt.isAfter(
        DateTime.now().add(const Duration(minutes: 1)),
      );
}
