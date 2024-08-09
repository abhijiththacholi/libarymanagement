import 'dart:convert';
import 'dart:io';
import 'details.dart';


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
   // Search Members by name or ID
  List<Member> searchMembers({String? name, String? memberId}) {
    return members.where((member) {
      return (name == null || member.name.contains(name)) &&
             (memberId == null || member.memberId.contains(memberId));
    }).toList();
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