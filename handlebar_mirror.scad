// handlebar_mirror.scad
// sizes should be in mm, I hope.

ball_rad = 6;
bar_irad = 8.5;
bar_orad = 10;
bar_depth = 30;
mount_length = 2;
expander_slits = 5;
socket_slits = 2;
screw_rad = 2;

// bar insert
difference(){
	union(){
		cylinder(r=bar_irad, h=bar_depth);
		translate([0,0,-2])
		cylinder(r=bar_orad,h=2);				// bar-end cap
		translate([0,0,-ball_rad])
		sphere(r=ball_rad);					// ball
	}
	cylinder(r1=4, r2=7, h=bar_depth);		// tapered hole
	translate([0,0,-2*ball_rad]){
		cylinder(r=screw_rad, h=2*ball_rad);	// screw hole
		cylinder(r=3, h=ball_rad);			// counter sink
	}
	slits(expander_slits,bar_irad,bar_depth);
}

// expander plug
translate([0,0,4/3*bar_depth])
difference(){
	cylinder(r1=6, r2=7, h=bar_depth/3);
	cylinder(r=screw_rad, h=bar_depth/3);
}

// socket
//mirror([0,0,1]) translate([2*bar_orad,0,-.414*bar_orad]) rotate(a=135,v=[1,0,0])
translate([0,0,-4*ball_rad])
difference(){
	union(){
		sphere(r=2+ball_rad);				// socket
		translate([0,0,-mount_length*(4+ball_rad)])
		cylinder(r=bar_orad,h=mount_length*bar_orad);	// mirror mount
	}
	sphere(r=ball_rad);						// socket
	translate([0,0,ball_rad])
	cube([3*ball_rad,3*ball_rad,ball_rad],
		center=true);
	slits(socket_slits,2+ball_rad,ball_rad);
	translate([0,0,-mount_length*bar_orad])
	rotate(a=45,v=[1,0,0])
	cube([2*bar_orad,5*bar_orad,1.414*bar_orad], center=true);
}


module slits(n, r, d){				// n cuts
	for(i = [0:n-1]){
		rotate(a=i*360/n,v=[0,0,1])
		translate([0,-1,0])
		cube([r,2,d]);
	}
}
