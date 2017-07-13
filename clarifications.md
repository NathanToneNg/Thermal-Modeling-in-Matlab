# 1: Dimensions/Materials slide:
	* 2 Materials mean there are two different materials, but neither is necessarily the receptor. 1 Matrix/ 1 Receptor guarantees that the receptors will be located where the second material is.



# 2: Settings Menu: 
	* re-check parameters tells whether the program has a chance of becoming unstable with the given material parameters and step sizes.
		* If the user is concerned about parameters, the button should be clicked to refresh it after changing the parameters.




# 3: Size & Time Settings:
	* Assumed units are in meters and seconds, but scaling can be done as clarified in the README right below Usage.
	* Graphing Framerate tells the program how often (in terms of time steps) the program should take a snapshot graph and calculate the average temperature and energy.



# 4: Material Constants:
	* Conduction Constant is h_c in Newton’s Law of Cooling, and Radiation Emissivity Constant is ε in the Stefan-Boltzmann Law
	* All assumed units are meters, seconds, kilograms, Watts, and ºC.
	* Thermal Conductivity between the two materials is in the second material box, and is the thermal conductivity on the interface between the two materials, which is usually between the two individual thermal conductivities.



# 5: Energy Dissipation: 
	* Conduction on the Edges is usually turned off, except for in test cases and when the situation should be considered as connecting to a “grounded” material at the room temperature.
	* Convection/Radiation off unseen directions are used in the 1D and 2D cases:
		* 1D: This acts as if the setting given is a rectangular prism material of thickness given by dd (almost infinitely thin), where the surroundings are all air and thus convection/radiation occurs off all pixels in addition to sides
		* 2D: This acts as if the setting given is a flat material of thickness given by dd (almost infinitely thin), where the 3rd dimension (top and bottom) are air above and below, and thus convection/radiation occurs off all pixels in addition to sides.
	* The same process is for both 1D and 2D, but twice as impactful for 1D.



# 6: Distribution (For both 2nd Material and/or Energy Receptors)
	* Center Pixel: Only the single pixel in the center of the grid
	* Center Block: With the center at the middle, a line/square/cube covering a 5th of the total dimension (a 10th out from the center in each direction)
	* Uniform Distribution: 1 out of every (input) pixels become the second material/receptor, by taking the nth root and rounding.
	* Random Distribution: 1 out of every (input) pixels become the second material/ receptor, by randomly finding unselected spots and filling until the ratio is fulfilled.
	* Random Spheres: 1 out of every (input) pixels become the second material/ receptor, by randomly finding a radius within the remainder of needed pixels, and then picking a random unselected spot. The process is repeated until the ratio is fulfilled.



# 7: Room Temperature Settings:
	* The option for constant time allows the user run the program slightly faster than otherwise, assuming the room temperature remains at an approximately constant temperature. 
	* The room temperature function should be written in the form of an anonymous function in matlab. For example, f(x) = 10 + 3x^2 should be written as ‘@(x)10 + 3*(x^2)’



# 8: Energy Insertion:
	* Initial temperature has a spread option, which is just uniform distribution. 
		* If the entire block should be started at a higher temperature, simply use the “spread” option and give Frequency as 1.
	* Energy absorption is how much energy per kg is inputted into each receptor each second (W/kg, or J/(kg * s)).
	* Time on and off are in seconds, not steps.
	* Time distribution tells the program to cycle the energy input, using a sine curve unless this is Constant.
		* Constant is the default, a constant rate at the input.
		* All cycle means that all temperatures cycle together, there is no variation between which receptor gets how much energy
		* Rotation means that there is variation on which receptors get energy, distributing higher energy to one side and less energy to the other, and switching over time.
		* Middle means the high peak of the sine curve is the energy rate provided
		* High means the middle point of the sine curve is the energy rate provided.
	* Note that on a sine based curve this means that the average input is multiplied by sqrt(2) of the energy rate inputted, and high means multiplied by 2sqrt(2)



# 9: Misc./Graphing Settings:
	* Isosurface option applies for 3D case only: Will plot Isosurfaces for every 10th percentile
	* Saving the movie will have the program save the movie as recentTestMovie.avi in your MATLAB folder. Drag this into the MATLAB Command Window to bring the movie to the workspace, and use * movie(recentTestMovie) * to play it.
	* Precision digits determine how many digits calculations should be carried out to
	* Tracking top temperatures will leave the global topTemps as an array with the average top (top z values) of a matrix down to the provided depth.



# 10: Repick #Materials / Dimensions 
	* Allows the user to repick the number of materials or dimensions without resetting all other settings.



