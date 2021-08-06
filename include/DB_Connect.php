<?php
class DB_Connect {

    // constructor
    function __construct() {
        
    }

    // destructor
    function __destruct() {
        // $this->close();
    }

    // Conexion a la base de datos
    public function connect() {
        require_once 'include/DB_config.php';
        // conexion a mysql
        $con = mysql_connect(DB_HOST, DB_USER, DB_PASSWORD);
        // seleccion de base de datos
        mysql_select_db(DB_DATABASE);

        // retorna el hilo de conexion
        return $con;
    }

    // Cierra conexion de base de datos
    public function close() {
        mysql_close();
    }

}

?>
