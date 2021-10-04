/*
    Author: RoyEightySix (https://www.roy86.com.au)
    Date: 2020-12-22
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
*/
//class CfgFunctions {
	class MPSF {
        tag = "MPSF";
        class init {
            file = "framework\functions";
            class Framework { preInit = 1; postInit = 1; };
        };
        class Camera {
            file = "framework\functions\camera";
            class camera {};
            class cameraShot {};
            class cameraUI {};
            class restrict3rdPersonCamera {};
            class typeText {};
        };
        class Common {
            file = "framework\functions\common";
            class animateUnit {};
            class checkMods {};
            class createCtrl {};
            class createDiaryNote {};
            class createMarker {};
            class createMarker3D {};
            class createMarkerLocal {};
            class destroyCtrl {};
            class getDispersionArea {};
            class getDispersionCentre {};
            class getGridPos {};
            class getHeadlessClient {};
            class getHeadlessClients {};
            class getNearbyBuildings {};
            class getNearestObject {};
            class getNearestRespawnPoint {};
            class getObjectFromNetID {};
            class getPosGrid {};
            class getRandomCodeName {};
            class getRandomOpName {};
            class getRandomString {};
            class getSquadVehicleTypes {};
            class getTurrets {};
            class getUnitRank {};
            class getUnitTrait {};
            class getVehicleRoles {};
            class intel {};
            class isAdmin {};
            class isClientType {};
            class isHeadlessClient {};
            class isHeadlessClientPresent {};
            class isNearPlayers {};
            class isUnitSpeaking {};
            class isWeaponRaised {};
            class setUnitRank {};
            class setUnitTrait {};
        };
        class Config {
            file = "framework\functions\config";
            class getCfgComposition {};
            class getCfgData {};
            class getCfgDataArray {};
            class getCfgDataBool {};
            class getCfgDataNumber {};
            class getCfgDataObject {};
            class getCfgDataText {};
            class getCfgFaction {};
            class getCfgFactionID {};
            class getCfgIconNATO {};
            class getCfgIconNATOSize {};
            class getCfgMapData {};
            class getCfgParam {};
            class getCfgRoles {};
            class getCfgSubClasses {};
            class getCfgText {};
            class getConfigLoadout {};
            class loadCfgDisplayVariables {};
        };
        class Developer {
            file = "framework\functions\developer";
            class createCfgMapData {};
            class drawMapData {};
        };
        class Environment {
            file = "framework\functions\environment";
            class setDateTime {};
            class setEnvironment {};
            class setWeather {};
        };
        class SysActions {
            file = "framework\functions\sysactions";
            class actionBodyBag {};
            class actionBodySearch {};
            class addAction {};
            class hasAction {};
            class removeAction {};
            class interaction {};
        };
        class SysEvents {
            file = "framework\functions\sysevents";
            class addEventHandler {};
            class eventHasMoved {};
            class eventOnAddAction {};
            class eventOnCreateMarker3D {};
            class eventOnEachFrame {};
            class eventOnEachFrame3DIcons {};
            class eventOnEachFrameClient {};
            class eventOnEachFrameServer {};
            class eventOnFired {};
            class eventOnFiredBaseProtection {};
            class eventOnGetIn {};
            class eventOnGetOut {};
            class eventOnHandleDamage {};
            class eventOnHandleDatamageMultiplier {};
            class eventOnHandleRating {};
            class eventOnHit {};
            class eventOnIntelCreated {};
            class eventOnIntelDownloadComplete {};
            class eventOnIntelPickup {};
            class eventOnIntelRecieve {};
            class eventOnKeyDown {};
            class eventOnKeyUp {};
            class eventOnKilled {};
            class eventOnkilledDropIntel {};
            class eventOnKilledOrange {};
            class eventOnHandcuffUnit {};
            class eventOnKilledSurrender {};
            class eventOnKilledTargets {};
            class eventOnMapClick {};
            class eventOnObjectDamagedC4 {};
            class eventOnObjectDeploy {};
            class eventOnObjectDeployed {};
            class eventOnPutItem {};
            class eventOnRemoveAction {};
            class eventOnRespawn {};
            class eventOnSeatSwitch {};
            class eventOnSmokeThrown {};
            class eventOnTakeItem {};
            class eventOnTaskAssign {};
            class eventOnTaskComplete {};
            class eventOnTaskObjectDestroyed {};
            class eventOnTaskRequestAbort {};
            class eventOnTaskUnitKilled {};
            class eventOnTaskValidate {};
            class eventOnTimeChange {};
            class eventOnTriggerIED {};
            class eventOnVehicleReturned {};
            class eventOnWeatherChange {};
            class eventSystem {};
            class isEventHandler {};
            class removeEventHandler {};
            class triggerEventHandler {};
        };
        class SysSimulation {
            file = "framework\functions\syssimulation";
            class addConversation {};
            class capture { ext = ".fsm"; };
            class conversation {};
            class setGroupAirCombat {};
            class setGroupAttack {};
            class setGroupCrowd {};
            class setGroupDefend {};
            class setGroupHold {};
            class setGroupMoveRandom {};
            class setGroupOccupy {};
            class setGroupPatrol {};
            class setGroupQRF {};
            class setGroupSIED {};
            class setGroupSurrender {};
            class simulCapture {};
            class simulCiv {};
        };
        class SysSpawner {
            file = "framework\functions\sysspawner";
            class create3DENComposition {};
            class createAgentGroup {};
            class createAgentVehicle {};
            class createAircraftCAS {};
            class createAircraftFlyby {};
            class createAmbush {};
            class createAreaDebris {};
            class createBridge {};
            class createCarrier01 {};
            class createCheckpoint {};
            class createComposition {};
            class createConvoy {};
            class createCrew {};
            class createDeployable {};
            class createGroup {};
            class createIED {};
            class createIntel {};
            class createLogic {};
            class createObject {};
            class createOccupiedArea {};
            class createParadrop {};
            class createPatrol {};
            class createQRFresponse {};
            class createSamSite {};
            class createUXOarea {};
            class createVehicle {};
            class effectExplosionSecondaries {};
            class setFactionTypeOPF {};
            class setUnitGear {};
            class setVehicleAmmo {};
            class setVehicleFuel {};
            class setVehicleHealth {};
        };
        class SysTasks {
            file = "framework\functions\systasks";
            class addCfgTask {};
            class addCfgTaskMonitor {};
            class createCfgTask {};
            class createCfgTaskCompositions {};
            class createCfgTaskDeployable {};
            class createCfgTaskGroups {};
            class createCfgTaskLogic {};
            class createCfgTaskMarkers {};
            class createCfgTaskObjective {};
            //class createCfgTaskQRF {};
            class createCfgTaskReturnPoint {};
            class getCfgTaskID {};
            class getCfgTaskModules {};
            class getCfgTaskPosition {};
            class getCfgTasks {};
            class initCfgTasks {};
            class processCfgTask {};
            class processCfgTaskArguments {};
            class removeCfgTask {};
            class removeCfgTaskMonitor {};
        };
        class Tasks {
            file = "framework\functions\tasks";
            class areTasksComplete {};
            class assignTask {};
            class createTask {};
            class getAssignedTask {};
            class getAssignedTaskPlayers {};
            class getAvailableTasks {};
            class getNearestReturnPoint {};
            class getReturnPoints {};
            class getTaskData {};
            class getTaskDescription {};
            class isNearbyTaskModule {};
            class isTaskComplete {};
            class isTaskState {};
            class removeTask {};
            class updateTaskDestination {};
            class updateTaskState {};
        };
        class UI {
            file = "framework\functions\ui";
            class 3Dmarkers { postInit = 1; };
            class briefingNotes {};
            class itemAmrelTablet {};
        };
        class Zeus {
            file = "framework\functions\zeus";
            class addZeusEditArea {};
            class addZeusObjects {};
            class initZeus {};
            class removeZeusEditArea {};
        };
    };
//};