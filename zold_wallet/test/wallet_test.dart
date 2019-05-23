
import 'package:flutter_test/flutter_test.dart';
import 'package:zold_wallet/wallet.dart';

import 'secret.dart';

void main() {
  final Wallet wallet = Wallet.instance()
  ..apiKey = Secrets.apiKey;
  /// test the order of transactions (descending).
  test('test transactions order', () async {
    await wallet.updateTransactions();
    expect(wallet.transactions.length, isNot(0));
    for(int i=0; i<wallet.transactions.length-1; i++) {
      expect(wallet.transactions[i+1].isAfter(wallet.transactions[i]), false);
    }
  }, skip: true);
}