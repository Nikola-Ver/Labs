//---------------------------------------------------------------------------

#ifndef DaH
#define DaH
//---------------------------------------------------------------------------
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.ImageList.hpp>
#include <Vcl.ImgList.hpp>
//---------------------------------------------------------------------------
class TSymMas : public TThread
{
private:
        int State;
protected:
	void __fastcall Execute() override;
public:
        __fastcall TSymMas(int Thread);
        void __fastcall Progress();
        void __fastcall EnterText();
};
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
	TRichEdit *Input;
	TRichEdit *Output;
	TSplitter *Splitter;
	TSplitter *KeySplitter;
	TMainMenu *Menu;
	TMenuItem *N1;
	TMenuItem *LFSR;
	TMenuItem *N2;
	TMenuItem *Encode;
	TMenuItem *N5;
	TMenuItem *LoadFile;
	TMenuItem *SaveFile;
	TPanel *StatusText;
	TProgressBar *ProgBar;
	TGroupBox *GroupStatus;
	TPanel *FileStatus;
	TOpenDialog *OpenDialog;
	TImageList *ImageList;
	TEdit *SizeRead;
	TSaveDialog *SaveDialog;
	TMenuItem *Gefe;
	TMenuItem *EncodeGefe;
	TGroupBox *GroupBox;
	TRichEdit *EnterKey;
	TRichEdit *EnterKey1;
	TRichEdit *EnterKey2;
	TSplitter *KeySplitterLeft;
	TSplitter *KeySplitterRight;
	void __fastcall LoadFileClick(TObject *Sender);
	void __fastcall FormResize(TObject *Sender);
	void __fastcall EncodeClick(TObject *Sender);
	void __fastcall EnterKeyKeyPress(TObject *Sender, System::WideChar &Key);
	void __fastcall SizeReadKeyPress(TObject *Sender, System::WideChar &Key);
	void __fastcall SaveFileClick(TObject *Sender);
	void __fastcall EncodeGefeClick(TObject *Sender);
	void __fastcall GefeClick(TObject *Sender);
	void __fastcall LFSRClick(TObject *Sender);
	void __fastcall EnterKey2KeyPress(TObject *Sender, System::WideChar &Key);
	void __fastcall EnterKey1KeyPress(TObject *Sender, System::WideChar &Key);
	void __fastcall EnterKey2KeyDown(TObject *Sender, WORD &Key, TShiftState Shift);




private:	// User declarations
public:		// User declarations
	__fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
