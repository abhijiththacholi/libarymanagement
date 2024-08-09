//MEMBERS CLASS

class Book {
  String title;
  String author;
  int publishedYear;
  String isbn;
  bool isLent;
  String dueDate;

  Book(this.title, this.author, this.publishedYear, this.isbn,
      {this.isLent = false, this.dueDate = ''});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'publishedYear': publishedYear,
      'isbn': isbn,
      'isLent': isLent,
      'dueDate': dueDate,
    };
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      json['title'],
      json['author'],
      json['publishedYear'],
      json['isbn'],
      isLent: json['isLent'],
      dueDate: json['dueDate'],
    );
  }
}

class Author {
  String name;
  List<String> booksWritten;

  Author(this.name, this.booksWritten);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'booksWritten': booksWritten,
    };
  }

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      json['name'],
      List<String>.from(json['booksWritten']),
    );
  }
}

class Member {
  String name;
  String memberId;
  List<String> borrowedBooks;

  Member(this.name, this.memberId, this.borrowedBooks);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'memberId': memberId,
      'borrowedBooks': borrowedBooks,
    };
  }

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      json['name'],
      json['memberId'],
      List<String>.from(json['borrowedBooks']),
    );
  }
}
