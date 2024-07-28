//*******************************************************************************************************
//
//    Universal parametic rugged Box
//
//  2023 by Rainer Backes
//
//   based on ideas of yanew and Whity
//
//*******************************************************************************************************

// Disk radius
d = 43;            // mm
r = d / 2;         // mm
circle_height = 4; // mm
support_height = 12;
support_diameter = 8.25;               // mm
support_radius = support_diameter / 2; // mm
bottom_bump = 9;

disk_gap = 5; // mm
disks_x = 3;
disks_y = 3;

disk_collector_size_x = disks_x * (d + disk_gap);
disk_collector_size_y = disks_y * (d + disk_gap);

/* [View] */
// Select View
View = "Parts"; // [Complete, Complete Open, Parts, Lid, Bottom, Latch, Seal ]
// Open Angle for complete Open
ViewAngle = 90; //[0:180]

/* [General] */

// Depth of Inner Box (available space)
InnerBoxDepth = disk_collector_size_x;
// Width of Inner Box (available space)
InnerBoxWidth = disk_collector_size_y;
// Hight of bottom part of Inner Box (available space) >= 16
InnerBoxBottomHeight = 22;
// Hight of top part of Inner Box (available space)
InnerBoxLidHeight = 2;
// Cornet Radius of Inner Box (vertical)
InnerCornerRadius = 3;
// Chamfer of inner Box (horizontal)
InnerChamferSize = 1.5;

// Length of Screw
ScrewLength = 30;
// Diameter of Screw
ScrewDiameter = 3;
// Tolerance for Latch holes
ScrewTol = 0.4;

ScrewThreadDiameter = ScrewDiameter - 0.15;
// Wall Thickness
WallThickness = 2.4;
// Number of Hinges(1-3)
NumHinge = 2;
// Number of Latches (1-3)
NumLatch = 1;
// Additional Height for TPU-Seal
TSealHeight = 0;
// Apply Interior to Lid
InteriorToLid = false;

/* [Hinges] */
// Offset of Hinge and Latchs to inner side corner
HingeLatchOffset = 12;

HingeWidthTolerance = 0.25;

// With of Front and Back Ribs
HingeLatchRibWidth = 3.2;

HingeOuterDiameter = 6.8;
HingeOuterExtend = 3;
HingeBottomLength = HingeLatchRibWidth + HingeOuterExtend;
HingeLidLength = ScrewLength - 2 * HingeBottomLength - HingeWidthTolerance;

/* [Side Ribs] */
// Number of Side rib Pairs
NumRibs = 2;
// if more than 1 Side Rib Pair, distance of Ribs to the inner corner
RibOffset = 18;
// Width of Ribs
RibWidth = 5;
// Distance between Ribs
RibDist = 20;

/* [Latches] */
// Distance of the screws making the Latch
LatchDistance = 16;
// Latch Displacement downwards
LatchDisplacement = 2;

LatchWidthTolerance = 0.4;
BoxLatchRibChamfer = 17;
LidLatchRibChamfer = 13;

// Latch: Radius of the rounding
LatchRoundRad = 15;
// Latch Wall thickness
LatchWall = 3;
// Length of the Latch Handle
LatchHandleLen = 11;
// Ofset of Handle from vertical
LatchHandleOfs = 4;

/* [Seal] */
// Height of Seal
SealHeight = 1.4;
// Height of Lid protion, if TPUSeal > 0
TSealLid = 0.5;
// Tolerance for the TPU-Seal ( 1 layer )
TSealTol = 0.2;

SealWall = WallThickness / 2;
// Additional wall tickness of box for seal
SealThick = 1.9;
// Toleance
SealTol = 0.2;
// Chanfer Angle for Seal-Support
SealCAng = 70;
// Heigth of Seal support
SealBHeigh = 8;

/* [Interior] */
// default Width of interior Walls
iWall = 1;

// Interior definition, everything here get masked an added to the interior of bottom and optional lid
module Interior()
{
    diskHolder();
}

// evertything here gets substracted (difference() ) from the lid
module liddiff()
{
}

// evertything here gets added to the lid
module lidadd()
{
}

// evertything here gets substracted (difference() ) from the bottom
module bottomdiff()
{
}

// evertything here gets added to the bottom
module bottomadd()
{
}

module diskHolder()
{
    // Start with our base frame
    // translate(v = [ -1 * disk_collector_size_x / 2, -1 * disk_collector_size_y / 2, 0 ])
    translate(v = [ r + disk_gap / 2, r + disk_gap / 2, bottom_bump ])
    {
        for (x = [0:disks_x - 1])
        {
            for (y = [0:disks_y - 1])
            {
                translate([ x * (d + disk_gap), y * (d + disk_gap), 0 ])
                {
                    difference()
                    {
                        cube([ d + disk_gap, d + disk_gap, circle_height ], center = true);
                        cylinder(h = circle_height + 10, r = r, center = true);
                    }
                    translate(v = [ 0, 0, circle_height ])
                        cylinder(h = support_height, r = support_radius, center = true);
                    translate(v = [ 0, 0, support_height - 2 ]) sphere(r = support_radius);
                }
            }
        }
    }

    cube([ disk_collector_size_x, disk_collector_size_y, bottom_bump ]);
}

if (View == "None")
{
    diskHolder();
}
include <rugbox.scad>