@echo OFF
setlocal

set DIR .\builds

color 0a

:start
echo Welcome to Patrol Operations 4 Builder&echo,
echo To begin, we need some information regarding the options to create with&echo,
Pause
echo Lets go&echo,

set /P "Name=Mission Name:"
set /P "World=World ID:"
set /P "FactionBlu=Blufor Faction ID:"
set /P "FactionOpf=Opfor Faction ID:"
set /P "FactionCiv=Civilian Faction ID:"

:init
set Name = %Name%
set Name=%Name:,=comma%
set Name=%Name:;=semicolon%
set Name=%Name::=fullcolon%
set Name=%Name:;=SEMICOLON%
set Name=%Name:,=COMMA%
set Name=%Name: =%

echo Creating %Name% on %World%!

mkdir .\builds\patrolops_4_%Name%.%World%
 
Pause&Exit
