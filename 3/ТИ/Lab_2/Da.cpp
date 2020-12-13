//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Da.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
#include <iostream>
#include <cstdio>
#include <fstream>
#include <cstdlib>
#include <time.h>
#include <string>
#include <vector>
#include <string.h>
#include <iomanip>
TForm1 *Form1;
TSymMas *SymMas;
const int lenLink = 256;
long long FileLen = 0;
std::vector <unsigned char> SymVector;
char Buff[1000000];
char Sym;
int iPos;
int iVec = 0;
wchar_t Link[lenLink];
//---------------------------------------------------------------------------
void CreateKey(std::vector <unsigned char> *KeyArr, std::vector <bool> *BitArr, char Vorious, int len, bool *pKey)
{
        long long Pos = 0;
        do
        {
            if (Pos >= len) {
                (*BitArr)[Pos] = pKey[len - 1];
            }
            else
            	(*BitArr)[Pos] = pKey[Pos];
            Pos++;
            if (Pos >= len)
            {
                bool Shift;
                switch (Vorious)
                {
                        case 1:
                        {
                            Shift = pKey[0] ^ pKey[25] ^ pKey[19] ^ pKey[18];
                            break;
                        };

                        case 2:
                        {
                            Shift = pKey[0] ^ pKey[33] ^ pKey[20] ^ pKey[19];
                            break;
                        };

                        case 3:
                        {
                            Shift = pKey[0] ^ pKey[23] ^ pKey[21] ^ pKey[20];
                            break;
                        };
                };

                for (int i = 0; i < len - 1; i++) pKey[i] = pKey[i + 1];
                pKey[len - 1] = Shift;
            }
        }
        while (Pos != FileLen * 8);

        for (Pos = 0; Pos < FileLen; Pos++)
        {
            (*KeyArr)[Pos] = 128 * (*BitArr)[Pos * 8] + 64 * (*BitArr)[Pos * 8 + 1] + 32
                   * (*BitArr)[Pos * 8 + 2] + 16 * (*BitArr)[Pos * 8 + 3] + 8
                   * (*BitArr)[Pos * 8 + 4] + 4 * (*BitArr)[Pos * 8 + 5] + 2
                   * (*BitArr)[Pos * 8 + 6] + (*BitArr)[Pos * 8 + 7];
        };
}
//---------------------------------------------------------------------------

void TextByteToBit(std::vector <bool> *BitArr)
{
        for (long long Pos = 0; Pos < FileLen; Pos++)
                for (int Pow = 0; Pow < 8; Pow++)
                {
                        int Shift = 1;
                        for (int i = Pow + 1; i < 8; i++) Shift *= 2;
                	(*BitArr)[Pos * 8 + Pow] = SymVector[Pos] & Shift;
                }
}
//---------------------------------------------------------------------------
__fastcall TSymMas::TSymMas(int Thread)
        : TThread(false)
{
	State = Thread;
	FreeOnTerminate = true;
        Priority = tpHigher;
}
//---------------------------------------------------------------------------
void __fastcall TSymMas::Execute()
{
        iPos = 0;
        std::ifstream f(&Link[0], std::ios_base::binary);
        f.seekg(0, std::ios_base::end);
        FileLen = f.tellg();
        if (FileLen <= 0)
        {
                Form1->StatusText->Caption = "���� ����";
                Sleep(500);
		Form1->ProgBar->Visible = false;
                Form1->StatusText->Visible = false;
        	return;
        }
        SymVector.assign(FileLen, 0);
        f.seekg(0, std::ios_base::beg);
        int BufLen = 1000000;
        if (FileLen < 1000000) BufLen = FileLen;
        while (f.read(Buff, BufLen))
        {
            for (iVec = iPos; iVec < iPos + BufLen; iVec++)
            	SymVector[iVec] = Buff[iVec - iPos];
            iPos += BufLen;
            Synchronize(Progress);
            if ((FileLen - iPos < 1000000) && (FileLen - iPos > 0)) BufLen = FileLen - iPos;
        };
        Form1->ProgBar->Position = 100;
        f.close();
        Sleep(250);
	Form1->ProgBar->Visible = false;
        Form1->StatusText->Visible = false;
        int d = 0;
        for (; (d < lenLink) && (Link[d] != '\0'); d++) {};
        for (; (d > 0) && (Link[d] != '\\'); d--) {};
        d++;
        Form1->FileStatus->Caption = &Link[d];
        Form1->Output->Text = "";
        Form1->Input->Text = "";
        std::vector <bool> BitMas;
        BitMas.assign(FileLen * 8, 0);
        TextByteToBit(&BitMas);
        int SizeRead = StrToInt(Form1->SizeRead->Text);
        if (SizeRead > FileLen) SizeRead = FileLen;
        //������� ������� �����
        for (int i = 0; i < SizeRead * 8; i++)
        {
                if (BitMas[i] == 0) Sym = '0';
                else Sym = '1';
                Synchronize(EnterText);
        };
}
//---------------------------------------------------------------------------
void __fastcall TSymMas::EnterText()
{
	Form1->Input->Text += Sym;
}
//---------------------------------------------------------------------------
void __fastcall TSymMas::Progress()
{
	Form1->ProgBar->Position = int(double(iPos) / double(FileLen) * 100);
}
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
	: TForm(Owner)
{
        Form1->EnterKey1->Visible = false;
        Form1->EnterKey2->Visible = false;
        Form1->KeySplitterLeft->Visible = false;
        Form1->KeySplitterRight->Visible = false;
        Form1->EnterKey->Left = 17;
        Form1->EnterKey->Width = Form1->Width - 17;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::LoadFileClick(TObject *Sender)
{
	OpenDialog->Filter = "��� ����� (*.*)|*.*";
        OpenDialog->DefaultExt = "*.*";
        if (OpenDialog->Execute())
        {
        	int i = 0;
                for (; i < lenLink; i++) Link[i] = '\0';
                i = 0;
		for (; i < OpenDialog->FileName.Length(); i++)
                {
        		Link[i] = OpenDialog->FileName[i + 1];
                };

                if (FileLen != 0) {
                    SymVector.resize(0);
                    SymVector.shrink_to_fit();
                }
		Form1->ProgBar->Visible = true;
                Form1->StatusText->Visible = true;
                Form1->StatusText->Caption = "�������� �����";
                SymMas = new TSymMas(1);
        };
}
//---------------------------------------------------------------------------
void __fastcall TForm1::FormResize(TObject *Sender)
{
        StatusText->Left = Form1->Width - 186;
        ProgBar->Left = Form1->Width - 186;
        FileStatus->Left = 0;
        Input->Width = Form1->Width / 2;
        if (Form1->LFSR->ImageIndex == 0)
        {
            Form1->EnterKey->Left = 17;
            Form1->EnterKey->Width = Form1->Width - 17;
        }
        else
        {
            Form1->EnterKey->Left = Form1->Width * 2 / 3;
            Form1->EnterKey->Width = Form1->Width / 3;
            Form1->EnterKey2->Width = Form1->Width / 3;
        };
}
//---------------------------------------------------------------------------

void __fastcall TForm1::EncodeClick(TObject *Sender)
{
        int lenKey = 26;
        if (FileLen <= 0)
        {
                ShowMessage("��������� ���� ��� ��������");
                return;
        };

        if (EnterKey->Text.Length() != lenKey)
        {
                ShowMessage("����� ����� ������ ���� ����� 26");
                return;
        }
        else
        {
                int SizeRead = StrToInt(Form1->SizeRead->Text);
                if (SizeRead > FileLen) SizeRead = FileLen;
                Output->Text = "";
                std::vector <unsigned char> KeyMas;
                std::vector <bool> BitMas;
                KeyMas.assign(FileLen, 0);
                BitMas.assign(FileLen * 8, 0);
                bool Key[lenKey];
                for (int i = 0; (i < lenKey) && (i < EnterKey->Text.Length()); i++)
                        Key[i] = EnterKey->Text[i + 1] - 48;
                CreateKey(&KeyMas, &BitMas, 1, lenKey, Key);
                //������� �������������� ����
                EnterKey->Text = "";
                for (int i = 0; i < SizeRead * 8; i++)
                {
                        char temp;
                        if (BitMas[i] == 0) temp = '0';
                        else temp = '1';
                        EnterKey->Text += temp;
                };
                //������� ���������
                for (int i = 0; i < FileLen; i++)
                	SymVector[i] = SymVector[i] ^ KeyMas[i];
                TextByteToBit(&BitMas);
                for (int i = 0; i < SizeRead * 8; i++)
                {
                        char temp;
                        if (BitMas[i] == 0) temp = '0';
                        else temp = '1';
                        Output->Text += temp;
                };
        };
}
//---------------------------------------------------------------------------
void __fastcall TForm1::EnterKeyKeyPress(TObject *Sender, System::WideChar &Key)
{
    if ((((Key != 48) && (Key != 49)) || (EnterKey->Text.Length() > 25)) &&
        (LFSR->ImageIndex == 0)) Key = 0;
    else
        if ((((Key != 48) && (Key != 49)) || (EnterKey->Text.Length() > 23)) &&
            (LFSR->ImageIndex == -1)) Key = 0;

}
//---------------------------------------------------------------------------

void __fastcall TForm1::SizeReadKeyPress(TObject *Sender, System::WideChar &Key)
{
    if (((Key < '0') || (Key > '9')) && (Key != 8)) Key = 0;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::SaveFileClick(TObject *Sender)
{
	SaveDialog->Filter = "��� ����� (*.*)|*.*";
        SaveDialog->DefaultExt = "*.*";
        if (SaveDialog->Execute())
        {
                char TempLink[256];
                for (int i = 0; i < 256; i++) TempLink[i] = '\0';
		for (int i = 0; i < SaveDialog->FileName.Length(); i++)
                {
        		TempLink[i] = SaveDialog->FileName[i + 1];
                };
                FILE *f;
                f = fopen(TempLink, "wb");
                for (int i = 0; i < FileLen; i++) fputc(SymVector[i], f);
                fclose(f);
        };
}
//---------------------------------------------------------------------------

void __fastcall TForm1::EncodeGefeClick(TObject *Sender)
{
        if (FileLen <= 0)
        {
                ShowMessage("��������� ���� ��� ��������");
                return;
        };

        if (EnterKey2->Text.Length() != 26)
        {
                ShowMessage("����� ����� 1 ������ ���� ����� 26");
                return;
        }
        else
	if (EnterKey1->Text.Length() != 34)
        {
                ShowMessage("����� ����� 2 ������ ���� ����� 34");
                return;
        }
        else
	if (EnterKey->Text.Length() != 24)
        {
                ShowMessage("����� ����� 3 ������ ���� ����� 24");
                return;
        }
        else
        {
            int SizeRead = StrToInt(Form1->SizeRead->Text);
            if (SizeRead > FileLen) SizeRead = FileLen;
            Output->Text = "";
            std::vector <unsigned char> KeyMas;
            std::vector <bool> BitMas1;
            std::vector <bool> BitMas2;
            std::vector <bool> BitMas3;
            KeyMas.assign(FileLen, 0);
            BitMas1.assign(FileLen * 8, 0);
            BitMas2.assign(FileLen * 8, 0);
            BitMas3.assign(FileLen * 8, 0);
            //���� 1
            //-------------------------------------------------------------------
            bool Key1[26];
            for (int i = 0; (i < 26) && (i < EnterKey2->Text.Length()); i++)
                    Key1[i] = EnterKey2->Text[i + 1] - 48;
            CreateKey(&KeyMas, &BitMas1, 1, 26, Key1);
            //������� �������������� ���� 1
            EnterKey2->Text = "";
            for (int i = 0; i < SizeRead * 8; i++)
            {
                    char temp;
                    if (BitMas1[i] == 0) temp = '0';
                    else temp = '1';
                    EnterKey2->Text += temp;
            };
            //���� 2
            //-------------------------------------------------------------------
            bool Key2[34];
            for (int i = 0; (i < 34) && (i < EnterKey1->Text.Length()); i++)
                    Key2[i] = EnterKey1->Text[i + 1] - 48;
            CreateKey(&KeyMas, &BitMas2, 2, 34, Key2);
            //������� �������������� ���� 2
            EnterKey1->Text = "";
            for (int i = 0; i < SizeRead * 8; i++)
            {
                    char temp;
                    if (BitMas2[i] == 0) temp = '0';
                    else temp = '1';
                    EnterKey1->Text += temp;
            };
            //���� 3
            //-------------------------------------------------------------------
            bool Key3[24];
            for (int i = 0; (i < 24) && (i < EnterKey->Text.Length()); i++)
                    Key3[i] = EnterKey->Text[i + 1] - 48;
            CreateKey(&KeyMas, &BitMas3, 3, 24, Key3);
            //������� �������������� ���� 3
            EnterKey->Text = "";
            for (int i = 0; i < SizeRead * 8; i++)
            {
                    char temp;
                    if (BitMas3[i] == 0) temp = '0';
                    else temp = '1';
                    EnterKey->Text += temp;
            };
            //-------------------------------------------------------------------
            //������������ ���� ��� ����������
            for (int i = 0; i < FileLen * 8; i++)
            {
                    BitMas1[i] = (BitMas1[i] & BitMas2[i]) | (!BitMas1[i] & BitMas3[i]);
//                    if (BitMas1[i] == 1)
//                            BitMas1[i] = BitMas2[i];
//                    else
//                            BitMas1[i] = BitMas3[i];
            }

            for (int i = 0; i < FileLen; i++)
            {
                    KeyMas[i] = 128 * BitMas1[i * 8] + 64 * BitMas1[i * 8 + 1] + 32
                                * BitMas1[i * 8 + 2] + 16 * BitMas1[i * 8 + 3] + 8
                                * BitMas1[i * 8 + 4] + 4 * BitMas1[i * 8 + 5] + 2
                                * BitMas1[i * 8 + 6] + BitMas1[i * 8 + 7];
            }
            //-------------------------------------------------------------------
            //������� ���������
            for (int i = 0; i < FileLen; i++)
                    SymVector[i] = SymVector[i] ^ KeyMas[i];
            TextByteToBit(&BitMas1);
            for (int i = 0; i < SizeRead * 8; i++)
            {
                    char temp;
                    if (BitMas1[i] == 0) temp = '0';
                    else temp = '1';
                    Output->Text += temp;
            };
        };
}
//---------------------------------------------------------------------------

void __fastcall TForm1::GefeClick(TObject *Sender)
{
        EncodeGefe->Visible = true;
        Encode->Visible = false;
        Gefe->ImageIndex = 0;
        LFSR->ImageIndex = -1;
        Form1->EnterKey1->Visible = true;
        Form1->EnterKey2->Visible = true;
        Form1->EnterKey->Left = Form1->Width * 2 / 3;
        Form1->EnterKey->Width = Form1->Width / 3;
        Form1->EnterKey2->Width = Form1->Width / 3;
        Form1->KeySplitterLeft->Visible = true;
        Form1->KeySplitterRight->Visible = true;
        Form1->KeySplitterLeft->Left = Form1->Width / 3 + 10;
        Form1->EnterKey->Hint = "���� 3";
}
//---------------------------------------------------------------------------

void __fastcall TForm1::LFSRClick(TObject *Sender)
{
        EncodeGefe->Visible = false;
        Encode->Visible = true;
        Gefe->ImageIndex = -1;
        LFSR->ImageIndex = 0;
        Form1->EnterKey1->Visible = false;
        Form1->EnterKey2->Visible = false;
        Form1->KeySplitterLeft->Visible = false;
        Form1->KeySplitterRight->Visible = false;
        Form1->EnterKey->Left = 17;
        Form1->EnterKey->Width = Form1->Width - 17;
        Form1->EnterKey->Hint = "����";
}
//---------------------------------------------------------------------------

void __fastcall TForm1::EnterKey2KeyPress(TObject *Sender, System::WideChar &Key)

{
	if (((Key != 48) && (Key != 49)) || (EnterKey2->Text.Length() > 25)) Key = 0;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::EnterKey1KeyPress(TObject *Sender, System::WideChar &Key)

{
        if (((Key != 48) && (Key != 49)) || (EnterKey1->Text.Length() > 33)) Key = 0;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::EnterKey2KeyDown(TObject *Sender, WORD &Key, TShiftState Shift)

{
        if (Key == 13) Key = 0;
        if (Key == 86) Key = 0;
}
//---------------------------------------------------------------------------

