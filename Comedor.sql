f

/*---------------------------- SISTEMA COMEDOR UNI ----------------------------*/

Create Database Comedor
Go

Use Comedor
Go

Create Login Administrador With Password = 'unidbe'
Go

sp_addsrvrolemember Administrador , sysadmin
Go



Use Comedor
Go

Sp_AddUser Administrador, AdministradorDBE
Go



Sp_AddRoleMember [db_owner] , AdministradorDBE
Go



Create Table Estudiante (
ID_Estudiante Int Identity (1,1) Primary Key,
No_Carne_Estudiante Nvarchar (10) not null,
Nombres_Estudiante Nvarchar (50) not null,
Apellidos_Estudiante Nvarchar (50) not null,
Fecha_Nacimiento_Estudiante date not null,
Sexo_Estudiante Nvarchar (10) not null,
Facultad_Estudiante Nvarchar (50) not null,
Carrera_Estudiante Nvarchar (50) not null,
Foto_Estudiante Varbinary (Max),
Estado_Estudiante Nvarchar (10) Default 'Activo' not null,
Becado Nvarchar (2) Default 'No' not null,
Check (Sexo_Estudiante in ('Masculino', 'Femenino')),
Check (Estado_Estudiante in ('Activo', 'Inactivo')),
Check (Becado in ('Si','No'))
)
Go

Create Table Trabajador (
ID_Trabajador Int Identity (1,1) Primary Key,
No_Carne_Trabajador Nvarchar (10) not null,
Nombres_Trabajador Nvarchar (50) not null,
Apellidos_Trabajador Nvarchar (50) not null,
No_Cedula_Trabajador Nvarchar (16) not null,
Sexo_Trabajador Nvarchar (10) not null,
Puesto_Trabajador Nvarchar (50) not null,
Foto_Trabajador Varbinary (Max),
Estado_Trabajador Nvarchar (10) Default 'Activo' not null,
PlanAlimento Nvarchar (2) Default 'No' not null,
Check (Sexo_Trabajador in ('Masculino', 'Femenino')),
Check (Estado_Trabajador in ('Activo', 'Inactivo')),
Check (PlanAlimento in ('Si','No'))
)
Go

Create Table BecaAlimenticia (
ID_BecaAlimenticia Int Identity (1,1) Primary Key,
ID_Estudiante Int Foreign Key References Estudiante (ID_Estudiante) not null,
ContadorE int Default 0 not null,
Estado_Beca Nvarchar (10) not null,
Check (ContadorE >= 0),
Check (ContadorE <= 3),
Check (Estado_Beca in ('Activo', 'Inactivo'))
)
Go

Create Table ContadoresE (
ID_ContadoresE Int Identity (1,1) Primary Key,
ID_BecaAlimenticia Int Foreign Key References BecaAlimenticia (ID_BecaAlimenticia) not null,
Contador_CorrespondienteE int not null,
FechaContadorE DateTime Default GetDate() not null,
Justificado Nvarchar (2) Default 'No' not null,
FechaC Date not null,
Check (Contador_CorrespondienteE > 0),
Check (Contador_CorrespondienteE <= 3),
Check (Justificado in ('Si', 'No'))
)
Go

Create Table PlanAlimenticio (
ID_PlanAlimenticio Int Identity (1,1) Primary Key,
ID_Trabajador Int Foreign Key References Trabajador (ID_Trabajador) not null,
Estado_Plan Nvarchar (10) Default 'Activo' not null,
ContadorT int Default 0 not null,
Check (ContadorT >= 0),
Check (Estado_Plan in ('Activo', 'Inactivo'))
)
Go

Create Table ContadoresT (
ID_ContadoresT Int Identity (1,1) Primary Key,
ID_PlanAlimenticio Int Foreign Key References PlanAlimenticio (ID_PlanAlimenticio) not null,
Contador_CorrespondienteT int not null,
FechaContadorT DateTime Default GetDate() not null,
Justificado Nvarchar (2) Default 'No' not null,
FechaC Date not null,
Check (Contador_CorrespondienteT > 0),
Check (Justificado in ('Si', 'No'))
)
Go


Create Table Usuarios (
ID_Usuarios Int Identity (1,1) Primary Key,
Nombres_Usuario Nvarchar (50) not null,
Apellidos_Usuario Nvarchar (50) not null,
No_Cedula_Usuario Nvarchar (16) not null,
Puesto_Usuario Nvarchar (50) not null,
Recinto_Usuario Nvarchar (50) not null,
Foto_Usuario Varbinary (Max),
Privilegio_Usuario Nvarchar (15) Default 'Standard' not null,
NombreLogin Nvarchar (50) not null,
Estado_Usuario Nvarchar (10) Default 'Activo' not null,
Check (Estado_Usuario in ('Activo', 'Inactivo')),
Check (Privilegio_Usuario in ('Standard', 'Administrador') )
)

Create Table RegistroComedorE (
ID_RegistroComedorE Int Identity (1,1) Primary Key,
ID_BecaAlimenticia Int Foreign Key References BecaAlimenticia (ID_BecaAlimenticia) not null,
ID_Usuarios Int Foreign Key References Usuarios (ID_Usuarios) not null,
FechaHoraComedor DateTime Default GetDate() not null,
Comedor Nvarchar(50) not null,
FechaContador Date not null,
)
Go

Create Table RegistroComedorT (
ID_RegistroComedorT Int Identity (1,1) Primary Key,
ID_PlanAlimenticio Int Foreign Key References PlanAlimenticio (ID_PlanAlimenticio ) not null,
ID_Usuarios Int Foreign Key References Usuarios (ID_Usuarios) not null,
FechaHoraComedor DateTime Default GetDate() not null,
Comedor Nvarchar(50) not null,
FechaContador Date not null,
)
Go

Create Table Semanas (
ID_Semana Int Identity (1,1) Primary Key,
Semana int not null,
Anio int not null,
Check (Semana > 0)
)
Go

Create Table CerrarSesion(
ID_CerrarSesion Int Identity (1,1) Primary Key,
FechaHora Datetime not null,
ID_Usuarios Int Foreign Key References Usuarios (ID_Usuarios) not null
)
Go


---------------------------------------------------------------------------
---------------------------------------------------------------------------

---FUNCION ESCALAR ----
CREATE  FUNCTION ConvertirUTFaLatin1(@entrada NVARCHAR(max)) RETURNS NVARCHAR(max) 
BEGIN 
    DECLARE @salida NVARCHAR(max); 
        SET @salida = REPLACE(@entrada , '√°', '·'); 
        SET @salida = REPLACE(@salida , '√©', 'È'); 
        SET @salida = REPLACE(@salida , '√*', 'Ì'); 
        SET @salida = REPLACE(@salida , '√≥', 'Û'); 
        SET @salida = REPLACE(@salida , '√∫', '˙'); 
        SET @salida = REPLACE(@salida , '√ ', '‡'); 
        SET @salida = REPLACE(@salida , '√®', 'Ë'); 
        SET @salida = REPLACE(@salida , '√¨', 'Ï'); 
        SET @salida = REPLACE(@salida , '√≤', 'Ú'); 
        SET @salida = REPLACE(@salida , '√π', '˘'); 
        SET @salida = REPLACE(@salida , '√§', '‰'); 
        SET @salida = REPLACE(@salida , '√´', 'Î'); 
        SET @salida = REPLACE(@salida , '√Ø', 'Ô'); 
        SET @salida = REPLACE(@salida , '√∂', 'ˆ'); 
        SET @salida = REPLACE(@salida , '√º', '¸'); 
        SET @salida = REPLACE(@salida , '√Å', '¡'); 
        SET @salida = REPLACE(@salida , '√â', '…'); 
        SET @salida = REPLACE(@salida , '√ç', 'Õ'); 
        SET @salida = REPLACE(@salida , '√ì', '”'); 
        SET @salida = REPLACE(@salida , '√ö', '⁄'); 
        SET @salida = REPLACE(@salida , '√ë', '—'); 
        SET @salida = REPLACE(@salida , '√Ä', '¿'); 
        SET @salida = REPLACE(@salida , '√à', '»'); 
        SET @salida = REPLACE(@salida , '√å', 'Ã'); 
        SET @salida = REPLACE(@salida , '√í', '“'); 
        SET @salida = REPLACE(@salida , '√ô', 'Ÿ'); 
        SET @salida = REPLACE(@salida , '√ë', '—'); 
        SET @salida = REPLACE(@salida , '√Ñ', 'ƒ'); 
        SET @salida = REPLACE(@salida , '√ã', 'À'); 
        SET @salida = REPLACE(@salida , '√è', 'œ'); 
        SET @salida = REPLACE(@salida, '√ñ', '÷'); 
        SET @salida = REPLACE(@salida , '√ú', '‹'); 
    RETURN @salida; 
END

GO 

---------------------------------------------------------------------------
---------------------------------------------------------------------------

create Procedure Agregar_FotoEstudiante(
@ID_Estudiante int,
@RutaFoto nvarchar (max)
)

As Begin
Begin try

Declare @ExecString nvarchar (max)


Set @RutaFoto = (Select [dbo].[ConvertirUTFaLatin1](@RutaFoto))


SET @EXECString = 'UPDATE [dbo].[Estudiante] SET  [Foto_Estudiante] = 
(SELECT * FROM OPENROWSET(BULK N'''+(@RutaFoto)+ '''' + ', 
SINGLE_BLOB) AS photo) WHERE [ID_Estudiante] = ' + CAST(@ID_Estudiante AS 
VARCHAR(max))



-- Now execute the dynamic SQL held in @EXECString
EXEC (@EXECString);




End try

Begin catch
Raiserror('ERROR AL INSERTAR IMAGEN ESTUDIANTE',10,1)
Rollback Tran

End catch

End

Go
----------------
----------------- 

Create Procedure Agregar_Estudiante(
@No_Carne Nvarchar (10),
@Nombres Nvarchar (50),
@Apellidos Nvarchar (50),
@Sexo Nvarchar (10),
@Facultad Nvarchar (50),
@Carrera Nvarchar (50),
@DiaNacimiento int,
@MesNacimiento int,
@AnoNacimiento int
)

As
Begin

Begin try

Declare @Fecha_Nacimiento date
Set @Fecha_Nacimiento = DateFromParts(@AnoNacimiento, @MesNacimiento, @DiaNacimiento)

If not exists (Select [No_Carne_Estudiante] from [dbo].[Estudiante] where [No_Carne_Estudiante] = @No_Carne)
Begin

Insert Into [dbo].[Estudiante]
           ([No_Carne_Estudiante],
		   [Nombres_Estudiante],
		   [Apellidos_Estudiante],
		   [Fecha_Nacimiento_Estudiante],
		   [Sexo_Estudiante],
		   [Facultad_Estudiante],
		   [Carrera_Estudiante]
		   )
     Values
           (@No_Carne, @Nombres, @Apellidos, @Fecha_Nacimiento, @Sexo, @Facultad, @Carrera)


End

Else
Begin

Print 'ESTUDIANTE YA REGISTRADO EN LA BASE DE DATOS'

End

End try

Begin catch
Raiserror('ERROR AL INSERTAR ESTUDIANTE',10,1)
Rollback Tran

End catch

End

Go
--------------
--------------


Create Procedure Activar_Estudiante(@ID int)

As
Begin

Begin try

Update [dbo].[Estudiante]
Set [Estado_Estudiante] = 'Activo'
Where [ID_Estudiante] = @ID

End try

Begin catch
Raiserror('ERROR AL ACTIVAR ESTUDIANTE',10,1)
Rollback Tran
End catch

End


Go
-----------------
----------------



Create Procedure Desactivar_Estudiante(@ID int)

As
Begin

Begin try

Begin

Update [dbo].[Estudiante]
Set [Estado_Estudiante] = 'Inactivo'
Where [ID_Estudiante] = @ID

Update [dbo].[BecaAlimenticia]
Set  [Estado_Beca] = 'Inactivo'
Where [ID_Estudiante] =  @ID

End

End try

Begin catch
Raiserror('ERROR AL DESACTIVAR ESTUDIANTE',10,1)
Rollback Tran
End catch

End

Go
-----------------
----------------


Create Procedure Actualizar_Estudiante(
@ID int,
@No_Carne Nvarchar (10),
@Nombres Nvarchar (50),
@Apellidos Nvarchar (50),
@Sexo Nvarchar (10),
@Facultad Nvarchar (50),
@Carrera Nvarchar (50),
@DiaNacimiento int,
@MesNacimiento int,
@AnoNacimiento int
)

As
Begin

Begin try

Declare @Fecha_Nacimiento date
Set @Fecha_Nacimiento = DateFromParts(@AnoNacimiento, @MesNacimiento, @DiaNacimiento)

If not exists (Select [No_Carne_Estudiante] from [dbo].[Estudiante] where ([No_Carne_Estudiante] = @No_Carne) and ([ID_Estudiante] != @ID))
Begin

Update [dbo].[Estudiante]
   Set [No_Carne_Estudiante] = @No_Carne,
	   [Nombres_Estudiante] = @Nombres,
	   [Apellidos_Estudiante] = @Apellidos,
	   [Sexo_Estudiante] = @Sexo,
	   [Fecha_Nacimiento_Estudiante] = @Fecha_Nacimiento,
	   [Facultad_Estudiante] = @Facultad,
	   [Carrera_Estudiante] = @Carrera
 Where([ID_Estudiante] = @ID)

End

Else
Begin

Print 'CARNET YA REGISTRADO EN LA BASE DE DATOS'

End

End try

Begin catch
Raiserror('ERROR AL ACTUALIZAR ESTUDIANTE',10,1)
Rollback Tran
End catch

End

Go
-----------------
-----------------

create Procedure Agregar_FotoUsuario(
@ID_Usuarios int,
@RutaFoto nvarchar (max)
)

As Begin
Begin try

Declare @ExecString nvarchar (max)


Set @RutaFoto = (Select [dbo].[ConvertirUTFaLatin1](@RutaFoto))


SET @EXECString = 'UPDATE [dbo].[Usuarios] SET [Foto_Usuario] = 
(SELECT * FROM OPENROWSET(BULK N'''+(@RutaFoto)+ '''' + ', 
SINGLE_BLOB) AS photo) WHERE [ID_Usuarios] = ' + CAST(@ID_Usuarios AS 
VARCHAR(max))



-- Now execute the dynamic SQL held in @EXECString
EXEC (@EXECString);



End try

Begin catch
Raiserror('ERROR AL INSERTAR IMAGEN USUARIO',10,1)
Rollback Tran

End catch

End

Go
----------------
----------------- 

Create Procedure Agregar_Usuario(
@Nombres Nvarchar (50),
@Apellidos Nvarchar (50),
@Cedula Nvarchar (16),
@Puesto Nvarchar (50),
@Recinto Nvarchar (50),
@Privilegio Nvarchar (15),
@NombreLogin Nvarchar (50)
)

As
Begin

Begin try


If not exists (Select [No_Cedula_Usuario] from [dbo].[Usuarios] where ([No_Cedula_Usuario] = @Cedula) )
Begin

Insert Into [dbo].[Usuarios]
           ([Nombres_Usuario],
		   [Apellidos_Usuario],
		   [No_Cedula_Usuario],
		   [Puesto_Usuario],
		   [Recinto_Usuario],
		   [Privilegio_Usuario],
		   [NombreLogin]
		   )
     Values
           (@Nombres, @Apellidos, @Cedula, @Puesto, @Recinto, @Privilegio, @NombreLogin)


End

Else
Begin

Print 'CEDULA YA REGISTRADA EN LA BASE DE DATOS'

End

End try

Begin catch
Raiserror('ERROR AL INSERTAR USUARIO',10,1)
Rollback Tran

End catch

End

Go
--------------
--------------


Create Procedure Activar_Usuario(@ID int)

As
Begin

Begin try

Update [dbo].[Usuarios]
Set  [Estado_Usuario] = 'Activo'
Where [ID_Usuarios] = @ID

End try

Begin catch
Raiserror('ERROR AL ACTIVAR USUARIO',10,1)
Rollback Tran
End catch

End


Go
-----------------
----------------


Create Procedure Desactivar_Usuario(@ID int)

As
Begin

Begin try

Begin


Update [dbo].[Usuarios]
Set  [Estado_Usuario] = 'Inactivo'
Where [ID_Usuarios] = @ID


End

End try

Begin catch
Raiserror('ERROR AL DESACTIVAR USUARIO',10,1)
Rollback Tran
End catch

End

Go
-----------------
----------------


Create Procedure Actualizar_Usuario(
@ID int,
@Nombres Nvarchar (50),
@Apellidos Nvarchar (50),
@Cedula Nvarchar (16),
@Puesto Nvarchar (50),
@Recinto Nvarchar (50),
@Privilegio Nvarchar (15),
@NombreLogin Nvarchar (50)
)

As
Begin

Begin try

If not exists (Select [No_Cedula_Usuario] from [dbo].[Usuarios] where ([No_Cedula_Usuario] = @Cedula) and ([ID_Usuarios] != @ID))
Begin

Update [dbo].[Usuarios]
       Set [Nombres_Usuario] = @Nombres,
		   [Apellidos_Usuario] = @Apellidos,
		   [No_Cedula_Usuario] = @Cedula,
		   [Puesto_Usuario] = @Puesto,
		   [Recinto_Usuario] = @Recinto,
		   [Privilegio_Usuario] = @Privilegio,
		   [NombreLogin] = @NombreLogin
		  
		   where ([ID_Usuarios] = @ID)


End

Else
Begin

Print 'CEDULA YA REGISTRADA EN LA BASE DE DATOS'

End




End try

Begin catch
Raiserror('ERROR AL ACTUALIZAR ESTUDIANTE',10,1)
Rollback Tran
End catch

End

Go
-----------------
-----------------

Create Procedure IngresarBeca_Estudiante(@ID int)

As
Begin

Begin try

If not exists (Select [ID_Estudiante] From [dbo].[BecaAlimenticia] Where [ID_Estudiante] = @ID)
Begin

Insert Into [dbo].[BecaAlimenticia]
([ID_Estudiante],
 [Estado_Beca]
)
Values (@ID, 'Activo')

End

Else

Begin
Print 'ESTUDIANTE YA REGISTRADO EN BECA ALIMENTICIA'
End

End try

Begin catch
Raiserror('ERROR AL REGISTRAR ESTUDIANTE A BECA ALIMENTICIA',10,1)
Rollback Tran
End catch

End


Go
-----------------
----------------


Create Procedure ActivarBeca_Estudiante(@ID int)

As
Begin

Begin try

Update [dbo].[BecaAlimenticia]
Set [Estado_Beca] = 'Activo'
Where [ID_BecaAlimenticia] = @ID

Declare @ID_Estudiante int
Set @ID_Estudiante = (Select [ID_Estudiante] from [BecaAlimenticia] where [ID_BecaAlimenticia] = @ID )

Update [dbo].[Estudiante]
Set  [Becado] = 'Si'
Where ID_Estudiante = @ID_Estudiante

End try

Begin catch
Raiserror('ERROR AL ACTIVAR BECA ESTUDIANTE',10,1)
Rollback Tran
End catch

End


Go
-----------------
----------------




Create Procedure DesactivarBeca_Estudiante(@ID int)

As
Begin

Begin try

Begin

Update [dbo].[BecaAlimenticia]
Set [Estado_Beca] = 'Inactivo'
Where [ID_BecaAlimenticia] = @ID

Declare @ID_Estudiante int
Set @ID_Estudiante = (Select [ID_Estudiante] from [BecaAlimenticia] where [ID_BecaAlimenticia] = @ID )

Update [dbo].[Estudiante]
Set  [Becado] = 'No'
Where ID_Estudiante = @ID_Estudiante

End

End try

Begin catch
Raiserror('ERROR AL DESACTIVAR BECA ESTUDIANTE',10,1)
Rollback Tran
End catch

End

Go
-----------------
----------------

create Procedure Agregar_FotoTrabajador(
@ID_Trabajador int,
@RutaFoto nvarchar (max)
)

As Begin
Begin try

Declare @ExecString nvarchar (max)


Set @RutaFoto = (Select [dbo].[ConvertirUTFaLatin1](@RutaFoto))

SET @EXECString = 'UPDATE [dbo].[Trabajador] SET [Foto_Trabajador]  = 
(SELECT * FROM OPENROWSET(BULK N'''+(@RutaFoto)+ '''' + ', 
SINGLE_BLOB) AS photo) WHERE [ID_Trabajador] = ' + CAST(@ID_Trabajador AS 
VARCHAR(max))



-- Now execute the dynamic SQL held in @EXECString
EXEC (@EXECString);



End try

Begin catch
Raiserror('ERROR AL INSERTAR IMAGEN TRABAJADOR',10,1)
Rollback Tran

End catch

End

Go
----------------
----------------- 

Create Procedure Agregar_Trabajador(
@No_Carne Nvarchar (10),
@Nombres Nvarchar (50),
@Apellidos Nvarchar (50),
@Cedula Nvarchar (16),
@Sexo Nvarchar (10),
@Puesto Nvarchar (50)
)

As
Begin

Begin try


If not exists (Select [No_Carne_Trabajador] from [dbo].[Trabajador] where [No_Carne_Trabajador]= @No_Carne)
If not exists (Select [No_Cedula_Trabajador] from [dbo].[Trabajador] where [No_Cedula_Trabajador]= @Cedula)
Begin
Begin


Insert Into [dbo].[Trabajador]
           ([No_Carne_Trabajador],
		   [Nombres_Trabajador],
		   [Apellidos_Trabajador],
		   [No_Cedula_Trabajador],
		   [Sexo_Trabajador],
		   [Puesto_Trabajador]
		   )
     Values
           (@No_Carne, @Nombres, @Apellidos, @Cedula, @Sexo, @Puesto)


End
End

Else
Begin

Print 'TRABAJADOR YA REGISTRADO EN LA BASE DE DATOS'

End



End try

Begin catch
Raiserror('ERROR AL INSERTAR TRABAJADOR',10,1)
Rollback Tran

End catch

End

Go
--------------
--------------


Create Procedure Activar_Trabajador(@ID int)

As
Begin

Begin try

Update [dbo].[Trabajador]
Set [Estado_Trabajador] = 'Activo'
Where [ID_Trabajador] = @ID

End try

Begin catch
Raiserror('ERROR AL ACTIVAR TRABAJADOR',10,1)
Rollback Tran
End catch

End


Go
-----------------
----------------


Create Procedure Desactivar_Trabajador(@ID int)

As
Begin

Begin try

Begin

Update [dbo].[Trabajador]
Set [Estado_Trabajador] = 'Inactivo'
Where [ID_Trabajador] = @ID

Update [dbo].[PlanAlimenticio]
Set  [Estado_Plan] = 'Inactivo'
Where [ID_Trabajador] =  @ID

End

End try

Begin catch
Raiserror('ERROR AL DESACTIVAR TRABAJADOR',10,1)
Rollback Tran
End catch

End

Go
-----------------
----------------


Create Procedure Actualizar_Trabajador(
@ID int,
@No_Carne Nvarchar (10),
@Nombres Nvarchar (50),
@Apellidos Nvarchar (50),
@Cedula Nvarchar (16),
@Sexo Nvarchar (10),
@Puesto Nvarchar (50)
)

As
Begin

Begin try

If not exists (Select [No_Carne_Trabajador] from [dbo].[Trabajador] where ([No_Carne_Trabajador]= @No_Carne) and ([ID_Trabajador]!=@ID) )
If not exists (Select [No_Cedula_Trabajador] from [dbo].[Trabajador] where [No_Cedula_Trabajador]= @Cedula  and ([ID_Trabajador]!=@ID ))
Begin
Begin

Update [dbo].[Trabajador]
   Set [No_Carne_Trabajador] = @No_Carne,
	   [Nombres_Trabajador] = @Nombres,
       [Apellidos_Trabajador] = @Apellidos,
	   [No_Cedula_Trabajador] = @Cedula,
	   [Sexo_Trabajador] = @Sexo,
	   [Puesto_Trabajador] = @Puesto
 Where([ID_Trabajador] = @ID)

 End
 End

Else
Begin

Print 'CEDULA O CARNET YA REGISTRADO EN LA BASE DE DATOS'

End


End try

Begin catch
Raiserror('ERROR AL ACTUALIZAR ESTUDIANTE',10,1)
Rollback Tran
End catch

End

Go
-----------------
-----------------

Create Procedure IngresarPlan_Trabajador(@ID int)

As
Begin

Begin try

If not exists (Select [ID_Trabajador] From [dbo].[PlanAlimenticio] Where [ID_Trabajador] = @ID)
Begin

Insert Into [dbo].[PlanAlimenticio]
([ID_Trabajador]
)
Values (@ID)

End
Else

Begin
Print 'TRABAJADOR YA REGISTRADO EN PLAN ALIMENTICIO'
End


End try

Begin catch
Raiserror('ERROR AL REGISTRAR TRABAJADOR A PLAN ALIMENTICIO ',10,1)
Rollback Tran
End catch

End


Go
-----------------
----------------


Create Procedure ActivarPlan_Trabajador(@ID int)

As
Begin

Begin try

Update [dbo].[PlanAlimenticio]
Set  [Estado_Plan] = 'Activo'
Where [ID_PlanAlimenticio] = @ID


Declare @ID_Trabajador int
Set @ID_Trabajador = (Select [ID_Trabajador] from [PlanAlimenticio] where [ID_PlanAlimenticio] = @ID )

Update [dbo].[Trabajador]
Set  [PlanAlimento] = 'Si'
Where ID_Trabajador = @ID_Trabajador

End try

Begin catch
Raiserror('ERROR AL ACTIVAR PLAN ALIMENTO A TRABAJADOR',10,1)
Rollback Tran
End catch

End


Go
-----------------
----------------


Create Procedure DesactivarPlan_Trabajador(@ID int)

As
Begin

Begin try

Begin

Update [dbo].[PlanAlimenticio]
Set  [Estado_Plan] = 'Inactivo'
Where [ID_PlanAlimenticio] = @ID

Declare @ID_Trabajador int
Set @ID_Trabajador = (Select [ID_Trabajador] from [PlanAlimenticio] where [ID_PlanAlimenticio] = @ID )

Update [dbo].[Trabajador]
Set  [PlanAlimento] = 'No'
Where ID_Trabajador = @ID_Trabajador


End

End try

Begin catch
Raiserror('ERROR AL DESACTIVAR PLAN ALIMENTO A TRABAJADOR',10,1)
Rollback Tran
End catch

End

Go
-----------------
----------------



Create Procedure ContadorEstudiante(
@ID_BecaAlimenticia int,
@DiaA int,
@MesA int,
@AnoA int
)

As
Begin

Begin try

Declare @FechaActual date
Set @FechaActual = DateFromParts(@AnoA, @MesA, @DiaA)

Declare @Estado Nvarchar (10)
Set @Estado = (Select [Estado_Beca] from [dbo].[BecaAlimenticia] where [ID_BecaAlimenticia] = @ID_BecaAlimenticia)

If not exists (Select [ID_BecaAlimenticia] from [dbo].[RegistroComedorE] 
where ([ID_BecaAlimenticia] = @ID_BecaAlimenticia) and ([FechaContador] = @FechaActual))
Begin

If not exists (Select [ID_BecaAlimenticia] from [dbo].[ContadoresE]
where ([ID_BecaAlimenticia] = @ID_BecaAlimenticia) and ([FechaC] = @FechaActual))
Begin

If  (@Estado = 'Activo')
Begin

Declare @Contador int
Set @Contador = (Select ContadorE from [dbo].[BecaAlimenticia] where [ID_BecaAlimenticia] = @ID_BecaAlimenticia)
Set @Contador = @Contador+1

Insert Into [dbo].[ContadoresE]
           ([ID_BecaAlimenticia],
		   [Contador_CorrespondienteE],
		   [FechaContadorE],
		   [FechaC] 
		   )
     Values
           (@ID_BecaAlimenticia, @Contador, GetDate(), @FechaActual)


End
End
End


End try

Begin catch
Raiserror('ERROR AL INSERTAR ESTUDIANTE A CONTADOR',10,1)
Rollback Tran

End catch

End

Go
--------------
--------------

Create Procedure ContadorTrabajador(
@ID_PlanAlimenticio int,
@Dia int,
@Mes int,
@Ano int
)

As
Begin

Begin try

Declare @FechaActual date
Set @FechaActual = DateFromParts(@Ano, @Mes, @Dia)

Declare @Estado Nvarchar (10)
Set @Estado = (Select [Estado_Plan] from [dbo].[PlanAlimenticio] where [ID_PlanAlimenticio] = @ID_PlanAlimenticio)
Begin

If not exists (Select [ID_PlanAlimenticio] from [dbo].[RegistroComedorT]
where ([ID_PlanAlimenticio] = @ID_PlanAlimenticio) and ([FechaContador] = @FechaActual))
Begin

If not exists (Select [ID_PlanAlimenticio] from [dbo].[ContadoresT]
where ([ID_PlanAlimenticio] = @ID_PlanAlimenticio) and ([FechaC] = @FechaActual))

If  (@Estado = 'Activo')
Begin


Declare @Contador int
Set @Contador = (Select ContadorT from [dbo].[PlanAlimenticio] where [ID_PlanAlimenticio] = @ID_PlanAlimenticio)
Set @Contador = @Contador+1

Insert Into [dbo].[ContadoresT]
           ([ID_PlanAlimenticio],
			[Contador_CorrespondienteT],
			[FechaContadorT],
			[FechaC] 
		   )
     Values
           (@ID_PlanAlimenticio, @Contador, GetDate(), @FechaActual)


End
End
End


End try

Begin catch
Raiserror('ERROR AL INSERTAR TRABAJADOR A CONTADOR',10,1)
Rollback Tran

End catch

End

Go
--------------
--------------


Create Procedure RegistroE(
@ID_Estudiante int,
@ID_Usuarios int,
@Comedor Nvarchar (50),
@Dia int,
@Mes int,
@Ano int
)

As
Begin

Begin try

Declare @FechaActual date, @ID_BecaAlimenticia int
Set @FechaActual = DateFromParts(@Ano, @Mes, @Dia)
Set @ID_BecaAlimenticia = (Select [ID_BecaAlimenticia] from [dbo].[BecaAlimenticia] where [ID_Estudiante] = @ID_Estudiante)

Declare @Estado Nvarchar (10)
Set @Estado = (Select [Estado_Beca] from [dbo].[BecaAlimenticia] where [ID_BecaAlimenticia] = @ID_BecaAlimenticia)

If  (@Estado = 'Inactivo')
Begin
Print 'ESTUDIANTE SIN BECA ALIMENTICIA'
End

If exists (Select [ID_BecaAlimenticia] from [dbo].[RegistroComedorE] 
where ([ID_BecaAlimenticia] = @ID_BecaAlimenticia) and ([FechaContador] = @FechaActual))
Begin
Print 'ESTUDIANTE YA REGISTRADO EL DIA DE HOY'
End


If not exists (Select [ID_BecaAlimenticia] from [dbo].[RegistroComedorE] 
where ([ID_BecaAlimenticia] = @ID_BecaAlimenticia) and ([FechaContador] = @FechaActual))

If  (@Estado = 'Activo')
Begin
Begin



Insert Into [dbo].[RegistroComedorE]
           ([ID_BecaAlimenticia],
		    [ID_Usuarios],
			[FechaHoraComedor],
			[Comedor],
			[FechaContador]
		   )
     Values
           (@ID_BecaAlimenticia, @ID_Usuarios, GetDate(), @Comedor, @FechaActual)


End
End


End try

Begin catch
Raiserror('ERROR AL INSERTAR ESTUDIANTE A REGISTRO',10,1)
Rollback Tran

End catch

End

Go
--------------
--------------



Create Procedure RegistroT(
@ID_Trabajador int,
@ID_Usuarios int,
@Comedor Nvarchar (50),
@Dia int,
@Mes int,
@Ano int
)

As
Begin

Begin try

Declare @FechaActual date, @ID_PlanAlimenticio int
Set @FechaActual = DateFromParts(@Ano, @Mes, @Dia)
Set @ID_PlanAlimenticio = (Select [ID_PlanAlimenticio] from [dbo].[PlanAlimenticio] where [ID_Trabajador] = @ID_Trabajador)


Declare @Estado Nvarchar (10)
Set @Estado = (Select [Estado_Plan] from [dbo].[PlanAlimenticio] where [ID_PlanAlimenticio] = @ID_PlanAlimenticio)

If  (@Estado = 'Inactivo')
Begin
Print 'TRABAJADOR SIN PLAN ALIMENTICIO'
End

If exists (Select [ID_PlanAlimenticio] from [dbo].[RegistroComedorT]
where ([ID_PlanAlimenticio] = @ID_PlanAlimenticio) and ([FechaContador] = @FechaActual))
Begin
Print 'TRABAJADOR YA REGISTRADO EL DIA DE HOY'
End


If not exists (Select [ID_PlanAlimenticio] from [dbo].[RegistroComedorT]
where ([ID_PlanAlimenticio] = @ID_PlanAlimenticio) and ([FechaContador] = @FechaActual))

If  (@Estado = 'Activo')
Begin
Begin



Insert Into [dbo].[RegistroComedorT]
           ([ID_PlanAlimenticio],
		    [ID_Usuarios],
			[FechaHoraComedor],
			[Comedor],
			[FechaContador]
		   )
     Values
           (@ID_PlanAlimenticio, @ID_Usuarios, GetDate(), @Comedor, @FechaActual)


End
End


End try

Begin catch
Raiserror('ERROR AL INSERTAR TRABAJADOR A REGISTRO',10,1)
Rollback Tran

End catch

End

Go
--------------
--------------

Create Procedure JustificarContadorE(@ID int)

As
Begin

Begin try

Begin

Update [dbo].[ContadoresE]
Set [Justificado] = 'Si'
Where [ID_ContadoresE] = @ID

End

End try

Begin catch
Raiserror('ERROR AL JUSTIFICAR ESTUDIANTE',10,1)
Rollback Tran
End catch

End

Go
-----------------
----------------

Create Procedure JustificarContadorT(@ID int)

As
Begin

Begin try

Begin

Update [dbo].[ContadoresT]
Set [Justificado] = 'Si'
Where [ID_ContadoresT] = @ID

End

End try

Begin catch
Raiserror('ERROR AL JUSTIFICAR ESTUDIANTE',10,1)
Rollback Tran
End catch

End

Go
-----------------
----------------


Create Procedure ReiniciarContadores(@Semana int, @Anio int)

As
Begin

Begin try


Declare @UltimaSemana int, @Ano int
Set @UltimaSemana = (Select MAX (Semana) from [dbo].[Semanas] where [Anio] = @Anio)
Set @Ano = (Select MAX (Anio) from [dbo].[Semanas])


If(@UltimaSemana<@Semana)
Begin

Declare @ID_Beca int
Set @ID_Beca  = 0

While (@ID_Beca  <= (Select Max(ID_BecaAlimenticia) from BecaAlimenticia))
Begin

Set @ID_Beca  = @ID_Beca+1;

If((Select Estado_Beca from BecaAlimenticia where ID_BecaAlimenticia = @ID_Beca ) = 'Activo')
Begin

Update BecaAlimenticia
set ContadorE = 0
where ID_BecaAlimenticia = @ID_Beca 

End


End


Declare @ID_Plan int
Set @ID_Plan  = 0

While (@ID_Plan <= (Select Max(ID_PlanAlimenticio) from PlanAlimenticio))
Begin

Set @ID_Plan = @ID_Plan+1;

If((Select Estado_Plan from PlanAlimenticio where ID_PlanAlimenticio = @ID_Plan ) = 'Activo')
Begin

Update [dbo].[PlanAlimenticio]
Set [ContadorT] = 0
where ID_PlanAlimenticio= @ID_Plan

End


End



End

If(@Ano<@Anio)
Begin

Declare @ID_Beca1 int
Set @ID_Beca1  = 0

While (@ID_Beca1  <= (Select Max(ID_BecaAlimenticia) from BecaAlimenticia))
Begin

Set @ID_Beca1  = @ID_Beca1+1;

If((Select Estado_Beca from BecaAlimenticia where ID_BecaAlimenticia = @ID_Beca1 ) = 'Activo')
Begin

Update BecaAlimenticia
set ContadorE = 0
where ID_BecaAlimenticia = @ID_Beca1 

End


End


Declare @ID_Plan1 int
Set @ID_Plan1  = 0

While (@ID_Plan1 <= (Select Max(ID_PlanAlimenticio) from PlanAlimenticio))
Begin

Set @ID_Plan1 = @ID_Plan1+1;

If((Select Estado_Plan from PlanAlimenticio where ID_PlanAlimenticio = @ID_Plan1 ) = 'Activo')
Begin

Update [dbo].[PlanAlimenticio]
Set [ContadorT] = 0
where ID_PlanAlimenticio= @ID_Plan1

End


End




End

End try

Begin catch
Raiserror('ERROR AL REINICIAR CONTADOR',10,1)
Rollback Tran
End catch

End

Go
-----------------
----------------
Create Procedure Agregar_Semana(@Semana int, @Anio int)

As
Begin

Begin try

Declare @AnioActual int, @SemanaActual int
Set @AnioActual = (Select Max(Anio) from [dbo].[Semanas])
Set @SemanaActual = (Select Max(Semana) from [dbo].[Semanas] where [Anio] = @Anio)

If(@SemanaActual<@Semana)
If(@Anio = @AnioActual)
Begin
Begin

Insert Into [dbo].[Semanas]
([Semana],
 [Anio]
 ) Values (@Semana, @Anio)

End
End

If(@Anio > @AnioActual)
Begin

Insert Into [dbo].[Semanas]
([Semana],
 [Anio]
 ) Values (@Semana, @Anio)

End

End try

Begin catch
Raiserror('ERROR AL INGRESAR SEMANA',10,1)
Rollback Tran
End catch

End


Go
-----------------
----------------
 
Create Procedure Privilegios(
@ID int,
@Privilegio Nvarchar (15)
)

As
Begin

Begin try


Update [dbo].[Usuarios]
   Set [Privilegio_Usuario] = @Privilegio
 Where([ID_Usuarios] = @ID)




End try

Begin catch
Raiserror('ERROR AL CAMBIAR PRIVILEGIO',10,1)
Rollback Tran
End catch

End

Go
-----------------
-----------------




---------------------------------------------------------------------------
---------------------------------------------------------------------------




Create Trigger BecaActiva
On [dbo].[BecaAlimenticia]
For Insert
As

Begin

Update [dbo].[Estudiante]
Set  [Becado] = 'Si'
From  Inserted 
Where [dbo].[Estudiante].ID_Estudiante = Inserted.ID_Estudiante


End

Go
-----------------
-----------------

Create Trigger PlanActivo
On [dbo].[PlanAlimenticio]
For Insert
As

Begin

Update [dbo].[Trabajador]
Set  [PlanAlimento] = 'Si'
From  Inserted 
Where [dbo].[Trabajador].ID_Trabajador = Inserted.ID_Trabajador


End

Go
-----------------
-----------------

/*
Create Trigger BecaInactiva
On [dbo].[BecaAlimenticia]
For Update
As

Begin

Declare @Estado Nvarchar (10)
Set @Estado = (Select [Estado_Beca] from Inserted)

If(@Estado = 'Inactivo')
Begin
Update [dbo].[Estudiante]
Set  [Becado] = 'No'
From  Inserted 
Where [dbo].[Estudiante].ID_Estudiante = Inserted.ID_Estudiante
End



End

Go*/
-----------------
-----------------
/*
Create Trigger PlanInactivo
On [dbo].[PlanAlimenticio]
For Insert
As

Begin

Declare @Estado Nvarchar (10)
Set @Estado = (Select [Estado_Plan] from inserted)

If(@Estado = 'Inactivo')
Begin

Update [dbo].[Trabajador]
Set  [PlanAlimento] = 'No'
From  Inserted 
Where [dbo].[Trabajador].ID_Trabajador = Inserted.ID_Trabajador

End

End

Go*/
-----------------
-----------------

/*
Create Trigger PlanActivoDirecto
On [dbo].[PlanAlimenticio]
After Update
As

Begin

Declare @Estado Nvarchar (10), @ID int
Set @ID = (Select ID_PlanAlimenticio from inserted)
Set @Estado = (Select [Estado_Plan] from [dbo].[PlanAlimenticio] where [ID_PlanAlimenticio] = @ID)

If(@Estado = 'Activo')
Begin

Update [dbo].[Trabajador]
Set  [PlanAlimento] = 'Si'
From  Inserted 
Where [dbo].[Trabajador].ID_Trabajador = Inserted.ID_Trabajador

End

Else

Begin

Update [dbo].[Trabajador]
Set  [PlanAlimento] = 'No'
From  Inserted 
Where [dbo].[Trabajador].ID_Trabajador = Inserted.ID_Trabajador

End

End

Go */
-----------------
-----------------
/*
Create Trigger BecaActivaDirecta
On [dbo].[BecaAlimenticia]
After Update
As

Begin

Declare @Estado Nvarchar (10), @ID int
Set @ID = (Select ID_BecaAlimenticia from inserted)
Set @Estado = (Select [Estado_Beca] from [dbo].[BecaAlimenticia] where [ID_BecaAlimenticia] = @ID)

If(@Estado = 'Activo')
Begin

Update [dbo].[Estudiante]
Set  [Becado] = 'Si'
From  Inserted 
Where [dbo].[Estudiante].ID_Estudiante = Inserted.ID_Estudiante

End

Else

Begin

Update [dbo].[Estudiante]
Set  [Becado] = 'No'
From  Inserted 
Where [dbo].[Estudiante].ID_Estudiante = Inserted.ID_Estudiante

End

End

Go */
-----------------
-----------------

Create Trigger DesactivarBeca_Contador
On [dbo].[BecaAlimenticia]
For Update
As

Begin

Declare @Estado Nvarchar (10), @Contador int
Set @Estado = (Select [Estado_Beca] from Inserted)

Set @Contador = (Select [ContadorE] from Inserted)

If(@Estado = 'Activo')
If(@Contador >= 3 )
Begin
Begin

Update [dbo].[BecaAlimenticia]
Set  [Estado_Beca] = 'Inactivo'
From  Inserted 
Where [dbo].[BecaAlimenticia].ID_BecaAlimenticia = Inserted.ID_BecaAlimenticia

Update [dbo].[Estudiante]
Set  [Becado] = 'No'
From  Inserted 
Where [dbo].[Estudiante].ID_Estudiante = Inserted.ID_Estudiante

End

End

End

Go
-----------------
-----------------

Create Trigger DesactivarPlan_Contador
On [dbo].[PlanAlimenticio]
For Update
As

Begin

Declare @Estado Nvarchar (10), @Contador int
Set @Estado = (Select [Estado_Plan] from inserted)

Set @Contador = (Select [ContadorT] from Inserted)

If(@Estado = 'Activo')
If(@Contador >= 3 )
Begin
Begin

Update [dbo].[PlanAlimenticio]
Set  [Estado_Plan] = 'Inactivo'
From  Inserted 
Where [dbo].[PlanAlimenticio].ID_PlanAlimenticio = Inserted.ID_PlanAlimenticio

Update [dbo].[Trabajador]
Set  [PlanAlimento] = 'No'
From  Inserted 
Where [dbo].[Trabajador].ID_Trabajador = Inserted.ID_Trabajador

End
End

End

Go
-----------------
-----------------

Create Trigger JustificarE
On [dbo].[ContadoresE]
For Update
As

Begin

Declare @Justificado Nvarchar (2)
Set @Justificado = (Select [Justificado] from inserted)

If(@Justificado = 'Si' )
Begin

Update [dbo].[BecaAlimenticia]
Set  [ContadorE] = [ContadorE]-1
From  Inserted 
Where [dbo].[BecaAlimenticia].ID_BecaAlimenticia = Inserted.ID_BecaAlimenticia

End

End

Go
-----------------
-----------------

Create Trigger JustificarT
On [dbo].[ContadoresT]
For Update
As

Begin

Declare @Justificado Nvarchar (2)
Set @Justificado = (Select [Justificado] from inserted)

If(@Justificado = 'Si' )
Begin

Update [dbo].[PlanAlimenticio]
Set  [ContadorT] = [ContadorT]-1
From  Inserted 
Where [dbo].[PlanAlimenticio].ID_PlanAlimenticio = Inserted.ID_PlanAlimenticio

End

End

Go
-----------------
-----------------


Create Trigger ActivarBecaContador
On [dbo].[ContadoresE]
For Update
As

Begin

Declare @Estado Nvarchar (10), @Contador int, @ID_Beca int

Set @ID_Beca = (Select ID_BecaAlimenticia from inserted)
Set @Contador = (Select [ContadorE] from [dbo].[BecaAlimenticia] where ID_BecaAlimenticia = @ID_Beca)
set @Estado = (Select [Estado_Beca]  from [dbo].[BecaAlimenticia] where ID_BecaAlimenticia = @ID_Beca)

If(@Estado = 'Inactivo')
If(@Contador < 3 )
Begin
Begin

Update [dbo].[BecaAlimenticia]
Set  [Estado_Beca] = 'Activo'
From  Inserted 
Where [dbo].[BecaAlimenticia].ID_BecaAlimenticia = Inserted.ID_BecaAlimenticia



Update [dbo].[Estudiante]
Set  [Becado] = 'Si'
From  Inserted 
Where [dbo].[Estudiante].ID_Estudiante = Inserted.ID_Estudiante

End
End

End

Go
-----------------
-----------------

Create Trigger ActivarPlanContador
On [dbo].[ContadoresT]
For Update
As

Begin

Declare @Estado Nvarchar (10), @Contador int, @ID_Plan int

Set @ID_Plan = (Select ID_PlanAlimenticio from inserted)
Set @Contador = (Select [ContadorT] from [dbo].[PlanAlimenticio] where ID_PlanAlimenticio = @ID_Plan)
set @Estado = (Select [Estado_Plan]  from [dbo].[PlanAlimenticio] where ID_PlanAlimenticio = @ID_Plan)

If(@Estado = 'Inactivo')
If(@Contador < 3 )
Begin
Begin

Update [dbo].[PlanAlimenticio]
Set  [Estado_Plan] = 'Activo'
From  Inserted 
Where [dbo].[PlanAlimenticio].ID_PlanAlimenticio = Inserted.ID_PlanAlimenticio

Update [dbo].[Trabajador]
Set  [PlanAlimento] = 'Si'
From  Inserted 
Where [dbo].[Trabajador].ID_Trabajador = Inserted.ID_Trabajador

End
End

End

Go
-----------------
-----------------

Create Trigger PlanContador
On [dbo].[ContadoresT]
For insert
As

Begin

Declare @Estado Nvarchar (10), @Contador int, @ID_Plan int

Set @ID_Plan = (Select ID_PlanAlimenticio from inserted)
Set @Contador = (Select [ContadorT] from [dbo].[PlanAlimenticio] where ID_PlanAlimenticio = @ID_Plan)
set @Estado = (Select [Estado_Plan]  from [dbo].[PlanAlimenticio] where ID_PlanAlimenticio = @ID_Plan)

If(@Estado = 'Activo')
If(@Contador <= 3 )
Begin
Begin

Update [dbo].[PlanAlimenticio]
Set [ContadorT] = [ContadorT] + 1
From  Inserted 
Where [dbo].[PlanAlimenticio].ID_PlanAlimenticio = Inserted.ID_PlanAlimenticio

End
End

End

Go
-----------------
-----------------

Create Trigger BecaContador
On [dbo].[ContadoresE]
For insert
As

Begin

Declare @Estado Nvarchar (10), @Contador int, @ID_Plan int

Set @ID_Plan = (Select [ID_BecaAlimenticia] from inserted)
Set @Contador = (Select [ContadorE] from [dbo].[BecaAlimenticia] where [ID_BecaAlimenticia] = @ID_Plan)
set @Estado = (Select  [Estado_Beca] from [dbo].[BecaAlimenticia] where [ID_BecaAlimenticia] = @ID_Plan)

If(@Estado = 'Activo')
If(@Contador <= 3 )
Begin
Begin

Update [dbo].[BecaAlimenticia]
Set  [ContadorE] = [ContadorE]+1
From  Inserted 
Where [dbo].[BecaAlimenticia].ID_BecaAlimenticia= Inserted.ID_BecaAlimenticia

End
End

End

Go
-----------------
-----------------

-------------------------------------------------------
-------------------------------------------------------

Create View EstudianteV as (
Select [ID_Estudiante], [No_Carne_Estudiante], [Nombres_Estudiante], [Apellidos_Estudiante], 
[Fecha_Nacimiento_Estudiante], [Sexo_Estudiante], [Facultad_Estudiante], [Carrera_Estudiante], [Estado_Estudiante],
[Becado] from [dbo].[Estudiante])
Go

Create View TrabajadorV as (
Select [No_Carne_Trabajador],[Nombres_Trabajador],[Apellidos_Trabajador],[No_Cedula_Trabajador],[Sexo_Trabajador],
[Puesto_Trabajador], [Estado_Trabajador], [PlanAlimento]
from [dbo].[Trabajador])
Go

Create View BecaAlimenticiaV as (
Select B.ID_BecaAlimenticia , E.Nombres_Estudiante, E.Apellidos_Estudiante, E.No_Carne_Estudiante, E.Sexo_Estudiante, 
E.Facultad_Estudiante, E.Carrera_Estudiante, B.Estado_Beca, B.ContadorE
from [dbo].[BecaAlimenticia] B
Inner Join [dbo].[Estudiante] E
On B.ID_Estudiante = E.ID_Estudiante
)
Go

Create View PlanAlimenticioV as (
Select P.ID_PlanAlimenticio, T.Nombres_Trabajador, T.Apellidos_Trabajador, T.No_Carne_Trabajador, T.No_Cedula_Trabajador,
T.Sexo_Trabajador, T.Puesto_Trabajador, P.Estado_Plan, P.ContadorT
From [dbo].[PlanAlimenticio] P
Inner Join [dbo].[Trabajador] T
On P.ID_Trabajador = T.ID_Trabajador
)
Go



Create Procedure AgregarLoginSHA2_512
(
@Usuario Nvarchar(200),
@Contrasena Nvarchar(Max)
)

As
Begin

Begin Try


Declare @PassConvert varchar(max), @PassVarchar varchar(max), @HashBytes varbinary(max);
Select @PassVarchar= Convert(varchar,@Contrasena);
Select @HashBytes = HashBytes('SHA2_512', @PassVarchar);

Set @PassConvert='0x' + Cast('' as xml).value
('xs:hexBinary(sql:variable("@hashbytes"))', 'varchar(max)');
 

Declare @ContrasenaSHA2_512 Nvarchar(max)
Set @ContrasenaSHA2_512 = Convert(Nvarchar, @PassConvert)

Declare @sql nvarchar(max)


set @sql = 'Create Login ' + @Usuario + 
           ' With Password = ''' + @ContrasenaSHA2_512 + '''; ' +
           'Create User ' + @Usuario + ' From Login ' + @Usuario + ';'

Exec (@sql)

End Try

Begin Catch
Raiserror('ERROR AL AGREGAR LOGIN',10,1)
Rollback Tran
End Catch

End

Go


/*  --- Obtener Hora del Datetime Formato AM/PM ---
SELECT Right( Convert(Datetime, [FechaHoraComedor], 108),8) as Fecha From [dbo].[RegistroComedorE] 
where [ID_BecaAlimenticia] =1 
*/

Insert Into Usuarios 
Values (
'Administrador', 
'****',
'****',
'Super Administrador',
'****',
0xFFD8FFE000104A46494600010100000100010000FFFE003B43524541544F523A2067642D6A7065672076312E3020287573696E6720494A47204A50454720763632292C207175616C697479203D2039300AFFDB0043000302020302020303030304030304050805050404050A070706080C0A0C0C0B0A0B0B0D0E12100D0E110E0B0B1016101113141515150C0F171816141812141514FFDB00430103040405040509050509140D0B0D1414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414141414FFC00011080100010003012200021101031101FFC4001F0000010501010101010100000000000000000102030405060708090A0BFFC400B5100002010303020403050504040000017D01020300041105122131410613516107227114328191A1082342B1C11552D1F02433627282090A161718191A25262728292A3435363738393A434445464748494A535455565758595A636465666768696A737475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F0100030101010101010101010000000000000102030405060708090A0BFFC400B51100020102040403040705040400010277000102031104052131061241510761711322328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728292A35363738393A434445464748494A535455565758595A636465666768696A737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00FD53A28A2800A28A2800A28A2800A28A2800A28A2800A28AE6BE22FC41D23E17F84AF7C41ADCC63B3B718544C192690FDD8D077627F2E49C004D006FDDDDC1616D25C5CCD1DB5BC6373CB2B85451EA49E00AF04F885FB6B7807C1B24B6DA5BCFE2ABE4C8C69F816E0FA199B823DD0357C79F19BE3678A7E2EEB0F2EAF7525A697BB7DB68F0B910C0BFC25871BDF1FC479F4C0E079B18A803E88F17FEDDDF1035B91D744B6D3BC376E7EE18E1FB4CC3EAD27CA7FEF815E61AAFC78F88FE2372D7BE36D6B0DD52DAEDADD0FF00C063DA3F4AE10A814E89C29A00EB6D7C5BE20B994BCBAFEA92BB1C967BD9093F8EEAECBC3DE3AF14E9CC86D7C4FACDB6DE823BF95475CF4DD8C7B579A58CE01E6BA2D3AFC211CD007D0DE12FDA03C75A5EC126B0353887FCB3BF8564CFFC0861BF5AF65F0BFED270DE844D63487B76EF359BEF5FAED6C11F99AF8F34ED6D10AF35D6E99E248940F985203EE7D07C69A2F89947F67EA114D211FEA9BE493FEF93835B75F16E93E248B2A77804739CD7AB7847E2CEA16012392E3EDB6E3F82739207B375A2E07BE51581E1CF1A69DE2450B0C9E55C63981CF3F81EF5BF4C028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A002BE04FDA47E251F8ABF14F56B6171B7C1BE0A792D5769F96E6F80FDFB9F50846C1EEA71D4D7D91F193C6F27C39F85DE25F10DB857BEB3B36FB1A3FDD7BA7C47029F632BA03F5AFCC4F8BD70BF0EFE0FDBE971485EE6EDD619257397958E5E5763DCB1DC49F53401CBFF00C2469AADD4B704E0C8C580F41D854AF76A47045792E99AFB46061CFD0D74565AF997037500764D700F4A5497158D6D77E677AB6B37BF3401AD1DDECEF56A3D5761EB59D6DA75CDC0DCC5208FFBF336D157A3D3F458B06EF5D407BAC1196FD4D005C8FC426323E6ABF6FE2D6461F37EB54629BC1110DB25EEA1337F786D51F962AC2DD7804281E7EA218F7F3178FF00C76803A8D3BC725768DE7F3AEE743F1E0017327EB5E3C7FE10E6198759BD898F40F1AB01FCA9BF6EB2B4E6D75E865F41246C87F4CD007D4BA178F04451D662ACA72083820D7D23F093E20FFC26DA6DCC3336FBBB3DA1A41FC6AD9C13EFC1CFE15F9CBE10D57C41E2BD7ED744F0FD94DADEA539C470D9FCD81DD989C0551DD98803B9AFD16F829F0C1FE18F84C5B5E5C2DDEB174565BD9A3FB8180E113D5572793D49278CE0203D0A8A28A6014514500145145001451450014514500145145001451450014514500145145007837ED79A911E0FF0FE8E8DFF001FDAAACB3467A3430C6EFF00A4BE41FF00F557E6CFED6BAD6FD6342D315B88A279DD7DC9007F235F7A7ED7DAC6EF893E03D2964002699A95D3C7C1DD992D554FA8C6D6FAEEF6AFCD7FDA5B5317DF15EF23078B682287F1C163FF00A15007016F295AD6B2BF30B8249C0F4AE7A192AE4737BD007A2693ABC2E8332A0F5C9C1AF62F863F0BAF7C62897F72CFA6E96C331CDB479B3FBA03D17FDA239EC0F5AF26F811E088FC7BE37862BB41269B64BF69B943D240080A9F893CFB035F71D84691222228445002AA8C0007615E1E3F1AE8BF674F73DAC060D56FDE54D8E5ECBE01785176B5DD85D5FB75DF737327F25207E95B769F043C0F1A903C3B6AC09CFCECEDFCD8D7A4F856F23993C9900DEBD33DC574CB63031C9894FE15E1FB4AD3D79D9EDF251A6ECE08F1E4F823E06EFE1AB2FF00BE4FF8D45FF0A07C02CC58F8720049CF12CA3FF66AF6AFECFB6FF9E29FF7CD38585BFF00CF14FCA9A75BF9DFDE293A1FC8BEE3C3E5FD9DFE1F4CFB9BC3AA0E31F25DCEA3F21253EDFF0067AF015BBEF8FC3AAC7D1EEA771F91722BDC059C2BD2351F853CC48BD14569CD5BF9DFDE62BD8DFE05F71C1F8734587C0935BDDE83A741A598183816F088C363AEEC63391C1CF5CD7D3FA16B10EBFA3DA6A16E7F777118703392A7B83EE0E47E15E332C4B246CA40C115D6FC19BF65B4D4F497627ECB3096304F447CF03F1527F1AECCBEA4A9D6E493BA97E672E3E11AB49548AB38FE47A4D14515F4E7CD85145140051451400514514005145140051451400514514005145140051451401F14FED69A8237ED3BE16B1DADE62784A79B776C35DA8C7D7E5AFCE1F8E97065F8BBE2524FDDB808003E88A2BEFF00FDB66E134AFDAC3E1ADC0621EF7C3D756AE09E0AACACE31F8E6BF38FE286A0751F88FE23B820297BD938FA1C50064C52E2A749BE6EB59B1C98A9964E6803EB2FD8FED10687AFDF71BE5B98E127D9549FFD9EBE99B36E95F347EC7F27FC51DAC7FD843FF69A57D216726715F118ED71123ECF0365422745632B44EAEA4AB2F208AEF746D552FA1009DB201C835E756D2702B56CEE5A1757462AC3B8AE284F919DB3829A3D18734A0E2B1F4AD723B950927CB27F3AD60430C8E45774649EA8F3E5071D18FC8A427349455DCCD2B0568FC389FECBE3E78F9DB7368E31EEACA47E99ACC66A97C29308BE22685C81BCCA849FFAE4E7F9815549F2D583F342AAAF4A6BC99EE1451457D89F2814514500145145001451450014514500145145001451450014514500145145007C05FF00053BB1B8D23C6BF05FC51065123BBBDD3A593FBA64109419C771E6F53DBEB5F9B1E391247E32D644830FF6A727F3CD7EC7FF00C142FE19CBF11BF666D76E2CA2F3354F0D4B1EBD6C02E4E21C89BF285E53EE5457E38788EEA2D6FC653CFCAC577323E4F50182FF008D26ECAE34AEEC7A6780BF66FD4FC55A5DBEA17DA947A5C33A092388446490A9E413C803F5AD6D6BF65AD46D549D275DB4BF907FCB29E3688FE0C370FCF15EE173A80B3822B587080A8C85E30BD00AB5A7DCF4AF9296615F9EE9E9D8FA68E068F2D9AD4E3FF65ED0F53F0BE95E21B1D52DA5B4963BE002480804EC1965F5078E7BD7D07653F4E6B8EB2B8C62B7ACEE781CD79F5AA3AD3737D4F46841528282E875B6B3F4AD3826AE66D6E7A735A905CF039AE63AD33A0867C11CE0D6DE9DE2192DF0B26644F5EE2B928AE781CD594B9E3AD352717A038A968CF44B5D520BB4CA38FA7A5583267BD79C2DD1420AB107D455DB7F135CDB705848BE86BA235975396543F94EDD9EA2F0F4E0FC48F0EA679F35CFFE436AE723F18C046254643EA39153F82F568F51F8ABE1DF29B2A2493FF45B56F09A752167D57E673CA128C2775D19F4DD14515F6E7C7051451400514514005145140051451400514514005145140051451400514514011CF047750490CD1A4D0C8A51E391432B29182083D411DABF0B7F6C2F8017BFB3AFC6AD4F4558A41E1FBC26F744BA3921ED589DA9BBFBF19F90F7F943630C2BF75ABC77F6A3FD9B343FDA6FE1B4DE1ED4596C756B66371A4EAC1373D9CF8C73FDE8D87CACBDC60FDE552003F33BC25E2E1E2AD26CF51C80D24481D41E8E000C3F306BB5B0BAC639AF04B6D07C4BFB3DFC46D47C09E34B27D36E925F90B731393C2C91B7468DC6307D47383903D7F4DBF0EA0835F158AA0E85571E9D0FABC35655609F53D1965F2842DD9901AD5B3BBC639AE7BCFF003747B694754500FD3A54B697BD39AE268EF4CED6D6EF38E6B520BCE9CD71B6D7BD39AD482FFDEA2C6899D64577C75AB2B79EF5CC457DEF5652FBDE958BE63A1177C75A6B5E7BD61FDBB8EB4D6BEF7A2C3B9AD2DDFBD75BF0381BDF8B3A411C8812691BE9E532FF003615E692DF7BD7ACFECAB64DA878EF57BFC6E8ED2CBCBCFA348E31FA235756163CD8882F338F153E5A137E47D4F451457DE1F1214514500145145001451450014514500145145001451450014514500145145001451450078DFED3DF03BC1DF1CBE1E5FD8789F4A5B9BCB3B7966D3F5087E5B9B4976920C6FD70481953956C0C8E011F95FE16FED2D007D86FA617B047C45799C332FA383DFDC673EC7AFEBEFC4AB9FB36857EFBB6A882424938006D35F9257001241E86BC0CD1FC28F632F5F133D4BC317AB7BA3842723953FE7F1A823B96B699A36386538AE5FC09AC7D9E49ACA56C31C3267BFF009E2BA1D73236DCA74E8FFD0D7CF9EE276372DAFF0020735A505FF4E6B86B6D47A735A706A38C7353634523B38AFF00DEAC26A1EF5C8C7A97BD584D4B3DEA6C5DCEABFB438FBD4C6D43DEB9BFED1E3EF535B51F7A2C173766D430A4E6BEACFD9034336BE04D47599170FA9DE1546FEF4510DA3FF1F3257C5CD7535ECF0DADB234D733BAC5146BD5DD8E001F526BF4A7E1FF008563F04782B45D0A3DA7EC36A913B28C07931976FC58B1FC6BD9CAE9735573EC7939955B5250EE743451457D51F34145145001451450014514500145145001451450014514500145145001451450014514C95C46849A00F29FDA0B5A4D13E1C7892F198294B19827FBE54AA8FF00BE88AFCB5B8FBE7EB5F6B7ED9BF142D2F6CD7C21A75D477172D2892FC44E1BCA0BCAC6D8E8C4E1B1D4051EA2BE33BFB528C4E2BE5B31ACA75B91743E8B0349C6973BEA67ABBC12A4D11DB2C672A7D7DABBDD23578F59B0DDC7236C919EC6B83E9525A5E4DA65CFDA2DCFCDFC487A38AF28EF376F449A5DC946FB87946F515243AA74E6ACC17F65E27B43113B261CEC3F794FB5605FD85C69736D7E54FDD71D0D1B8EED1D1C5A98E39AB09A9FFB55C72DDBAD4AB7EC3D69587CC75FFDA7EF4D7D4C7F7AB94FED13EF56744B3D4FC59AED8E89A45B3DEEA77D2AC10411F5663FC80EA4F4001269A4DE8839BB9F48FEC73E0093C7BF13BFB76E622FA4F87809CB30F95EE4E444A3FDDC17F6DAB9EB5F7F5705F047E1559FC1CF877A7787ADD966BA51E75F5D28FF008F8B86037BFD380A3FD955AEF3A57D860E87B0A493DDEE7CBE2AB7B6A8E4B6E82D14515DC72051451400514514005145140051451400514514005145140051451400515C0FC5EF8EBE08F819A1FF0069F8CB5EB7D2D5C1305A03BEE6E48ED1443E66FAE3033C915F127C40FDB5BE2A7C746B8B2F85BA4BF81BC2CD943AE5EAABDFCABDCA9E523E3FBBB883D1C53B01F66FC66FDA3FE1EFC03D37ED3E31F10DBD95CBA6F834C87F7B7971E9B215F9B04F1B8E147722BF33BF688FF8295F8F7E2A35DE91E0D0FE05F0D392A24B693FE2633A7FB730FF00579EB88F04723730AF3AF1BF812C74FBDB99751D4AE7C43E26B86F32E2F2F6569599CF567624927EA49AF14D7B489B4FD52589D704E1863BE68608EA7E157C4293C33E2375D4677934FD424FF49925624A393C4A49F73CFA83EC2BE88D4AC830C8C10790457C7C2D1CD7D0BF04FC68DAE68FFD837F26EBEB24FDC3B1E658476FAAF4FA63D0D7CDE69857FC787CCFA1CBB10BF813F91B3756C6363C556AE9AFEC3AF15893D99435E0C6573D59D37165068C860E8C63907465ABE9E24BB487C9BA55B88F18CB8CFEB5079273D0D3D2DC9AA33D489AE6195B318280FF000939A42EA3B8AB71E8F1CC794C7B8E2BCB3C63E2FBEF0FF8E6EB4A49512CA331A82EA095DD1AB673F56ADE85296227C90DCCEB4E3463CF2D8F51D1B49D47C4DAB5BE95A3D8CFA96A572DB21B6B68CBBB9F603F327A01C9AFD14FD957F65A83E0CD80D7F5F115E78CEEE3DAC54868EC233D638CF763FC4E3E838C96F9DFF648FDAEBE1DFC38820D03C53E11B5F07EA3301149E27B0479A2B939E3CFDC5A48FF0002C80927083A7E83E95AB58EBBA6DB6A1A6DE41A8585CA0921BAB5904914AA7A32B02411EE2BE8B0D80541F3D4D59E162318EAAE58688B7451457AC79C1451450014514500145145001451450014514500145145001451450021214124E00EA4D7C31FB52FFC1472CFC25A85CF837E12C70F88BC4A1CDBDC6B857CDB4B49338DB0AFFCB7901EFF00701C7DFE40F25FDBB3F6E7BBF1DEABA87C32F86BA8B47E1D898DB6AFAE5939DDA8B74682161FF2C472ACC3FD61C81F27DF6FECAFFB345B784F4EB6F137882D964D5A65DD6F6EE38B7523D3FBDEA7B74F5CB1195F0AFF0066ED6FE236B6FE39F8B1A8DE6B5AB5C9127957F3191D80E81C9E80764185038C761D27C70F8AFA5F832CFF00E11AF0CC50A5DAAEC76880DB08FF001F41FE4F67F1EFE33DBFC38D18D858959759BA52B147DA31FDE3EC3F5AF8BA4B99AFEEA5B8B891A69E562EEEE72589EA68193877B995A595DA491CEE6763924FAD731E34D24CF776D3AAE7721438F63FFD7AEB204AB3269A35055423241C8AA03CAD74573FC06B474582F344D4EDEFED098EE2070CA7F983EC4707EB5E889E17FF0063F4AB09E18FF62A5C54934F62A327169A3D134ABE83C45A4C17D08DA255F993A946EEA7E86AB5D69FC9E3354BC05653596A4B60A5562BB60A048DB5449D179E833C0C9E3A6718AEBAFF004F96CEE2482E2178268CE1A39170C0FB8AF81C661A584AAD2F87A1F6F84AF1C5D34FED7538F6B0C374A962B1E7A56DC96A3D334E8ED80ED5C5CE752A452B5B0008C8AF1DF8F9E108D359B2D5614C19E211CD81D586769FCB8FC057BC47185AADF173E1C5C2FC34D275EBA89922BFB992389597F8102ED6FC4B37E0B9EF5EA654E4F12ADB753CFCCD4638777DCF14F0BC69AF787A249941B8B70227CF7007CA7F2FD41AF47F835F1FBC77FB376ABE67876EFEDFA04926FBAD02F58B5ACBEAC9DE27C7F12F5C0DC180C572FE1EF0FBD886645E197040EF56AEED965521866BEE8F8A68FD55F805FB47F847F687F0EB5FF87EE1ADB53B60A2FF0046BA205CDA31F503EF213D1C707D88207AA57E1FE8FAB6BBF0DFC5365E26F0B6A33691AD5936E86E603DBBAB0E8CA47054E411D6BF517F653FDAB748FDA37C3F35BCF147A478C74D8D4EA1A5EFF9641C0F3E1C9C98C9E08EA848073952D2D761A7DCF7BA28A2A461451450014514500145145001451450014514500257C3BFF052DFDAAE6F865E158BE19F85AF3CAF14F886DCB6A1730BE1EC6C4E5481E8F2FCCA0F50AAC78254D7D8FE38F18E99F0F3C1BADF89F599BC8D2B47B396FAE5C75F2E352C428EEC71803B92077AFC2BFED2D7FF006A3F8F37FADEA258EA5E22D41A79002585AC1D1517FD98E30AA3FDD1EB4C0F5CFD8DFE020F12EA11F8AB55807F6659BE2DA375E25907F17D076F7FA57D95F107C6763F0F3C2777AA5D308E38130883A93D0003EB8156FC19E15B2F04F86AC748B18961B7B5882003D857C81FB54FC516F15F8BBFE11FB39B3A769ADFBC0A78797FFAC0FE64FA51B81E5FE26F14DF78D7C4175AB6A123493CEC4804E422F651EC2A1B71D2B3AD874AD3B7E954068402B6F4250DA8DB29C61DC273EFC7F5AC683B56A59B98A4475FBCA430FAD007A3A7873FD8A9D3C39FECD7A059E949776D0CE8B949503AFD08CD5A5D0BFD9A093CED3C3B8C1DBCD7D05E0EF0FE9BF16FC20B1EA76E25D5EC14432CCA71295FE0707DF1CE72320F1CD70CBA18FEED75BF0DB567F0478A6DAFC82D68DFBABA8C7F1464F3F88E08FA5673846A2E592BA2E15254E5CD1766737E22FD9F354B1919B4DBA8EE63ED1DC0D8E3F11907F4AF39F19F87351F879A0DEEB7E21B63A769364A1E7BC76568D0121464A93D4B01EB935FA2F3785AD3528239E1DB2452A87475E8C08C835F057FC15C75E8BC05F01345F0DC2C12EFC4DAB2AB2671BADEDC79AE7F090DBFE75E2D4CA70F3775747B10CD6BC559D9947F65FBFF0087FF001EBC577D61A6F8921D66F34C896E66D3228658B7216DBBB73AAEF50D8076647CCBCF233EF9FB66F84D2DBE0769F24712A0B5BF440AA000A9E54878F6CA2F02BF163E00FC68D63F67DF8B7E1EF1CE8B9927D367067B52DB56EEDDB896163CF0C848CE0E0E0F502BF73FE3CF8AF43F8C3FB27C7E2EF0E5C8BED13518ED2FEDA618C857709B58738652E558750C08EC6BD1C3E1A9E1A3CB4D1C15F1353132BD467C63E11D11750D2ED2E0283BD064FB8E0FEA2B9DF1A7879F41D50A6DC4328F3233EDDC7E07FA57A5FC11B51A8F83D38C982E248BE9D1BFF66ADFF8ABE085D57C1D71748A16E74F5370AC78CA01F38FC867EAA2BB0E33E68B98C3820D63E93AF6B7F0DBC59A778ABC337AFA76B5A74BE6C13A720F62AC3A32B024153C1048ADC9EB2EF6213232914C763F5BFF00671F8F5A47ED0FF0DACFC47A785B5D423C5BEA9A6EECB59DC80372FBA9FBCADDD48E84103D4ABF1C7F656F8E737ECE9F1A2CAFEE6768FC29AC32D8EB3113F22C65BE49F1EB131DD9EBB4B81F7ABF635583A86521948C82390454B56042D1451486145145001451450014514500145145007C23FF000569F8B8FE16F83FA0F80ACA62977E2BBD32DD053FF2E76C55CA9F4DD2B43F508C39E6BC13F608F8649069B7FE2FBA8BF7929FB3DA961D101F988FAB7FE835C57FC1493C7137C4BFDB06FB43B573341E1FB5B5D16DD54FCAD2B0F3A4E3D77CE50FFD731E82BECEF851E1183C0FF0FF0045D1EDD405B7B6456206371C724FD7AD3029FC67F1CA7C3DF87DAA6AA48F3963290A93F79CF007E6457E721BB9AF6EA5B99E432CF33992476EACC4E49FCEBE90FDB77C6E67D5B49F0CC121D9103733A83DFA28FF00D0BF215F345B374A10D2362D9BA569DB9E95936CDD2B4EDDAA846AC07A569406B2A06E95A3035007D59F0BB6EAFE03D227C72B17927FE004A7F2515D62E983D2BE5AF087C44D77C2184D3AF4ADB6EDC6DA51BE23EBC1E9F51835EC5E18FDA0F4FBC0916B564D6329E0CF6F9923FA95FBC3F0DD4127A38D3463A53D74E1E953693ADE9FAF5BF9FA7DE4379177689C1C7B11DBE86AF5023D9FE06789DAEF479344B86CCB64374249E5A227A7FC049FC88F4AFCC5FF0082D56AFACDC7C6FF000369D73692C3A0DAE82D3595C372934F24EE27C1F50238011D7A1E8457DD1E16D765F0D6BB69A84792236F9D47F121E187E5FD2A9FFC1447F6788FF692FD9C6FA4D2214B9F13F8794EB5A3BA8F9A601333400FFD348FA0EEEB1FA54B291F8215FAA3FF0004F4FEDDD5FF00604F8A30DFDE3DC6876BAD14D32DE73C40516DE69B677DA59D4E3A6EDC7825ABF2BABF6CFF00623F0D5A69DFF04D081AD5A39E4D42C356D42E18608F31679971F5558907D5690CE43F671B63FF0008EEB4AC3E44D49D471DF6267FA527ED07E301A76950F87ED9F135D812DC107958C1F957F123F25F7AB5F01264B1F0B788659582C69AA4AE4FFDB38CD73BF117C2D6DE31BB9F52B793ECFA93F5DE7292003001F4C000647A5512786CE7AD66CE7AD6B6AD6571A5DD3DBDD44D0CC9D55BF98F51EF58D3B75A651CEF88ED44F6EDC76AFD52FF00827FFC5A97E29FECEBA4C37D399F58F0E48DA25D33B659D630A6163DF989A319EE51ABF2E7501BE1615F56FF00C12A7C572597C4BF1FF854BB18AFB4C8753543D14C12F96C47A13F685CFAE07A527B0BA9FA574514548C28A28A0028A28A0028A28A0028A2B87F8E9E223E10F827F1035C56DAFA6F87EFEF14FF00B51DBC8C31EF902803F17FE1337FC2F5FDAF754F1048AD2DBEA3AE5E6B4D9E708D333A0FA02C83F0AFD323B6087D1117F415F007FC138BC37F6AF15EBFACB8E2D6DD2043EEC493FF00A0AD7DD9E2BD4134AF0DEA577236D48A07627D062819F9C3F1D7C50DE29F8B7E21BB2D948EE0DBA0CE7013E53FAE6B93B67E95953DFB5FDFDCDD3925E795A4627D5893FD6AF5B49D29A19B76CFD2B52DDFA5625B49D2B4EDE4E94C46CC0F5A1049D2B1E092AFC3274A62362192AF452563C32D5D8A5A047A4780A29ED6CAEF51824921937089248D8A918193C8FA8FCABA28FE3BEB1E199426A16F1EAD6CBC139F2E503FDE0307F11F8D4FA3E8FF00D97E0ED3E265C48F1095FD72DF37E8081F8579C78C6DF87E28123DDFC27FB40782FC57325B0D5134ABF63816BA9621627D1589DADF4073ED5F587C23F112EABE1E7D36765924B4F942B73BA26E9F5C723E98AFC60F18418958D7A97EC53F1F35BF86FF001E3C2BA4DEEB372DE16D567FECB9ECA798B4319946D89941E13127964E31C039A4CAB1F9FB5FAB7FF04B1F88EBE24FD95FE2DF80AE66CCDA20B8BA8413CADBDD5B38C2FAE248643EDBC67A8AFCA4AFABFF00E09B5F117FE10EF8F1A9E8334C22B3F16F87B50D218B7DD12888CD137D731141FF005D0D481F51687E2B4D27C3779A5C4764936A0F71311C657CB8C28FCC13F9530F89C7F7FF005AF31F11EBE34FD6AE61DD8C153FF8E8ACC3E2CFF6FF005AA158EAFE20EB835196D61183E5A9627BF3FF00EAAE1677EB566EAF1AE9BCC63CB0159D3C94C654BC7F91BE95EF9FF04CF73FF0D4D7814900F87AEF763B8F360EBF8E2BE78D467090B1CD7D6DFF0004A1F0A497FF00127E2078B0A910D8E9B0E968E7A319E5F3580FA0B75CFF00BC3D6811FA614514540C28A28A0028A28A0028A28A002BC13F6F2D5DB44FD907E285C2920BE97F66E31D2595223D7D9EBDEEBE59FF00829BDE0B6FD8BBC73114DDF699B4E88107EEE2FE07CFFE398FC6803E47FF00827368B1DB7C39D6F51DBFBDB8BE2BBB1FC2A8A07EB9AFA0BE385CFD8FE1378AA6070574F988E71CEC35E55FB0669074EF8116570719BBB89A4E3DA461FD2BD03F696B69AE7E09F8AD606DAEB65231E71C0539A067E645B49D2B56DE5E95CFDB4BD39AD4B697A5051BF6F2D69DBCBD2B02DE5E95A504DD2A84CDE825F7ABD0CB58904DD2AF4335324DA866AE87C1FA637887C49A6E9C0122E27546C765CE58FE00135C8C5356E7863C4B75E16D6ED354B2651716CDB9770C82082194FB1048FC6803EA8F11C01518000003000ED5E39E30B7C87AF53D37C5763E38D023D46CCED2C36CB0139689FBA9FE87B8AF3EF17C190F4128F9DBC6B060B1C77AF33BA9E5B1BE86E6091A19E171247221C32B039047B835EBDE36B6FF0059C5791EB0986349968F0FBFB53657D3C07FE59B95FC8D69782FC5377E08F1768BE20B072977A65E45771E3B9460D83EA0E30477048A93C6D6DE46BAEE0604A8AFFD3FA560D488FACFE21788D2EBC5B792DB4BBEDDD6268D8742A62520FEB589A7EA125FDFC10073FBC70A79EDDEB82D1AFEE6EB47B179E532482DE3404FF75542A8FC14015D9FC3D81A7D65E76E5608C91FEF1E07E99A7719E9934B542697AD3A69BAF358BA9EA896E8DF35508A7E21D44450B0CF6AFD71FD80BE13FF00C2ACFD9B3C3ED736DE46B1E20DDADDEEE5C366503C9539E462158B83D096F5AF853F623FD932F7F685F19C1E2BF12D9C917C39D267DEFE60C0D56753C409EB183F7D8761B072495FD775508A154055030001800527D843A8A28A91851451400514514005145140057C93FF00054ABC8ED7F63EF10C6F9DD71A85844981DC5C2BF3F821AFADAB91F8AFF0ABC37F1A7C05AAF83FC57622FF0046D463DB2283B648D81CA491B7F0BA90083EDCE4120807C01FB0BEBF657DF0374BD3E2B88DEEAD649449186F9949918F23E841FC6BD57E34DA1BFF00855E28B755DC65B095303BE548AF83BE357C0FF89BFB057C4917567757171E19B99C8D375E893FD1AF1072229D47092819CA9EB825491CD7BAFC37FDB3B45F895E189F48D6615D3F5C780AB46C7E494E3AA1EFEB8EBFCE819F09DB4DD2B52DE6E9CD65EAB08D3B5BBFB61C2C33BA0FA0638A96DE7E9CD051D15BCDD39AD1826F7AE7A09FDEB4609E981D0433F4E6AF433FBD60433FBD5D8AE3DE988DE8A7F7AB51CFEF58715C7BD5A8EE3DE992771E0AF1BDD783F5417109325BC8024F6E4F122FF423B1FF00135EB3AC5EDB6B5A725EDA4825B795772B0FE47D08AF9D96E7DEBA6F0978C1F4395ADE662F6131F9D7AEC3FDE1FD68021F1ADBF12715E31ADC586715EF1E308D66899D087461B9587420F7AF13F1043B65907BD26347927C41B7E2CE703FBC84FE447F5AE36BD0FC730799A216C7FAB955BF98FEB5C15A43F69BB861FF009E8EA9F99C54833D574E8FC9D3EDA3FEE44ABF9015E89E0755B1D1E49D8E1A77C8FF0074703F5CD70D6F6F2DD4F141044F34D2B08E38A352CCEC4E02803A9270315F627C10FF00827B7C56F8A56F6536B56EBF0FFC3DB57371ABC64DDBAE39296C086CF3FF002D0A7E34D033E7EBDD69A69E3B6B6479EE26711C7144A59DD89C0500724927000AFB13F661FF008270EB3E37B9B2F147C5A8E6D1742E2687C36AC52F2E8751E791CC287BA8F9CE483B0F5FB2BE01FEC79F0E7F67B8E3BAD174C3AA788B690FAFEABB65BAE46088F80B12F5E10024752D5EDF4DBEC494B46D16C3C39A4DA697A5D9C1A769B6712C36F696D188E38914602AA8E0002AED14548C28A28A0028A28A0028A28A0028A28A0028A28A00C8F15F84B45F1D787AFB41F10E976BACE8D7B1F9571657B10922917AF20F704020F504023915F9BBFB45FF00C1252EADEE6E75DF82FAB294C993FE118D5E6DAC87AE2DEE4F5ED859718C64C87A57E9CD1401FCE2FC41F03F8C3E19F8824D37C6BE1FD4BC3FAA83CC7A8DBB4664C71B9588C38FF694907D6B22D75156C722BFA3BF13F84B43F1AE932E97E21D1AC35DD365FBF67A95B25C42DF547041FCABE5AF891FF04B7F81BE3A965B9D334CD4BC157B2658BE837A4445BD7CA9848807B2051F4EB40EE7E3FDBDDA9EF5A305D0E39AFBA3C59FF0472D72D25964F0A7C4CB2BC8C9CC76FACE9AF0151E8648DDF3F5D83E95E5DACFFC12E7E3E68848B5B7F0EEB8077B0D57683FF7F923A0773E7786E7DEAEC571EF5EA371FB03FED17A63012FC389E404901ADF54B19738EFF2CE48FC714E8FF622FDA0C0E7E1ADFF00FE065AFF00F1DA62B9E6F1DC7BD584BB03B8AF49B6FD86FF00687BC93CB8BE1BDDAB119FDEEA3671AFE6D3015D1691FF0004EAFDA0F510BF68F0D69DA56464FDAF58B76C738C1F299FEB4C2E78D2DEA8FE214E3A9C69D5857D43A07FC12AFE2BDF32B6B1E2BF0B697113C8B796E2E645FA8F2917F26AF4FF000C7FC12474A89D1BC4BF12B51BF4272F1695A6C76A40C740F23CBDFBEDFC2815CF8834FF001743E4FD86E241E51FF56CC7EE93DBE95CD6B9A74F7BA80B7B6864B89E56DA9144A5998FA003926BF5A3C1DFF04E0F81DE14F29EE740BEF12DC47C89B5AD4647C9F748CA467F15AF7EF0A7C3CF0B7812010F873C39A56851ED08469D671C0580F52A013F8D1703F13FC2DFB027C6EF8BF6324361E0BB9D12D27C62FBC427EC31A8CE436D7FDE30E3AAA357D31F073FE08ABA5E8F7169A8FC45F1FDC6A33C6C1DB4DF0E5B88620476F3E50CCC3E91A9F7AFD39A2A40F17F865FB1BFC1DF84B3DB5DE83E06D39F53B721E3D4B53537B728E3F8D1E52DE5B7BA6DAF68A28A0028A28A0028A28A0028A28A0028A28A0028A28A00FFD9,
'Administrador',
'****',
'Activo')
Go

Insert Into Semanas Values (1,1)