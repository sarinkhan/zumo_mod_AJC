
arduinoX=68.6;
arduinoY=53.3;


arduinoHolesRadius=3.0/2;
hole1XShift=15;
hole1Yshift=2.5;

hole2XShift=15;
hole2Yshift=arduinoY-2.5;


hole3XShift=50.8+14+1.3;
hole3Yshift=15.2+2.5;

hole4XShift=hole3XShift;
hole4Yshift=15.2+27.9+2;


sensorHolesDist=37;
sensorHolesRadius=3/2;

//sharpIRSensorSupport

coverPlateX=arduinoX;
coverPlateY=arduinoY;

coverSmallBeamsThickness=2;
coverMedBeamsThickness=5;
coverLargeBeamsThickness=7;
thinWallThickness=1;

fixationLipWidth=10;

verticalBeamsHeight=30;

padding=0.1;
h001=2;


module arduinoHole(radius,height)
{
	translate([0,0,height/2-padding])
	cylinder(r=radius,h=height,$fn=16,center=true);
}

module arduinoHoleReinforcement(radius,height)
{
	translate([0,0,height/2])
	cylinder(r=radius,h=height,$fn=64,center=true);
}


module arduinoHoles(radius,height)
{
	translate([hole1XShift,hole1Yshift,0])
	arduinoHole(radius,height);

	translate([hole2XShift,hole2Yshift,0])
	arduinoHole(radius,height);

	translate([hole3XShift,hole3Yshift,0])
	arduinoHole(radius,height);

	translate([hole4XShift,hole4Yshift,0])
	arduinoHole(radius,height);
}

module arduinoHolesReinforcements(radius,height)
{
	translate([hole1XShift,hole1Yshift,0])
	arduinoHoleReinforcement(radius,height);

	translate([hole2XShift,hole2Yshift,0])
	arduinoHoleReinforcement(radius,height);

	translate([hole3XShift,hole3Yshift,0])
	arduinoHoleReinforcement(radius,height);

	translate([hole4XShift,hole4Yshift,0])
	arduinoHoleReinforcement(radius,height);
}

module bottomStructureNoHoles()
{
//left bar
cube([coverPlateX,coverMedBeamsThickness,coverMedBeamsThickness]);
//top bar
cube([coverMedBeamsThickness,coverPlateY,coverMedBeamsThickness]);
//right bar
translate([0,coverPlateY-coverMedBeamsThickness,0])
{cube([coverPlateX,coverMedBeamsThickness,coverMedBeamsThickness]);}
//top bar
translate([coverPlateX-coverMedBeamsThickness,0,0])
{cube([coverMedBeamsThickness,coverPlateY,coverMedBeamsThickness]);}

//reinforcement bar 1
translate([hole1XShift-coverMedBeamsThickness/2,0,0])
{cube([coverMedBeamsThickness,coverPlateY,coverMedBeamsThickness]);}

//reinforcement bar 2
translate([arduinoX/3,0,0])
{cube([coverMedBeamsThickness,coverPlateY,coverMedBeamsThickness]);}

//reinforcement bar 3
translate([2*arduinoX/3,0,0])
{cube([coverMedBeamsThickness,coverPlateY,coverMedBeamsThickness]);}

arduinoHolesReinforcements(coverMedBeamsThickness,coverMedBeamsThickness);

	translate([arduinoX-coverMedBeamsThickness/2,coverMedBeamsThickness/2,0])
	 {arduinoHoleReinforcement(coverMedBeamsThickness,coverMedBeamsThickness);}

	translate([arduinoX-coverMedBeamsThickness/2,arduinoY-coverMedBeamsThickness/2,0])
	 {arduinoHoleReinforcement(coverMedBeamsThickness,coverMedBeamsThickness);}
}


module bottomStructureWithHoles()
{
	difference()
	{
		bottomStructureNoHoles();
		arduinoHoles(arduinoHolesRadius,coverLargeBeamsThickness+padding*2);
	}
}





module verticalBeamWithHoles()
{

xShift001=(-coverLargeBeamsThickness+coverMedBeamsThickness)/2;
yShift001=(-coverLargeBeamsThickness+coverMedBeamsThickness)/2;

translate([xShift001,xShift001,coverMedBeamsThickness])
{
difference()
	{
		cube([coverLargeBeamsThickness,coverLargeBeamsThickness,verticalBeamsHeight]);
		translate([coverLargeBeamsThickness/2,coverLargeBeamsThickness/2,verticalBeamsHeight-coverLargeBeamsThickness+padding*2])
			{arduinoHole(sensorHolesRadius,coverLargeBeamsThickness);}

			translate([-coverMedBeamsThickness/2,coverLargeBeamsThickness/2,sensorHolesRadius+h001])
			{
				rotate([0,90,0])
				arduinoHole(sensorHolesRadius,coverMedBeamsThickness*2);
			}

			translate([-coverMedBeamsThickness/2,coverLargeBeamsThickness/2,verticalBeamsHeight-coverMedBeamsThickness-h001])
			{
				rotate([0,90,0])
				arduinoHole(sensorHolesRadius,coverMedBeamsThickness*2);
			}

			translate([coverLargeBeamsThickness/2,coverLargeBeamsThickness,verticalBeamsHeight/2+h001/2])
			{
				rotate([90,0,0])
				arduinoHole(sensorHolesRadius,coverMedBeamsThickness*2);
			}
	}
}
}

module verticalBeamWithHolesAndFoot()
{
	verticalBeamWithHoles();
	translate([coverMedBeamsThickness/2,coverMedBeamsThickness/2,0])
		{arduinoHoleReinforcement(coverMedBeamsThickness,coverMedBeamsThickness);}
}

module verticalBeams()
{
	//vertical beam front
translate([2*arduinoX/3,0,0])
{
	verticalBeamWithHolesAndFoot();
}




//vertical beam front
translate([2*arduinoX/3,arduinoY-coverMedBeamsThickness,0])
{
	verticalBeamWithHolesAndFoot();
}

//vertical rear beam
translate([0,0,0])
{
	verticalBeamWithHolesAndFoot();
	//cube([thinWallThickness,fixationLipWidth,verticalBeamsHeight]);
	//cube([fixationLipWidth,thinWallThickness,verticalBeamsHeight]);
}

//vertical rear beam
translate([0,arduinoY-coverMedBeamsThickness,0])
{
	verticalBeamWithHolesAndFoot();
}
}



module sensorPlate()
{
xShift002=coverLargeBeamsThickness-coverMedBeamsThickness;
zShift002=1;
//sensor plate
translate([2*arduinoX/3-thinWallThickness,0,0])
{
	
	difference()
	{
	translate([-thinWallThickness,-xShift002/2,coverMedBeamsThickness+zShift002])
		cube([thinWallThickness,arduinoY+xShift002,verticalBeamsHeight-zShift002]);

		translate([-coverMedBeamsThickness/2,coverMedBeamsThickness/2,coverMedBeamsThickness+sensorHolesRadius+h001])
		{
			rotate([0,90,0])
			arduinoHole(sensorHolesRadius,coverMedBeamsThickness*2);
		}

		translate([-coverMedBeamsThickness/2,coverMedBeamsThickness/2,verticalBeamsHeight-h001])
		{
			rotate([0,90,0])
			arduinoHole(sensorHolesRadius,coverMedBeamsThickness*2);
		}



		translate([0,arduinoY-coverMedBeamsThickness,0])
		{
			translate([-coverMedBeamsThickness/2,coverMedBeamsThickness/2,coverMedBeamsThickness+sensorHolesRadius+h001])
		{
			rotate([0,90,0])
			arduinoHole(sensorHolesRadius,coverMedBeamsThickness*2);
		}

		translate([-coverMedBeamsThickness/2,coverMedBeamsThickness/2,verticalBeamsHeight-h001])
		{
			rotate([0,90,0])
			arduinoHole(sensorHolesRadius,coverMedBeamsThickness*2);
		}
	}



		//sensor hole 1
		translate([-coverMedBeamsThickness/2,arduinoY/2-sensorHolesDist/2,verticalBeamsHeight/2+sensorHolesRadius])
		{
			rotate([0,90,0])
			arduinoHole(sensorHolesRadius,coverMedBeamsThickness*2);
		}

		//sensor hole 2
		translate([-coverMedBeamsThickness/2,arduinoY/2+sensorHolesDist/2,verticalBeamsHeight/2+sensorHolesRadius])
		{
			rotate([0,90,0])
			arduinoHole(sensorHolesRadius,coverMedBeamsThickness*2);
		}

	
		translate([-coverMedBeamsThickness/2,coverMedBeamsThickness+xShift002/2,verticalBeamsHeight-1.5*coverMedBeamsThickness])
		{
			cube([coverLargeBeamsThickness,arduinoY-coverMedBeamsThickness*2-xShift002,coverLargeBeamsThickness*2+padding]);
		}

		translate([-coverMedBeamsThickness/2,coverMedBeamsThickness+xShift002/2,coverMedBeamsThickness-padding])
		{
			cube([coverMedBeamsThickness,arduinoY-coverMedBeamsThickness*2-xShift002,coverMedBeamsThickness*1+padding*2]);
		}
	}
}
}


module lateralPlate()
{




	difference()
	{
		translate([(-coverLargeBeamsThickness+coverMedBeamsThickness)/2,-coverLargeBeamsThickness+coverMedBeamsThickness,coverMedBeamsThickness])
			cube([2*arduinoX/3+coverLargeBeamsThickness,thinWallThickness,verticalBeamsHeight]);

		translate([coverLargeBeamsThickness/2-h001/2,coverLargeBeamsThickness,verticalBeamsHeight/2+coverMedBeamsThickness+h001/2])
			{
				rotate([90,0,0])
				arduinoHole(sensorHolesRadius,coverLargeBeamsThickness*2);
			}

			translate([2*arduinoX/3+coverMedBeamsThickness-coverMedBeamsThickness/2,coverMedBeamsThickness,verticalBeamsHeight/2+coverMedBeamsThickness+h001/2])
			{
				rotate([90,0,0])
				arduinoHole(sensorHolesRadius,coverMedBeamsThickness*2);
			}
	}
}

module topCoverHoles()
{
	translate([0,0,verticalBeamsHeight+coverMedBeamsThickness])
	{
	translate([coverMedBeamsThickness/2,coverMedBeamsThickness/2,0])
		arduinoHole(arduinoHolesRadius,coverMedBeamsThickness*2);

		translate([2*arduinoX/3+coverMedBeamsThickness/2,coverMedBeamsThickness/2,0])
		arduinoHole(arduinoHolesRadius,coverMedBeamsThickness*2);

		translate([coverMedBeamsThickness/2,arduinoY-coverMedBeamsThickness/2,0])
		arduinoHole(arduinoHolesRadius,coverMedBeamsThickness*2);

		translate([2*arduinoX/3+coverMedBeamsThickness/2,arduinoY-coverMedBeamsThickness/2,0])
		arduinoHole(arduinoHolesRadius,coverMedBeamsThickness*2);
}
	}


module topCoverHolesReinforcements()
{
	translate([0,0,verticalBeamsHeight+coverMedBeamsThickness])
	{
	translate([coverMedBeamsThickness/2,coverMedBeamsThickness/2,0])
		cylinder(r=coverMedBeamsThickness,h=coverMedBeamsThickness,$fn=64);

		translate([2*arduinoX/3+coverMedBeamsThickness/2,coverMedBeamsThickness/2,0])
		cylinder(r=coverMedBeamsThickness,h=coverMedBeamsThickness,$fn=64);

		translate([coverMedBeamsThickness/2,arduinoY-coverMedBeamsThickness/2,0])
		cylinder(r=coverMedBeamsThickness,h=coverMedBeamsThickness,$fn=64);

		translate([2*arduinoX/3+coverMedBeamsThickness/2,arduinoY-coverMedBeamsThickness/2,0])
		cylinder(r=coverMedBeamsThickness,h=coverMedBeamsThickness,$fn=64);
}
	}

module topCoverNoHoles()
{
	translate([0,0,verticalBeamsHeight+coverMedBeamsThickness])
	{
		//cube([2*arduinoX/3+coverMedBeamsThickness,arduinoY,thinWallThickness]);
		
		/*translate([2*arduinoX/3+coverMedBeamsThickness,0,0])
		{
		intersection()
		{
		cube([arduinoX/3+coverMedBeamsThickness,arduinoY,thinWallThickness]);
		translate([0,arduinoY/2,0])
			{cylinder(r=arduinoY/2,h=thinWallThickness,$fn=256);}
		}
		}*/

		translate([2*arduinoX/3,0,0])
			{cube([coverMedBeamsThickness,coverPlateY,coverMedBeamsThickness]);}
		cube([coverMedBeamsThickness,coverPlateY,coverMedBeamsThickness]);

		translate([0,arduinoY/2-coverMedBeamsThickness*2,0])
		cube([2*arduinoX/3+coverMedBeamsThickness,coverMedBeamsThickness,coverMedBeamsThickness]);

		translate([0,arduinoY/2+coverMedBeamsThickness,0])
		cube([2*arduinoX/3+coverMedBeamsThickness,coverMedBeamsThickness,coverMedBeamsThickness]);
	

	}
	topCoverHolesReinforcements();
}

module topCoverWithHoles()
{
	difference()
	{
		topCoverNoHoles();
		topCoverHoles();
	}
}

bottomStructureWithHoles();
verticalBeams();

topCoverWithHoles();
//rotate([0,90,0])
sensorPlate();
//rotate([90,0,0])
lateralPlate();















