// Star Nest by Pablo RomÃ¡n Andrioli

// This content is under the MIT License.

// Original post by Kali https://www.shadertoy.com/view/XlfGRj

shader_type canvas_item;

const int iterations = 14;
const float formuparam = 0.53;

const int volsteps = 20;
const float stepsize = 0.1;

const float zoom = 2.800;
const float tile = 0.850;
const float speed =  0.0; 

const float brightness = 0.002;
const float darkmatter = 0.300;
const float distfading = 0.750;
const float saturation = 0.750;

uniform vec2 iMouse = vec2(0.0);

float SCurve (float value) {

    if (value < 0.5)
    {
        return value * value * value * value * value * 16.0; 
    }
    
    value -= 1.0;
    
    return value * value * value * value * value * 16.0 + 1.0;
}

void fragment()
{

	vec2 iResolution = 1./TEXTURE_PIXEL_SIZE;
	vec2 fragCoord = UV * iResolution;
	float iTime = TIME;

	//get coords and direction
	vec2 uv=fragCoord.xy/iResolution.xy-.5;
	uv.y*=iResolution.y/iResolution.x;
	vec3 dir=vec3(uv*zoom,1.);
	float time=iTime*speed+.25;

	//mouse rotation
	float a1=.5+iMouse.x/iResolution.x*2.;
	float a2=.8+iMouse.y/iResolution.y*2.;
	mat2 rot1=mat2(vec2(cos(a1),sin(a1)),vec2(-sin(a1),cos(a1)));
	mat2 rot2=mat2(vec2(cos(a2),sin(a2)),vec2(-sin(a2),cos(a2)));
	dir.xz*=rot1;
	dir.xy*=rot2;
	vec3 from=vec3(1.,.5,0.5);
	from+=vec3(time*2.,time,-2.);
	from.xz*=rot1;
	from.xy*=rot2;
	
	//volumetric rendering
	float s=0.1,fade=1.;
	vec3 v=vec3(0.);
	for (int r=0; r<volsteps; r++) {
		vec3 p=from+s*dir*.5;
		p = abs(vec3(tile)-mod(p,vec3(tile*2.))); // tiling fold
		float pa,a=pa=0.;
		for (int i=0; i<iterations; i++) { 
			p=abs(p)/dot(p,p)-formuparam; // the magic formula
			a+=abs(length(p)-pa); // absolute sum of average change
			pa=length(p);
		}
		float dm=max(0.,darkmatter-a*a*.001); //dark matter
		a = pow(a, 2.5); // add contrast
		if (r>6) fade*=1.-dm; // dark matter, don't render near
		//v+=vec3(dm,dm*.5,0.);
		v+=fade;
		v+=vec3(s,s*s,s*s*s*s)*a*brightness*fade; // coloring based on distance
		fade*=distfading; // distance fading
		s+=stepsize;
	}
    
	v=mix(vec3(length(v)),v,saturation); //color adjust
    
    vec4 C = vec4(v*.01,1.);
    
     	C.r = pow(C.r, 0.35); 
 	 	C.g = pow(C.g, 0.36); 
 	 	C.b = pow(C.b, 0.4); 
 	
    vec4 L = C;   	
    
    	C.r = mix(L.r, SCurve(C.r), 1.0); 
    	C.g = mix(L.g, SCurve(C.g), 0.9); 
    	C.b = mix(L.b, SCurve(C.b), 0.6);     	
		
	C.r = clamp(C.r, 0.0, 2.0);
	C.g = clamp(C.g, 0.0, 2.0);
	C.b = clamp(C.b, 0.0, 2.0);
	C.a = clamp(C.a, 0.0, 2.0);
    
	COLOR = C;
}