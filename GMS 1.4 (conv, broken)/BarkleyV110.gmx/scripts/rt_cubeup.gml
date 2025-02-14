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

tex0 = surface_get_texture(s1);
tex1 = surface_get_texture(s2);
texw0 = texture_get_width(tex0);
texw1 = texture_get_width(tex1);
texh0 = texture_get_height(tex0);
texh1 = texture_get_height(tex1);

draw_set_color(c_white);
draw_set_alpha(1);

x1 = 0;
y1 = 0;
x2 = 0;
y2 = h;

n = 100;

for (i = 0; i < 0.5; i += 0.05*timefactor)
    {
    draw_clear(c_black);
    
    x1 = n*i;
    x2 = -x1;
    x3 = n*(1-i);
    y2 = h*(1-i);
    
    draw_set_color(make_color_rgb((1-i)*255,(1-i)*255,(1-i)*255));
    
    draw_primitive_begin_texture(pr_trianglelist,tex0);
    
    draw_vertex_texture(x1,y1,0,0);
    draw_vertex_texture(w-x1,y1,texw0,0);
    draw_vertex_texture(x2,y2,0,texh0);
    
    draw_vertex_texture(w-x1,y1,texw0,0);
    draw_vertex_texture(x2,y2,0,texh0);
    draw_vertex_texture(w-x2,y2,texw0,texh0);
    
    draw_primitive_end();
    
    draw_set_color(make_color_rgb((i)*255,(i)*255,(i)*255));
    
    draw_primitive_begin_texture(pr_trianglelist,tex1);
    
    draw_vertex_texture(x2,y2,0,0);
    draw_vertex_texture(w-x2,y2,texw0,0);
    draw_vertex_texture(x3,h,0,texh0);
    
    draw_vertex_texture(w-x2,y2,texw0,0);
    draw_vertex_texture(x3,h,0,texh0);
    draw_vertex_texture(w-x3,h,texw0,texh0);
    
    draw_primitive_end();

    screen_refresh();
    sleep(30);
    }

for (i = 0.5; i > 0; i -= 0.05*timefactor)
    {
    draw_clear(c_black);
    
    x1 = n*(1-i);
    x2 = -n*i;
    x3 = n*i;
    y2 = h*i;
    
    draw_set_color(make_color_rgb((i)*255,(i)*255,(i)*255));
    
    draw_primitive_begin_texture(pr_trianglelist,tex0);
    
    draw_vertex_texture(x1,y1,0,0);
    draw_vertex_texture(w-x1,y1,texw0,0);
    draw_vertex_texture(x2,y2,0,texh0);
    
    draw_vertex_texture(w-x1,y1,texw0,0);
    draw_vertex_texture(x2,y2,0,texh0);
    draw_vertex_texture(w-x2,y2,texw0,texh0);
    
    draw_primitive_end();
    
    draw_set_color(make_color_rgb((1-i)*255,(1-i)*255,(1-i)*255));
    
    draw_primitive_begin_texture(pr_trianglelist,tex1);
    
    draw_vertex_texture(x2,y2,0,0);
    draw_vertex_texture(w-x2,y2,texw0,0);
    draw_vertex_texture(x3,h,0,texh0);
    
    draw_vertex_texture(w-x2,y2,texw0,0);
    draw_vertex_texture(x3,h,0,texh0);
    draw_vertex_texture(w-x3,h,texw0,texh0);
    
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