
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
      for(int j=1; j<wallet.transactions.length; j++) {
        expect(wallet.transactions[i].isAfter(wallet.transactions[j]),
        true);
      }
    }
  });
}