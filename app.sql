-- Library Management System
-- Description: This project is a simple Library Management System using SQL.
-- It allows adding books, registering borrowers, tracking book loans, and managing returns.
-- Users can query borrowed books and check loan details.

-- Create database
CREATE DATABASE LibraryDB;
USE LibraryDB;

-- Create table for books
CREATE TABLE Books (
    BookID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(99) NOT NULL,
    Author VARCHAR(89),
    Genre VARCHAR(89),
    PublishedYear INT
);

-- Create table for borrowers
CREATE TABLE Borrowers (
    BorrowerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(89) NOT NULL,
    Email VARCHAR(89) UNIQUE NOT NULL
);

-- Create table for tracking book loans
CREATE TABLE Loans (
    LoanID INT PRIMARY KEY AUTO_INCREMENT,
    BookID INT,
    BorrowerID INT,
    LoanDate DATE DEFAULT (CURRENT_DATE),
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (BorrowerID) REFERENCES Borrowers(BorrowerID)
);

-- Insert sample data into Books table
INSERT INTO Books (Title, Author, Genre, PublishedYear) VALUES
('1984', 'George Orwell', 'Dystopian', 1949),
('To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960),
('The Great Gatsby', 'F. Scott Fitzgerald', 'Classic', 1925);

-- Insert sample data into Borrowers table
INSERT INTO Borrowers (Name, Email) VALUES
('Alice Johnson', 'alice@example.com'),
('Bob Smith', 'bob@example.com');

-- Borrow a book
INSERT INTO Loans (BookID, BorrowerID) VALUES (1, 1);

-- Return a book
UPDATE Loans SET ReturnDate = CURRENT_DATE WHERE LoanID = 1;

-- List all books borrowed by a borrower
SELECT Books.Title, Borrowers.Name, Loans.LoanDate, Loans.ReturnDate 
FROM Loans
JOIN Books ON Loans.BookID = Books.BookID
JOIN Borrowers ON Loans.BorrowerID = Borrowers.BorrowerID
WHERE Borrowers.Name = 'Alice Johnson';
