# A Thermal Modeling program written in Matlab.
This program was created for the purpose of modeling microwave heating by receptive materials within a polymer matrix for use in the [Banaszak Holl Group](http://bhgroup.lsa.umich.edu//). 

## Usage
* The GUI is initially accessed with overallGUI. This function will reset all variables to defaults, so if you want to change only a few variables, use chooseSettings1 in the case of one material, or chooseSettings2 in the case of two materials of differing properties.  

* The parameters can be viewed using printParameters, and individual programs with variables set can be run in the Thermal*Ind functions. 

* It is recommended that the user run "clear global" between different instances to ensure that there are no artifacts from previous runs.

Other programs with _check and exp are various checks that the program works as predicted in basic cases, checking that total energy/temperature remains constant when no energy should be lost, and that there is exponential decay. 

#### Time-distance scale
* In everything except the amount of energy used, time and distance are proportional by time \alpha distance^2. Thus, if we are doing simple cases of heat dissipation, converting distance up by a degree of magnitude means increasing time by two degrees of magnitude. Note that all dimensions must decrease evenly- you may not decrease just one dimension by a degree of magnitude and decrease time with it.

	* For example, if we run the program in 0.2 by 0.2 by 0.2 meters and 500 seconds, the same process will occur over 2 by 2 by 2 meters in 50,000 seconds, or over 2 by 2 by 2 millimeters in 50 milliseconds, or over 2 by 2 by 2 microns in 50 nanoseconds.
	
* If energy insertion is to be projected this way as well, the amount of energy must increase by an order of magnitude for each degree of magnitude distance is incremented. 

	* For example, if we run the program taking in 5 W in a 0.2 by 0.2 by 0.2 area and 500 seconds, the same process will occur if 0.05 W are inserted in a 2 by 2 by 2 millimeter volume in 50 milliseconds.



## Theory

### Physics
The following equations were used to determine the numerical calculations.
	* Q = mc (dT)
	* dQ/dt = kA(dT/dx) (_conduction_)
	* dQ/dt = 

### Implementation versions
* Each version states how many dimensions it applies over within the name of the file.

### Extra Tools
* _OverallGUI_ should be run to reset all conditions and set them all up fresh.
* _chooseSettings_ should be run to keep most conditions the same but with the ability to change just a few.
* _anyMelting(Melting point, temperature matrix, [logical array for matrix])_ will return the number of pixels in the matrix (in the logical in the matrix) above the melting point provided. 
* _plotTemps [matrix]_ can plot a matrix with number of dimensions set (specifically useful for finalTemps).
* _saveConditions [filename.m]_ is a function that can be run to save all global variables (parameters to run the program, and important results such as final data and average temperatures) into a file in the home directory. They can be run as a matlab script and set up the program.
* _calculate_ will choose which program to run based on the number of dimensions. 

### Implementation choices
* There are three versions of almost everything: One for one dimension, two dimensions, and three dimensions. This is because the differences between number of dimensions causes enough changes in implementation that it saves time to write and run them separately.

* Each main Matrix is two larger in each dimension, with the bound properties depending on whether conduction is turned on on the borders. This makes the program work with one conduction statement instead of multiple and saves repeating statements with various conditionals. 

* Density is always used in replacement of mass since distance is a greater determining factor.


---

If you have additional questions, emails may be sent to nathantoneng@gmail.com

-Nathan Ng



