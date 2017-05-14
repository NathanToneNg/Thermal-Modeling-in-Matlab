# A Thermal Modeling program written in Matlab.
	This program was created for the purpose of modeling microwave heating by receptive materials within a polymer matrix for use in the [Banaszak Holl Group](http://bhgroup.lsa.umich.edu//). 

## Usage
* The GUI is initially accessed with overallGUI. This function will reset all variables to defaults, so if you want to change only a few variables, use chooseSettings1 in the case of one material, or chooseSettings2 in the case of two materials of differing properties.  

* The parameters can be viewed using printParameters, and individual programs with variables set can be run in the Thermal*Ind functions. 

* It is recommended that the user run "clear global" between different instances to ensure that there are no artifacts from previous runs.

Other programs with _check and exp are various checks that the program works as predicted in basic cases, checking that total energy/temperature remains constant when no energy should be lost, and that there is exponential decay. 




## Theory

### Physics
The following equations were used to determine the numerical calculations.
	* Q = mc (dT)
	* dQ/dt = kA(dT/dx) (_conduction_)
	* dQ/dt = 

### Implementation versions
* Each version states how many dimensions it applies over within the name of the file.

#### The following indicate what the files with this term in their names mean for the version

*  Efficient
	* _These versions were created and eliminated an unnecessary dimension, instead reusing the previous frame_
	
*  Ind
	* _These versions are called by the interface whenever only one material is used_
	
*  TwoMat
	* _These versions are called by the interface whenever two different materials are needed_
	
*  check
	* _These versions were used to check simple characteristics of the program and ensured that they aligned with theory_
	
*  settle
	* _These versions namely declare a global "list" and work with one material. The list includes averages of the temperatures across the matrix and were usually used to ensure that no energy was lost when all energy loss methods were removed_


### Implementation choices
* There are three versions of almost everything: One for one dimension, two dimensions, and three dimensions. This is because the differences between number of dimensions causes enough changes in implementation that it saves time to write and run them separately.

* The _Efficient_ versions were created so that previous matrices are re-used instead of having additional layers on each matrix. For example, with 10 time intervals and 2 dimensions, instead of adding a third time dimensions on a matrix, each time step is taken and a figure is printed and saved and then the two dimensional matrix is re-used.

* Each main Matrix is two larger in each dimension, with the bound properties depending on whether conduction is turned on on the borders. This makes the program work with one conduction statement instead of multiple and saves repeating statements with various conditionals. 

* Density is always used in replacement of mass since distance is a greater determining factor.


---

If you have additional questions, emails may be sent to nathantoneng@gmail.com

-Nathan Ng



