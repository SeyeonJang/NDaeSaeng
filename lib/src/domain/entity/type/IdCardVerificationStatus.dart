enum IdCardVerificationStatus {
  NOT_VERIFIED_YET, VERIFICATION_IN_PROGRESS, VERIFICATION_SUCCESS, VERIFICATION_FAILED;

  bool get isNotVerifiedYet => this == NOT_VERIFIED_YET;
  bool get isVerificationInProgress => this == VERIFICATION_IN_PROGRESS;
  bool get isVerificationSuccess => this == VERIFICATION_SUCCESS;
  bool get isVerificationFailed => this == VERIFICATION_FAILED;

  static IdCardVerificationStatus fromValue(String? value) {
    switch (value) {
      case 'NOT_VERIFIED_YET': return NOT_VERIFIED_YET;
      case 'VERIFICATION_IN_PROGRESS': return VERIFICATION_IN_PROGRESS;
      case 'VERIFICATION_SUCCESS': return VERIFICATION_SUCCESS;
      case 'VERIFICATION_FAILED': return VERIFICATION_FAILED;
      default: return NOT_VERIFIED_YET;
    }
  }

  String toValue() {
    switch (this) {
      case NOT_VERIFIED_YET: return 'NOT_VERIFIED_YET';
      case VERIFICATION_IN_PROGRESS: return 'VERIFICATION_IN_PROGRESS';
      case VERIFICATION_SUCCESS: return 'VERIFICATION_SUCCESS';
      case VERIFICATION_FAILED: return 'VERIFICATION_FAILED';
      default: return 'NOT_VERIFIED_YET';
    }
  }
}
