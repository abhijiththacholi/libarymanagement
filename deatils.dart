//MEMBERS CLASS

class Member{
  String name;
  String memberId;
  List<String>borrowed;
  Member(this.name ,this.memberId,this.borrowed);

  Map<String,dynamic>toJson() =>
  {'name':name,'memberId':memberId,'borrowed':borrowed};

  factory Member.fromJson(Map<String,dynamic>json)=>Member(
   json['name'] ,
   json['memberId'],
  List<String>.from(json['borrowed']));  
  
}


// BOOKS CLASS
class Book{
String title;
String Author;
int   publishedyear;
String isbn;
bool islent;
String duedate;

Book(this.title,this.Author,this.publishedyear,this.isbn,
{this.islent=false,this.duedate=''});
Map<String,dynamic>toJson() =>{
  'title':title,
  'author':Author,
  'publishedyear':publishedyear,
 'isLent': islent,
  'dueDate': duedate,

  };
  factory Book.fromJson(Map<String, dynamic> json) => Book(
        json['title'],
        json['author'],
        json['publicationYear'],
        json['isbn'],
        islent: json['isLent'],
        duedate: json['dueDate'],
      );

}


// AUTHOR CLASS

class Author {
  String name;
  List<String> bookWritten;

  Author(this.name, this.bookWritten);

  Map<String, dynamic> toJson() => {
        'name': name,
        'bookWritten': bookWritten,
      };

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        json['name'],
        List<String>.from(json['bookWritten']),
  
      );
}


