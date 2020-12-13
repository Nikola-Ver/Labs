#define ID_CH1 1 
#define ID_CH2 2
#define ID_CH3 3 
#define ID_CH4 4 
#define ID_CH5 5
#define ID_EXIT 6 
#define ID_STATIC 7 
#define ID_LIN 8
 
#include <windows.h>
#include <resource.h>
 
//Создаем прототип функции окна
LRESULT CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam); 
TCHAR szProgName[]=TEXT("Имя программы");//имя программы
TCHAR szMenu[] =TEXT("Menu");//меню
HINSTANCE hInstance; 
HCURSOR hCurs1, hCurs2; //дескрипторы курсоров
COLORREF color = RGB(255,255,128);  
//создаём экземпляр структуры графического вывода
PAINTSTRUCT ps;
DWORD dColor[3] ={255,222,222}; 
 
int WINAPI WinMain(HINSTANCE hInst, HINSTANCE hPrevinstance, LPSTR lpszCmdLine, int nCmdShow) 
{  
    HWND hWnd; //идентификатор окна
    MSG IpMsg;  //идентификатор сообщения
    hInstance=hInst;//дескриптор текущего экземпляра программы
    WNDCLASS w; //создаём экземпляр структуры WNDCLASS и начинаем ее заполнять
    w.lpszClassName=szProgName;//имя программы - объявленор выше
    w.hInstance=hInst;//идентификатор текущего приложения
    w.lpfnWndProc=WndProc;//указатель на функцию окна
    w.hCursor=LoadCursor(hInst, MAKEINTRESOURCE(230));//курсор
    w.hIcon=LoadIcon(NULL, IDI_APPLICATION);//стандартная иконка приложения win api
    w.lpszMenuName=szMenu;//меню
    w.hbrBackground=(HBRUSH)GetStockObject(1);//цвет фона окна
    w.style=CS_HREDRAW|CS_VREDRAW;//стиль - перерисовываемое по х и по y
    w.cbClsExtra=0; 
    w.cbWndExtra=0; 
 
    //Если не удалось зарегистрировать класс окна - выходим
    if(!RegisterClass(&w)) 
    return 0; 
    //Создадим окно в памяти, заполнив аргументы CreateWindow
    hWnd=CreateWindow(szProgName,//имя программы
                     TEXT("Alternative"),//заголовок окна
                      WS_OVERLAPPEDWINDOW|WS_VISIBLE | DS_SETFONT | 
                      DS_MODALFRAME | DS_3DLOOK | DS_FIXEDSYS | WS_CAPTION | WS_SYSMENU, //стиль окна
                      100,110,//положение окна на экране по x и по y
                      330,330,//размеры по x и y
                      (HWND)NULL,//идентификатор родительского окна
                      (HMENU)NULL,//идентификатор меню
                      hInstance,//идентификатор экземпляра программы
                      (LPSTR)NULL);//отсутствие дополнительных параметров
    //Выводим окно из памяти на экран
    ShowWindow(hWnd, nCmdShow); 
    //Обновим содержимое окна
    UpdateWindow(hWnd); 
    //Цикл обработки сообщений
    while(GetMessage(&IpMsg, NULL, 0, 0)) { 
        TranslateMessage(&IpMsg); 
        DispatchMessage(&IpMsg); 
    }
     return((int)IpMsg.wParam);
}
//Функция окна
LRESULT CALLBACK WndProc(HWND hWnd, UINT messg, WPARAM wParam, LPARAM IParam) 
{
    HDC hdc;//создаём контекст устройства
    DEVMODE dm; 
    hCurs1 = LoadCursor(NULL, IDC_NO);//задаём настройки курсоров
    hCurs2 = LoadCursor(NULL, IDC_ARROW); 
    CHOOSECOLOR cc; 
    cc.Flags = CC_RGBINIT|CC_FULLOPEN; 
    cc.hInstance = NULL;
    cc.hwndOwner = hWnd; 
    cc.lCustData = 0L; 
    cc.lpCustColors = dColor; 
    cc.lpfnHook = NULL; 
    cc.lpTemplateName = (LPCSTR)NULL; 
    cc.lStructSize = sizeof(cc);
    cc.rgbResult = RGB(255,0,0); 
    HBRUSH hBrush;
    RECT rcClient;// прямоугольник рабочей области
    POINT ptClientUL;// верхний левый угол рабочей области
    POINT ptClientLR;// нижний правый угол рабочей области
    static POINTS ptsBegin;// исходная точка
    static POINTS ptsEnd;// новая конечная точка
    static POINTS ptsPrevEnd;// предыдущая конечная точка
    static BOOL fPrevLine =FALSE;// флажок предыдущей линии
 
    switch(messg) 
    { 
    case WM_LBUTTONDOWN: 
     //Захват ввода данных от мыши.
     SetCapture(hWnd); 
     //Получим экранные координаты рабочей области,и преобразуем их в рабочие координаты.
     GetClientRect(hWnd, &rcClient); 
     ptClientUL.x = rcClient.left; 
     ptClientUL.y = rcClient.top; 
     //Добавим по единице с правой и нижней стороны, поскольку координаты полученные при помощи GetClientRect He
     //включают в себя крайний левый и крайний нижний пиксели.
     ptClientLR.x = rcClient.right + 1;
     ptClientLR.y = rcClient.bottom + 1; 
     ClientToScreen(hWnd, &ptClientUL); 
     ClientToScreen(hWnd, &ptClientLR);
     //Скопируем рабочие координаты рабочей области в член rcCIient структуры. Ограничим курсор мыши рабочей областью с помощью передачи rcCIient структуры в
     //функцию ClipCursor.
     SetRect(&rcClient, ptClientUL.x, ptClientUL.y, ptClientLR.x, ptClientLR.y); ClipCursor(&rcClient); 
     //Преобразуем координаты курсора B структуру POINTS, которая определяет исходную точку рисуемой линии
     //в ходе сообщения WM_MOUSEMOVE.
    ptsBegin = MAKEPOINTS(IParam); 
    return 0; 
    case WM_MOUSEMOVE:
     //Когда мышь движется, пользователь, чтобы нарисовать линию, должен удерживать нажатой левую кнопку мыши.
     if (wParam & MK_LBUTTON) { 
     //Получим контекст устройства (DC) для рабочей области.
     hdc = GetDC(hWnd); 
     //Ниже следуют функции гарантирующие, что пиксели предыдущей нарисованной линии установятся в белый и
     //Te же самые новой линии установятся в черный.
     SetROP2(hdc, R2_NOTXORPEN); 
     //Если линия была нарисована раньше сообщения WM_MOUSEMOVE то рисование проходит поверх ее. Линия стирается при помощи
     //установки ее пиксепей в белый цвет.
     if (fPrevLine) 
     { 
     MoveToEx(hdc, ptsBegin.x, ptsBegin.y, (LPPOINT) NULL); 
     LineTo(hdc, ptsPrevEnd.x, ptsPrevEnd.y); 
     } 
    //Преобразуем текущие координаты курсора в структуру POINTS, а затем нарисуем новую линию.
     ptsEnd = MAKEPOINTS(IParam); 
     MoveToEx(hdc, ptsBegin.x, ptsBegin.y, (LPPOINT) NULL); 
     LineTo(hdc, ptsEnd.x, ptsEnd.y);
     //Установим флажок предыдущей линии, сохраним конечную точку новой линии, а затем восстановим прежний DC.
     fPrevLine = TRUE;
     ptsPrevEnd = ptsEnd; 
     ReleaseDC(hWnd, hdc);
     }
    break;
 
    case WM_LBUTTONUP:
     //Пользователь закончил рисовать линию. Сбросим флажок предыдущей линии, освободим курсор мыши, и освободим мышь от захвата
    fPrevLine =FALSE; 
    ClipCursor(NULL); 
    ReleaseCapture(); 
    return 0;
 
    case WM_CREATE: 
     //Текст
     CreateWindow(TEXT("static"), TEXT("Выбирайте"), WS_CHILD|WS_VISIBLE|SS_CENTER, 
     30,10, 
     260,30,  hWnd, (HMENU)ID_STATIC, hInstance, NULL); 
     //Кнопка "800х600(8)"
     CreateWindow(TEXT("button"), TEXT("800х600(8)"), WS_CHILD|WS_VISIBLE|BS_DEFPUSHBUTTON, 
     30,45, 
     120,30, hWnd, (HMENU)ID_CH1, hInstance, NULL); 
     //Kнoпкa "800х600(16)"
     CreateWindow(TEXT("button"), TEXT("800х600(16)"), WS_CHILD|WS_VISIBLE|BS_DEFPUSHBUTTON, 
     30,75, 
     120,30, hWnd, (HMENU)ID_CH2, hInstance, NULL);
     //Kнoпкa "800х600(32)"
     CreateWindow(TEXT("button"), TEXT("800х600(32)"), WS_CHILD|WS_VISIBLE|BS_DEFPUSHBUTTON, 
     170,45, 
     120,30, hWnd, (HMENU)ID_CH3, hInstance, NULL); 
     //Kнoпкa "1024х768(32)"
     CreateWindow(TEXT("button"),TEXT("1024х768(32)"),
     WS_CHILD|WS_VISIBLE|BS_DEFPUSHBUTTON, 
     170,75, 
     120,30, hWnd, (HMENU)ID_CH4, hInstance, NULL); 
     //Kнoпкa "Выход"
     CreateWindow(TEXT("button"), TEXT("Выход"), 
     WS_CHILD|WS_VISIBLE|BS_DEFPUSHBUTTON, 
     30,180, 
     120,30, hWnd, (HMENU)ID_EXIT, hInstance, NULL); 
     //Kнoпкa "Выбор фона"
     CreateWindow(TEXT("button"),TEXT("Выбор фона"),
     WS_CHILD|WS_VISIBLE|BS_DEFPUSHBUTTON, 
     170,180, 
     120,30, hWnd, (HMENU)ID_CH5, hInstance, NULL); 
    break;
 
    case WM_COMMAND: 
    //Обработка сообщений от элементов управления
    switch(LOWORD(wParam)) 
    { 
        case WM_SETCURSOR: 
        //изменить вид курсора на перечеркнутый круг при выборе пункта меню
        case ID_CURSOR_DIFFERENT:
         hCurs1 = LoadCursor(NULL, IDC_WAIT);
         SetClassLong(hWnd, GCL_HCURSOR, (LONG)hCurs1); 
        break;
 
        //изменить курсор на стандартный
        case ID_CURSOR_NORMAL: 
         SetClassLong(hWnd, GCL_HCURSOR, (LONG)hCurs2); 
        break; 
 
        //вызов окна выбора цвета при нажатии пункта меню
        case ID_BACKGROUND: 
         if(ChooseColor(&cc)){
             color = (COLORREF)cc.rgbResult; 
         } 
        InvalidateRect(hWnd, NULL, 1); 
        break; 
 
     //самое простое - кнопка выхода
        case ID_EXIT: 
          DestroyWindow(hWnd); 
        return 0;
        break; 
        
        //Кнопка "800х600(8)"
        case ID_CH1: 
         memset(&dm,0,sizeof(DEVMODE)); 
         dm.dmSize=sizeof(DEVMODE); 
         dm.dmBitsPerPel=8; 
         dm.dmPelsWidth=800; 
         dm.dmPelsHeight=600; 
         dm.dmFields=DM_BITSPERPEL|DM_PELSWIDTH|DM_PELSHEIGHT|DM_DISPLAYFREQUENCY; 
         ChangeDisplaySettings(&dm,CDS_FULLSCREEN); 
         CDS_FULLSCREEN; 
        break; 
         //Кнопка "800х600(16)"
        case ID_CH2:
         memset(&dm,0,sizeof(DEVMODE)); 
         dm.dmSize=sizeof(DEVMODE); 
         dm.dmBitsPerPel=16; 
         dm.dmPelsWidth=800; 
         dm.dmPelsHeight=600; 
         dm.dmFields=DM_BITSPERPEL|DM_PELSWIDTH|DM_PELSHEIGHT|DM_DISPLAYFREQUENCY; 
         ChangeDisplaySettings(&dm,CDS_FULLSCREEN); 
        break; 
        //кнопак "800х600(32)"
        case ID_CH3:
         memset(&dm,0,sizeof(DEVMODE)); 
         dm.dmSize=sizeof(DEVMODE); 
         dm.dmBitsPerPel=32; 
         dm.dmPelsWidth=800; 
         dm.dmPelsHeight=600;
         dm.dmFields=DM_BITSPERPEL|DM_PELSWIDTH|DM_PELSHEIGHT|DM_DISPLAYFREQUENCY; 
         ChangeDisplaySettings(&dm,CDS_FULLSCREEN); 
        break; 
        //Кнопка "1024х768"
        case ID_CH4:
         memset(&dm,0,sizeof(DEVMODE)); 
         dm.dmSize=sizeof(DEVMODE); 
         dm.dmBitsPerPel=32; 
         dm.dmPelsWidth=1024; 
         dm.dmPelsHeight=768; 
         dm.dmFields=DM_BITSPERPEL|DM_PELSWIDTH|DM_PELSHEIGHT|DM_DISPLAYFREQUENCY; 
         ChangeDisplaySettings(&dm,CDS_FULLSCREEN); 
        break; 
 
        case ID_CH5: 
         if (ChooseColor(&cc)){ 
            color = (COLORREF)cc.rgbResult; 
         } 
         InvalidateRect(hWnd, NULL, 1); 
        break; 
        break; 
    } 
        break;//wm-command
        //рисование
        case WM_PAINT: 
        { 
            PAINTSTRUCT ps; //экземпляр структуры рисования
            hdc = BeginPaint(hWnd, &ps);//начали рисование
            hBrush = CreateSolidBrush(color);//создание кисти
            SelectObject(hdc, hBrush);//выбор кисти
            SetBkMode(hdc, TRANSPARENT);//Устанавливает режим, определяющий,должен ли интерфейс GDI удалять существующие цвета фона 
            //перед рисованием текста, использованием шриховочных кистей и стилей пера при рисовании несплошных линий.
            Rectangle(hdc,0,0,500,500);//перерисовывание фона окна приложения
            EndPaint(hWnd, &ps);//закончили рисование     
            break; 
        } 
        //сообщение выхода - разрушение окна
        case WM_DESTROY:
            PostQuitMessage(0); // сообщение выхода с кодом 0 - нормальое завершение
        break;
        default: 
        return(DefWindowProc(hWnd, messg, wParam, IParam));//освобождаем очередь приложения от нераспознаных функций
    }
     return 0; 
}