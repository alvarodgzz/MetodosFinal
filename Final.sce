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
    plot2d(x,[y ,yfit],[-9,5],leg='Original Data-Points@Fitted Line');
    mstr=string(m);
    cstr=string(c);
    titleeq='Equation of the fitted line: '+mstr+'x + '+cstr;
    xtitle(titleeq);
    xlabel('x-->');
endfunction

/// main program
datos = leerDatos()
tabla = imprimirDatos(datos)
x = createArrX(tabla)
y = createArrY(tabla)
//x=[1,2,3,4,5];
//y=[2,4,6,8,10];
[yfit,m,c] = lfitplot(x,y)
//plot2d(x,y,-size(x))  //dotted points for the original/observed data-points
//plot2d(x,y, size(x)) //red line for the fitted points
disp(size(tabla, 1))
disp(x)
disp(y)
