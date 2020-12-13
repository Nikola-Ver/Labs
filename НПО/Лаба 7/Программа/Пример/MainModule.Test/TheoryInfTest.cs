using System;
using MainModule;
using NLog;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace MainModule.Test
{
    [TestClass]
    public class TheoryInfTest
    {
        private static Logger _log = LogManager.GetCurrentClassLogger();

        private void ToLog (object expected, object actual, string methodName)
        {
            string result = "";
            try
            {
                Assert.AreEqual(expected, actual);
                result = "test passed successfully.";
            }
            catch
            {
                result = "test passed unsuccessfully.";
            }
            _log.Info("Test of method \"" + methodName + "\". Result: " + result);
        }

        [TestMethod]
        public void ProvNaDigits_12gh45u_1245()
        {
            string str = "12gh45u";
            string expected = "1245";
            string actual = MainModule.TheoryInf.ProvNaDigits(str);
            ToLog(expected, actual, "ProvNaDigits");
        }

        [TestMethod]
        public void ProvNaDigits_u_()
        {
            string str = " u ";
            string expected = "";
            string actual = MainModule.TheoryInf.ProvNaDigits(str);
            ToLog(expected, actual, "ProvNaDigits");
        }

        [TestMethod]
        public void FuncEiler_54328_7499_407343846()
        {
            long a = 54328;
            long b = 7499;
            long expected = 407343846;
            long actual = MainModule.TheoryInf.FuncEiler(a,b);
            ToLog(expected, actual, "FuncEiler");
        }

        [TestMethod]
        public void Ext_GCD_407343846_7499_()
        {
            long eiler = 407343846;
            long d = 7499;
            long expected = 9994835;
            long actual = MainModule.TheoryInf.Ext_GCD(eiler, d);
            ToLog(expected, actual, "Ext_GCD");
        }

        [TestMethod]
        public void InPower_99_9994835_54345000_8948499()
        {
            //M^e mod r
            byte M = 99;
            long e = 9994835;
            long r = 54345000;
            long expected = 8948499;
            long actual = MainModule.TheoryInf.InPower(M, e, r);
            ToLog(expected, actual, "InPower");
        }

        [TestMethod]
        public void NOD_567910_5679100_567910()
        {
            long m = 567910;
            long n = 5679100;
            long expected = 567910;
            long actual = MainModule.TheoryInf.NOD(m, n);
            ToLog(expected, actual, "NOD");
        }

        [TestMethod]
        public void IsSimple_5679100_false()
        {
            long N = 5679100;
            bool expected = false;
            bool actual = MainModule.TheoryInf.isSimple(N);
            ToLog(expected, actual, "IsSimple");
        }

        [TestMethod]
        public void IsSimple_1184993_true()
        {
            long N = 1184993;
            bool expected = true;
            bool actual = MainModule.TheoryInf.isSimple(N);
            ToLog(expected, actual, "IsSimple");
        }

        [TestMethod]
        [ExpectedException(typeof(NullReferenceException))]
        public void ProvNaDigits_null_ExpectedException()
        {
            string str = null;

            try
            {
                MainModule.TheoryInf.ProvNaDigits(str);
                _log.Info("Test of method \"ProvNaDigits\". Result: test passed without exception.");
            }
            catch
            {
                _log.Info("Test of method \"ProvNaDigits\". Result: test passed with exception.");
            }

            string actual = MainModule.TheoryInf.ProvNaDigits(str);
        }

        [TestMethod]
        [ExpectedException(typeof(DivideByZeroException))]
        public void InPower_99_9994835_54345000_0_ExpectedException()
        {
            //M^e mod r
            byte M = 99;
            long e = 9994835;
            long r = 0;

            try
            {
                MainModule.TheoryInf.InPower(M, e, r);
                _log.Info("Test of method \"InPower\". Result: test passed without exception.");
            }
            catch
            {
                _log.Info("Test of method \"InPower\". Result: test passed with exception.");
            }

            long actual = MainModule.TheoryInf.InPower(M, e, r);
        }
    }
}
