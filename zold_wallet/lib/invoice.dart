/// Invoice model
class Invoice {
  /// ctor
  Invoice(this.prefix, this.invoice, this.id);

  /// ctor
  Invoice.fromJson(Map<String, dynamic> map) {
    prefix = map['prefix'];
    invoice = map['invoice'];
    id = map['id'];
  }

  /// Prefix of invoice
  String prefix;

  ///The invoice
  String invoice;

  /// Id of invoice
  String id;
}
