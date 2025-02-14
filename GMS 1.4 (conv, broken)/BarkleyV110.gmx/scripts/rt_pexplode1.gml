{

// THIS IS A TEMPLATE FOR MAKING PARTICLE BASED TRANSITIONS!

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

draw_set_color(c_white);

i = 0;

for (ix = 0; ix < w; ix += 20)
    for (iy = 0; iy < h; iy += 20)
        {        
        p_array[i,0] = 20; // life
        p_array[i,1] = ix; // x
        p_array[i,2] = iy; // y
        p_array[i,3] = ix; // surface x
        p_array[i,4] = iy; // surface y
        p_array[i,5] = 20; // surface width
        p_array[i,6] = 20; // surface height
        p_array[i,7] = 1;  // xscale
        p_array[i,8] = 1;  // yscale
        p_array[i,9] = 1;  // alpha
        p_array[i,10] = random(10) + 10; // speed
        p_array[i,11] = point_direction(w/2,h/2,ix,iy); // direction
        p_array[i,12] = 0; // gravity
        p_array[i,13] = 270; // gravity direction
        p_array[i,14] = s1;  // surface id
        
        ////////////
        
        p_array[i,15] = p_array[i,0]; // stores original life
        
        i += 1;
        }

p_count = i;
p_alive = i;

while (p_alive > 0)
    {
    draw_surface(s2,0,0);
    
    time = current_time;
    
    // STEP + DRAW
    for (i = 0; i < p_count; i += 1)
        {
        if (p_array[i,0] <= 0) continue;
        
        p_array[i,0] -= 1;
        if (p_array[i,0] == 0) p_alive -= 1;
        
        draw_surface_part_ext(p_array[i,14],p_array[i,3],p_array[i,4],p_array[i,5],p_array[i,6],p_array[i,1],p_array[i,2],p_array[i,7],p_array[i,8],c_white,p_array[i,9]);
        
        speed = p_array[i,10];
        direction = p_array[i,11];
        motion_add(p_array[i,13],p_array[i,12]);
        p_array[i,10] = speed;
        p_array[i,11] = direction;
        
        p_array[i,1] += lengthdir_x(p_array[i,10],p_array[i,11]);
        p_array[i,2] += lengthdir_y(p_array[i,10],p_array[i,11]);
        
        /////////
        
        p_array[i,9] = p_array[i,0]/p_array[i,15];
        }
    
    screen_refresh();
    sleep(30/timefactor - (current_time - time));
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