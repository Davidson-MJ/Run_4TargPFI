# Run_4TargPFI
This is the Matlab code to run a four target PFI experiment, with dynamically updated textures within target regions, and the background.
The main experiment is called from Run_experiment.m

Within that script there are many parameter options to toggle, including Target Frequency, size, colour, eccentricity, and location. 
As well as background density, frequency, etc...

The experiment launches from the menu.m script (in /supportfiles).
From this menu, options are displayed on screen to select either a Calibration version, or Experiment version of the script.

During Calibration, keyboard responses can be recorded to estimate the amount of PFI occurring. 
More importantly, different keys also toggle the experimental display, in real-time, to adapt to each users needs. 

This can be done to optimize the SSVEP tagging frequency (as in Davidson et al., eLife 2020), or calibrate disappearances to a desired level.

The keys for updating the screen during calibration are: 

•	Use mouse to click on targets to turn on/off targets
•	Left arrow on keyboard: decrease eccentricity
•	Right arrow on keyboard: increase eccentricity
•	Down arrow on keyboard: decrease background density
•	Up arrow on keyboard: increase background density
•	Return on keyboard: turn background on/off
•	F1: decrease target size
•	F2: increase target size
•	F3: change target colour (R value)
•	F4: change target colour (G value)
•	F5: change target colour (B value)
•	F9: change top left target frequency
•	F10: change top right target frequency
•	F11: change bottom left target frequency
•	F12: change bottom right target frequency
•	Press “Q” on key board to quit Calibration mode and back to menu. 

More information is provided in the 'How to use PFI-BCI scripts.doc', and within the code itself.

Any questions please let me know,

Happy piloting!
