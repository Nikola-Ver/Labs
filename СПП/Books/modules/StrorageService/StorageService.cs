using System;
using System.Collections.Generic;

namespace StorageService
{
    public class StorageService : Storage
    {

        public StorageService() { }

        public void AddBook(Book book)
        {
            books.Add(book);
        }

        public void FindBooks(int variant, string value)
        {
            List<Book> tempBooks = new List<Book>();

            switch (variant)
            {
                case 0: 
                    books.ForEach(e => {
                        if (e.Isbn == value) tempBooks.Add(e); 
                    });
                    break;
                case 1: 
                    books.ForEach(e => {
                        if (e.Author == value) tempBooks.Add(e);
                    });
                    break;
                case 2: 
                    books.ForEach(e => { 
                        if (e.Name == value) tempBooks.Add(e);
                    });
                    break;
                case 3: 
                    books.ForEach(e => {
                        if (e.Year == ((int)value)) tempBooks.Add(e);
                    });
                    break;
                case 4:
                    books.ForEach(e => {
                        if (e.Pages == ((int)value)) tempBooks.Add(e);
                    });
                    break;
                case 5:
                    books.ForEach(e => {
                        if (e.Price == ((int)value)) tempBooks.Add(e);
                    });
                    break;
            }

            return tempBooks;
        }

        public void RenoveBook(Book book)
        {

        }

        public void SortBook() 
        {
        
        }
    }
}