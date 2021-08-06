<?php

/*
|-----------------
| Session id
|------------------
*/
session_start();
if (!isset($_SESSION["userid"])){
	print "<p>Debe iniciar sesion</p>\n";
	return;
}
/*
|-----------------
| Manejo de Errores
|------------------
*/

error_reporting(-1);

/*
|-----------------
| Constante con la direccion de los archivos de descarga
|------------------
*/
//Ruta del repositorio de modelos
define( "FSROOT", "C:/" );
/*
|-----------------
| clase para el manejo de las descargas
|------------------
*/

require_once("/include/class.chip_download.php");

/*
|-----------------
| Instancia de la clase
|------------------
*/

$download_path = FSROOT . "download/";
$file = $_REQUEST['f'];

$args = array(
		'download_path'		=>	$download_path,
		'file'				=>	$file,		
		'extension_check'	=>	TRUE,
		'referrer_check'	=>	FALSE,
		'referrer'			=>	NULL,
		);

	$download = new chip_download( $args );

/*
|-----------------
| Descarga
|------------------
*/
$download_hook = $download->get_download_hook();

if( $download_hook['download'] == TRUE ) {
	$download->get_download();
}

?>