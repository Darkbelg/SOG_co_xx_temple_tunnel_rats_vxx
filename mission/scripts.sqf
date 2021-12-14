// MISSION VARAIBLES
player addRating 100000;
[player, "NoVoice"] remoteExec ["setSpeaker", -2, format["NoVoice_%1", netId player]]; // No player voice
showSubtitles false; // No radio calls
"Group" setDynamicSimulationDistance 1200;
"Vehicle" setDynamicSimulationDistance 2500;
enableEngineArtillery false; 	// Disable Artillery Computer
//onMapSingleClick "_shift";	// Disable Map Clicking
f_var_AuthorUID = '76561198016469048'; // Allows GUID to access Admin/Zeus features in MP.
//f_var_fogOverride = [[0,0,0],[0.1,0.005,100],[0.1,0.04,100],[0.1,random 0.02,100]]; // Override default fog settings [[none],[Light],[heavy],[rand]].
//[] spawn {sleep 1; tao_foldmap_isOpen = true;}; // Disable TAO Folding Map
//[] spawn {sleep 5; ZEU_tkLog_mpKilledEH = {};}; // Disable Zeus TK Spam
// ====================================================================================
// F3 - Casualty Cap - Sides: west | east | resistance - Format: [SIDE,ENDING,<PERCENT>]
[west, 2,90] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";
f_param_CasMinToStart = 5;

if (isServer) then {


	{
		civilian revealMine _x;
		east revealMine _x;	
	} forEach allMines;

	// randomSelectedTunnel = selectRandom [1,2,3,4];
	// publicVariable "randomSelectedTunnel";
	// systemChat format ["randomSelectedTunnel %1",randomSelectedTunnel];

	
	[] spawn {
		sleep 10;
		if (alive trapN) exitWith {
			_entry = tunnel_s getVariable "vn_tunnel_trapdoor";
			_entry setPosATL (getPosATL tunnel_n);
			deleteVehicle tunnel_n;
			deleteVehicle tunnel_w;
			deleteVehicle animalsS;
			deleteVehicle animalsW;

			for "_i" from 0 to 4 do {  
				deleteMarker format ["qrf_s_%1",_i];
				deleteMarker format ["qrf_w_%1",_i];
			};

			true;
		};
		if ( alive trapW ) exitWith {
			_entry = tunnel_s getVariable "vn_tunnel_trapdoor";
			_entry setPosATL (getPosATL tunnel_w);
			deleteVehicle tunnel_n;
			deleteVehicle tunnel_w;
			deleteVehicle animalsS;
			deleteVehicle animalsN;

			for "_i" from 0 to 4 do {  
				deleteMarker format ["qrf_n_%1",_i];
				deleteMarker format ["qrf_s_%1",_i];
			};

			true;
		};
		
		for "_i" from 0 to 4 do {  
			deleteMarker format ["qrf_n_%1",_i];
			deleteMarker format ["qrf_w_%1",_i];
		};

		deleteVehicle tunnel_n;
		deleteVehicle tunnel_w;
		deleteVehicle animalsN;
		deleteVehicle animalsW;
	};

playersInTunnel = false;
playersInTunnelN = false;
playersInTunnelW = false;
playersInTunnelS = false;
publicVariable "playersInTunnel";
publicVariable "playersInTunnelN";
publicVariable "playersInTunnelW";
publicVariable "playersInTunnelS";
};

// Parameters - If not set in scripts.sqf defaults will be used below.
 FAR_var_InstantDeath = 	TRUE;	// Heavy hits to head and body will instantly kill.
 FAR_var_DeathChance = 	75;		// Percent to randomly survive an instant kill (head and body).
 FAR_var_DeathDmgHead = 	5;		// Kill when damage to the head is over this value.
 FAR_var_DeathDmgBody = 	5;		// Kill when damage to the body is over this value.
 FAR_var_BleedOut = 		45;		// Seconds until unconscious unit bleeds out and dies. Set to 0 to disable.
 FAR_var_RespawnBagTime = 0;		// Time for player to respawn (if allowed). Set to 0 or less to disable.
 FAR_var_ReviveMode = 	2;		// 0 = Only medics can revive  1 = All units can revive (Uses 1 FAK)  2 = Same as 1 but a medikit is required to revive
 FAR_var_DeathMessages = 	TRUE;		// Enable Team Kill notifications
 FAR_var_SpawnInMedical = FALSE;		// Units respawn in the nearest medical vehicle (if available and respawn enabled).
 FAR_var_AICanHeal = TRUE;			// Nearest AI in team will automatically revive players.
 FAR_var_SkipSide = [sideLogic];	// Don't allow these sides to use the medical script.
