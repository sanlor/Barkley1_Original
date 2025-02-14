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

for (i = 5; i < 30; i += 2*timefactor)
    {
    for (ix = 0; ix < w; ix += i)
        for (iy = 0; iy < h; iy += i)
            {
            draw_surface_part_ext(s1,ix+i/2,iy+i/2,1,1,ix,iy,i,i,c_white,1);
            }
    
    screen_refresh();
    sleep(30);
    }

for (i = 30; i > 5; i -= 2*timefactor)
    {
    for (ix = 0; ix < w; ix += i)
        for (iy = 0; iy < h; iy += i)
            {
            draw_surface_part_ext(s2,ix+i/2,iy+i/2,1,1,ix,iy,i,i,c_white,1);
            }
    
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