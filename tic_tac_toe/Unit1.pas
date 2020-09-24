// Jogo da Velha / Jogo do Galo / Tic-Tac-Toe
// (c) 2019, Antonio Rodrigo dos Santos Silva


unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls;

type
  TForm1 = class(TForm)
    lbl_next_turn: TLabel;
    lbl_status: TLabel;
    bllAmZug: TLabel;
    grp_game_mode: TGroupBox;
    rad_2p: TRadioButton;
    rad_1p: TRadioButton;
    pnl_buttons: TPanel;
    btn11: TButton;
    btn12: TButton;
    btn13: TButton;
    btn21: TButton;
    btn22: TButton;
    btn23: TButton;
    btn31: TButton;
    btn32: TButton;
    btn33: TButton;
    btn_start: TButton;
    Shape1: TShape;
    Shape2: TShape;
    cbo_1p_char: TComboBox;
    StaticText2: TStaticText;
    lbl_copyright: TStaticText;
    procedure btn11Click(Sender: TObject);
    procedure btn12Click(Sender: TObject);
    procedure btn13Click(Sender: TObject);
    procedure btn21Click(Sender: TObject);
    procedure btn22Click(Sender: TObject);
    procedure btn23Click(Sender: TObject);
    procedure btn31Click(Sender: TObject);
    procedure btn32Click(Sender: TObject);
    procedure btn33Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_startClick(Sender: TObject);
    procedure rad_1pClick(Sender: TObject);
    procedure rad_2pClick(Sender: TObject);
  private

  public
    { Public declarations }
  end;

var
    Form1: TForm1;
    playmode: Integer;
    turn: Integer;
implementation

{$R *.dfm}

// Checks the win-situations
function isWon:string;
begin
    if (form1.btn11.caption=form1.btn12.caption) and (form1.btn12.caption=form1.btn13.caption) and (form1.btn13.caption<>'') then
    begin
        form1.btn11.Font.Color:=clred;
        form1.btn12.Font.Color:=clred;
        form1.btn13.Font.Color:=clred;
        result:= form1.btn12.caption;
        exit;
    end;

    if (form1.btn21.caption=form1.btn22.caption) and (form1.btn22.caption=form1.btn23.caption) and (form1.btn23.caption<>'') then
    begin
        form1.btn21.Font.Color:=clred;
        form1.btn22.Font.Color:=clred;
        form1.btn23.Font.Color:=clred;
        result:= form1.btn22.caption;
        exit;
    end;

    if (form1.btn31.caption=form1.btn32.caption) and (form1.btn32.caption=form1.btn33.caption) and (form1.btn33.caption<>'') then
    begin
        form1.btn31.Font.Color:=clred;
        form1.btn32.Font.Color:=clred;
        form1.btn33.Font.Color:=clred;
        result:= form1.btn33.caption;
        exit;
    end;

    if (form1.btn11.caption=form1.btn21.caption) and (form1.btn21.caption=form1.btn31.caption) and (form1.btn31.caption<>'') then
    begin
        form1.btn21.Font.Color:=clred;
        form1.btn11.Font.Color:=clred;
        form1.btn31.Font.Color:=clred;
        result:= form1.btn21.caption;
        exit;
    end;

    if (form1.btn12.caption=form1.btn22.caption) and (form1.btn22.caption=form1.btn32.caption) and(form1.btn32.caption<>'') then
    begin
        form1.btn12.Font.Color:=clred;
        form1.btn22.Font.Color:=clred;
        form1.btn32.Font.Color:=clred;
        result:= form1.btn22.caption;
        exit;
    end;

    if (form1.btn13.caption=form1.btn23.caption) and (form1.btn23.caption=form1.btn33.caption) and (form1.btn33.caption<>'') then
    begin
        form1.btn13.Font.Color:=clred;
        form1.btn23.Font.Color:=clred;
        form1.btn33.Font.Color:=clred;
        result:= form1.btn33.caption;
        exit;
    end;

    if (form1.btn11.caption=form1.btn22.caption) and(form1.btn22.caption=form1.btn33.caption) and (form1.btn33.caption<>'') then
    begin
        form1.btn22.Font.Color:=clred;
        form1.btn33.Font.Color:=clred;
        form1.btn11.Font.Color:=clred;
        result:= form1.btn11.caption;
        exit;
    end;

    if (form1.btn31.caption=form1.btn22.caption) and (form1.btn22.caption=form1.btn13.caption) and (form1.btn13.caption<>'') then
    begin
        result:= form1.btn22.caption;
        exit;
    end;

    // No one has won
    result:='';
end;


procedure resetGame;
var
    x,y: short;
    i: Integer;
begin
    //Reset the caption
    form1.lbl_status.caption:='';

    form1.lbl_next_turn.caption:=form1.cbo_1p_char.Text;

    //Reset board
    for i:= 0 to form1.pnl_buttons.ControlCount-1 do
    begin
        if ( (form1.pnl_buttons.Controls[i]) is TButton) then
        begin
            TButton(form1.pnl_buttons.Controls[i]).Caption := '';
            TButton(form1.pnl_buttons.Controls[i]).Enabled := True;
        end;
    end;
end;

procedure playerAction(btn:Tbutton);
var
    i: short;
    selected: boolean;
begin
    // Is the game still runnung
    if form1.lbl_status.caption <> '' then
    begin
        MessageDlg('Jogo finalizado!',mtInformation,[mbOk],0);
        exit;
    end;

    // Is the field already occupied?
    if btn.Caption <> '' then
    begin
        MessageDlg('Campo já preenchido!',mtInformation,[mbOk],0);
        exit;
    end
    else
    begin
        // Put O or X
        btn.caption:=form1.lbl_next_turn.caption;
        btn.Enabled:=False;

        if isWon = 'X' then
        begin
           form1.lbl_status.caption:= 'X venceu!';
           exit;
        end
        else if isWon = 'O' then
        begin
           form1.lbl_status.caption:= 'O venceu!';
           exit;
        end
        else
        begin
          if form1.lbl_next_turn.Caption = 'X' then
              form1.lbl_next_turn.Caption:='O'
          else
              form1.lbl_next_turn.Caption:='X';

          if turn = 1 then
          begin
              turn:= 2;
          end
          else
          begin
              turn:= 1;
          end;

          if (playmode = 1) and (turn = 2) then
          begin
              selected := False;
              while selected = False do
              begin
                  Randomize;
                  i:= 1 + Random(9);
                  if i = 1 then
                  begin
                      if form1.btn11.Enabled = True then
                      begin
                          selected:= True;
                      end;
                  end
                  else if i = 2 then
                  begin
                      if form1.btn12.Enabled = True then
                      begin
                          selected:= True;
                      end;
                  end
                  else if i = 3 then
                  begin
                      if form1.btn13.Enabled = True then
                      begin
                          selected:= True;
                      end;
                  end
                  else if i = 4 then
                  begin
                      if form1.btn21.Enabled = True then
                      begin
                          selected:= True;
                      end;
                  end
                  else if i = 5 then
                  begin
                      if form1.btn22.Enabled = True then
                      begin
                          selected:= True;
                      end;
                  end
                  else if i = 6 then
                  begin
                      if form1.btn23.Enabled = True then
                      begin
                          selected:= True;
                      end;
                  end
                  else if i = 7 then
                  begin
                      if form1.btn31.Enabled = True then
                      begin
                          selected:= True;
                      end;
                  end
                  else if i = 8 then
                  begin
                      if form1.btn32.Enabled = True then
                      begin
                          selected:= True;
                      end;
                  end
                  else
                  begin
                      if form1.btn33.Enabled = True then
                      begin
                          selected:= True;
                      end;
                  end;
              end;

              if i = 1 then
              begin
                  playerAction(form1.btn11);
              end
              else if i = 2 then
              begin
                  playerAction(form1.btn12);
              end
              else if i = 3 then
              begin
                  playerAction(form1.btn13);
              end
              else if i = 4 then
              begin
                  playerAction(form1.btn21);
              end
              else if i = 5 then
              begin
                  playerAction(form1.btn22);
              end
              else if i = 6 then
              begin
                  playerAction(form1.btn23);
              end
              else if i = 7 then
              begin
                  playerAction(form1.btn31);
              end
              else if i = 8 then
              begin
                  playerAction(form1.btn32);
              end
              else
              begin
                  playerAction(form1.btn33);
              end;

          end;
        end;
    end;
end;


procedure TForm1.btn11Click(Sender: TObject);
begin
    playerAction(form1.btn11);
end;

procedure TForm1.btn12Click(Sender: TObject);
begin
    playerAction(form1.btn12);
end;

procedure TForm1.btn13Click(Sender: TObject);
begin
    playerAction(form1.btn13);
end;

procedure TForm1.btn21Click(Sender: TObject);
begin
    playerAction(form1.btn21);
end;

procedure TForm1.btn22Click(Sender: TObject);
begin
    playerAction(form1.btn22);
end;

procedure TForm1.btn23Click(Sender: TObject);
begin
    playerAction(form1.btn23);
end;

procedure TForm1.btn31Click(Sender: TObject);
begin
    playerAction(form1.btn31);
end;

procedure TForm1.btn32Click(Sender: TObject);
begin
    playerAction(form1.btn32);
end;

procedure TForm1.btn33Click(Sender: TObject);
begin
    playerAction(form1.btn33);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    // Center Screen
    Left:=(Screen.Width-Width) div 2;
    Top:=(Screen.Height-Height) div 2;

    //Standard Playmode - Human Vs CPU
    playmode:=1;
    turn:=1;

    resetGame;
end;

procedure TForm1.rad_1pClick(Sender: TObject);
begin
    if rad_1p.Checked= true then
    begin
        playmode:=1;
    end
    else
    begin
        playmode:=2;
    end;
end;

procedure TForm1.rad_2pClick(Sender: TObject);
begin
    if rad_2p.Checked = true then
    begin
        playmode:=2;
    end
    else
    begin
        playmode:=1;
    end;
end;

procedure TForm1.btn_startClick(Sender: TObject);
begin
    resetGame;
end;

end.
