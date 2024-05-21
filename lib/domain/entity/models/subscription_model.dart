class SubscriptionModel {
  bool isActive;
  String? planName;
  DateTime? expirationDate;
  DateTime? billingIssueDetectedAt;

  SubscriptionModel({
    required this.isActive,
    this.planName,
    this.expirationDate,
    this.billingIssueDetectedAt,
  });
}
