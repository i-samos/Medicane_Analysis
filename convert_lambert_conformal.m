function [lon, lat] = convert_lambert_conformal(x, y, nco)
% Convert x and y coordinates to latitude and longitude using Lambert Conformal Conic projection

% Extract projection parameters for Lambert Conformal Conic projection
[OriginLatitude, OriginLongitude, FirstStandardParallel, SecondStandardParallel] = lambert_projection_parameters(nco);

% Constants
GRS80 = 6378137;
InverseFlattening = 298.2572221;
FalseNorthing = 0;
FalseEasting = 0;

% Compute parameters for the conversion
a = GRS80;
f = 1 / InverseFlattening;
phi1 = FirstStandardParallel * pi() / 180;
phi2 = SecondStandardParallel * pi() / 180;
phi0 = OriginLatitude * pi() / 180;
lambda0 = OriginLongitude * pi() / 180;
N0 = FalseNorthing;
E0 = FalseEasting;
e = sqrt(2 * f - f^2);

m1 = cos(phi1) / sqrt(1 - (e * sin(phi1))^2);
m2 = cos(phi2) / sqrt(1 - (e * sin(phi2))^2);
t0 = tan(pi() / 4 - phi0 / 2) / ((1 - e * sin(phi0)) / (1 + e * sin(phi0)))^(e / 2);
t1 = tan(pi() / 4 - phi1 / 2) / ((1 - e * sin(phi1)) / (1 + e * sin(phi1)))^(e / 2);
t2 = tan(pi() / 4 - phi2 / 2) / ((1 - e * sin(phi2)) / (1 + e * sin(phi2)))^(e / 2);

if phi1 ~= phi2
    n = (log(m1) - log(m2)) / (log(t1) - log(t2));
else
    n = sin(phi1);
end

Fcap = m1 / (n * t1^n);
rho0 = a * Fcap * t0^n;
Nprime = y * 1000 - N0;
Eprime = x * 1000 - E0;
rhoprime = sign(n) * sqrt(Eprime.^2 + (rho0 - Nprime).^2);
tprime = (rhoprime / (a * Fcap)).^(1 / n);
gammaprime = atan(Eprime ./ (rho0 - Nprime));
phiout = pi() / 2 - 2 * atan(tprime);

cnt = 1;
phiIN = phiout;
while (cnt < 10)
    phiOUT = pi() / 2 - 2 * atan(tprime .* ((1 - e * sin(phiIN)) ./ (1 + e * sin(phiIN))).^(e / 2));
    phiIN = phiOUT;
    cnt = cnt + 1;
end

phix = phiOUT;
lat = phix * 180 / pi();
lon = (gammaprime / n + lambda0) * 180 / pi();
