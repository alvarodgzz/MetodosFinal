clear
function dataSheets = leerDatos()
    archivo = input("Cual es el nombre del archivo xls ?",'s');
    dataSheets = readxls(archivo + ".xls");
endfunction

function dataLabor = imprimirDatos(datos)
    dataLabor = datos(1)
endfunction
/// main program
datos = leerDatos()
tabla = imprimirDatos(datos)
disp(tabla)
