

 import 'dart:io';
 import 'deatils.dart';
import 'LibaryManager.dart';
void main() async {
 Libarymanager libarymanager = Libarymanager();

 // Load data at startup
  await libarymanager.loadData();

  while (true) {
print('''
Library management
1.Add Book
2.view Books
3.updates Books
4.Delete Books
5.Search Books
6.Lend books
7.Return books
8.Add Author
9.View All Author
10.Updates Author
11.Delete Author
12.Add Member
13.view all Member
14.Update Member
15.Delete Member
16.Search Member
17.Exit
enter your choice:''');


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
      libarymanager.addBook(Book(title, author, publicationYear, isbn));
    } else if (choice == '2') {

      // View All Books
      List<Book> books = libarymanager.viewAllBooks();
      for (var book in books) {
        print(
            'Title: ${book.title}, Author: ${book.Author}, Year: ${book.publishedyear}, ISBN: ${book.isbn}, Lent: ${book.islent}, Due Date: ${book.duedate}');
      }
    } else if (choice == '3') {

      // Update Book

      print('Enter ISBN of the book for update: ');
      String isbn = stdin.readLineSync()!;
      print('Enter new title: ');
      String title = stdin.readLineSync()!;
      print('Enter new author: ');
      String author = stdin.readLineSync()!;
      print('Enter publication year: ');
      int publicationYear = int.parse(stdin.readLineSync()!);
      libarymanager.updateBook(
          isbn, Book(title, author, publicationYear, isbn));
    } else if (choice == '4') {

      // Delete Book

      print('Enter ISBN to delete book: ');
      String isbn = stdin.readLineSync()!;
      libarymanager.deleteBook(isbn);
    } else if (choice == '5') {

      // Search Books

      print('Enter title to search (leave empty if not searching by title): ');
      String? title = stdin.readLineSync();
      print(
          'Enter author to search (leave empty if not searching by author): ');
      String? author = stdin.readLineSync();
      List<Book> books = libarymanager.searchBooks(
        title: title,
        author: author,
      );
      for (var book in books) {
        print(
            'Title: ${book.title}, Author: ${book.Author}, Year: ${book.publishedyear}, ISBN: ${book.isbn}, Lent: ${book.islent}, Due Date: ${book.duedate}');
      }
    } else if (choice == '6') {

      // Lend Book

      print('Enter ISBN of the book to lend: ');
      String isbn = stdin.readLineSync()!;
      print('Enter Member ID to lend the book to: ');
      String memberId = stdin.readLineSync()!;
      print('Enter due date (yyyy-mm-dd): ');
      String dueDate = stdin.readLineSync()!;
      libarymanager.lendBook(isbn, memberId, dueDate);
    } else if (choice == '7') {

      // Return Book

      print('Enter ISBN of the book to return: ');
      String isbn = stdin.readLineSync()!;
      libarymanager.returnBook(isbn);
    } else if (choice == '8') {

      // Add Author

      print('Enter name: ');
      String name = stdin.readLineSync()!;
      libarymanager.addAuthor(Author(name, []));
    } else if (choice == '9') {

      // View All Authors

      List<Author> authors = libarymanager.viewAllAuthors();
      for (var author in authors) {
        print('Name: ${author.name}, Books Written:');
        for (var isbn in author.bookWritten) {
          var book = libarymanager.book.firstWhere(
              (book) => book.isbn == isbn,
              orElse: () => Book('Unknown', 'Unknown', 0, 'Unknown'));
          print(
              '  Title: ${book.title}, Year: ${book.publishedyear}, ISBN: ${book.isbn}');
        }
      }
    } else if (choice == '10') {

      // Update Author

      print('Enter name of the author to update: ');
      String name = stdin.readLineSync()!;
      print('Enter new name: ');
      String newName = stdin.readLineSync()!;
      libarymanager.updateAuthor(name, Author(newName, []));
    } else if (choice == '11') {

      // Delete Author

      print('Enter name of the author to delete: ');
      String name = stdin.readLineSync()!;
      libarymanager.deleteAuthor(name);
    } else if (choice == '12') {

      // Add Member

      print('Enter name: ');
      String name = stdin.readLineSync()!;
      print('Enter Member ID: ');
      String memberId = stdin.readLineSync()!;
      libarymanager.addMember(Member(name, memberId, []));
    } else if (choice == '13') {

      // View All Members

      List<Member> members = libarymanager.viewAllMembers();
      for (var member in members) {
        print(
            'Name: ${member.name}, Member ID: ${member.memberId}, Borrowed Books: ${member.borrowed}');
      }
    } else if (choice == '14') {

      // Update Member

      print('Enter Member ID of the member to update: ');
      String memberId = stdin.readLineSync()!;
      print('Enter new name: ');
      String name = stdin.readLineSync()!;
      libarymanager.updateMember(memberId, Member(name, memberId, []));
    } else if (choice == '15') {

      // Delete Member
      
      print('Enter Member ID of the member to delete: ');
      String memberId = stdin.readLineSync()!;
      libarymanager.deleteMember(memberId);
    } else if (choice == '16') {
      // Exit
      await libarymanager.saveData();
      print('Exiting...');
      break;
    } else {
      print('Invalid choice. Please try again.');
    }
  }
}


