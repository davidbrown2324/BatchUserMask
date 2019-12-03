//Give paths to a testfile and a test_output dir if you want to run this script!!
testfile="";
test_output="";

function UserMasks(filename){
//print("Running UserMasks");
open(filename);
run("Make Composite");
setOption("AutoContrast", 1);

//The Manager is reset to prevent duplicate ROIs.
roiManager("reset");
MaskNumber = 1;
MoreMasks = 1
	while (MoreMasks==1){
	UserMask(MaskNumber);
	MaskNumber +=1;
		if (MaskNumber > 1){
		MoreMasks = getBoolean("Would you like to Mask another Region in this image?");
		}
	}
	//The ROI set is saved
	RoiSetName = File.nameWithoutExtension+"_Mask_Rois.zip";
	roiManager("deselect");
	roiManager("save", output+RoiSetName);
}

//The function 'UserMask' is defined below.
function UserMask(MaskNumber){
//print("Running UserMask");
MaskNum =IJ.pad(MaskNumber, 3);
MaskName = File.nameWithoutExtension+"_Mask"+MaskNum;
	
waitForUser("Mask", "Please draw a new ROI around the target.");
roiManager("Add");
roiManager("select", roiManager("count")-1);
roiManager("Rename", "Mask"+MaskNum);

//Make Cell Mask
run("Create Mask");

//Save Cell Mask
saveAs("Tiff", output+MaskName+".tif");
close();

}

//Test Run
output = test_output;
UserMasks(testfile);