theta = atan(5/2);
phi = acos(7/sqrt(78));

Ru = Rz(phi)*Ry(theta)*Rz(deg2rad(47))*Ry(-theta)*Rz(-phi);
Ru*[1 2 3]'

function matrix = Rx(x)
    matrix = [1, 0, 0; 
              0, cos(x), -sin(x);
              0, sin(x), cos(x)];
end

function matrix = Ry(x)
    matrix = [cos(x), 0, sin(x);
              0, 1, 0;
              -sin(x), 0, cos(x)];
end

function matrix = Rz(x)
    matrix = [cos(x), -sin(x), 0;
              sin(x), cos(x), 0;
              0, 0, 1];
end

