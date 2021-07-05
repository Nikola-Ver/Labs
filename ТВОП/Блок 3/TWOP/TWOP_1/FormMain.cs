using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace TWOP_1
{
    public partial class FormMain : Form
    {
        private const string MSG_EQUILATERAL_TRIANGLE = "Введенный треугольник равносторонний.";
        private const string MSG_ISOSCELES_TRIANGLE = "Введенный треугольник равнобедренный.";
        private const string MSG_SCALENE_TRIANGLE = "Введенный треугольник неравносторонний.";

        private const string HELP_CONTENT = "Программа принимает на вход 3 целых числа в диапазоне от 1 до \n1 000 000 000, интерпретируемых как длины сторон треугольника, печатает сообщение о том, является ли треугольник неравносторонним, равнобедренным или равносторонним.";
        private const string HELP_TITLE = "Помощь";

        private const int MIN_CHAR_VALUE = '0';
        private const int MAX_CHAR_VALUE = '9';
        private const int BACKSPACE_CHAR_VALUE = '\b';

        public FormMain()
        {
            InitializeComponent();
        }

        private void ButtonCalculate_Click(object sender, EventArgs e)
        {
            Triangle triangle = null;

            try
            {
                triangle = new Triangle(TextBoxAB.Text, TextBoxBC.Text, TextBoxAC.Text);
            }
            catch (Exception exception)
            {
                LabelResault.Text = exception.Message;
            }

            if (triangle != null)
            {
                if (triangle.isEquilateral())
                {
                    LabelResault.Text = MSG_EQUILATERAL_TRIANGLE;
                }
                else
                {
                    if (triangle.isIsosceles())
                    {
                        LabelResault.Text = MSG_ISOSCELES_TRIANGLE;
                    }
                    else
                    {
                        LabelResault.Text = MSG_SCALENE_TRIANGLE;
                    }
                }
            }

        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {
            MessageBox.Show(HELP_CONTENT, HELP_TITLE);
        }

        private void TextBoxKeyPress(object sender, KeyPressEventArgs e)
        {
            LabelResault.Text = "";
            if (!(MIN_CHAR_VALUE <= e.KeyChar && MAX_CHAR_VALUE >= e.KeyChar || e.KeyChar == BACKSPACE_CHAR_VALUE))
            { 
                e.Handled = true;
            }
        }
    }
}
