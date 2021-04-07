using System;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using _3;
using System.Windows.Forms;

namespace UTests
{
    [TestClass]
    public class UnitTest1
    {
        Form1 _use;


        [TestInitialize]
        public void Init()
        {
            _use = new Form1();
        }
        [TestMethod]
        public void TestMethod1()
        {
            var res = _use.IsTextBoxEmpty("");
            Assert.AreEqual(true, res);
        }
        [TestMethod]
        public void TestMethod2()
        {
            var res = _use.isTriangle(3,3,3);
            Assert.AreEqual(true, res);
        }
        [TestMethod]
        public void TestMethod3()
        {
            var res = _use.isTriangle(1, 1, 1);
            Assert.AreEqual(true, res);
        }
        [TestMethod]
        public void TestMethod4()
        {
            var res = _use.isTriangle(444444, 444445, 444446);
            Assert.AreEqual(true, res);
        }
        [TestMethod]
        public void TestMethod5()
        {
            var res = _use.isTriangle(999999, 999998, 999997);
            Assert.AreEqual(true, res);
        }
        [TestMethod]
        public void TestMethod6()
        {
            var res = _use.TypeTriangle(2, 2, 2);
            Assert.AreEqual(true, res);
        }
        [TestMethod]
        public void TestMethod7()
        {
            var res = _use.TypeTriangle(3, 4, 5);
            Assert.AreEqual(false, res);
        }
        [TestMethod]
        public void TestMethod8()
        {
            var res = _use.TypeTriangle(4, 5, 5);
            Assert.AreEqual(true, res);
        }
        [TestMethod]
        public void TestMethod9()
        {
            var res = _use.TypeTriangle(1, 1, 2);
            Assert.AreEqual(true, res);
        }
        [TestMethod]
        public void TestMethod10()
        {
            var res = _use.TypeTriangle(444444, 444445, 444444);
            Assert.AreEqual(true, res);
        }
        [TestMethod]
        public void TestMethod11()
        {
            var res = _use.TypeTriangle(999998, 999999, 999999);
            Assert.AreEqual(true, res);
        }
        [TestMethod]
        public void TestMethod12()
        {
            var res = _use.isTriangleEquals(4, 4, 5);
            Assert.AreEqual(false, res);
        }
        [TestMethod]
        public void TestMethod13()
        {
            var res = _use.isTriangleEquals(1, 1, 1);
            Assert.AreEqual(true, res);
        }
        [TestMethod]
        public void TestMethod14()
        {
            var res = _use.isTriangleEquals(444444, 444444, 444444);
            Assert.AreEqual(true, res);
        }
        [TestMethod]
        public void TestMethod15()
        {
            var res = _use.isTriangleEquals(999999, 999999, 999999);
            Assert.AreEqual(true, res);
        }
        [TestMethod]
        public void TestMethod16()
        {
            var res = _use.isTriangleEquals(123, 123, 122);
            Assert.AreEqual(false, res);
        }
        [TestMethod]
        public void TestMethod17()
        {
            var res = _use.TypeTriangle(4, 5, 6);
            Assert.AreEqual(false, res);
        }
        [TestMethod]
        public void TestMethod18()
        {
            var res = _use.isTriangle(5, 2, 2);
            Assert.AreEqual(false, res);
        }
        [TestMethod]
        public void TestMethod19()
        {
            var res = _use.isTriangle(1, 2, 2);
            Assert.AreEqual(true, res);
        }
        [TestMethod]
        public void TestMethod20()
        {
            var res = _use.isTriangle(2, 1, 2);
            Assert.AreEqual(true, res);
        }
        [TestMethod]
        public void TestMethod21()
        {
            var res = _use.isTriangle(2, 2, 1);
            Assert.AreEqual(true, res);
        }
    }
}
