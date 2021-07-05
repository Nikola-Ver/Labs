
namespace TWOP_1
{
    partial class FormMain
    {
        /// <summary>
        /// Обязательная переменная конструктора.
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
        /// Требуемый метод для поддержки конструктора — не изменяйте 
        /// содержимое этого метода с помощью редактора кода.
        /// </summary>
        private void InitializeComponent()
        {
            this.LabelAB = new System.Windows.Forms.Label();
            this.LabelAC = new System.Windows.Forms.Label();
            this.LabelBC = new System.Windows.Forms.Label();
            this.TextBoxAB = new System.Windows.Forms.TextBox();
            this.TextBoxBC = new System.Windows.Forms.TextBox();
            this.TextBoxAC = new System.Windows.Forms.TextBox();
            this.LabelResault = new System.Windows.Forms.Label();
            this.ButtonCalculate = new System.Windows.Forms.Button();
            this.PictureBoxInfo = new System.Windows.Forms.PictureBox();
            ((System.ComponentModel.ISupportInitialize)(this.PictureBoxInfo)).BeginInit();
            this.SuspendLayout();
            // 
            // LabelAB
            // 
            this.LabelAB.AutoSize = true;
            this.LabelAB.Location = new System.Drawing.Point(69, 69);
            this.LabelAB.Name = "LabelAB";
            this.LabelAB.Size = new System.Drawing.Size(69, 13);
            this.LabelAB.TabIndex = 0;
            this.LabelAB.Text = "Введите AB:";
            // 
            // LabelAC
            // 
            this.LabelAC.AutoSize = true;
            this.LabelAC.Location = new System.Drawing.Point(69, 98);
            this.LabelAC.Name = "LabelAC";
            this.LabelAC.Size = new System.Drawing.Size(69, 13);
            this.LabelAC.TabIndex = 1;
            this.LabelAC.Text = "Введите BC:";
            // 
            // LabelBC
            // 
            this.LabelBC.AutoSize = true;
            this.LabelBC.Location = new System.Drawing.Point(69, 128);
            this.LabelBC.Name = "LabelBC";
            this.LabelBC.Size = new System.Drawing.Size(69, 13);
            this.LabelBC.TabIndex = 2;
            this.LabelBC.Text = "Введите AC:";
            // 
            // TextBoxAB
            // 
            this.TextBoxAB.Location = new System.Drawing.Point(144, 66);
            this.TextBoxAB.MaxLength = 10;
            this.TextBoxAB.Name = "TextBoxAB";
            this.TextBoxAB.Size = new System.Drawing.Size(100, 20);
            this.TextBoxAB.TabIndex = 3;
            this.TextBoxAB.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.TextBoxKeyPress);
            // 
            // TextBoxBC
            // 
            this.TextBoxBC.Location = new System.Drawing.Point(144, 95);
            this.TextBoxBC.MaxLength = 10;
            this.TextBoxBC.Name = "TextBoxBC";
            this.TextBoxBC.Size = new System.Drawing.Size(100, 20);
            this.TextBoxBC.TabIndex = 4;
            this.TextBoxBC.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.TextBoxKeyPress);
            // 
            // TextBoxAC
            // 
            this.TextBoxAC.Location = new System.Drawing.Point(144, 125);
            this.TextBoxAC.MaxLength = 10;
            this.TextBoxAC.Name = "TextBoxAC";
            this.TextBoxAC.Size = new System.Drawing.Size(100, 20);
            this.TextBoxAC.TabIndex = 5;
            this.TextBoxAC.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.TextBoxKeyPress);
            // 
            // LabelResault
            // 
            this.LabelResault.AutoSize = true;
            this.LabelResault.BackColor = System.Drawing.SystemColors.HighlightText;
            this.LabelResault.ForeColor = System.Drawing.Color.Black;
            this.LabelResault.Location = new System.Drawing.Point(12, 194);
            this.LabelResault.Name = "LabelResault";
            this.LabelResault.Size = new System.Drawing.Size(65, 13);
            this.LabelResault.TabIndex = 6;
            this.LabelResault.Text = "-Результат-";
            // 
            // ButtonCalculate
            // 
            this.ButtonCalculate.Location = new System.Drawing.Point(144, 164);
            this.ButtonCalculate.Name = "ButtonCalculate";
            this.ButtonCalculate.Size = new System.Drawing.Size(100, 23);
            this.ButtonCalculate.TabIndex = 7;
            this.ButtonCalculate.Text = "Определить";
            this.ButtonCalculate.UseVisualStyleBackColor = true;
            this.ButtonCalculate.Click += new System.EventHandler(this.ButtonCalculate_Click);
            // 
            // PictureBoxInfo
            // 
            this.PictureBoxInfo.BackColor = System.Drawing.SystemColors.HighlightText;
            this.PictureBoxInfo.BackgroundImage = global::TWOP_1.Properties.Resources.Help;
            this.PictureBoxInfo.InitialImage = null;
            this.PictureBoxInfo.Location = new System.Drawing.Point(307, 1);
            this.PictureBoxInfo.Name = "PictureBoxInfo";
            this.PictureBoxInfo.Size = new System.Drawing.Size(32, 32);
            this.PictureBoxInfo.TabIndex = 8;
            this.PictureBoxInfo.TabStop = false;
            this.PictureBoxInfo.Click += new System.EventHandler(this.pictureBox1_Click);
            // 
            // FormMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.HighlightText;
            this.ClientSize = new System.Drawing.Size(340, 278);
            this.Controls.Add(this.PictureBoxInfo);
            this.Controls.Add(this.ButtonCalculate);
            this.Controls.Add(this.LabelResault);
            this.Controls.Add(this.TextBoxAC);
            this.Controls.Add(this.TextBoxBC);
            this.Controls.Add(this.TextBoxAB);
            this.Controls.Add(this.LabelBC);
            this.Controls.Add(this.LabelAC);
            this.Controls.Add(this.LabelAB);
            this.ForeColor = System.Drawing.SystemColors.ControlText;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "FormMain";
            this.Text = "Triangles";
            ((System.ComponentModel.ISupportInitialize)(this.PictureBoxInfo)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label LabelAB;
        private System.Windows.Forms.Label LabelAC;
        private System.Windows.Forms.Label LabelBC;
        private System.Windows.Forms.TextBox TextBoxAB;
        private System.Windows.Forms.TextBox TextBoxBC;
        private System.Windows.Forms.TextBox TextBoxAC;
        private System.Windows.Forms.Label LabelResault;
        private System.Windows.Forms.Button ButtonCalculate;
        private System.Windows.Forms.PictureBox PictureBoxInfo;
    }
}

