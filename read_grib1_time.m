function [lat,lon,data]=read_grib1_time(IDX, IDX2);
% Load variables from the base workspace
% [IDX, IDX2] = load_base_variables();

% Read GRIB1 data
[data, ~, ~] = ReadGRIB1(IDX2, IDX);

% Get projection information
nco = ncgeodataset(IDX2);
PROJECTION = nco.variables{1};

try
    % Get latitude and longitude from nco object
    [lat, lon] = get_lat_lon_from_nco(nco);
catch
    % Get x and y from nco object
    [x, y] = get_x_y_from_nco(nco);
    
    if strcmp(char(PROJECTION), 'LambertConformal_Projection') == 1
        % Extract projection parameters and convert x and y coordinates to lat and lon
        [lat, lon] = convert_lambert_conformal(x, y, nco);
    elseif strcmp(char(PROJECTION), 'RotatedLatLon_Projection') == 1
        % Extract projection parameters and rotate coordinates to obtain lat and lon
        [lat, lon] = convert_rotated_latlon(x, y, nco);
    end
end

% Calculate gravitational acceleration (g)
% g = 9.81;
% 
% % Assign g, data, lat, and lon to the base workspace
% assignin('base', 'g', g);
% assignin('base', 'data', data);
% assignin('base', 'lat', lat);
% assignin('base', 'lon', lon);