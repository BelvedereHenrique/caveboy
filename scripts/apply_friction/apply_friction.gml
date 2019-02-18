/// @description Apply friction(amount)
/// @param amount
var amount = argument0;

//First check if is moving
if(xspeed != 0){
	if(abs(xspeed) - amount > 0){
		xspeed -= amount * image_xscale;
	}else{
	xspeed = 0;
	}
}