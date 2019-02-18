/// @description Insert description here
// You can write your code in this editor
var above = y < other.y + yspeed;
var falling = yspeed > 0;

if(above and (falling or state == player.hanging)){
	//Keep player above the enemy
	if(!place_meeting(x, yprevious, o_solid)){
		y = yprevious;
	}
	
	while(!place_meeting(x, y + 1, other)){
		y++;
	}
	with(other){
		instance_destroy()
	}
	//Bounce
	yspeed = -(16/3);
	audio_play_sound(a_step,6,false);
	
}else{
	take_damage()
}
