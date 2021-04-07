using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace _3
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        public void first_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (Char.IsDigit(e.KeyChar) || e.KeyChar == (char)Keys.Back) 
                return;
            else
                e.Handled = true;

        }

        public void second_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (Char.IsDigit(e.KeyChar) || e.KeyChar == (char)Keys.Back)
                return;
            else
                e.Handled = true;
        }

        public void third_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (Char.IsDigit(e.KeyChar) || e.KeyChar == (char)Keys.Back)
                return;
            else
                e.Handled = true;
        }

        public void textBox_TextChanged(object sender, EventArgs e)
        {
            bool isCorrect = true;
            CheckValue((TextBox)sender);
            if (IsTextBoxEmpty(first.Text))
            {
                isCorrect = false;
            }
            if (IsTextBoxEmpty(second.Text))
            {
                isCorrect = false;
            }
            if (IsTextBoxEmpty(third.Text))
            {
                isCorrect = false;
            }

            checkbutton.Enabled = isCorrect;
        }

        public bool IsTextBoxEmpty(string textBox)
        {
            return textBox.Length == 0;
        }

        public void CheckValue(TextBox textBox)
        {
            if (textBox.Text.Length > 0)
            {
                if (textBox.Text[0] == '0')
                {
                    textBox.Text = textBox.Text.Substring(1, textBox.Text.Length - 1);
                }
            }
        }

        public void checkbutton_Click(object sender, EventArgs e)
        {
            int A = Convert.ToInt32(first.Text);
            int B = Convert.ToInt32(second.Text);
            int C = Convert.ToInt32(third.Text);
            if (!isTriangle(A, B, C))
            {
                MessageBox.Show("Треугольник с данными длинами сторон не существует. Сумма двух сторон должна быть всегда больше третьей. Повторите ввод.", "Неккоректный ввод", MessageBoxButtons.OK);
            }
            else
            {
                if (TypeTriangle(A, B, C))
                {
                    if (isTriangleEquals(A,B, C))
                    {
                        MessageBox.Show("Треугольник равносторонний", "Тип треугольника", MessageBoxButtons.OK);
                    }
                    else
                    {
                        MessageBox.Show("Треугольник равнобедренный", "Тип треугольника", MessageBoxButtons.OK);
                    }
                }
                else
                {
                    MessageBox.Show("Треугольник неравносторонний", "Тип треугольника", MessageBoxButtons.OK);
                }
            }
        }
        public bool isTriangle(int A, int B, int C)
        {
            return ((A + B > C) && (A + C > B) && (C + B > A));
        }
        public bool TypeTriangle(int A, int B, int C)
        {
            return ((A == B) || (A == C) || (B == C));
        }
        public bool isTriangleEquals(int A, int B, int C)
        {
            return (A == C && A == B && C == B);
        }

        private void enter_Press(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)Keys.Enter)
            {
                if (checkbutton.Enabled == true)
                {
                    checkbutton_Click(sender, e);
                }
            }
        }
    }
}
