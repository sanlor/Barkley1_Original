// THIS IS NOT A TRANSITION!
// DO NOT CALL THIS SCRIPT.
//
// THIS MUST BE INCLUDED WITH THE OTHER SCRIPTS FOR THEM TO WORK!

{

if (argument0 == 0)
    {
    if (!variable_global_exists('_transition_obj'))
        {
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
        }
    }
else
    {
    if (timefactor == 0) timefactor = 1;
    
    s2 = surface_create(w,h);
        
    surface_set_target(s2);
    draw_clear_alpha(c_black,0);
    screen_redraw();
    
    draw_set_blend_mode_ext(bm_inv_dest_alpha,bm_one);
    draw_set_color(c_black);
    draw_rectangle(0,0,w,h,0);
    draw_set_blend_mode(bm_normal);
    surface_reset_target();
    }

}