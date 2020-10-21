function[AN]=transformaciones(A,type)
% cada columna en A representa los componenetes x,y,z de un punto
%type=1 para realizar translaciones, 2 para rotaciones sobre ejes
%arbitrarios, 3 para rotacion sobre recta arbitraria
[r,c]=size(A);
A=[A;ones(1,c)];
T=@(x,y,z) [1 0  0 x;0 1 0 y;0 0 1 z; 0 0 0 1];
Rz=@(x)[cos(x) -sin(x) 0 0; sin(x) cos(x) 0 0;0 0 1 0;0 0 0 1];
Ry=@(x)[cos(x) 0 sin(x) 0;0 1 0 0;-sin(x) 0 cos(x) 0;0 0 0 1];
Rx=@(x)[1 0 0 0;0 cos(x) -sin(x) 0;0 sin(x) cos(x) 0;0 0 0 1];
switch type
    case 1 %Translación
        x=input('escriba x,y,z en formato [x y z]: ');
        AN=T(x(1),x(2),x(3))*A;
        AN=AN(1:end-1,:);
    case 2 %Rotación
        x=input('escriba la recta del eje de giro en formato [x y z]: ');
        x0=input('punto por el que pasa la recta, formato [x0 y0 z0]: ');
        alpha=input('escriba el ángulo de giro: ');
        n=x/norm(x);
        M=[0 -alpha*n(3) alpha*n(2); alpha*n(3) 0 -alpha*n(1);-alpha*n(2) alpha*n(1) 0];
        Ru=expm(M);
        Ru=[Ru,zeros(3,1)]; Ru=[Ru;[0 0 0 1]];
        AN=T(x0(1),x0(2),x0(3))*Ru*T(-x0(1),-x0(2),-x0(3))*A;
        AN=AN(1:end-1,:);       
    case 3 %Reflexión
        cord=input('para vector en cartesianas inserte 1, esfericas 2: ');
        if cord==1
            x=input('escriba la recta de reflexión en formato [x y z]: ');
            theta=acos(x(3)/norm(x));
            if x(1)<0 && x(2)>=0
                phi=pi-atan(x(2)/x(1));
            elseif x(1)<0 && x(2)<0
                phi=pi+atan(x(2)/x(1));
            else
                phi=atan(x(2)/x(1));
            end
        else
            x=input('escriba la recta de reflexión en formato [theta, phi]: ');
            theta=x(1);phi=x(2);
        end
        x0=input('punto por el que pasa la recta, formato [x0 y0 z0]: ');
        M=[1 0 0 0;0 1 0 0;0 0 -1 0;0 0 0 1];
        AN=T(x0(1),x0(2),x0(3))*Rz(phi)*Ry(theta)*M*Ry(-theta)*Rz(-phi)*T(-x0(1),-x0(2),-x0(3))*A;
        AN=AN(1:end-1,:);
end
end