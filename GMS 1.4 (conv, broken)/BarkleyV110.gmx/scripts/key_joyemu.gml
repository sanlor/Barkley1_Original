if (joystick_exists(1)) {
twe=20;
fff=joystick_direction(1);
if (fff=vk_numpad6) { key_ress(right); }
else if (fff=vk_numpad9) { key_ress(right,up); }
else if (fff=vk_numpad8) { key_ress(up); }
else if (fff=vk_numpad7) { key_ress(left,up); }
else if (fff=vk_numpad4) { key_ress(left); }
else if (fff=vk_numpad1) { key_ress(left,down); }
else if (fff=vk_numpad2) { key_ress(down); }
else if (fff=vk_numpad3) { key_ress(right,down); }
else if (fff=vk_numpad5) { key_ress(); }
nb=1;
repeat (20) {
if (joystick_check_button(1,nb)) key_ress2(64+nb,1);
else key_ress2(64+nb,0);
nb+=1;
}
}