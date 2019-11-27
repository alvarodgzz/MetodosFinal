clear

////////////////////////////////////////////////////
// Final.sce
// Este programa calcula las ecuaciones de el resultado de un ajuste lineal, cuadrático, exponencial y potencial de un set de datos X y Y
// También, calcula el coeficiente r^2 para determinar la regresión más acertada, evalúa en un valor a aproximar, grafica las ecuaciones 
// resultantes y analiza cuáles datos son los más alejados del emjro ajuste.
// Melba Geraldine Consuelos Fernández    
// A01410921
// Alvaro Rodríguez
// A0
// 27/11/2019 versión 1.0
////////////////////////////////////////////////////
global r2L
global r2C
global r2E
global r2P

//Esta función nos permite leer una X y una Y de una tabla desde un archivo .XLS, dejando que el usuario especifique el nombre del archivo a leer.
function dataSheets = leerDatos()
    archivo = input("Cual es el nombre del archivo xls ?",'s');
    dataSheets = readxls(archivo + ".xls");
endfunction
//función que imprime los datos para comprobar que estén correctos.
function dataLabor = imprimirDatos(datos)
    dataLabor = datos(1)
endfunction
//Esta función asigna la primera columna de datos a un arreglo, guardando los valores de X
function array = createArrX(tabla)
    for i = 1 : size(tabla, 1)
       array(i) = tabla(i, 1)
    end 
endfunction
//Esta función asigna la segunda columna de datos a un arreglo, guardando los valores en Y
function array = createArrY(tabla)
    for i = 1 : size(tabla, 1)
       array(i) = tabla(i, 2)
    end
endfunction



/// Linear
//Aquí sacamos los valores de la ecuación de la regresión lineal, para después graficarla con las nuevas variables 'y' sacadas del ajuste 
funcprot(0);
function [yfit,m,c] = lfitplot(x,y,Evx,media, tabla)
    n=size(x);
    if n(2)>n(1) then
        n=n(2)
    else
        n=n(1);
    end
    xsum=0;         //// Inicialización de las sumatorias
    ysum=0;
    xysum=0;
    x2sum=0;
    yminusfit=0;
    for i=1:n          //// ciclo en donde se realizan las sumatorias
        xsum=x(i)+xsum;
        ysum=y(i)+ysum;
        x2sum=x(i)*x(i)+x2sum;
        xysum=x(i)*y(i)+xysum;
    end
    m =(n*xysum-xsum*ysum)/(n*x2sum-xsum*xsum);
    c =(x2sum*ysum-xsum*xysum)/(x2sum*n-xsum*xsum);
    for i=1:n
        yfit(i)=m*x(i)+c;
        
    end
    x = matrix(x,n,1)
    y = matrix(y,n,1);
    yfit= matrix(yfit,n,1);
    clf();
    mstr=string(m);
    cstr=string(c);
    dLineal = c + (m * Evx);
    
    sst = 0
    for i = 1 : size(tabla,1)
         sst = sst + (tabla(i,2) - media)^2
    end
    
    ssr = 0
    for i = 1 : size(tabla,1)
         ssr = ssr + (y(i,1) - (c + (m * x(i,1))))^2
    end
    r2 = (sst - ssr)/ sst
    global r2L
    r2L = r2
    disp('- Lineal     :   y = '+ '('+cstr+')'+' + '+'('+mstr+ ')'+' * x , ' + string(r2))
    disp('- Valor Estimado : ' + string(dLineal))
    //xtitle(titleeq);
    xlabel('x-->');
endfunction

//Regresión Cuadrática
//En esta función, sacamos el valor de la regresión cuadrática para los puntos dados, regresando los coeficientes de la nueva equación.
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

// En esta segunda función para la regresión cuadrática, usamos los valores calculados en la función de regresión para calcular sus valores de 'Y' ajustada con los valores en X
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
    sst = 0
    for i = 1 : size(tabla,1)
         sst = sst + (tabla(i,2) - media)^2
    end
    
    ssr = 0
    for i = 1 : size(tabla,1)
         ssr = ssr + (y(i,1) - (cuad(A, x(i,1))))^2
    end
    r2 = (sst - ssr)/ sst
    global r2C
    r2C = r2
    disp('- Cuadrático :   y = '+titleeq+ ', r^2 =  '+ string(r2))
    disp('- Valor Estimado : ' + string(dCuadratica))
    //xtitle(titleeq);
    xlabel('x-->');
endfunction

function evaluado = cuad(A, valX)
    dCuadratica = 0
    for i= 0:2
        if i==0 then
            dCuadratica = dCuadratica + A(i+1)
        else
            dCuadratica = dCuadratica + A(i+1) * valX^i
        end
    end
    evaluado = dCuadratica
endfunction
/// Exponencial
//Esta segunda funcion de regresión exponencial ayuda a relacionar los puntos X con las Y ajustadas para poder graficarla.
funcprot(0);
function [y3fit,a,c] = efitplot(x,y,Evx, tabla)
    n=size(x);
    if n(2)>n(1) then
        n=n(2)
    else
        n=n(1);
    end
    for i=1:n
        Yln(i)=log(y(i));
    end
    xsum=0;           ///  Inicializacion de las sumatorias
    ysum=0;
    xysum=0;
    x2sum=0;
    for i=1:n         /// Ciclco para la realización de las sumatorias
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
    dExponencial = (c * ((%e)^(a * Evx)))
    lnMean = 0
    suma = 0
    for i = 1 : size(tabla, 1)
        suma = suma + log(tabla(i, 2))
    end
    lnMean = suma / size(tabla, 1)
    sst = 0
    for i = 1 : size(tabla,1)
         sst = sst + (log(tabla(i,2)) - lnMean)^2
    end
    
    ssr = 0
    for i = 1 : size(tabla,1)
         ssr = ssr + (log(y(i,1)) - log((c * ((%e)^(a * x(i,1))))))^2
    end
    r2 = (sst - ssr)/ sst
    global r2E
    r2E = r2
    disp('- Exponencial:   y = '+ '('+cstr+') * '+ 'e^' + '('+astr+')'+ ' * x, r^2 = ' + string(r2))
    disp('- Valor Estimado : ' + string(dExponencial))
    //xtitle(titleeq);
    xlabel('x-->');
endfunction

//Potencia
//Esta segunda funcion de regresión exponencial ayuda a relacionar los puntos X con las Y ajustadas para poder graficarla.
funcprot(0);
function [y4fit,a,c] = pofitplot(x,y,Evx)
    n=size(x);
    if n(2)>n(1) then
        n=n(2)
    else
        n=n(1);
    end
    for i=1:n
        Yln(i)=log(y(i));
    end
    xsum=0;          /// Inicialización de las sumatorias
    ysum=0;
    xysum=0;
    x2sum=0;
    
    for i=1:n
        Yln(i)=log(y(i));
        Xln(i)=log(x(i));
    end
    
    for i=1:n        /// Ciclo para la realización de las sumatorias
        xsum=Xln(i)+xsum;
        ysum=Yln(i)+ysum;
        x2sum=(Xln(i))^2 +x2sum;
        xysum= (Xln(i)* Yln(i)) + xysum;
    end
    a=(n*xysum-xsum*ysum)/(n*x2sum-xsum*xsum);
    b=(x2sum*ysum-xsum*xysum)/(x2sum*n-xsum*xsum);
    c = exp(b);
    for i=1:n
        y4fit(i)= (c * (x(i))^a);
    end
    x=matrix(x,n,1)
    y=matrix(y,n,1);
    y4fit=matrix(y4fit,n,1);
    clf();
    //plot2d(x,[y,y3fit],[-9,5],leg='Original Data-Points@Fitted Line');
    astr=string(a);
    cstr=string(c);
    dPotencial = (c*Evx^a)
    lnMean = 0
    suma = 0
    for i = 1 : size(tabla, 1)
        suma = suma + log(tabla(i, 2))
    end
    lnMean = suma / size(tabla, 1)
    sst = 0
    for i = 1 : size(tabla,1)
         sst = sst + (log(tabla(i,2)) - lnMean)^2
    end
    
    ssr = 0
    for i = 1 : size(tabla,1)
         ssr = ssr + (log(y(i,1)) - log(c*x(i,1)^a))^2
    end
    r2 = (sst - ssr)/ sst
    global r2P
    r2P = r2
    disp('- Potencial:   y = ('+cstr+') * '+ 'x^('+astr+'), r^2 = ' + string(r2))
    disp('- Valor Estimado : ' + string(dPotencial))
    //xtitle(titleeq);
    xlabel('x-->');
endfunction

function media = getMedia(y, tabla)
    suma = 0
    for i = 1 : size(tabla, 1)
        suma = suma + tabla(i, 2)
    end
    media = suma / size(tabla, 1)
endfunction

function sst = getSST(tabla, media, flag)
    if  (flag == 0)
        sst = 0
        for i = 1 : size(tabla, 1)
            sst = sst + (tabla(i,2) - media)^2
        end
    else
        sst = 0
        for i = 1 : size(tabla, 1)
            sst = sst + (log(tabla(i,2)) - media)^2
        end
    end
endfunction

function [mejorR, reg] = getMejorR()
    rBuena = r2L
    reg = 'Lineal'
    if (rBuena < r2C)
        rBuena = r2C
        reg = 'Cuadratica'
    end
    if (rBuena < r2E)
        rBuena = r2E
        reg = 'Exponencial'
    end
    if (rBuena < r2P)
        rBuena = r2P
        reg = 'Potencial'
    end
    mejorR = rBuena
endfunction
/// main program
datos = leerDatos()
tabla = imprimirDatos(datos)
x = createArrX(tabla)
y = createArrY(tabla)
Evx = input('Para que valor desea estimar? x = ')
disp("I) Modelos: ")
media = getMedia(y, tabla)
[yfit,m,c] = lfitplot(x,y,Evx, media,tabla)    ///lineal
equation = npolyfit(x,y,2)
[equation , y2fit] = pfitplot(x,y,2,Evx)
[y3fit,a,c] = efitplot(x,y,Evx)
[y4fit,a,c] = pofitplot(x,y,Evx)
disp("II) Conclusiones: ")
[rFinal, regresion] = getMejorR()
disp('La mejor regresion es ' + regresion + ' : ' + string(rFinal))
/*
sstL = (media, tabla, 0)
sstC = (media, tabla, 0)
sstE = (media, tabla, 1)
sstP = (media, tabla, 1)
*/
//disp(media)
plot2d(x,[y ,yfit],[-9,5],leg='Original Data-Points@Fitted Line');  /// lineal
plot2d(x,[y,y2fit],[-9,6],leg='Original Data-Points@Fitted Line'); /// cuadratico
plot2d(x,[y,y3fit],[-9,4],leg='Original Data-Points@Fitted Line'); /// exponencial
plot2d(x,[y,y4fit],[-9,3],leg='Original Data-Points@Fitted Line'); /// potencial
//plot2d(x,y,-size(x))  //dotted points for the original/observed data-points
//plot2d(x,y, size(x)) //red line for the fitted points
//disp(size(tabla, 1))
//disp(x)
//disp(y)
