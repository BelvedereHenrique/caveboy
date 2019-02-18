/// @description Insert description here
++move_timer;
y += move_amount;

if(move_timer > move_max_timer){
	move_timer = 0;
	move_amount *= -1;
}
