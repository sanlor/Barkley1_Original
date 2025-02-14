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
draw_set_alpha(1);

tex   = surface_get_texture(s1);
tex_w = texture_get_width(tex);
tex_h = texture_get_height(tex);

for (i = 1; i > 0; i -= 0.05*timefactor)
    {
    draw_clear(c_black);
    
    draw_primitive_begin_texture(pr_trianglelist,tex);
    
    draw_vertex_texture(w/2 - w/2*i,50*(1 - i),0,0);
    draw_vertex_texture(w/2 + w/2*i,-50*(1 - i),tex_w,0);
    draw_vertex_texture(w/2 + w/2*i,h + 50*(1 - i),tex_w,tex_h);
    
    draw_vertex_texture(w/2 - w/2*i,50*(1 - i),0,0);
    draw_vertex_texture(w/2 - w/2*i,h - 50*(1 - i),0,tex_h);
    draw_vertex_texture(w/2 + w/2*i,h + 50*(1 - i),tex_w,tex_h);
    
    draw_primitive_end();
    
    screen_refresh();
    sleep(30);
    }

tex   = surface_get_texture(s2);
tex_w = texture_get_width(tex);
tex_h = texture_get_height(tex); 

for (i = 0; i < 1; i += 0.05*timefactor)
    {
    draw_clear(c_black);
    
    draw_primitive_begin_texture(pr_trianglelist,tex);
    
    draw_vertex_texture(w/2 - w/2*i,-50*(1 - i),0,0);
    draw_vertex_texture(w/2 + w/2*i,50*(1 - i),tex_w,0);
    draw_vertex_texture(w/2 + w/2*i,h - 50*(1 - i),tex_w,tex_h);
    
    draw_vertex_texture(w/2 - w/2*i,-50*(1 - i),0,0);
    draw_vertex_texture(w/2 - w/2*i,h + 50*(1 - i),0,tex_h);
    draw_vertex_texture(w/2 + w/2*i,h - 50*(1 - i),tex_w,tex_h);
    
    draw_primitive_end();
    
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