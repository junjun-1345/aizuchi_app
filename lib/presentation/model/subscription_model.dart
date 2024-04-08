class SubscriptionModel {
  final bool isActive;
  final String? planName;
  final DateTime? expirationDate;
  final DateTime? billingIssueDetectedAt;

  SubscriptionModel({
    required this.isActive,
    this.planName,
    this.expirationDate,
    this.billingIssueDetectedAt,
  });
}
