import 'dart:io';
import 'dart:convert';

void main() async {
  LibraryManager libraryManager = LibraryManager();

  // Load data at startup
  await libraryManager.loadData();

  while (true) {
    print('''
Library management
1. Add Book
2. View Books
3. Update Book
4. Delete Book
5. Search Books
6. Lend Book
7. Return Book
8. Add Author
9. View All Authors
10. Update Author
11. Delete Author
12. Add Member
13. View All Members
14. Update Member
15. Delete Member
16.search Member
16. Exit
Enter your choice:''');

    var choice = stdin.readLineSync();
    if (choice == '1') {
      // Add Book

      print('Enter title: ');
      String title = stdin.readLineSync()!;
      print('Enter author: ');
      String author = stdin.readLineSync()!;
      print('Enter publication year: ');
      int publicationYear = int.parse(stdin.readLineSync()!);
      print('Enter ISBN: ');
      String isbn = stdin.readLineSync()!;
      libraryManager.addBook(Book(title, author, publicationYear, isbn));
    } else if (choice == '2') {
      // View All Books

      List<Book> books = libraryManager.viewAllBooks();
      for (var book in books) {
        print(
            'Title: ${book.title}, Author: ${book.author}, Year: ${book.publishedYear}, ISBN: ${book.isbn}, Lent: ${book.isLent}, Due Date: ${book.dueDate}');
      }
    } else if (choice == '3') {
      // Update Book

      print('Enter ISBN of the book to update: ');
      String isbn = stdin.readLineSync()!;
      print('Enter new title: ');
      String title = stdin.readLineSync()!;
      print('Enter new author: ');
      String author = stdin.readLineSync()!;
      print('Enter publication year: ');
      int publicationYear = int.parse(stdin.readLineSync()!);
      libraryManager.updateBook(
          isbn, Book(title, author, publicationYear, isbn));
    } else if (choice == '4') {
      // Delete Book

      print('Enter ISBN to delete book: ');
      String isbn = stdin.readLineSync()!;
      libraryManager.deleteBook(isbn);
    } else if (choice == '5') {
      // Search Books

      print('Enter title to search (leave empty if not searching by title): ');
      String? title = stdin.readLineSync();
      print(
          'Enter author to search (leave empty if not searching by author): ');
      String? author = stdin.readLineSync();
      List<Book> books = libraryManager.searchBooks(
        title: title,
        author: author,
      );
      for (var book in books) {
        print(
            'Title: ${book.title}, Author: ${book.author}, Year: ${book.publishedYear}, ISBN: ${book.isbn}, Lent: ${book.isLent}, Due Date: ${book.dueDate}');
      }
    } else if (choice == '6') {
      // Lend Book

      print('Enter ISBN of the book to lend: ');
      String isbn = stdin.readLineSync()!;
      print('Enter Member ID to lend the book to: ');
      String memberId = stdin.readLineSync()!;
      print('Enter due date (yyyy-mm-dd): ');
      String dueDate = stdin.readLineSync()!;
      libraryManager.lendBook(isbn, memberId, dueDate);
    } else if (choice == '7') {
      // Return Book

      print('Enter ISBN of the book to return: ');
      String isbn = stdin.readLineSync()!;
      libraryManager.returnBook(isbn);
    } else if (choice == '8') {
      // Add Author

      print('Enter name: ');
      String name = stdin.readLineSync()!;
      libraryManager.addAuthor(Author(name, []));
    } else if (choice == '9') {
      // View All Authors

      List<Author> authors = libraryManager.viewAllAuthors();
      for (var author in authors) {
        print('Name: ${author.name}, Books Written:');
        for (var isbn in author.booksWritten) {
          var book = libraryManager.books.firstWhere(
              (book) => book.isbn == isbn,
              orElse: () => Book('Unknown', 'Unknown', 0, 'Unknown'));
          print(
              '  Title: ${book.title}, Year: ${book.publishedYear}, ISBN: ${book.isbn}');
        }
      }
    } else if (choice == '10') {
      // Update Author

      print('Enter name of the author to update: ');
      String name = stdin.readLineSync()!;
      print('Enter new name: ');
      String newName = stdin.readLineSync()!;
      libraryManager.updateAuthor(name, Author(newName, []));
    } else if (choice == '11') {
      // Delete Author

      print('Enter name of the author to delete: ');
      String name = stdin.readLineSync()!;
      libraryManager.deleteAuthor(name);
    } else if (choice == '12') {
      // Add Member

      print('Enter name: ');
      String name = stdin.readLineSync()!;
      print('Enter Member ID: ');
      String memberId = stdin.readLineSync()!;
      libraryManager.addMember(Member(name, memberId, []));
    } else if (choice == '13') {
      // View All Members

      List<Member> members = libraryManager.viewAllMembers();
      for (var member in members) {
        print(
            'Name: ${member.name}, Member ID: ${member.memberId}, Borrowed Books: ${member.borrowedBooks}');
      }
    } else if (choice == '14') {
      // Update Member

      print('Enter Member ID of the member to update: ');
      String memberId = stdin.readLineSync()!;
      print('Enter new name: ');
      String name = stdin.readLineSync()!;
      libraryManager.updateMember(memberId, Member(name, memberId, []));
    } else if (choice == '15') {
      // Delete Member

      print('Enter Member ID of the member to delete: ');
      String memberId = stdin.readLineSync()!;
      libraryManager.deleteMember(memberId);
    } else if (choice == '16') {
      // Exit

      await libraryManager.saveData();
      print('Exiting...');
      break;
    } else {
      print('Invalid choice. Please try again.');
    }
  }
}

// ...............................................................................
// import 'dart:convert';
// import 'dart:io';
// import 'details.dart';

class LibraryManager {
  List<Book> books = [];
  List<Author> authors = [];
  List<Member> members = [];

  // Add Book
  void addBook(Book book) {
    books.add(book);
  }

  // View All Books
  List<Book> viewAllBooks() {
    return books;
  }

  // Update Book by ISBN
  void updateBook(String isbn, Book updatedBook) {
    for (var i = 0; i < books.length; i++) {
      if (books[i].isbn == isbn) {
        books[i] = updatedBook;
        return;
      }
    }
    print('Book with ISBN not found');
  }

  // Delete Book by ISBN
  void deleteBook(String isbn) {
    books.removeWhere((book) => book.isbn == isbn);
  }

  // Search Books by title or author
  List<Book> searchBooks({String? title, String? author}) {
    return books.where((book) {
      return (title == null || book.title.contains(title)) &&
          (author == null || book.author.contains(author));
    }).toList();
  }

  // Lend Book to a member
  void lendBook(String isbn, String memberId, String dueDate) {
    for (Book book in books) {
      if (book.isbn == isbn) {
        if (!book.isLent) {
          book.isLent = true;
          book.dueDate = dueDate;
          for (Member member in members) {
            if (member.memberId == memberId) {
              member.borrowedBooks.add(isbn);
              return;
            }
          }
        } else {
          print('Book is already lent.');
          return;
        }
      }
    }
    print('Book or Member not found.');
  }

  // Return Book
  void returnBook(String isbn) {
    for (Book book in books) {
      if (book.isbn == isbn) {
        book.isLent = false;
        book.dueDate = '';
        for (Member member in members) {
          member.borrowedBooks.remove(isbn);
        }
        return;
      }
    }
    print('Book not found.');
  }

  // Add Author
  void addAuthor(Author author) {
    authors.add(author);
  }

  // View All Authors
  List<Author> viewAllAuthors() {
    return authors;
  }

  // Update Author by name
  void updateAuthor(String name, Author updatedAuthor) {
    for (int i = 0; i < authors.length; i++) {
      if (authors[i].name == name) {
        authors[i] = updatedAuthor;
        return;
      }
    }
    print('Author with name $name not found.');
  }

  // Delete Author by name
  void deleteAuthor(String name) {
    authors.removeWhere((author) => author.name == name);
  }

  // Add Member
  void addMember(Member member) {
    members.add(member);
  }

  // View All Members
  List<Member> viewAllMembers() {
    return members;
  }

  // Update Member by ID
  void updateMember(String memberId, Member updatedMember) {
    for (var i = 0; i < members.length; i++) {
      if (members[i].memberId == memberId) {
        members[i] = updatedMember;
        return;
      }
    }
    print('Member with ID $memberId not found.');
  }

  // Delete Member by ID
  void deleteMember(String memberId) {
    members.removeWhere((member) => member.memberId == memberId);
  }

  // Load data from JSON files
  Future<void> loadData() async {
    try {
      String booksJson = await File('Book.json').readAsString();
      String authorsJson = await File('Author.json').readAsString();
      String membersJson = await File('Member.json').readAsString();

      List<dynamic> booksList = jsonDecode(booksJson);
      books = booksList.map((book) => Book.fromJson(book)).toList();

      List<dynamic> authorsList = jsonDecode(authorsJson);
      authors = authorsList.map((author) => Author.fromJson(author)).toList();

      List<dynamic> membersList = jsonDecode(membersJson);
      members = membersList.map((member) => Member.fromJson(member)).toList();
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  // Save data to JSON files
  Future<void> saveData() async {
    try {
      String booksJson = jsonEncode(books);
      String authorsJson = jsonEncode(authors);
      String membersJson = jsonEncode(members);

      await File('Book.json').writeAsString(booksJson);
      await File('Author.json').writeAsString(authorsJson);
      await File('Member.json').writeAsString(membersJson);
    } catch (e) {
      print('Error saving data: $e');
    }
  }
}

// ...................................................................
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
