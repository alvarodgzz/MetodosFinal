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
function [yfit,m,c] = lfitplot(x,y,Evx)
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
    /*
    // Aquí se saca la R^2 lineal
    sse = 0
    for i =1 : length(y)
        sse = sse + (y(i) - ((10.9) + (1.1 * x(i))))^2
    end
    // Obtenemos promedio para poder resolver sst después
    sst = 0
    suma = 0
    for i = 1 : length(y)
        suma = suma + y(i)
    end
    promedio = suma/length(y)
    for i = 1 : length(x)
        sst = sst + ((i) - promedio)^2
    end
    rcuadrada = (sst - sse) / sst
    */
    //disp("El valor de R^2 lineal es: "+ string(rcuadrada))
    //plot2d(x,[y ,yfit],[-9,5],leg='Original Data-Points@Fitted Line');
    mstr=string(m);
    cstr=string(c);
    dLineal = c + (m * Evx);
    disp('- Lineal     :   y = '+ '('+cstr+')'+' + '+'('+mstr+ ')'+' * x')
    disp('- Valor Estimado : ' + string(dLineal))
    //xtitle(titleeq);
    xlabel('x-->');
endfunction

//Quadratic Fitting
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
function [A,y2fit] = pfitplot(x,y,n, Evx)
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
    dCuadratica = 0;
    for i= 0:n
        istr=string(i);
        Astr=string(A(i+1));
        if i==0 then
            titleeq ='('+Astr+')'
            dCuadratica = dCuadratica + A(i+1)
        else
            titleeq='('+Astr+')'+' x^'+istr+' + '+titleeq;
            dCuadratica = dCuadratica + A(i+1) * Evx^i
        end
    end
    disp('- Cuadrático :   y = '+titleeq)
    disp('- Valor Estimado : ' + string(dCuadratica))
    //xtitle(titleeq);
    xlabel('x-->');
endfunction
//Exponential Fitting
//To exponentially fit a given set of data-points.
//Written By: Manas Sharma(www.bragitoff.com)
funcprot(0);
function [f,a,c] = expofit(x,y)
    n=size(x+1);
    if n(2)>n(1) then
        n=n(2)
    else
        n=n(1);
    end
    for i=1:n
        Yln(i)=log(y(i));
    end
    xsum=0;
    ysum=0;
    xysum=0;
    x2sum=0;
    for i=1:n
        xsum=x(i)+xsum;
        ysum=Yln(i)+ysum;
        x2sum=x(i)*x(i)+x2sum;
        xysum=x(i)*Yln(i)+xysum;
    end
    a=(n*xysum-xsum*ysum)/(n*x2sum-xsum*xsum);
    b=(x2sum*ysum-xsum*xysum)/(x2sum*n-xsum*xsum);
    c=exp(b);
    for i=1:n
        f(i)=c*exp(a*x(i));
    end
endfunction
//To plot the fitted equation and the observed data-points and display the equation
funcprot(0);
function [y3fit,a,c] = efitplot(x,y,Evx)
    n=size(x);
    if n(2)>n(1) then
        n=n(2)
    else
        n=n(1);
    end
    for i=1:n
        Yln(i)=log(y(i));
    end
    xsum=0;
    ysum=0;
    xysum=0;
    x2sum=0;
    for i=1:n
        xsum=x(i)+xsum;
        ysum=Yln(i)+ysum;
        x2sum=x(i)*x(i)+x2sum;
        xysum=x(i)*Yln(i)+xysum;
    end
    a=(n*xysum-xsum*ysum)/(n*x2sum-xsum*xsum);
    b=(x2sum*ysum-xsum*xysum)/(x2sum*n-xsum*xsum);
    c=exp(b);
    for i=1:n
        y3fit(i)=c*exp(a*x(i));
    end
    x=matrix(x,n,1)
    y=matrix(y,n,1);
    y3fit=matrix(y3fit,n,1);
    clf();
    //plot2d(x,[y,y3fit],[-9,5],leg='Original Data-Points@Fitted Line');
    astr=string(a);
    cstr=string(c);
    disp('- Exponencial:   y = '+ '('+cstr+') * '+ 'e^' + '('+astr+')'+ ' * x')
    dExponencial = (c * ((2.718)^(a * Evx)))
    disp('- Valor Estimado : ' + string(dExponencial))
    //xtitle(titleeq);
    xlabel('x-->');
endfunction

/// main program
datos = leerDatos()
tabla = imprimirDatos(datos)
x = createArrX(tabla)
y = createArrY(tabla)
Evx = input('Para que valor desea estimar? x = ')
disp("I) Modelos: ")
[yfit,m,c] = lfitplot(x,y,Evx)
equation = npolyfit(x,y,2)
[equation , y2fit] = pfitplot(x,y,2,Evx)
[y3fit,a,c] = efitplot(x,y,Evx)
disp("II) Conclusiones: ")
plot2d(x,[y ,yfit],[-9,5],leg='Original Data-Points@Fitted Line');  /// lineal
plot2d(x,[y,y2fit],[-9,6],leg='Original Data-Points@Fitted Line'); /// cuadratico
plot2d(x,[y,y3fit],[-9,4],leg='Original Data-Points@Fitted Line'); /// exponencial
//plot2d(x,y,-size(x))  //dotted points for the original/observed data-points
//plot2d(x,y, size(x)) //red line for the fitted points
//disp(size(tabla, 1))
//disp(x)
//disp(y)
