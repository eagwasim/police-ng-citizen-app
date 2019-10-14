class SendPhoneVerificationCodeRequest {
  String phoneNumber;

  SendPhoneVerificationCodeRequest(this.phoneNumber);

  Map<String, dynamic> toJson() {
    return {"phone_number": this.phoneNumber};
  }
}

class VerifyPhoneNumberRequest {
  String phoneNumber;
  String verificationCode;

  VerifyPhoneNumberRequest({this.phoneNumber, this.verificationCode});

  Map<String, dynamic> toJson() {
    return {
      "phone_number": this.phoneNumber,
      "verification_code": this.verificationCode,
    };
  }
}
