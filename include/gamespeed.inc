#pragma newdecls required
#pragma semicolon 1
#pragma tabsize 4

#if !defined GAMESPEED_INC
	#define GAMESPEED_INC

	#define GAMESPEED_VERSION "1.0.0"
	#define GAMESPEED_LIBRARY_NAME "gamespeed"
	#define GAMESPEED_FILE_NAME "gamespeed.smx"

/**
 * Set game speed.
 * @param speed	Speed multiplier.
 */
native any				SetGameSpeed(const float speed);

public SharedPlugin		__pl_gamespeed =
{
	name = GAMESPEED_LIBRARY_NAME,
	file = GAMESPEED_FILE_NAME,
	#if defined REQUIRE_PLUGIN
	required = 1,
	#else
	required = 0,
	#endif
};

#endif