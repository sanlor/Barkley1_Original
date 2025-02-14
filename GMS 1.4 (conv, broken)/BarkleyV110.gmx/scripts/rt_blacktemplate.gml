{

// THIS IS A TEMPLATE FOR MAKING TO-BLACK TRANSITIONS!
//
// I don't expect anyone to understand what I'm doing here. Read the script if you want
// but I'm not going to be making a tutorial anytime soon.
//
// Basically:
//
// p_array : 2D Array of particles. Index 1: Particle | Index 2: Particle variable
// p_count : Num. of particles
// p_done  : Num. of dead particles. Used to find if all particles are dead.

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

i = 0;

for (ix = 0; ix < w; ix += 20)
    for (iy = 0; iy < h; iy += 20)
        {
        p_array[i,0] = 0; // done
        p_array[i,1] = ix; // x
        p_array[i,2] = iy; // y
        p_array[i,3] = 20; // width
        p_array[i,4] = 20; // height
        p_array[i,5] = 0; // xscale
        p_array[i,6] = 0; // yscale
        p_array[i,7] = 0;  // alpha
        
        i += 1;
        }

p_count = i;
p_done = 0;

while (p_done < p_count)
    {
    draw_surface(s1,0,0);
    
    time = current_time;
    
    // STEP + DRAW
    for (i = 0; i < p_count; i += 1)
        {
        ix = p_array[i,1] + p_array[i,3]/2*(1-p_array[i,5]);
        iy = p_array[i,2] + p_array[i,4]/2*(1-p_array[i,6]);
        
        draw_set_alpha(p_array[i,7]);
        draw_rectangle(ix,iy,ix + p_array[i,3]*(p_array[i,5]),iy + p_array[i,4]*(p_array[i,6]),0);
        
        p_array[i,7] = min(p_array[i,7] + 0.1,1);
        if (p_array[i,7] >= 1) && (!p_array[i,0]) {p_array[i,0] = 1; p_done += 1;}
        }
    
    screen_refresh();
    sleep(30/timefactor - (current_time - time));
    }

while (p_done > 0)
    {
    draw_surface(s2,0,0);
    
    time = current_time;
    
    // STEP + DRAW
    for (i = 0; i < p_count; i += 1)
        {
        if (!p_array[i,0]) continue;
        
        ix = p_array[i,1] + p_array[i,3]/2*(1-p_array[i,5]);
        iy = p_array[i,2] + p_array[i,4]/2*(1-p_array[i,6]);
        
        draw_set_alpha(p_array[i,7]);
        draw_rectangle(ix,iy,ix + p_array[i,3]*(p_array[i,5]),iy + p_array[i,4]*(p_array[i,6]),0);
        
        p_array[i,7] = max(p_array[i,7] - 0.1,0);
        if (p_array[i,7] <= 0) && (p_array[i,0] == 1) {p_array[i,0] = 0; p_done -= 1;}
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