
import 'package:flutter_test/flutter_test.dart';
import 'package:zold_wallet/wallet.dart';

import 'secret.dart';

void main() {
  Wallet wallet = Wallet.instance();
  wallet.apiKey = Secrets.apiKey;
  test('test transactions order', () async {
    await wallet.updateTransactions();
    expect(wallet.transactions.length, isNot(0));
    for(int i=0; i<wallet.transactions.length-1; i++) {
      expect(wallet.transactions[i+1].isAfter(wallet.transactions[i]), false);
    }
  });
}