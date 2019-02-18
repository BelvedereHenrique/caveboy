	/// @description Controll player state

#region Setup player controls 
	right = keyboard_check(vk_right);
	left = keyboard_check(vk_left);
	up = keyboard_check(vk_up);
	down = keyboard_check(vk_down);
	up_release = keyboard_check_released(vk_up);
#endregion

#region State machine
	switch(state){
		#region Moving State
			case player.moving:
				if(xspeed = 0 ){
					sprite_index = s_player_idle;
				}else{
					sprite_index = s_player_walk;
				}
				//Check if player is on the ground
				if(!place_meeting(x, y + 1, o_solid)){
					//Player is in the air
					yspeed += gravity_acceleration;
					sprite_index = s_player_jump;
					image_index = (yspeed > 0);
					
					//Control the jump height
					if(up_release and yspeed < -6){
						yspeed = -3;
					}
				}else{
					yspeed = 0;
					
					//Jump
					if(up){
						yspeed = jump_height;
						audio_play_sound(a_jump,5,false);
					}
				}
				//Change direction of sprite
				if(xspeed != 0){
					image_xscale = sign(xspeed);
				}
				//Check for moving left or right
				if(right or left){
					xspeed += (right - left) * acceleration;
					xspeed = clamp(xspeed, -max_speed, max_speed);
				}else{
					apply_friction(acceleration);
				}
				
				if(place_meeting(x,y + yspeed + 1,o_solid) and yspeed > 0){
					audio_play_sound(a_step,5,false);
				}
				
				//Move character
				move(o_solid);
				
				//Check ledge grab state
				var falling = y - yprevious > 0;
				var wasnt_wall = !position_meeting(x + grab_width * image_xscale, yprevious, o_solid);
				var is_wall = position_meeting(x + grab_width * image_xscale, y, o_solid);
				
				if(falling and wasnt_wall and is_wall){
					xspeed = 0;
					yspeed = 0;
					
					//Move against the ledge
					
					while(!place_meeting(x + image_xscale, y, o_solid)){
						x += image_xscale;
					}
					
					//Check vertical position
					while(position_meeting(x + grab_width * image_xscale, y - 1, o_solid)){
						y -= 1; 	
					}
					
					//Change sprite and state
					sprite_index = s_player_ledge_grab;
					state = player.hanging;
					audio_play_sound(a_step, 5, false);
				}
			break;
		#endregion
		#region Hanging State
			case player.hanging:
				if(down){
					state = player.moving;
				}
				if(up){
					state = player.moving;
					yspeed = jump_height;
				}
			break;
		#endregion
		#region Hurt State
			case player.hurt:
			sprite_index = s_player_hurt;
			//Change directin as player bounce off
			if(xspeed != 0){
				image_xscale = sign(xspeed)
			}
			if(!place_meeting(x,y+1,o_solid)){
				yspeed += gravity_acceleration;
			}else{
				yspeed = 0;
				apply_friction(acceleration);
			}
			direction_move_bounce(o_solid);
			
			//Check health
			if(o_player_stats.hp <= 0){
				state = player.death;
					
			}else if(xspeed == 0 and yspeed = 0){
					state = player.moving;
					image_blend = c_white;
			}
			
			break;
		#endregion
		#region Door State	
			case player.door:
			sprite_index = s_player_exit;
				if(image_alpha > 0){
					image_alpha -= 0.1;
				}else {
					room_goto_next();
				}
			break;
		#endregion
		#region Death state
			case player.death:
			with(o_player_stats){
				hp = max_hp;
				sapphires = 0;
			}
			room_restart();
			break;
		#endregion
	}
#endregion