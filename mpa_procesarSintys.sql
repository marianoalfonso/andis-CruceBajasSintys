USE [sintys]
GO
/****** Object:  StoredProcedure [dbo].[mpa_procesarSintys]    Script Date: 9/30/2021 7:50:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





ALTER procedure [dbo].[mpa_procesarSintys]
	@id_proceso varchar(30),
	@estadoProceso tinyint output
as

declare @id_persona int
declare @ndoc int
declare @deno nvarchar(50)
declare @grado_confiab varchar(20)
declare @ffall char(10)

declare @fechaProceso char(8) = convert(char(8),getdate(),112)
declare @resultado tinyint
declare @contador int = 1

begin try
	
	set @estadoProceso = 0

	declare mcr_procesoSintysFallecidos cursor scroll for
		select id_persona,ndoc,deno,grado_confiab,ffall from _tmp_fallecidos --15580

	open mcr_procesoSintysFallecidos
	fetch next from mcr_procesoSintysFallecidos into
		@id_persona,@ndoc,@deno,@grado_confiab,@ffall

	while @@FETCH_STATUS = 0
	begin

		print 'numero de documento: ' + convert(nvarchar,@ndoc)

		exec mpa_beneficiarioBaja 
			2,
			@ndoc,
			@resultado output

		print 'resultado de la baja: ' + convert(char,@resultado)

		exec mpa_writeLog 
			@id_proceso,
			@fechaProceso,
			@id_persona,
			@grado_confiab,
			@ndoc,
			@deno,
			@resultado,
			@ffall,
			'baja por fallecimiento'
		
		set @contador = @contador + 1
		print 'contador: ' + convert(nvarchar,@contador)
		fetch next from mcr_procesoSintysFallecidos into
			@id_persona,@ndoc,@deno,@grado_confiab,@ffall
	end
	commit transaction
	close mcr_procesoSintysFallecidos
	deallocate mcr_procesoSintysFallecidos
end try
begin catch
	set @estadoProceso = 1
		close mcr_procesoSintysFallecidos
		deallocate mcr_procesoSintysFallecidos

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