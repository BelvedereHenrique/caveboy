switch(state){
	#region Bat Idle
	case bat.idle:
		image_index = s_bat_idle;
		if(instance_exists(o_player)){
			var dist = point_distance(x, y, o_player.x, o_player.y);
			if(dist < sight){
				state = bat.chase
			}
		}
	break;
	#endregion
	#region Bat Chase
	case bat.chase:
		if(instance_exists(o_player)){
			var dir = point_direction(x, y, o_player.x, o_player.y);
			xspeed = lengthdir_x(max_speed, dir);
			yspeed = lengthdir_y(max_speed, dir);
			sprite_index = s_bat_fly;
			if(xspeed != 0){
				image_xscale = sign(xspeed);
			}
			move(o_solid);
		}
	break;
	#endregion
}