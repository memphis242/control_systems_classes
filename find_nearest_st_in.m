function [nearest_st_in] = find_nearest_st_in(measured_dim)

st_in_sizes = 1/16:1/16:2;
A = abs(st_in_sizes - measured_dim);
[mn,in] = min(A);
N = st_in_sizes(in);

switch N
    case 0.0625
        nearest_st_in = '1/16';
    case 0.1250
        nearest_st_in = '2/16 or 1/8';
    case 0.1875
        nearest_st_in = '3/16';
    case 0.25
        nearest_st_in = '4/16 or 1/4';
    case 0.3125
        nearest_st_in = '5/16';
    case 0.3750
        nearest_st_in = '6/16 or 3/8';
    case 0.4375
        nearest_st_in = '7/16';
    case 0.5
        nearest_st_in = '1/2';
    case 0.5625
        nearest_st_in = '9/16';
    case 0.6250
        nearest_st_in = '10/16 or 5/8';
    case 0.6875
        nearest_st_in = '11/16';
    case 12/16
        nearest_st_in = '12/16 or 3/4';
    case 13/16
        nearest_st_in = '13/16';
    case 14/16
        nearest_st_in = '14/16 or 7/8';
    case 15/16
        nearest_st_in = '15/16';
    case 1
        nearest_st_in = '1';
    case 1.0625
        nearest_st_in = '1 1/16';
    case 1.1250
        nearest_st_in = '1 2/16 or 1 1/8';
    case 1.1875
        nearest_st_in = '1 3/16';
    case 1.25
        nearest_st_in = '1 4/16 or 1 1/4';
    case 1.3125
        nearest_st_in = '1 5/16';
    case 1.3750
        nearest_st_in = '1 6/16 or 1 3/8';
    case 1.4375
        nearest_st_in = '1 7/16';
    case 1.5
        nearest_st_in = '1 1/2';
    case 1.5625
        nearest_st_in = '1 9/16';
    case 1.6250
        nearest_st_in = '1 10/16 or 1 5/8';
    case 1.6875
        nearest_st_in = '1 11/16';
    case 1.75
        nearest_st_in = '1 12/16 or 1 3/4';
    case 1.8125
        nearest_st_in = '1 13/16';
    case 1.875
        nearest_st_in = '1 14/16 or 1 7/8';
    case 1.9375
        nearest_st_in = '1 15/16';
    case 2
        nearest_st_in = '2';
end

end

