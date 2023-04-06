function [OriginLatitude, OriginLongitude, FirstStandardParallel, SecondStandardParallel] = lambert_projection_parameters(nco)
% Extract projection parameters for Lambert Conformal Conic projection from the nco object

details = nco{'LambertConformal_Projection'};
details = details.attributes;

% Extract necessary values from the attributes
OriginLatitude = cell2mat(details(strcmp({'latitude_of_projection_origin'}, details(:, 1)), 2));
OriginLongitude = cell2mat(details(strcmp({'longitude_of_central_meridian'}, details(:, 1)), 2));
temp2 = cell2mat(details(strcmp({'standard_parallel'}, details(:, 1)), 2));
FirstStandardParallel = temp2(1, 1);

if numel(temp2) > 1
    SecondStandardParallel = temp2(2, 1);
else
    SecondStandardParallel = FirstStandardParallel;
end
