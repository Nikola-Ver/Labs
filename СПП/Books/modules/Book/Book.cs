using System;
using System.ComponentModel;

namespace Book
{
    public class Book
    {
        public string Isbn { get; set; }
        public string Author { get; set; }
        public string Name { get; set; }
        public int Year { get; set; }
        public int Pages { get; set; }
        public int Price 
        { 
            get;
            set { return value > 0 ? value : 0; }
        } // in $

        public Book() 
        {
            this.Isbn = "";
            this.Author = "";
            this.Name = "";
            this.Year = 0;
            this.Pages = 0;
            this.Price = 0; 
        }

        public Book(string isbn, string author, string name, int year, int pages, int price)
        {
            this.Isbn = isbn;
            this.Author = author;
            this.Name = name;
            this.Year = year;
            this.Pages = pages;
            this.Price = price; 
        }

        public virtual bool CompareBooks(string isbn)
        {
            return this.Isbn == isbn;
        }

        public override bool CompareBooks(Book book)
        {
            if (!book) return false;
            return this.Isbn == book.Isbn && this.Author == book.Author && this.Name == book.Name
                   && this.Year == book.Year && this.Pages == book.Pages && this.Price == book.Price;
        }
    }
}