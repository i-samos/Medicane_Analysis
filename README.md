<h1> Software for Analysis of Medicanes (a.k.a. Mediterranean Cyclones)  </h1>

<h2> A MATLAB Application for Medicane Analysis </h2>

This MATLAB application is designed to analyze meteorological parameters, such as geoheight and mean sea level pressure, in order to identify medicane characteristics based on Hart (2003) A Cyclone Phase Space Derived from Thermal Wind and Thermal Asymmetry
(https://doi.org/10.1175/1520-0493(2003)131%3C0585:ACPSDF%3E2.0.CO;2).

![Example Image](https://github.com/i-samos/Medicane_Analysis/blob/main/medicanes_icon.png)

<h2> Usage </h2>

The purpose of this application is to provide an easy way to visualize Medicane charasteristics from GRIB1 files. Running "medicanes.m" will open a GUI where you can select the time based on the GRIB1 files, that you want to analyze. The application will then extract the necessary parameters and use Hart's methodology to identify medicane characteristics, such as the cyclone's location and intensity. This application has been tested on Windows 10 64 platforms (Linux has not been tested yet, but probably no need for major modifications).

The INPUT_GRIB directory is a required component of the application, as it contains files with the same projection, in order for them to be read correctly. Additionally, the GRIB files must have a ".grb" extension (e.g. "test.grb") in order to be recognized by the application. All of the files contained in INPUT_GRIB directory must be a) of the same run with multiple forecasts, or b) has only analyses without any forecasts, as you cannot select model etc. If needed to change grib files, just replace them and re-run. This application has been tested with MATLAB versions 16b and 17a.

<h2> Code Modifications and Future Work </h2>
This application uses C code for MEX files, which has been modified to export the output to a text file in the filesystem and then read the text file back into MATLAB. This was done as a temporary solution until further work can be done to properly modify the code to assign the data to a matrix inside MATLAB. Future work for this application can include modifying the code to read GRIB2 files using nctoolbox. Currently, the application only supports GRIB1 files due to limitations with the code. In the future, the plan is to expand this application to include support for additional file formats, such as GRIB2. It is also planed to add more advanced features, such as the ability to generate reports and/or export results in various formats.

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
