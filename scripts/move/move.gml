/// @description move(collision_object)
/// @param collision_objecto
var collision_object = argument0;

//Horizontal Collisions
if(place_meeting(x + xspeed, y, collision_object)){
	while(!place_meeting(x + sign(xspeed),y , collision_object)){
		x+= sign(xspeed);
	}
	xspeed = 0;
}

x += xspeed;
//Vertical collisions
if(place_meeting(x, y + yspeed, collision_object)){
	while(!place_meeting(x, y + sign(yspeed), collision_object)){
		y += sign(yspeed);
	}
	yspeed = 0;
}
y += yspeed;
