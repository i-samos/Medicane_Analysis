<h1> Medicane_Analysis </h1>
<h2> A MATLAB Application for Visualizing Meteorological Parameters </h2>

Extracts the necessary parameters from GRIB files and uses Hart's methodology to identify the Medicane's location and intensity. It is designed for scientific purposes, including publishing in scientific journals.

This MATLAB application is designed to analyze GRIB1 edition files in order to identify medicane characteristics based on Hart (2003) A Cyclone Phase Space Derived from Thermal Wind and Thermal Asymmetry
(https://doi.org/10.1175/1520-0493(2003)131%3C0585:ACPSDF%3E2.0.CO;2).

![Example Image](https://github.com/i-samos/Medicane_Analysis/blob/main/medicanes_icon.png)

Installation
To use this application, you will need to have MATLAB installed on your computer. Simply download the source code from this repository and open the main MATLAB script called "medicanes.m" to get started. 
Usage
Running "Medicane_Analysis.m" will open a GUI where you can select the GRIB1 file that you want to analyze. The application will then extract the necessary parameters from the file and use Hart's Cyclone Phase Space to identify medicane characteristics, such as the cyclone's location and intensity.
Future Work
In the future, we plan to expand this application to include support for additional file formats, such as GRIB2. We also plan to add more advanced features, such as the ability to generate reports and export results in various formats.

This is an application written in MATLAB that can read GRIB1 files and visualize meteorological parameters. Due to size constraints, this application only includes map data for Europe.

<h2> Usage </h2>

The purpose of this application is to provide an easy way to visualize Medicane charasteristics from GRIB1 files. To use the application, open the main MATLAB script called "medicanes.m" and run it. When the script is executed, it will open a graphical user interface (GUI) that allows you to visualize the contents of the GRIB1 files. This application has been tested on Windows 10 64 platforms (Linux has not been tested yet, but probably no need for major modifications).

The INPUT_GRIB directory is a required component of the application, as it contains files with the same projection, in order for them to be read correctly. Additionally, the GRIB files must have a ".grb" extension (e.g. "test.grb") in order to be recognized by the application. All of the files contained in INPUT_GRIB directory must be a) of the same run and has multiple forecasts, or b) has only analyses without any forecasts, as you cannot select model etc. If needed to change grib files, just replace them and re-run. This application has been tested with MATLAB versions 16b and 17a.

<h2> Code Modifications and Future Work </h2>
This application uses C code for MEX files, which has been modified to export the output to a text file in the filesystem and then read the text file back into MATLAB. This was done as a temporary solution until further work can be done to properly modify the code to assign the data to a matrix inside MATLAB. Future work for this application can include modifying the code to read GRIB2 files using nctoolbox. Currently, the application only supports GRIB1 files due to limitations with the code. By extending the capabilities of the application to read GRIB2 files, users can expand the range of data that can be visualized.

<h2> Data </h2>
This application requires GRIB edition 1 data to function properly. Due to size limitations, the application only includes data for a specific region. The application can visualize data in several projections, including regular lat-lon, Lambert, and rotated lat-lon. However, orthographic projection is not currently supported. All of the previously mentioned projections will be visualized in the regular lat-lon projection.

<h2> Credits </h2>
This application uses code and tools from the following sources:

nctoolbox by B. Schlining, R. Signell, A. Crosby, Github repository
(https://github.com/nctoolbox/nctoolbox)

export_fig by Oliver Woodford and Yair Altman, GitHub repository
(https://github.com/altmany/export_fig/releases/tag/v3.34)

Efficient GRIB1 data reader by Shugong Wang, MATLAB Central File Exchange
(https://www.mathworks.com/matlabcentral/fileexchange/53705-efficient-grib1-data-reader)

maximize by Oliver Woodford, MATLAB Central File Exchange
(https://www.mathworks.com/matlabcentral/fileexchange/25471-maximize)

<h2> Purpose </h2>
This application is designed to offer an uncomplicated method for analysing and visualizing Medicane parameters. 
