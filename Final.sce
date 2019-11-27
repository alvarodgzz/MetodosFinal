//Linear Regression Function
/*
x  = rand(5, 100);
aa = testmatrix("magi", 5); aa = aa(1:3, :);
bb = [9; 10; 11];
y  = aa*x +bb*ones(1, 100)+ 0.1*rand(3, 100);

// Identification
[a, b, sig] = reglin(x, y);
max(abs(aa-a))
max(abs(bb-b))

// Another example: fitting a polynomial
f = 1:100; x = [f.*f; f];
y = [2 3]*x + 10*ones(f) + 0.1*rand(f);
[a, b] = reglin(x, y)

// Generating an odd function (symmetric with respect to the origin)
x = -30:30;
y = x.^3;

// Extracting the least square mean of that function and displaying

[a, b] = reglin(x, y);
plot(x, y, "red")
plot(x, a*x+b)
*/

//Polynomial Fitting
//To fit a given set of data points to an n-degree polynomial
//Written By: Manas Sharma (www.bragitoff.com)
funcprot(0);
function A=npolyfit(x,y,n)
    format(6);
    N=size(x);
    if N(2)>N(1) 
        N=N(2)
    else
        N=N(1);
    end
    X(1)=N;
    for i=1:2*n
        X(i+1)=0;
        for j=1:N
            X(i+1)=X(i+1)+x(j)^i;
        end 
    end
    for i=1:n+1
        for j=1:n+1
            B(i,j)=X(i+j-1)
        end
    end
    disp(B);
    for i=0:n
        C(i+1)=0;
        for j=1:N
            C(i+1)=C(i+1)+(x(j)^i)*y(j);
        end
    end
    C=-C;
    disp(C);
    A=linsolve(B,C);
endfunction
    
    /*x=[1,2,3,4,5];
y=[1.6,7.5,24.6,66,130];
a=npolyfit(x,y,2)
yfit=f(x);
plot2d(x,y,-5)
plot2d(x,yfit,5)*/

    
