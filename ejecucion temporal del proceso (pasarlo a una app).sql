select count(*) from sintys.dbo._tmp_fallecidos --15580
select count(*) from nue_profe.dbo.profe_dat_fil --984129 - 968554
select count(*) from nue_profe.dbo.profe_dat_dom --984129 - 968554
select count(*) from nue_profe.dbo.baja_profe_dat_fil --1274199 - 1289774
select count(*) from nue_profe.dbo.baja_profe_dat_dom --1274199 - 1289774

--truncate table mtb_errors
--truncate table mtb_log

select * into nue_profe.dbo.profe_dat_fil_bck_sintys_101775 from nue_profe.dbo.profe_dat_fil
select * into nue_profe.dbo.profe_dat_dom_bck_sintys_101775 from nue_profe.dbo.profe_dat_dom
select * into nue_profe.dbo.baja_profe_dat_fil_bck_sintys_101775 from nue_profe.dbo.baja_profe_dat_fil
select * into nue_profe.dbo.baja_profe_dat_dom_bck_sintys_101775 from nue_profe.dbo.baja_profe_dat_dom

declare @estado tinyint
exec mpa_procesarSintys '2-101775 (17082021)', @estado output
select @estado

select * from mtb_errors order by errorid desc

select * from mtb_log where procesado = 1
select * from mtb_log where procesado = 0


commit

SELECT 984129 - 968554 --15575
SELECT 1274199 - 1289774 --15575

