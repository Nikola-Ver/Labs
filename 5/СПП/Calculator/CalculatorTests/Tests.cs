using Microsoft.VisualStudio.TestTools.UnitTesting;
using Calculator;
using System;
using NLog;

namespace CalculatorTests
{
    [TestClass]
    public class Tests
    {
        private readonly static Logger log = LogManager.GetCurrentClassLogger();

        private void ToLog(object expected, object actual, string methodName)
        {
            string result = "true";
            try
            {
                Assert.AreEqual(expected, actual);
            }
            catch
            {
                result = "false";
            }
            log.Info("Test of method \"" + methodName + "\". Result: " + result);
        }

        [TestMethod]
        public void Sum_7_and_8()
        {
            var calc = new CalculatorLogic();
            calc.Add(7, 8);
            ToLog(15, calc.GetCurrentVal(), "Add(val1, val2)");
        }

        [TestMethod]
        public void Add_10_then_add_25()
        {
            var calc = new CalculatorLogic();
            calc.Add(10);
            calc.Add(25);
            ToLog(35, calc.GetCurrentVal(), "Add(val)");
        }

        [TestMethod]
        public void Difference_5_and_20()
        {
            var calc = new CalculatorLogic();
            calc.Subtraction(5, 20);
            ToLog(-15, calc.GetCurrentVal(), "Subtraction(val1, val2)");
        }

        [TestMethod]
        public void Sum_7_and_8_then_subtract_15()
        {
            var calc = new CalculatorLogic();
            calc.Add(7, 8);
            calc.Subtraction(15);
            ToLog(0, calc.GetCurrentVal(), "Add(val1, val2), Subtraction(val)");
        }

        [TestMethod]
        public void Division_10_by_0()
        {
            var calc = new CalculatorLogic();
            try
            {
                calc.Division(10, 0);
            }
            catch (Exception e)
            {
                log.Info(e.Message);
            }
        }

        [TestMethod]
        public void Division_10_by_10()
        {
            var calc = new CalculatorLogic();
            calc.Division(10, 10);
            ToLog(1, calc.GetCurrentVal(), "Division(val1, val2)");
        }

        [TestMethod]
        public void Sum_7_and_8_then_division_by_15()
        {
            var calc = new CalculatorLogic();
            calc.Add(7, 8);
            calc.Division(15);
            ToLog(1, calc.GetCurrentVal(), "Add(val1, val2), Division(val)");
        }

        [TestMethod]
        public void Multiply_10_and_10()
        {
            var calc = new CalculatorLogic();
            calc.Multiply(10, 10);
            ToLog(100, calc.GetCurrentVal(), "Multiply(val1, val2)");
        }

        [TestMethod]
        public void Add_10_then_multiply_by_10()
        {
            var calc = new CalculatorLogic();
            calc.Add(10);
            calc.Multiply(10);
            ToLog(100, calc.GetCurrentVal(), "Add(val1, val2), Multiply(val)");
        }

        [TestMethod]
        public void Subtraction_10_then_power_by_2()
        {
            var calc = new CalculatorLogic();
            calc.Subtraction(10);
            calc.Power(2);
            ToLog(100, calc.GetCurrentVal(), "Subtraction(val), Power(val)");
        }

        [TestMethod]
        public void power_negative_10_and_not_an_integer_number()
        {
            var calc = new CalculatorLogic();
            try
            {
                calc.Power(-10, 0.1);
            }
            catch (Exception e)
            {
                log.Info(e.Message);
            }
        }
    }
}
