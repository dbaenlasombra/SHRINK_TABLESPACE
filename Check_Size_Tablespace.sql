Select d.Status "Status",
       d.Tablespace_Name "Name",
       To_Char(Nvl(a.Bytes / 1024 / 1024 / 1024, 0), '99,999,990.90') "Size (GB)",
       To_Char(Nvl(a.Bytes - Nvl(f.Bytes, 0), 0) / 1024 / 1024 / 1024,
               '99999999.99') "Used (GB)",
       To_Char(Nvl(f.Bytes / 1024 / 1024 / 1024, 0), '99,999,990.90') "Free (GB)",
       Nvl((a.Bytes - Nvl(f.Bytes, 0)) / a.Bytes * 100, 0) "(Used) %"
  From Sys.Dba_Tablespaces d,
       (
       Select Pp.Name Tablespace_Name, Sum(Bytes) Bytes
          From v$datafile Rr, v$tablespace Pp
         Where Rr.Ts#  = Pp.Ts#
           And Pp.Name = '&TABLESPACE'
         Group By Pp.Name
        ) a,
       (Select Tablespace_Name, Sum(Bytes) Bytes
          From Dba_Free_Space
         Group By Tablespace_Name) f
 Where d.Tablespace_Name = a.Tablespace_Name
   And d.Tablespace_Name = f.Tablespace_Name