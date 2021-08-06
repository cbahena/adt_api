<?php

/**
 * Maneja las solicitudes de la API
 * para metodos POST
 * 
 * Cada solicitud esta basada en un TAG 
 * La respuesta es en formato JSON

 /**
 * Chequea el tipo de solicitud
 */
if (isset($_POST['tag']) && $_POST['tag'] != '') {
    // Obtiene el tag
    $tag = $_POST['tag'];

    // incluye el manejador de BD
    require_once 'include/DB_Functions.php';
    $db = new DB_Functions();

    // Array de respuesta
    $response = array("tag" => $tag, "success" => 0, "error" => 0);

    // Chequea el tipo de tag
    if ($tag == 'login') {
        $email = $_POST['email'];
        $password = $_POST['password'];

        // Chequea el ussuario
        $user = $db->getUserByEmailAndPassword($email, $password);
        if ($user != false) {
            // usuario encontrado inicia sesion
			session_start(); 
			$_SESSION['userid'] = $user["id"];

            $response["success"] = 1;
            $response["id"] = $user["id"];
            $response["user"]["name"] = $user["nombre_usuario"];
            $response["user"]["created_at"] = $user["fecha_registro"];
            echo json_encode($response);
        } else {
            // usuario no encontrado
            //retorna error = 1
            $response["error"] = 1;
            $response["error_msg"] = "Usuario o contraseña incorrecta";
            echo json_encode($response);
        }
    } else if ($tag == 'dashboard') {

        $userid = $_POST['userid'];
		
        // Consulta la bandeja de entrada
        $response = $db->getDashboardByUserId($userid);
		if ($response != false) {
			echo json_encode($response);
		 } else {
            // usuario no encontrado
            // error 3
            $response["error"] = 3;
            $response["error_msg"] = "No data found";
            echo json_encode($response);
        }
    } 
	else if ($tag == 'change_password') {
        // cambio de contraseña
        $user = $_POST['user'];
        $old_password = $_POST['old_password'];
        $new_password = $_POST['new_password'];

        // consulta si el usuario existe
        if (!$db->isUserExisted($user)) {
            // usuario no existe retorna error
            $response["error"] = 2;
            $response["error_msg"] = "Usuario no existe";
            echo json_encode($response);
        } else {
            // almacena la nueva contraseña
            $auth = $db->changePasswordByUsername($user, $old_password, $new_password);
            if ($auth) {
                // cambio de clave exitosa
                $response["success"] = 1;
				$response["id"] = 1;
				$response["user"]["name"] = $user;
				$response["user"]["created_at"] = date('d/m/Y');
                echo json_encode($response);
            } else {
                // error al actualizar
                $response["error"] = 1;
                $response["error_msg"] = "Usuario incorrecto, clave invalida, usuario inactivo o tipo de usuario administrador";
                echo json_encode($response);
            }
        }
		//Cierre de sesion
    }else if ($tag == 'logout') {
		session_start();  
		if(isset($_SESSION['userid'])){
			unset($_SESSION['userid']); 
			session_destroy();
		}
	}		
	else {
        echo "Invalid Request";
    }
} else {
    echo "Access Denied";
}
?>
