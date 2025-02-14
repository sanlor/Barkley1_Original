{

// INITIATION //////////////////////////////////////////////////////////////////////

rt_internal(0);

// TRANSITION //////////////////////////////////////////////////////////////////////

object_event_clear(global._transition_obj,ev_other,ev_room_start);
object_event_add(global._transition_obj,ev_other,ev_room_start,
"
rt_internal(1);

oc = draw_get_color();
oa = draw_get_alpha();

d3d_transform_stack_push();
d3d_transform_set_identity();
d3d_transform_set_scaling(fx,fy,1);

draw_set_color(c_black);

for (i = 1; i > 0; i -= 0.05*timefactor)
    {   
    draw_surface(s1,0,0)      
        
    for (r = 0; r < 360; r += 10)
        {
        draw_surface_ext(s1,lengthdir_x(6-i*5,r),lengthdir_y(6-i*5,r),1,1,0,c_white,0.05);
        }
        
    draw_set_alpha(1-i);
    draw_rectangle(0,0,w,h,0);
       
    screen_refresh();
    sleep(30);
    }

for (i = 0; i <= 1; i += 0.05*timefactor)
    {   
    draw_surface(s2,0,0)      
        
    for (r = 0; r < 360; r += 10)
        {
        draw_surface_ext(s2,lengthdir_x(6-i*5,r),lengthdir_y(6-i*5,r),1,1,0,c_white,0.05);
        }
        
    draw_set_alpha(1-i);
    draw_rectangle(0,0,w,h,0);
       
    screen_refresh();
    sleep(30);
    }

d3d_transform_stack_pop();

draw_set_color(oc);
draw_set_alpha(oa);

surface_free(s1);
surface_free(s2);
instance_destroy();
");

// ETC. //////////////////////////////////////////////////////////////////////

(instance_create(0,0,global._transition_obj)).timefactor = argument1;
room_goto(argument0);

}