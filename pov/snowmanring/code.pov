#include "colors.inc"
#include "shapes.inc"
#include "textures.inc"

camera {
  location<20,20,-30>
  look_at<0,0,0>
  angle 20
}

light_source {<40,40,-60> color 0.7 * White}

object {Plane_XZ texture{pigment{checker color Black,color White}} scale<10,0,10>translate<0,-0.5,0>}

#macro drawSnowman(p, th)
  union {
    object {Sphere texture{Soft_Silver} translate<p.x,0 + p.y,p.z>}
    object {Sphere texture{Soft_Silver} scale<0.8,0.8,0.8> translate<p.x,1.4 + p.y,p.z>}
    object {Cone_Y texture{Silver2} scale<0.75,0.85,0.7> translate<p.x,2.4 + p.y,p.z>}
    object {Disk_Y texture{DMFLightOak} scale<0.09,0.6,0.09> rotate<0,0,30> translate<-0.8 + p.x,0.7 + p.y,p.z>}
    object {Disk_Y texture{DMFLightOak} scale<0.09,0.6,0.09> rotate<0,0,-30> translate<0.8 + p.x,0.7 + p.y,p.z>}
    object {Disk_Z texture{pigment{color Black}} scale<0.1,0.1,0.03> rotate<20,0,0> translate<p.x,0.4 + p.y,-0.9 + p.z>}
    object {Disk_Z texture{pigment{color Black}} scale<0.1,0.1,0.03> rotate<6,0,0> translate<p.x,0.1 + p.y,-1 + p.z>}
    object {Disk_Z texture{pigment{color Black}} scale<0.1,0.1,0.03> rotate<-8,0,0> translate<p.x,-0.2 + p.y,-1 + p.z>}
    object {Cone_Z texture{DMFDarkOak} scale<0.2,0.2,0.4> rotate<0,180,0> translate<p.x,1.3 + p.y,-0.8 + p.z>}
    light_source {<p.x,p.y + 5,p.z - 1> color 1.2 * White spotlight point_at<p.x,p.y,p.z> radius 30 falloff 60}
    rotate<0,th,0>
  }
#end

#macro Disp(r,n)
  #declare i = 0;
  #while(i < 360)
    drawSnowman(<0,0,r>,i)
    #declare i = i + (360 / n);
  #end
  FallingSnow(-2 * r,0,-2 * r,2 * r,20,2 * r,3000)
#end

#macro FallingSnow(px1,py1,pz1,px2,py2,pz2,n)
  #declare s = seed(1000);
  #declare i = 0;
  #while(i < n)
    #declare px = (px2 - px1) * rand(s) + px1;
    #declare py = (py2 - py1) * rand(s) + py1;
    #declare pz = (pz2 - pz1) * rand(s) + pz1;
    #declare sz = rand(s) * 0.04 + 0.01;
    object {Sphere texture{pigment{color White}} scale<sz,sz,sz> translate<px,py,pz>}
    #declare i = i + 1;
  #end
#end

#Disp(6,10)
