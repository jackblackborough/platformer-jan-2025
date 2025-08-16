if  place_meeting(x, y, oPlayer_1)
{
	image_index += 1
	timer++
	
}

if not place_meeting(x, y, oPlayer_1)&&timer = 60
{
	image_index -= 1
	timer = 0
}