clear
function dataSheets = leerDatos()
    archivo = input("Cual es el nombre del archivo xls ?",'s');
    dataSheets = readxls(archivo + ".xls");
endfunction

function dataLabor = imprimirDatos(datos)
    dataLabor = datos(1)
endfunction

function array = createArrX(tabla)
    array = tabla(:, 1)
endfunction

function array = createArrY(tabla)
    array = tabla(:, 2)
endfunction
/// main program
datos = leerDatos()
tabla = imprimirDatos(datos)
x = createArrX(tabla)
y = createArrY(tabla)
disp(x)
disp(y)
