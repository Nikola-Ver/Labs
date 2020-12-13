unit Queue;

interface

type

   TIntArr = array of Integer;

   TValue = record
      tmWorks: TIntArr;
      isWork, isWrite, isFinish: Boolean;
      WorkNum, tmWork: Integer;
      tmWrite: Integer;

   end;

   PNodePointer = ^TNode;
   TNode = record
      Value: TValue;
      PNext: PNodePointer;
   end;

   TQueue = class
      PHead, PTail: PNodePointer;
      Length, ShiftCounter: Integer;
   public
      PRunner: PNodePointer;
      constructor Create;
      procedure Add(Value: TValue);
      procedure Show;
      procedure Move;
      procedure SetRunner;
      function Get(): TValue;
      function isEmpty: Boolean;
      function GetLength(): Integer;
      function GetShiftCounter(): Integer;
   end;

   TProcesses  = array of TQueue;
   TTacts = array of array of array of Char;

   function BetterFillTacts(Processes: TProcesses; var Tacts: TTacts): Integer;
   function GetTotalTime(Processes: TProcesses): Integer;
   procedure FillProcesses(var Processes: TProcesses);

var
   tmTact, tmWrite: Integer;
   FileName: string;
   InputFile: Text;

implementation

constructor TQueue.Create;
begin
   PHead := nil;
   PTail := nil;
   Length := 0;
   ShiftCounter := 0;
end;

function TQueue.GetShiftCounter: Integer;
begin
   Result := ShiftCounter;
end;

function TQueue.GetLength: Integer;
begin
   Result := Length;
end;

procedure TQueue.SetRunner;
begin
   PRunner := PHead;
end;

procedure TQueue.Show;
var
   PRunner: PNodePointer;
   i: Integer;
begin
   PRunner := PHead;
   while (PRunner <> nil) do
   begin
      for i := 0 to High(PRunner^.Value.tmWorks) do
         Write(PRunner^.Value.tmWorks[i], '-');
      Write('; ');
      PRunner := PRunner^.PNext;
   end;
end;

procedure TQueue.Move;
begin
   Add(Get);
   Inc(ShiftCounter);
end;

function TQueue.isEmpty: Boolean;
begin
   isEmpty := PHead = nil;
end;

procedure TQueue.Add(Value: TValue);
var
   Temp: PNodePointer;
begin
   New(Temp);
   Temp^.PNext := nil;
   temp^.Value := Value;
   if (isEmpty) then
   begin
      PHead := Temp;
      PTail := Temp;
   end
   else
   begin
      PTail^.PNext := Temp;
      PTail := Temp;
   end;
   Inc(Length);
end;

function TQueue.Get: TValue;
var
   Return: TValue;
   Temp: PNodePointer;
begin
   Return.WorkNum := -1;
   if not isEmpty then
   begin
      Return := PHead^.Value;
      Temp := PHead;
      PHead := PHead^.PNext;
      Dispose(Temp);
      if (PHead = nil) then
         PTail := nil;
      Dec(Length);
   end;
   Get := Return;
end;

//------------------------------------------------------------------------------

function GetProcessesNum(Processes: TProcesses): Integer;
var
   i, j, Counter: Integer;
   SaveValues: array of TValue;
begin
   Counter := 0;
   for i := 0 to High(Processes) do
   begin
      SetLength(SaveValues, 0);
      while not Processes[i].isEmpty do
      begin
         SetLength(SaveValues, Length(SaveValues) + 1);
         SaveValues[High(SaveValues)] := Processes[i].Get;
         Inc(Counter);
      end;
      for j := 0 to High(SaveValues) do
         Processes[i].Add(SaveValues[j]);
   end;
   Result := Counter;
end;

procedure DoWork(var Value: TValue);
begin
   Inc(Value.tmWork);
   if Value.tmWork = Value.tmWorks[Value.WorkNum] then
   begin
      if Value.WorkNum = High(Value.tmWorks) then
      begin
         Value.isWork := False;
         Value.isWrite := False;
         Value.isFinish := True;
      end
      else
      begin
         Value.isWork := False;
         Value.tmWork := 0;
         Value.isWrite := True;
         Value.tmWrite := 0;
      end;
   end;
end;

procedure DoWrite(var Value: TValue);
begin
   Inc(Value.tmWrite);
   if (Value.tmWrite = tmWrite) then
   begin
      Inc(Value.WorkNum);
      if Value.WorkNum < Length(Value.tmWorks) then
      begin
         Value.isWrite := False;
         Value.isWork := True;
         Value.tmWork := 0;
         Value.tmWrite := 0;
      end
      else
      begin
         Value.isWork := False;
         Value.isWrite := False;
         Value.isFinish := True;
      end;
   end;
end;

function BetterFillTacts(Processes: TProcesses; var Tacts: TTacts): Integer;
var
   ProcessesNum: Integer;
   PStart: PNodePointer;
   i, k, TactNum, WorkerNum: Integer;
   TotalI, TotalJ: Integer;
   LocalI: Integer;
   QLength, MoveCounter: Integer;
   isFound, isFinished: Boolean;
begin
   TactNum := 0;
   SetLength(Tacts, 0, 0, 0);
   ProcessesNum := GetProcessesNum(Processes);
   isFinished := False;
   while {(Counter < TotalTime) or} not isFinished do
   begin

      //add an element to 3d matrix
      //-----------------------------------------
      SetLength(Tacts, Length(Tacts) + 1);
      SetLength(Tacts[High(Tacts)], ProcessesNum);
      for i := 0 to ProcessesNum - 1 do
         SetLength(Tacts[High(Tacts)][i], tmTact);
      //------------------------------------------

      //found the number of priority that executes
      //------------------------------------------
      isFound := False;
      i := 0;
      while not isFound and (i < Length(Processes)) do
      begin
         Processes[i].SetRunner;
         if (Processes[i].PRunner^.Value.isWork) and
            not Processes[i].PRunner^.Value.isFinish then
         begin
            isFound := True;
            WorkerNum := i;
         end;
         Inc(i);
      end;

      for TotalJ := 0 to tmTact - 1 do
      begin
         TotalI := 0;
         for i := 0 to High(Processes) do
         begin
            QLength := Processes[i].GetLength;
            MoveCounter := Processes[i].GetShiftCounter;

            with Processes[i] do
            begin
               SetRunner;
               PStart := PRunner;
               LocalI := 0;
               k := TotalI + LocalI + MoveCounter mod QLength;
               if (i = WorkerNum) and PRunner^.Value.isWork and isFound then
               begin
                  Tacts[TactNum][k][TotalJ] := 'p';
                  DoWork(PRunner^.Value);
                  PRunner := PRunner^.PNext;
                  Inc(LocalI);
               end;
               if PRunner <> nil then
                  repeat
                     k := TotalI + (LocalI + MoveCounter) mod QLength;
                     if PRunner^.Value.isWork and
                        not PRunner^.Value.isFinish then
                     begin
                        Tacts[TactNum][k][TotalJ] := '0';
                     end;
                     if PRunner^.Value.isWrite and not PRunner^.Value.isFinish then
                     begin
                        Tacts[TactNum][k][TotalJ] := 'w';
                        DoWrite(PRunner^.Value);
                     end;
                     Inc(LocalI);
                     PRunner := PRunner^.PNext;
                  until (PRunner = nil) or (PRunner = PStart);
            end;
            Inc(TotalI, Processes[i].GetLength)
         end;


      end;

      if isFound then
      begin
         Processes[WorkerNum].SetRunner;
         if (Processes[WorkerNum].PRunner^.PNext <> nil) and
            not (Processes[WorkerNum].PRunner^.PNext.Value.isFinish) then
         Processes[WorkerNum].Move;
      end
      else
         for i := 0 to High(Processes) do
            Processes[i].Move;

      Inc(TactNum);
      i:= 0;
      isFinished := True;
      while isFinished and (i < Length(Processes)) do
         begin
            Processes[i].SetRunner;
            while isFinished and (Processes[i].PRunner <> nil) do
            begin
               if not Processes[i].PRunner^.Value.isFinish then
                  isFinished := False;
               Processes[i].PRunner := Processes[i].PRunner^.PNext;
            end;
            Inc(i);
         end;
   end;
   Result := TactNum;
end;

procedure AddProcess(var Processes: TProcesses; Priority: Integer);
var
   Size, i: Integer;
   Temp: TValue;
   tmWorks: TIntArr;
begin
   Temp.isWork := True;
   Temp.isWrite := False;
   Temp.WorkNum := 0;
   Temp.tmWork := 0;
   Temp.tmWrite := 0;
   Temp.isFinish := False;
   Readln(InputFile, Size);
   SetLength(tmWorks, Size);
   for i := 0 to High(tmWorks) do
   begin
      Read(InputFile, tmWorks[i]);
   end;
   Temp.tmWorks := Copy(tmWorks);
   Processes[Priority].Add(Temp);
end;

procedure FillProcesses(var Processes: TProcesses);
var
   Size, PriorityNum, i, j: Integer;
begin
   AssignFile(InputFile, FileName);
   {$I-}
      Reset(InputFile);
   {$I+}
   if IOResult = 0 then
   begin
      Readln(InputFile, PriorityNum);
      SetLength(Processes, PriorityNum);
      for i := 0 to High(Processes) do
         Processes[i] := TQueue.Create;
      for i := 0 to High(Processes) do
      begin
         Readln(InputFile, Size);
         for j := 1 to Size do
            AddProcess(Processes, i);
      end;
      CloseFile(InputFile);
   end;
end;


function GetTotalTime(Processes: TProcesses): Integer;
var
   i, j, Counter: Integer;
   Temp: TValue;
   SaveValues: array of TValue;
begin
   Counter := 0;
   for i := 0 to High(Processes) do
   begin
      SetLength(SaveValues, 0);
      while not Processes[i].isEmpty do
      begin
         SetLength(SaveValues, Length(SaveValues) + 1);
         Temp := Processes[i].Get;
         SaveValues[High(SaveValues)] := Temp;
         for j := 0 to High(Temp.tmWorks) do
            Counter := Counter + Temp.tmWorks[j];
      end;
      for j := 0 to High(SaveValues) do
         Processes[i].Add(SaveValues[j]);
   end;
   Result := Counter;
end;

end.
