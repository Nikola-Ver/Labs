using NUnit.Framework;
using TWOP_1;
using System;

namespace NUnitTest
{
    public class Tests
    {
        private const string MSG_OUT_OF_RANGE = "Введены неверные значения (значения должны\n быть целыми числами в диапазоне от 1 до 1 000 000 000)";
        private const string MSG_TRIANGLE_IS_NOT_EXIST = "Введенный треугольник не существует";
        [SetUp]
        public void Setup()
        {
        }

        [Test]
        public void isCorrectTest1()
        {
            Triangle triangle;

            Exception exception = Assert.Throws<Exception>(delegate { triangle = new Triangle("h", "4", "5"); });

            Assert.That(exception.Message, Is.EqualTo(MSG_OUT_OF_RANGE));
        }

        [Test]
        public void isCorrectTest2()
        {
            Triangle triangle;

            Exception exception = Assert.Throws<Exception>(delegate { triangle = new Triangle(null, "4", "5"); });

            Assert.That(exception.Message, Is.EqualTo(MSG_OUT_OF_RANGE));
        }

        [Test]
        public void isCorrectTest3()
        {
            Triangle triangle;

            Exception exception = Assert.Throws<Exception>(delegate { triangle = new Triangle("3", null, "5"); });

            Assert.That(exception.Message, Is.EqualTo(MSG_OUT_OF_RANGE));
        }

        [Test]
        public void isCorrectTest4()
        {
            Triangle triangle;

            Exception exception = Assert.Throws<Exception>(delegate { triangle = new Triangle("3", "4", null); });

            Assert.That(exception.Message, Is.EqualTo(MSG_OUT_OF_RANGE));
        }

        [Test]
        public void isCorrectTest5()
        {
            Triangle triangle;

            Exception exception = Assert.Throws<Exception>(delegate { triangle = new Triangle("0", "4", "5"); });

            Assert.That(exception.Message, Is.EqualTo(MSG_TRIANGLE_IS_NOT_EXIST));
        }

        [Test]
        public void isExistsTest1()
        {
            Triangle triangle;

            Exception exception = Assert.Throws<Exception>(delegate { triangle = new Triangle("3", "4", "100"); });

            Assert.That(exception.Message, Is.EqualTo("Введенный треугольник не существует"));
        }

        [Test]
        public void isExistsTest2()
        {
            Triangle triangle;

            Exception exception = Assert.Throws<Exception>(delegate { triangle = new Triangle("1000", "4", "100"); });

            Assert.That(exception.Message, Is.EqualTo("Введенный треугольник не существует"));
        }

        [Test]
        public void isExistsTest3()
        {
            Triangle triangle;

            Exception exception = Assert.Throws<Exception>(delegate { triangle = new Triangle("1000", "10000", "100"); });

            Assert.That(exception.Message, Is.EqualTo("Введенный треугольник не существует"));
        }

        [Test]
        public void isEquilateralTest1()
        {
            Triangle triangle = new Triangle("3", "3", "3");

            Assert.AreEqual(true, triangle.isEquilateral());
        }

        [Test]
        public void isEquilateralTest2()
        {
            Triangle triangle = new Triangle("32767", "32767", "32767");

            Assert.AreEqual(true, triangle.isEquilateral());
        }

        [Test]
        public void isEquilateralTest3()
        {
            Triangle triangle = new Triangle("1", "3", "3");

            Assert.AreEqual(false, triangle.isEquilateral());
        }

        [Test]
        public void isIsoscelesTest1()
        {
            Triangle triangle = new Triangle("3", "4", "5");

            bool flag = false;

            if ((triangle.isEquilateral() == false) && (triangle.isIsosceles() == true))
            {
                flag = true;
            }

            Assert.AreEqual(false, flag);
        }

        [Test]
        public void isIsoscelesTest2()
        {
            Triangle triangle = new Triangle("32767", "32767", "3");

            bool flag = false;

            if ((triangle.isEquilateral() == false) && (triangle.isIsosceles() == true))
            {
                flag = true;
            }

            Assert.AreEqual(true, flag);
        }

        [Test]
        public void isIsoscelesTest3()
        {
            Triangle triangle = new Triangle("32767", "32767", "32767");

            bool flag = false;

            if ((triangle.isEquilateral() == false) && (triangle.isIsosceles() == true))
            {
                flag = true;
            }

            Assert.AreEqual(false, flag);
        }

        [Test]
        public void isScaleneTest1()
        {
            Triangle triangle = new Triangle("32767", "32767", "32767");

            bool flag = false;

            if ((triangle.isEquilateral() == false) && (triangle.isIsosceles() == false))
            {
                flag = true;
            }

            Assert.AreEqual(false, flag);
        }

        [Test]
        public void isScaleneTest2()
        {
            Triangle triangle = new Triangle("32767", "32767", "3");

            bool flag = false;

            if ((triangle.isEquilateral() == false) && (triangle.isIsosceles() == false))
            {
                flag = true;
            }

            Assert.AreEqual(false, flag);
        }

        [Test]
        public void isScaleneTest3()
        {
            Triangle triangle = new Triangle("32764", "32765", "32766");

            bool flag = false;

            if ((triangle.isEquilateral() == false) && (triangle.isIsosceles() == false))
            {
                flag = true;
            }

            Assert.AreEqual(true, flag);
        }

        [Test]
        public void isVersatileTest1()
        {
            Triangle triangle = new Triangle("4", "2", "3");
            Assert.AreEqual(true, triangle.isVersatile());
        }
        [Test]
        public void isVersatileTest2()
        {
            Triangle triangle = new Triangle("3", "2", "4");
            Assert.AreEqual(true, triangle.isVersatile());
        }
        [Test]
        public void isVersatileTest3()
        {
            Triangle triangle = new Triangle("5", "7", "6");
            Assert.AreEqual(true, triangle.isVersatile());
        }
    }
}