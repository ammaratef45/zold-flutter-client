import 'package:flutter_test/flutter_test.dart';
import 'package:zold_wallet/backend/API.dart';
import 'package:zold_wallet/invoice.dart';
import 'secret.dart';
import 'package:zold_wallet/wts_log.dart';
import 'package:zold_wallet/job.dart';

void main() {
  test('test API PULL', () async {
    API api = API();
    String res =await api.pull(Secrets.apiKey);
    expect(res, isNot(null));
  });
  test('test API output', () async {
    API api = API();
    String job =await api.pull(Secrets.apiKey);
    WtsLog log = await api.output(job, Secrets.apiKey);
    expect(log.status, isNot(null));
    expect(log.fullLog, isNot(null));
  });

  test('test API job.json', () async {
    API api = API();
    String job = await api.pull(Secrets.apiKey);
    Job res = await api.job(job, Secrets.apiKey);
    expect(res.id, job);
    expect(res.errorMessage, null);
  });

  test('test API rate', () async {
    API api = API();
    String res = await api.rate();
    expect(res, isNotNull);
  });

  test('test API invoice.json', () async {
    API api = API();
    /*String job = await api.pull(Secrets.apiKey);
    String state = 'Running';
    while (state.toLowerCase()=='running') {
      Future.delayed(Duration(seconds: 3));
      state = (await api.job(job, Secrets.apiKey)).status;
    }*/
    Invoice res = await api.invoice(Secrets.apiKey);
    expect(res.id, '25a9cac1715a3726');
  });

  test('test API txns.json', () async {
    API api = API();
    /*String job = await api.pull(Secrets.apiKey);
    String state = 'Running';
    while (state.toLowerCase()=='running') {
      Future.delayed(Duration(seconds: 3));
      state = (await api.job(job, Secrets.apiKey)).status;
    }*/
    String res = await api.transactions(Secrets.apiKey);
    expect(res, isNotNull);
  });
}
