#pragma newdecls required
#pragma semicolon 1
#pragma tabsize 4

#include <sourcemod>
#include "gamespeed"

public Plugin myinfo =
{
	name = "Game speed",
	author = "exha",
	description = "Set general game speed.",
	version = GAMESPEED_VERSION,
	url = ""
};

static ConVar			g_hPhysTimescale;

static void				GameSpeed(const float speed)
{
	int					idx;

	idx = 1;
	SetConVarFloat(g_hPhysTimescale, speed);
	while (MaxClients >= idx)
	{
		if (IsClientInGame(idx) && !IsClientSourceTV(idx))
		{
			SetEntPropFloat(idx, Prop_Data, "m_flLaggedMovementValue", speed);
		}
		idx += 1;
	}
}

any						Native_SetGameSpeed(Handle plugin, int numParams)
{
	float				speed;

	speed = view_as<float>(GetNativeCell(1));
	if (0.0 >= speed)
	{
		ThrowNativeError(SP_ERROR_NATIVE, "Invalid speed value (%f).", speed);
	}
	GameSpeed(speed);
	return (0);
}

public void				OnPluginStart()
{
	g_hPhysTimescale = FindConVar("phys_timescale");
	if (null == g_hPhysTimescale)
	{
		SetFailState("Could not find phys_timescale cvar.");
	}
}

public APLRes			AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	RegPluginLibrary(GAMESPEED_LIBRARY_NAME);
	CreateNative("SetGameSpeed", Native_SetGameSpeed);
	return (APLRes_Success);
}