<?php

class DB_Functions {

    private $db;

    // constructor
    function __construct() {
        require_once 'DB_Connect.php';
        // conexion a la base de datos
        $this->db = new DB_Connect();
        $this->db->connect();
    }

    // destructor
    function __destruct() {
        
    }

    /**
     * Cambia contraseña
     * Retorna si fue exitoso TRUE o FALSE
     */
    public function changePasswordByUsername($user, $old_password, $new_password) {
		
		$user = mysql_real_escape_string($user);
		$old_password = mysql_real_escape_string($old_password);
		$new_password = mysql_real_escape_string($new_password);
		
        $result = mysql_query("SELECT * FROM usuario WHERE activo = 1 AND tipo_usuario = '1' AND nombre_usuario = '$user'") or die(mysql_error());
        // Chequea los resultados 
        $no_of_rows = mysql_num_rows($result);
        if ($no_of_rows > 0) {
			$result = mysql_fetch_array($result);
            $salt = $result['fecha_registro'];
            $encrypted_password = $result['clave'];
            $hash = $this->checkhashMD5($salt, $old_password);
            // identifica si las claves son iguales
            if ($encrypted_password == $hash) {
				$result = mysql_query("UPDATE usuario SET clave = '$new_password' WHERE nombre_usuario ='$user' AND activo = 1 AND tipo_usuario = '1'");
				// valida que el cambio fue exitoso
				if ($result) return true;
				else return false;
			}
			else return false;
		}
		else return false;      
    }

    /**
     * Obtiene el usuario por clave y nombre de usuario
     */
    public function getUserByEmailAndPassword($user, $password) {
		$user = mysql_real_escape_string($user);
		$password = mysql_real_escape_string($password);
		
        $result = mysql_query("SELECT * FROM usuario WHERE activo = 1 AND tipo_usuario = '1' AND nombre_usuario = '$user'") or die(mysql_error());
        // valida los resultados
        $no_of_rows = mysql_num_rows($result);
        if ($no_of_rows > 0) {
            $result = mysql_fetch_array($result);
            $salt = $result['fecha_registro'];
            $encrypted_password = $result['clave'];
            $hash = $this->checkhashMD5($salt, $password);
            // valida si las claves son iguales
            if ($encrypted_password == $hash) {
                // autenticacion correcta
                return $result;
            }
        } else {
            // usuario no encontrado
            return false;
        }
    }

    /**
     * Valida si el usuario existe
     */
    public function isUserExisted($user) {
        $result = mysql_query("SELECT NOMBRE_USUARIO from usuario WHERE nombre_usuario = '$user'");
        $no_of_rows = mysql_num_rows($result);
        if ($no_of_rows > 0) {
            // usuario si existe
            return true;
        } else {
            // usuario no encontrado
            return false;
        }
    }
	
	 /**
     * Obtiene los modelos de los pacientes por usuario del sistema
     */
    public function getDashboardByUserId($userid) {
        $result = mysql_query("SELECT `examen_tomografia`.`id` AS idExamen, `tipo_especialidad`.`descripcion` AS especialidadMedico, `personaMedico`.`codigo` AS codigoMedico, CONCAT(`personaMedico`.`nombres`, ' ' , `personaMedico`.`apellidos`) AS nombreMedico, `personaPaciente`.`codigo` AS codigoPaciente, CONCAT(`personaPaciente`.`nombres`, ' ', `personaPaciente`.`apellidos`) AS nombrePaciente, `paciente`.`numero_historia`, `paciente`.`fecha_historia` AS fechaHistoria, DATE_FORMAT(`examen_tomografia`.`fecha_examen`, '%d/%m/%Y %h:%i:%s %p') AS fechaExamen, `examen_tomografia`.`ruta_archivo_examen` AS rutaExamen, `examen_tomografia`.`observaciones`, `usuario`.`id` AS idUsuario, `tipo_examen`.`descripcion` AS tipoExamen, `tipo_examen`.`tipo_icono` AS tipoIcono FROM `usuario` INNER JOIN `persona` `personaMedico` ON (`usuario`.`id_persona` = `personaMedico`.`id`) INNER JOIN `medico` ON (`personaMedico`.`id` = `medico`.`id_persona`) INNER JOIN `tipo_especialidad` ON (`medico`.`id_tipo_especialidad` = `tipo_especialidad`.`id`) INNER JOIN `examen_tomografia` ON (`examen_tomografia`.`id_medico` = `medico`.`id`) INNER JOIN `paciente` ON (`paciente`.`id` = `examen_tomografia`.`id_paciente`) INNER JOIN `persona` `personaPaciente` ON (`paciente`.`id_persona` = `personaPaciente`.`id`) INNER JOIN `tipo_examen` ON (`examen_tomografia`.`id_tipo_examen` = `tipo_examen`.`id`) WHERE `usuario`.`id` = '$userid' AND examen_tomografia.`activo` = 1 ORDER BY `examen_tomografia`.`fecha_examen` DESC") or die(mysql_error());
        // valida los resultados
        $no_of_rows = mysql_num_rows($result);
        if ($no_of_rows > 0) {
			// convierte la respuesta en un array
			$rows = array(); 
			// llena el array con la respuesta de la base de datos
			while($row = mysql_fetch_array($result)) {
			$rows[] = $row;
			}
			return $rows;
        } else {
            // no se encontraron registros
            return false;
        }
    }

    /**
     * Encripta la contraseña
     * @param salt, password
     * Retorna el codigo hash
     */
    public function checkhashMD5($salt, $password) {
		$hash = md5($password . $salt);
        return $hash;
    }

}

?>
