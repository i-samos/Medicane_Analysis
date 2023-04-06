function [lon, lat] = convert_rotated_latlon(x, y, nco)
% Convert x and y coordinates to latitude and longitude using Rotated LatLon projection

% Extract projection parameters for Rotated LatLon projection
[SouthPoleLatitude, SouthPoleLongitude] = rotated_latlon_projection_parameters(nco);

lon_r = x';
lat_r = y';
SAr = -sind(lon_r) .* cosd(lat_r);
CAr = cosd(SouthPoleLatitude) .* sind(lat_r) + sind(SouthPoleLatitude) .* cosd(lat_r) .* cosd(lon_r);
lon = atand(SAr ./ CAr) + SouthPoleLongitude;
SLr = -sind(SouthPoleLatitude) .* sind(lat_r) + cosd(SouthPoleLatitude) .* cosd(lat_r) .* cosd(lon_r);
lat = asind(SLr);
lon = lon';
lat = lat';
