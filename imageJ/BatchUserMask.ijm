//The input and output folders are specified, and a list of filenames 'filelist' retrieved.
#@ File (label = "Input directory", style = "directory") input
#@ File (label = "Output directory", style = "directory") output

filelist=getFileList(input)

//The print function is iterated over the input folder.
for (i=0; i<filelist.length; i++){
//print(filelist[i]); This is not necessary

//The UserMasks function (defined below) is iterated over the input folder.
UserMasks(input+"//"+filelist[i]);
close();
}

function UserMasks(filename){
//print("Running UserMasks");
open(filename);

//Edit this section to taylor the inital view to the Users needs
/////////////////////////////
run("Make Composite");
setOption("AutoContrast", 1);
/////////////////////////////

//The Manager is reset to prevent duplicate ROIs.
roiManager("reset");
MaskNumber = 1;
MoreMasks = 1;
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
	roiManager("save", output+"//"+RoiSetName);
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

//Make Mask
run("Create Mask");

//Save Mask
saveAs("Tiff", output+"//"+MaskName+".tif");
close();

}
