class Invoice {
  String prefix;
  String invoice;
  String id;
  Invoice(this.prefix, this.invoice, this.id);
  Invoice.fromJson(Map<String, dynamic> map) {
    this.prefix = map["prefix"];
    this.invoice = map["invoice"];
    this.id = map["id"];
  }
}