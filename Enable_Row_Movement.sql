Begin
  For r In (
        Select 'Alter Table '|| Owner ||'.'|| Table_Name || ' Enable Row Movement' sentencia
          From Dba_Tables
         Where Tablespace_Name = '&TABLESPACE'
           And Partitioned = 'NO'
            ) Loop
    Execute Immediate r.sentencia;
  End Loop;
 End;