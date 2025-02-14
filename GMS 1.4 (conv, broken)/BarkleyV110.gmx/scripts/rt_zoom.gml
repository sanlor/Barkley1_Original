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

draw_surface(s1,0,0);

for (i = 0; i < 1; i += 0.05*timefactor)
    {
    draw_surface_ext(s1,-w*i,-h*i,1+i*2,1+i*2,0,c_white,0.25);
    
    screen_refresh();
    sleep(30);
    }

for (i = 1; i > 0; i -= 0.05*timefactor)
    {
    draw_surface_ext(s2,-w*i,-h*i,1+i*2,1+i*2,0,c_white,0.25);
    
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