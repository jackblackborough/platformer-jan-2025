function getPlayerInput() 
{
	inputRightKey = keyboard_check(ord("D")) + 
		keyboard_check(vk_right) +
		gamepad_button_check(0, gp_padr);
		
	inputRightKey = clamp(inputRightKey, 0, 1);
	
	inputLeftKey = keyboard_check(ord("A")) + 
		keyboard_check(vk_left) +
		gamepad_button_check(0, gp_padl);
		
	inputLeftKey = clamp(inputLeftKey, 0, 1);
	
	inputDownKey = keyboard_check(ord("S")) + 
		keyboard_check(vk_down) +
		gamepad_button_check(0, gp_padd);
		
	inputDownKey = clamp(inputDownKey, 0, 1);
	
	inputJumpKeyPressed = keyboard_check_pressed(vk_space) + 
		gamepad_button_check_pressed(0, gp_face1);
	inputJumpKeyPressed = clamp(inputJumpKeyPressed, 0, 1);	
}