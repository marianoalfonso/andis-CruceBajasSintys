----testear bajas de beneficiarios
--declare @resultado tinyint
--exec mpa_beneficiarioBaja 2,12504211,@resultado output
--select @resultado



--declare @resultado tinyint
--exec mpa_beneficiarioBaja 2,12504211,@resultado output
--select @resultado






use nue_profe

--select * from mtb_Errors order by errorid desc
declare @dni int = 41063684
select * from sintys.[dbo].[_tmp_fallecidos] where ndoc = @dni
select clave_excaja,clave_tipo,clave_numero,clave_coparticipe,clave_parentesco,apenom,numero_doc from profe_dat_fil where numero_doc = @dni
select clave_excaja,clave_tipo,clave_numero,clave_coparticipe,clave_parentesco,apenom,numero_doc from baja_profe_dat_fil where numero_doc = @dni

declare @beneficio int = 8611412
declare @coparticipe tinyint = 0
declare @parentesco tinyint = 0

select clave_excaja,clave_tipo,clave_numero,clave_coparticipe,clave_parentesco,apenom from profe_dat_fil where clave_numero = @beneficio and clave_coparticipe = @coparticipe and clave_parentesco = @parentesco
select clave_excaja,clave_tipo,clave_numero,clave_coparticipe,clave_parentesco from profe_dat_dom where clave_numero = @beneficio and clave_coparticipe = @coparticipe and clave_parentesco = @parentesco
select clave_excaja,clave_tipo,clave_numero,clave_coparticipe,clave_parentesco,apenom,fechopc,Motivo from baja_profe_dat_fil where clave_numero = @beneficio and clave_coparticipe = @coparticipe and clave_parentesco = @parentesco
select clave_excaja,clave_tipo,clave_numero,clave_coparticipe,clave_parentesco,fechopc from baja_profe_dat_dom where clave_numero = @beneficio and clave_coparticipe = @coparticipe and clave_parentesco = @parentesco
