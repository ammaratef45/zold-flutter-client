/*
 "id": 239,\n
 "date": "2019-01-13T15:42:17Z",\n'
 "amount": 1099511627,\n'
 "prefix": "CAQ8AMII",\n'
 "bnf": "e5b5fc7379d80ed7",\n'
 "details": "WTS signup bonus to ammaratef45",\n
 "sign": null,
 "tid": "e5b5fc7379d80ed7:239"
 */
class Transaction {
 num id;
 String date;
 num zents;
 String details;
 String sender;
 Transaction.fromJson(Map<String, dynamic> map) {
   this.id = map["id"];
   this.date = map["date"];
   this.zents = map["amount"];
   this.details = map["details"];
   this.sender = map["bnf"];
 }

 static List<Transaction> fromJsonList(List<dynamic> list) {
   List<Transaction> result =List();
   for (var i = 0; i < list.length; i++) {
     result.add(Transaction.fromJson(list[i]));
   }
   return result;
 }
}