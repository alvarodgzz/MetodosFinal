clear
function dataSheets = leerDatos()
    archivo = input("Cual es el nombre del archivo xls ?",'s');
    dataSheets = readxls(archivo + ".xls");
endfunction

function dataLabor = imprimirDatos(datos)
    dataLabor = datos(1)
endfunction

function array = createArrX(tabla)
    for i = 1 : size(tabla, 1)
       array(i) = tabla(i, 1)
    end
    //s1(2,:)  //get the 2 row of the sheet
endfunction

function array = createArrY(tabla)
    for i = 1 : size(tabla, 1)
       array(i) = tabla(i, 2)
    end
endfunction

//Linear Fit
//To fit a given set of data-points to a line.
//Written By: Manas Sharma(www.bragitoff.com)
/*funcprot(0);
function [f,m,c] = linefit(x,y)
    n=size(x);
    if n(2)<n(1) 
        n=n(2)
    else
        n=n(1);
    end
    xsum=0;
    ysum=0;
    xysum=0;
    x2sum=0;
    for i=1:n
        xsum=x(i)+xsum;
        ysum=y(i)+ysum;
        x2sum=x(i)*x(i)+x2sum;
        xysum=x(i)*y(i)+xysum;
    end
    m=(n*xysum-xsum*ysum)/(n*x2sum-xsum*xsum);
    c=(x2sum*ysum-xsum*xysum)/(x2sum*n-xsum*xsum);
    for i=1:n
        f(i)=m*x(i)+c;
    end
endfunction*/

/// Linear
funcprot(0);
function [yfit,m,c] = lfitplot(x,y)
    n=size(x);
    if n(2)>n(1) then
        n=n(2)
    else
        n=n(1);
    end
    xsum=0;
    ysum=0;
    xysum=0;
    x2sum=0;
    for i=1:n
        xsum=x(i)+xsum;
        ysum=y(i)+ysum;
        x2sum=x(i)*x(i)+x2sum;
        xysum=x(i)*y(i)+xysum;
    end
    m=(n*xysum-xsum*ysum)/(n*x2sum-xsum*xsum);
    c=(x2sum*ysum-xsum*xysum)/(x2sum*n-xsum*xsum);
    for i=1:n
        yfit(i)=m*x(i)+c;
    end
    x=matrix(x,n,1)
    y=matrix(y,n,1);
    yfit=matrix(yfit,n,1);
    clf();
    //plot2d(x,[y ,yfit],[-9,5],leg='Original Data-Points@Fitted Line');
    mstr=string(m);
    cstr=string(c);
    titleeq='Equation of the fitted line: '+mstr+'x + '+cstr;
    xtitle(titleeq);
    xlabel('x-->');
endfunction

//Polynomial Fitting
//To fit a given set of data points to an n-degree polynomial
//Written By: Manas Sharma (www.bragitoff.com)
funcprot(0);
function A = npolyfit(x,y,n)
    format(6);
    N=size(x);
    if N(2)>N(1) then
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
    for i=0:n
        C(i+1)=0;
        for j=1:N
            C(i+1)=C(i+1)+(x(j)^i)*y(j);
        end
    end
    C=-C;
    A=linsolve(B,C);
endfunction
// Cuadratic
funcprot(0);
function [A,y2fit] = pfitplot(x,y,n)
    format(6);
    N=size(x);
    if N(2)>N(1) then
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
    for i=0:n
        C(i+1)=0;
        for j=1:N
            C(i+1)=C(i+1)+(x(j)^i)*y(j);
        end
    end
    C=-C;
    [A,s]=linsolve(B,C);
    for i=1:N
        y2fit(i)=0;
        for j=0:n
            y2fit(i)=y2fit(i)+A(j+1)*x(i)^j;
        end
    end
    x=matrix(x,N,1)
    y=matrix(y,N,1);
    yfit=matrix(y2fit,N,1);
    clf();

    titleeq='';
    for i=0:n
        istr=string(i);
        Astr=string(A(i+1));
        if i==0 then
            titleeq='('+Astr+')'+'x^'+istr
        else
            titleeq='('+Astr+')'+'x^'+istr+'+'+titleeq;
        end
    end
    titleeq='Equation of the fitted poynomial: '+titleeq;
    xtitle(titleeq);
    xlabel('x-->');
endfunction

/// main program
datos = leerDatos()
tabla = imprimirDatos(datos)
x = createArrX(tabla)
y = createArrY(tabla)
equation = npolyfit(x,y,2)
[equation , y2fit] = pfitplot(x,y,2)
[yfit,m,c] = lfitplot(x,y)
plot2d(x,[y ,yfit],[-9,5],leg='Original Data-Points@Fitted Line');  /// lineal
plot2d(x,[y,y2fit],[-9,6],leg='Original Data-Points@Fitted Line'); /// cuadratico
//plot2d(x,y,-size(x))  //dotted points for the original/observed data-points
//plot2d(x,y, size(x)) //red line for the fitted points
disp(size(tabla, 1))
disp(x)
disp(y)
