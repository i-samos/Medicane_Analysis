# Medicane_Analysis
Extracts the necessary parameters from the file and uses Hart's method to identify the cyclone's location and intensity. It is designed for scientific purposes, including publishing in scientific journals.
This MATLAB application is designed to analyze GRIB1 edition files in order to identify medicane characteristics based on Hart (2003) A Cyclone Phase Space Derived from Thermal Wind and Thermal Asymmetry
(https://doi.org/10.1175/1520-0493(2003)131%3C0585:ACPSDF%3E2.0.CO;2).

Installation
To use this application, you will need to have MATLAB installed on your computer. Simply download the source code from this repository and open the main MATLAB script called "medicanes.m" to get started. 

Usage
Running "Medicane_Analysis.m" will open a GUI where you can select the GRIB1 file that you want to analyze. The application will then extract the necessary parameters from the file and use Hart's Cyclone Phase Space to identify medicane characteristics, such as the cyclone's location and intensity.

Credits
This application uses several tools and code from other sources, which are credited below:

B. Schlining, R. Signell, A. Crosby, nctoolbox (2009), Github repository (https://github.com/nctoolbox/nctoolbox)
Shugong Wang (2023). Efficient GRIB1 data reader, MATLAB Central File Exchange. Retrieved March 30, 2023 (https://www.mathworks.com/matlabcentral/fileexchange/53705-efficient-grib1-data-reader)
Oliver Woodford (2023). maximize, MATLAB Central File Exchange. Retrieved March 31, 2023 (https://www.mathworks.com/matlabcentral/fileexchange/25471-maximize)
Yair Altman (2023). export_fig, GitHub repository. Retrieved March 30, 2023 (https://github.com/altmany/export_fig/releases/tag/v3.34)

Future Work
In the future, we plan to expand this application to include support for additional file formats, such as GRIB2. We also plan to add more advanced features, such as the ability to generate reports and export results in various formats.
