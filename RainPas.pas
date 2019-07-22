program RainPas;

uses ptcGraph;

VAR
        gd, gm : SmallInt;
BEGIN
	DetectGraph(gd, gm);
        InitGraph(gd, gm, '');
        if GraphResult <> grok then
                halt;
        CloseGraph;
END.

