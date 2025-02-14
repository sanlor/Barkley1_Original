// THIS IS NOT A TRANSITION!
//
// If you have "Treat Unitialized variables as 0" checked under Global Game Settings
// you need to call this script before using any transitions.
//
// Only call it once at the start of the game. Example:
//
// obj_controller CREATE:
//
// rt_init();
//
// If you do not, there is no need to call this script.

global._transition_obj = object_add();
        
object_event_add(global._transition_obj,ev_create,0,
"
w  = window_get_region_width();
h  = window_get_region_height();
fx = w/display_get_width();
fy = h/display_get_height();
        
s1 = surface_create(w,h);
        
surface_set_target(s1);
draw_clear_alpha(c_black,0);
screen_redraw();

draw_set_blend_mode_ext(bm_inv_dest_alpha,bm_one);
draw_set_color(c_black);
draw_rectangle(0,0,w,h,0);
draw_set_blend_mode(bm_normal);
surface_reset_target();
");
        
object_set_persistent(global._transition_obj,1);