namespace _3
{
    partial class Form1
    {
        /// <summary>
        /// Требуется переменная конструктора.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Освободить все используемые ресурсы.
        /// </summary>
        /// <param name="disposing">истинно, если управляемый ресурс должен быть удален; иначе ложно.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Код, автоматически созданный конструктором форм Windows

        /// <summary>
        /// Обязательный метод для поддержки конструктора - не изменяйте
        /// содержимое данного метода при помощи редактора кода.
        /// </summary>
        private void InitializeComponent()
        {
            this.checkbutton = new System.Windows.Forms.Button();
            this.first = new System.Windows.Forms.TextBox();
            this.second = new System.Windows.Forms.TextBox();
            this.third = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // checkbutton
            // 
            this.checkbutton.DialogResult = System.Windows.Forms.DialogResult.OK;
            this.checkbutton.Enabled = false;
            this.checkbutton.Font = new System.Drawing.Font("Times New Roman", 18F);
            this.checkbutton.Location = new System.Drawing.Point(12, 381);
            this.checkbutton.Name = "checkbutton";
            this.checkbutton.Size = new System.Drawing.Size(558, 45);
            this.checkbutton.TabIndex = 0;
            this.checkbutton.Text = "Определить";
            this.checkbutton.UseVisualStyleBackColor = true;
            this.checkbutton.Click += new System.EventHandler(this.checkbutton_Click);
            // 
            // first
            // 
            this.first.AccessibleDescription = "";
            this.first.Font = new System.Drawing.Font("Times New Roman", 18F);
            this.first.Location = new System.Drawing.Point(283, 228);
            this.first.MaxLength = 6;
            this.first.Name = "first";
            this.first.ShortcutsEnabled = false;
            this.first.Size = new System.Drawing.Size(287, 42);
            this.first.TabIndex = 1;
            this.first.TextChanged += new System.EventHandler(this.textBox_TextChanged);
            this.first.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.first_KeyPress);
            // 
            // second
            // 
            this.second.Font = new System.Drawing.Font("Times New Roman", 18F);
            this.second.Location = new System.Drawing.Point(283, 276);
            this.second.MaxLength = 6;
            this.second.Name = "second";
            this.second.ShortcutsEnabled = false;
            this.second.Size = new System.Drawing.Size(287, 42);
            this.second.TabIndex = 2;
            this.second.TextChanged += new System.EventHandler(this.textBox_TextChanged);
            this.second.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.second_KeyPress);
            // 
            // third
            // 
            this.third.Font = new System.Drawing.Font("Times New Roman", 18F);
            this.third.Location = new System.Drawing.Point(282, 324);
            this.third.MaxLength = 6;
            this.third.Name = "third";
            this.third.ShortcutsEnabled = false;
            this.third.Size = new System.Drawing.Size(288, 42);
            this.third.TabIndex = 3;
            this.third.TextChanged += new System.EventHandler(this.textBox_TextChanged);
            this.third.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.third_KeyPress);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Times New Roman", 18F);
            this.label1.Location = new System.Drawing.Point(12, 231);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(265, 34);
            this.label1.TabIndex = 4;
            this.label1.Text = "Введите сторону А:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Times New Roman", 18F);
            this.label2.Location = new System.Drawing.Point(12, 279);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(264, 34);
            this.label2.TabIndex = 5;
            this.label2.Text = "Введите сторону В:";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Times New Roman", 18F);
            this.label3.Location = new System.Drawing.Point(12, 327);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(264, 34);
            this.label3.TabIndex = 6;
            this.label3.Text = "Введите сторону C:";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Times New Roman", 18F);
            this.label4.Location = new System.Drawing.Point(16, 68);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(468, 136);
            this.label4.TabIndex = 7;
            this.label4.Text = "Введите числа от 1 до 999999 в три\r\nполя для ввода, затем нажмите\r\nкнопку «Опреде" +
    "лить» для\r\nполучения результата";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Times New Roman", 18F);
            this.label6.Location = new System.Drawing.Point(16, 9);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(425, 34);
            this.label6.TabIndex = 9;
            this.label6.Text = "Определение типа треугольника";
            // 
            // Form1
            // 
            this.AcceptButton = this.checkbutton;
            this.AutoScaleDimensions = new System.Drawing.SizeF(11F, 23F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(582, 453);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.third);
            this.Controls.Add(this.second);
            this.Controls.Add(this.first);
            this.Controls.Add(this.checkbutton);
            this.Cursor = System.Windows.Forms.Cursors.Arrow;
            this.DoubleBuffered = true;
            this.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(204)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.Margin = new System.Windows.Forms.Padding(4, 5, 4, 5);
            this.MaximizeBox = false;
            this.MaximumSize = new System.Drawing.Size(800, 500);
            this.MinimumSize = new System.Drawing.Size(100, 200);
            this.Name = "Form1";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Определение типа треугольника";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.enter_Press);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button checkbutton;
        private System.Windows.Forms.TextBox first;
        private System.Windows.Forms.TextBox second;
        private System.Windows.Forms.TextBox third;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label6;
    }
}

