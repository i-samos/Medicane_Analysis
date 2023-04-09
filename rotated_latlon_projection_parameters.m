function [SouthPoleLatitude, SouthPoleLongitude] = rotated_latlon_projection_parameters(nco)
% Extract projection parameters for Rotated LatLon projection from the nco object

details = nco{'RotatedLatLon_Projection'};
details = details.attributes;

% Extract necessary values from the attributes
SouthPoleLatitude = cell2mat(details(strcmp({'grid_south_pole_latitude'}, details(:, 1)), 2));
SouthPoleLongitude = cell2mat(details(strcmp({'grid_south_pole_longitude'}, details(:, 1)), 2));
