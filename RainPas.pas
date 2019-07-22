PROGRAM RainPas;

USES ptcGraph, ptcCrt;

CONST
	NBLOBS = 20;
	MIN_SIZE_OF_BLOB = 10;
	MAX_SIZE_OF_BLOB = 200;
	MIN_COLOR = 5;
	MAX_COLOR = 35;

TYPE
	Blob = RECORD
		X: Integer;
		Y: Integer;
		Radius: Integer;
		Max_radius: Integer;
		Color: Integer;
		Tick: LongInt;
	END;	

VAR
        gd, gm : SmallInt;
	blobs: array [1..NBLOBS] of Blob;
	iterator: Integer;

PROCEDURE draw_blobs(i: integer);
Begin
	{Clear old blob}
	SetColor(0);
	Circle(blobs[i].X, blobs[i].Y, blobs[i].Radius - 1);

	{Draw new blob}
	SetColor(blobs[i].Color);
	Circle(blobs[i].X, blobs[i].Y, blobs[i].Radius);
End;

PROCEDURE init_blob(i: Integer);
Begin
	blobs[i].X := Random( GetMaxX ) + 0;
	blobs[i].Y := Random( GetMaxY ) + 0;
	blobs[i].Radius := Random(MAX_SIZE_OF_BLOB - MIN_SIZE_OF_BLOB) + MIN_SIZE_OF_BLOB;
	blobs[i].Max_radius := Random(MAX_SIZE_OF_BLOB - blobs[i].Radius) + blobs[i].Radius;
	blobs[i].Color := Random(MAX_COLOR - MIN_COLOR) + MIN_COLOR;
	blobs[i].Tick := Round(blobs[i].Radius / blobs[i].Color) + 1;
End;

PROCEDURE update_blob(i: Integer);
Begin
	blobs[i].Radius := blobs[i].Radius + 1;

	{If tick is passed update color}
	If blobs[i].Radius mod blobs[i].Tick = 0 Then
	Begin
		blobs[i].Color := blobs[i].Color - 1;
	End;

	{If radius or color equal zero re init this blob}
	If (blobs[i].Radius = blobs[i].Max_radius) OR (blobs[i].Color = 0) Then
	Begin
		SetColor(0);
		Circle(blobs[i].X, blobs[i].Y, blobs[i].Radius - 1);

		init_blob(i);
	End;
End;

BEGIN
	Randomize();
	DetectGraph(gd, gm);
        InitGraph(gd, gm, '');
        if GraphResult <> grok then
                halt;

	{Init all blobs}
	For iterator:=1 To NBLOBS Do
	Begin
		init_blob(iterator);
	End;


	While True do
	Begin
		For iterator:=1 To NBLOBS Do
		Begin
			{Draw blob}
			draw_blobs(iterator);

			{Update or re init blob}
			update_blob(iterator);

			{Delay calculs maximal for stable fps}
			Delay(Round((100 * (5 / NBLOBS) ) / NBLOBS) + 1);
		End;
	End;
	Readln;
	CloseGraph;
END.

