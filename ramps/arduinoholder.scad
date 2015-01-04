$fn=20;

module beehome (w,l,h,s){
difference (){
		cube([w,l,h]);
#	translate([(w%s)/2,(l%s)/2,0]){
		for ( j = [0 : s*1.96 : l] )	{
			for ( i = [0 : s*3.4 : w] )	{
				translate([i,j,0])cylinder (h,s,s,$fn=6);
				translate([i+s*1.7,j+s*0.96,0])cylinder (h,s,s,$fn=6);
			}
		}		
	}
}
}


module arm (){
	hull() {
		cube ([2.5,1,15]);
		cube ([2.5,15,1]);
	}
}

module arduino() {
 difference () {
		cube ([54,102,2]);
		translate ([2.5,15,0]) cylinder(10,1.5,1.5);
		translate ([2.5,90,0]) cylinder(10,1.5,1.5);
		translate ([18,46,0]) cylinder(10,1.5,1.5);
		translate ([46,46,0]) cylinder(10,1.5,1.5);
		translate ([51,15,0]) cylinder(10,1.5,1.5);
		translate ([51,96,0]) cylinder(10,1.5,1.5);
	}
}




difference () {
	cube ([60,3,16]);
#	translate([10,-1,10])rotate([-90,0,0]) cylinder(5,1.7,1.7);
#	translate([50,-1,10])rotate([-90,0,0]) cylinder(5,1.7,1.7);
}


translate ([0,0,0])arm ();
translate ([57.5,0,0])arm ();

difference () {
	cube ([60,113,4]);
#	translate([2.5,7.5,1])cube ([55,103,4]);
	translate([5,10,0])cube ([50,98,4]);
}
//conner
#translate ([0,50,0])hull() {
		translate([0,-5,0])cube ([2.5,15,0.5]);
		translate([0,0,8])cube ([2.5,5,0.5]);
}
#translate ([57.5,50,0])hull() {
		translate([0,-5,0])cube ([2.5,15,0.5]);
		translate([0,0,8])cube ([2.5,5,0.5]);
}
translate ([27,113,0])rotate([0,0,-90])hull() {
		translate([0,-5,0])cube ([2.5,15,0.5]);
		translate([0,0,8])cube ([2,5,0.5]);
}


//bottom beehome
beehome (60,113,0.75,7.6);



// color ("green")translate([3,8,4])  arduino();
