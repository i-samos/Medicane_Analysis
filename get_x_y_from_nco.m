function [x, y] = get_x_y_from_nco(nco)
% Get x and y from the nco object

x = nco{'x'}(:);
y = nco{'y'}(:);
x1=x;
x = repmat(x', [numel(y), 1]);
y = repmat(y', [numel(x1), 1]);
y = y';
