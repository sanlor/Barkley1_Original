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

draw_set_color(c_white);
draw_set_alpha(1.0);

width = 160;
steps = h/4;
freq = 6;

wi = 0;
s = 0;

for (i = 0.025; i < 1; i += 0.025*timefactor)
    {
    wi = width*i;
    s += 13.5;
    
    draw_clear(c_black);
    
    for (iii = 0; iii <= 1; iii += 1)
        {
        ss = s;
        
        if (iii == 0)
            {
            draw_set_alpha(1);
            tex  = surface_get_texture(s1);
            texw = texture_get_width(tex);
            texh = texture_get_height(tex);
            }
        else
            {
            draw_set_alpha(i-0.5);
            tex  = surface_get_texture(s2);
            texw = texture_get_width(tex);
            texh = texture_get_height(tex);
            }
        
        draw_primitive_begin_texture(pr_trianglelist,tex);
        
        for (ii = 0; ii < steps; ii += 1)
            {
            iix = sin(degtorad(ss)) * wi;
            
            draw_vertex_texture(iix,     h/steps*ii,       0,    texh/steps*ii);       // Top-left     +--+ 
            draw_vertex_texture(iix + w, h/steps*ii,       texw, texh/steps*ii);       // Top-right    | /
            draw_vertex_texture(iix,     h/steps*(ii + 1), 0,    texh/steps*(ii + 1)); // Bottom-left  +/
            
            draw_vertex_texture(iix + w, h/steps*ii,       texw, texh/steps*ii);       // Top-right       /+ 
            draw_vertex_texture(iix + w, h/steps*(ii + 1), texw, texh/steps*(ii + 1)); // Bottom-right   / |
            draw_vertex_texture(iix,     h/steps*(ii + 1), 0,    texh/steps*(ii + 1)); // Bottom-left   +--+
            
            ss += freq;
            if (ss >= 360) ss -= 360;
            }
        
        draw_primitive_end();
        }
    
    screen_refresh();
    sleep(15);
    }

for (i = 1; i > 0; i -= 0.025*timefactor)
    {
    wi = width*i;
    s += 13.5;
    
    draw_clear(c_black);
    
    for (iii = 0; iii <= 1; iii += 1)
        {
        ss = s;
        
        if (iii == 0)
            {
            draw_set_alpha(1);
            tex  = surface_get_texture(s1);
            texw = texture_get_width(tex);
            texh = texture_get_height(tex);
            }
        else
            {
            draw_set_alpha(1-i+0.5);
            tex  = surface_get_texture(s2);
            texw = texture_get_width(tex);
            texh = texture_get_height(tex);
            }
        
        draw_primitive_begin_texture(pr_trianglelist,tex);
        
        for (ii = 0; ii < steps; ii += 1)
            {
            iix = sin(degtorad(ss)) * wi;
            
            draw_vertex_texture(iix,     h/steps*ii,       0,    texh/steps*ii);       // Top-left     +--+ 
            draw_vertex_texture(iix + w, h/steps*ii,       texw, texh/steps*ii);       // Top-right    | /
            draw_vertex_texture(iix,     h/steps*(ii + 1), 0,    texh/steps*(ii + 1)); // Bottom-left  +/
            
            draw_vertex_texture(iix + w, h/steps*ii,       texw, texh/steps*ii);       // Top-right       /+ 
            draw_vertex_texture(iix + w, h/steps*(ii + 1), texw, texh/steps*(ii + 1)); // Bottom-right   / |
            draw_vertex_texture(iix,     h/steps*(ii + 1), 0,    texh/steps*(ii + 1)); // Bottom-left   +--+
            
            ss += freq;
            if (ss >= 360) ss -= 360;
            }
        
        draw_primitive_end();
        }
    
    screen_refresh();
    sleep(15);
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