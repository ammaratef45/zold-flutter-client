import 'package:flutter_test/flutter_test.dart';
import 'package:zold_wallet/backend/api.dart';
import 'package:zold_wallet/backend/head.dart';
import 'package:zold_wallet/invoice.dart';
import 'package:zold_wallet/job.dart';
import 'package:zold_wallet/wts_log.dart';
import 'secret.dart';

void main() {
  /// test pull endpoint isn't throwing any errors
  /// also the response shouldn't be null.
  test('test API PULL', () async {
    final API api = API();
    final String res = await api.pull(Secrets.apiKey);
    expect(res, isNot(null));
  });

  /// test if the job returned by endpoints like pull works as supposed.
  test('test API output', () async {
    final API api = API();
    final String job = await api.pull(Secrets.apiKey);
    final WtsLog log = await api.output(job, Secrets.apiKey);
    expect(log.status, isNot(null));
    expect(log.fullLog, isNot(null));
  });

  /// test retrieving running job info.
  test('test API job.json', () async {
    final API api = API();
    final String job = await api.pull(Secrets.apiKey);
    final Job res = await api.job(job, Secrets.apiKey);
    expect(res.id, job);
    expect(res.errorMessage, null);
  });

  /// test retrieving the rate of the coins.
  test('test API rate', () async {
    final API api = API();
    final String res = await api.rate();
    expect(res, isNotNull);
  });

  /// test getting the invoice works as supposed.
  test('test API invoice.json', () async {
    final API api = API();
    final Invoice res = await api.invoice(Secrets.apiKey);
    expect(res.id, '25a9cac1715a3726');
  }, skip: true);

  /// test retreiving the transactions works.
  test('test API txns.json', () async {
    final API api = API();
    final String res = await api.transactions(Secrets.apiKey);
    expect(res, isNotNull);
  });

  /// test retreiving the head works.
  test('test API head.json', () async {
    final API api = API();
    final Head res = await api.head(Secrets.apiKey);
    expect(res, isNotNull);
  });
}
