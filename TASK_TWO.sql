----create table 
IF OBJECT_ID(N'dbo.EmploysSalary', N'U') IS NULL
CREATE TABLE dbo.EmploysSalary (
    Id smallint ,
	FirstName varchar(100),
	LastName  varchar(100),
	City  varchar(100),
	Salary decimal (20,3)
    );
GO
INSERT INTO EmploysSalary (Id, FirstName ,LastName,City, Salary) 
VALUES 
    (1,'Henry','Cahil','Baghdad','2500.000'),
    (2,'Jimmy','clive','Najaf','1200.000'),
    (3,'James','cage','Najaf','3300.000'),
	(4,'Adam','jones','Baghdad','12000.000'),
	(5,'Sally','Johnson','Babil','500.000'),
	(6,'Monica','Selles','Kut','1230.000')
------create procedure -----------------
Go 
create or alter procedure [dbo].[EmployeesDetails]
as
declare 
----Varaibles for EmpCur cursor
	@FirstName varchar(100),
	@LastName varchar(100),
	@CityEmp  varchar(100),
	@Salary decimal (20,3),
----Generated values for result table 
	@SumEmpSarries decimal (20,3),
	@ConcatEmpNames varchar(300),
-----Varaible for CityCur cursor
	@City  varchar(100)
------------Cursor on cites
declare CityCur cursor for SELECT distinct city FROM EmploysSalary 
------------Curson on employees
declare EmpCur cursor for SELECT FirstName,LastName  ,City  ,Salary FROM EmploysSalary 
------------Table for results
declare @EmployeesDetailsTable table 
	(FullName  varchar(200),
	City  varchar(100),
	Salary decimal (20,3)
)

Open  CityCur
    fetch next from CityCur into @City 
    while @@FETCH_STATUS = 0
	begin
		set @SumEmpSarries =0
		set @ConcatEmpNames =''

		Open  EmpCur
			fetch next from EmpCur into @FirstName,@LastName  ,@CityEmp  ,@Salary
			while @@FETCH_STATUS = 0
			begin
				------------Concat the employees names and salaiers of the same city
				if @City = @Cityemp
				begin 
					set @SumEmpSarries = @SumEmpSarries + @Salary
					set @ConcatEmpNames =concat( @FirstName,' ', @LastName ,' , ' , @ConcatEmpNames )    
				END
				fetch next from EmpCur into @FirstName,@LastName  ,@CityEmp  ,@Salary
			END
		Close EmpCur
		------------Insert the new results
		INSERT INTO @EmployeesDetailsTable (FullName,City, Salary) VALUES (@ConcatEmpNames,@City,@SumEmpSarries)
					
		fetch next from CityCur into @City
	END
Close CityCur

select * from @EmployeesDetailsTable

DEALLOCATE EmpCur
DEALLOCATE CityCur