
getPlayerInput();

playerMovementDirection = inputRightKey - inputLeftKey;

if (playerMovementDirection != 0) 
{
	playerSpriteFacing = playerMovementDirection;
}


/*****************************************
**
** Player collision X 
**
*****************************************/

playerSpeedX = playerMovementDirection * playerMovementSpeed;

if (place_meeting(x + playerSpeedX, y, oGround)) 
{
	if (snapToColliders) 
	{
		snapToColliderOnX(playerSpeedX, oGround);
	}
	playerSpeedX = 0;
}


// Move the player along x
x += playerSpeedX;


/** Player movment Y **/
playerSpeedY += gravitySpeed;

// If player is on the ground and reset the jumps
if (playerOnGround) 
{
	playerJumps = 0;	
}

// Record platform we want to drop down through
if (inputJumpKeyPressed && inputDownKey && jumpThroughPlatformInstance != noone) 
{
	activeJumpThroughPlatformInstance = jumpThroughPlatformInstance
}

// Jump the player
if (inputJumpKeyPressed > 0 && playerJumps < playerMaxJumps && !inputDownKey) 
{
	playerSpeedY = playerJumpForce;
	
	setPlayerOnGround(false, true);
}

// Limit y speed to terminal velocity
if (playerSpeedY > gravityTerminalSpeed) {
	playerSpeedY = gravityTerminalSpeed;
}

/*****************************************
**
** Player collision Y 
**
*****************************************/

// Collision with the ground objects
if (place_meeting(x, y + playerSpeedY, oGround))
{
	playerSpeedY = 0;
	
	setPlayerOnGround(true);
}

// See if we are colliding with a jump through platform
jumpThroughPlatformInstance = noone;
var numberOfJumpThroughPlatforms = instance_number(oJumpThroughPlatform);

for (var i = 0; i < numberOfJumpThroughPlatforms; i++) 
{
	var localJumpThroughPlatformInstance = instance_find(oJumpThroughPlatform, i);
	
	if (
		place_meeting(x, y + playerSpeedY, localJumpThroughPlatformInstance) && 
		floor(y) <= localJumpThroughPlatformInstance.bbox_top && 
		activeJumpThroughPlatformInstance != localJumpThroughPlatformInstance
	)
	{	
		jumpThroughPlatformInstance = localJumpThroughPlatformInstance;
	}	
}

// Collide with a jump through platform
if (jumpThroughPlatformInstance != noone) 
{
	if (snapToColliders) 
	{
		snapToColliderOnY(playerSpeedY, jumpThroughPlatformInstance);
	}
	
	playerSpeedY = 0;
	
	setPlayerOnGround(true);
}

// Move the player along x
y += playerSpeedY;


// Switch the sprites
if (playerSpeedX == 0) 
{
	sprite_index = playerSpriteIdle;	
}

if (abs(playerSpeedX) > 0) 
{
	sprite_index = playerSpriteRun;		
}

if (abs(playerSpeedY) > 0) 
{
	sprite_index = playerSpriteJump;	
}

if (showDebug == true)
{
	show_debug_message("Number of jumps: " + string(playerJumps));
	show_debug_message("Number of max jumps: " + string(playerMaxJumps));
	show_debug_message("On ground: " + string(playerOnGround));
	show_debug_message("Player position X: " + string(x));
	show_debug_message("Player position Y: " + string(y));
}