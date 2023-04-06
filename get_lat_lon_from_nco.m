function [lon,lat] = get_lat_lon_from_nco(nco)
% Get latitude and longitude from the nco object

lat = nco{'lat'}(:);
lon = nco{'lon'}(:);
lat1=lat;
lat = double(repmat(lat', [numel(lon), 1]));
lon = double(repmat(lon', [numel(lat1), 1]));
lat = lat';
