
import 'dart:convert';
import 'dart:io';
import 'deatils.dart';

class Libarymanager{
  List<Book>book=[];
  List<Author>author=[];
   List<Member>member=[];

// ADD BOOK SECTION 

void addBook(Book Book ){
  book.add(Book);
}

  // View a list of books
  List<Book> viewAllBooks() {
    return book;
  }
  // Update a book by using ISBN
  void updateBook(String isbn, Book updateBook) {
    for (var i = 0; i < book.length; i++) {
      if (book[i].isbn == isbn) {
        book[i] = updateBook;
        return;
      }
    }
   print('Book with ISBN not found');
}
  // Delete book by ISBN
  void deleteBook(String isbn) {
    book.removeWhere((book) => book.isbn == isbn);
  }

    // Search book by title or author
  List<Book> searchBooks({String? title, String? author}) {
    return book.where((book) {
      return (title == null || book.title.contains(title)) &&
          (author == null || book.Author.contains(author));
    }).toList();
  }

  // Lend a book to member and track due date
  void lendBook(String isbn, String memberId, String dueDate) {
    for (Book book in book) {
      if (book.isbn == isbn) {
        if (!book.islent) {
          book.islent = true;
          book.duedate = dueDate;
          for (Member member in member) {
            if (member.memberId == memberId) {
              member.borrowed.add(isbn);
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

  // Return a book and update its status
  void returnBook(String isbn) {
    for (Book book in book) {
      if (book.isbn == isbn) {
        book.islent = false;
        book.duedate = '';
        for (Member member in member) {
          member.borrowed.remove(isbn);
        }
        return;
      }
    }
    print('Book not found.');
  }
  // --------------------------Author----------------------------------------

  // Add new author to list
  void addAuthor(Author Author) {
    author.add(Author);
  }

  // Return a list of all authors
  List<Author> viewAllAuthors() {
    return author;
  }
    // Update an existing author identified by name

  void updateAuthor(String name, Author updatedAuthor) {
    for (int i = 0; i < author.length; i++) {
      if (author[i].name == name) {
        author[i] = updatedAuthor;
        return;
      }
    }
    print('Author with name $name not found.');
  }

    // Delete an author identified by name
  void deleteAuthor(String name) {
    author.removeWhere((author) => author.name == name);
  }

 
   // --------------------------Member----------------------------------------

  // Add a new member to the list

  void addMember(Member Member) {
    member.add(Member);
  }

    // Return a list of all members

  List<Member> viewAllMembers() {
    return member;
  }

    // Update an existing member by their member ID

  void updateMember(String memberId, Member updatedMember) {
    for (int i = 0; i < member.length; i++) {
      if (member[i].memberId == memberId) {
        member[i] = updatedMember;
        return;
      }
    }
    print('Member with ID $memberId not found.');
  }
   // Delete a member by their member ID

  void deleteMember(String memberId) {
    member.removeWhere((member) => member.memberId == memberId);
  }
  
    // Search for members by name or member ID

  List<Member> searchMembers({String? memberId}) {
    return member.where((member) {
      return memberId == null || member.memberId.contains(memberId);
    }).toList();
  }
 
    

  // Save data to files
  Future<void> saveData() async {
    try {
      final bookFile = File('book.json');
      final authorFile = File('author.json');
      final memberFile = File('member.json');

      await bookFile.writeAsString(jsonEncode(book.map((book) => book.toJson()).toList()));
      await authorFile.writeAsString(jsonEncode(author.map((author) => author.toJson()).toList()));
      await memberFile.writeAsString(jsonEncode(member.map((member) => member.toJson()).toList()));
    } catch (e) {
      print('Error saving data: $e');
    }
  }
 
  // Load data from files
  Future<void> loadData() async {
    try {
      final bookFile = File('books.json');
      final authorFile = File('authors.json');
      final memberFile = File('members.json');

      if (await bookFile.exists()) {
        final bookData = await bookFile.readAsString();
        book = List<Book>.from(
            jsonDecode(bookData).map((data) => Book.fromJson(data)));
      }

      if (await authorFile.exists()) {
        final authorData = await authorFile.readAsString();
        author = List<Author>.from(
            jsonDecode(authorData).map((data) => Author.fromJson(data)));
      }

      if (await memberFile.exists()) {
        final memberData = await memberFile.readAsString();
        member = List<Member>.from(
            jsonDecode(memberData).map((data) => Member.fromJson(data)));
      }
    } catch (e) {
      print('Error loading data: $e');
    }
  }
}
