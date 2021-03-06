USE [sintys]
GO
/****** Object:  StoredProcedure [dbo].[mpa_writeLog]    Script Date: 9/30/2021 10:24:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[mpa_writeLog]
	@id_proceso nvarchar(30),				--idproceso sintys
	@fecha char(8),
	@id_persona int,				--id persona identificada por sintys en el idproceso
	@grado_confiab varchar(20),
	@ndoc int,	
	@deno nvarchar(50),
	@procesado bit,
	@fecha_fall char(10),
	@message nvarchar(200)
as

begin try
	begin transaction
	
		insert into mtb_log values
		(
			@id_proceso,
			@fecha,
			@id_persona,
			@grado_confiab,
			@ndoc,
			@deno,
			@procesado,
			@fecha_fall,
			@message
		)

	commit transaction
end try
begin catch

    rollback transaction

	insert into dbo.mtb_Errors
    values
	  (suser_sname(),
	   error_number(),
	   error_state(),
	   error_severity(),
	   error_line(),
	   error_procedure(),
	   error_message(),
	   getdate());

end catch
