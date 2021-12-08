
namespace DSP_LW3
{
    partial class MainForm
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.btnLoad = new System.Windows.Forms.Button();
            this.btnPerform = new System.Windows.Forms.Button();
            this.cmbFilter = new System.Windows.Forms.ComboBox();
            this.pbOriginalImage = new System.Windows.Forms.PictureBox();
            this.tbSize = new System.Windows.Forms.TextBox();
            this.tbSigma = new System.Windows.Forms.TextBox();
            this.pbPreview = new System.Windows.Forms.PictureBox();
            this.btnSave = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.pbOriginalImage)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pbPreview)).BeginInit();
            this.SuspendLayout();
            // 
            // btnLoad
            // 
            this.btnLoad.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnLoad.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
            this.btnLoad.Location = new System.Drawing.Point(574, 12);
            this.btnLoad.Name = "btnLoad";
            this.btnLoad.Size = new System.Drawing.Size(128, 32);
            this.btnLoad.TabIndex = 0;
            this.btnLoad.Text = "Загрузить";
            this.btnLoad.UseVisualStyleBackColor = true;
            this.btnLoad.Click += new System.EventHandler(this.LoadClick);
            // 
            // btnPerform
            // 
            this.btnPerform.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnPerform.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
            this.btnPerform.Location = new System.Drawing.Point(842, 12);
            this.btnPerform.Name = "btnPerform";
            this.btnPerform.Size = new System.Drawing.Size(128, 32);
            this.btnPerform.TabIndex = 1;
            this.btnPerform.Text = "Выполнить";
            this.btnPerform.UseVisualStyleBackColor = true;
            this.btnPerform.Click += new System.EventHandler(this.PerformClick);
            // 
            // cmbFilter
            // 
            this.cmbFilter.FormattingEnabled = true;
            this.cmbFilter.Items.AddRange(new object[] {
            "Без фильтра",
            "Box Blur",
            "Gaussian Blur",
            "Gaussian Fast Blur",
            "Gaussian Super Fast Blur",
            "Motion Blur",
            "Median Filter",
            "Sobel Operator",
            "Sharpen"});
            this.cmbFilter.Location = new System.Drawing.Point(12, 12);
            this.cmbFilter.Name = "cmbFilter";
            this.cmbFilter.Size = new System.Drawing.Size(218, 25);
            this.cmbFilter.TabIndex = 2;
            this.cmbFilter.SelectedIndexChanged += new System.EventHandler(this.FilterSelectedIndexChanged);
            // 
            // pbOriginalImage
            // 
            this.pbOriginalImage.Location = new System.Drawing.Point(12, 50);
            this.pbOriginalImage.Name = "pbOriginalImage";
            this.pbOriginalImage.Size = new System.Drawing.Size(480, 691);
            this.pbOriginalImage.TabIndex = 3;
            this.pbOriginalImage.TabStop = false;
            // 
            // tbSize
            // 
            this.tbSize.Location = new System.Drawing.Point(236, 12);
            this.tbSize.Name = "tbSize";
            this.tbSize.Size = new System.Drawing.Size(125, 25);
            this.tbSize.TabIndex = 4;
            this.tbSize.Text = "3";
            // 
            // tbSigma
            // 
            this.tbSigma.Location = new System.Drawing.Point(367, 12);
            this.tbSigma.Name = "tbSigma";
            this.tbSigma.Size = new System.Drawing.Size(125, 25);
            this.tbSigma.TabIndex = 4;
            this.tbSigma.Text = "3";
            // 
            // pbPreview
            // 
            this.pbPreview.Location = new System.Drawing.Point(498, 50);
            this.pbPreview.Name = "pbPreview";
            this.pbPreview.Size = new System.Drawing.Size(472, 691);
            this.pbPreview.TabIndex = 3;
            this.pbPreview.TabStop = false;
            // 
            // btnSave
            // 
            this.btnSave.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnSave.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
            this.btnSave.Location = new System.Drawing.Point(708, 12);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(128, 32);
            this.btnSave.TabIndex = 1;
            this.btnSave.Text = "Сохранить";
            this.btnSave.UseVisualStyleBackColor = true;
            this.btnSave.Click += new System.EventHandler(this.SaveClick);
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 17F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSize = true;
            this.BackColor = System.Drawing.SystemColors.ActiveCaptionText;
            this.ClientSize = new System.Drawing.Size(982, 753);
            this.Controls.Add(this.pbPreview);
            this.Controls.Add(this.tbSigma);
            this.Controls.Add(this.tbSize);
            this.Controls.Add(this.pbOriginalImage);
            this.Controls.Add(this.cmbFilter);
            this.Controls.Add(this.btnSave);
            this.Controls.Add(this.btnPerform);
            this.Controls.Add(this.btnLoad);
            this.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.Margin = new System.Windows.Forms.Padding(3, 5, 3, 5);
            this.Name = "MainForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "ЦОС";
            ((System.ComponentModel.ISupportInitialize)(this.pbOriginalImage)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pbPreview)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btnLoad;
        private System.Windows.Forms.Button btnPerform;
        private System.Windows.Forms.ComboBox cmbFilter;
        private System.Windows.Forms.PictureBox pbOriginalImage;
        private System.Windows.Forms.TextBox tbSize;
        private System.Windows.Forms.TextBox tbSigma;
        private System.Windows.Forms.PictureBox pbPreview;
        private System.Windows.Forms.Button btnSave;
    }
}

