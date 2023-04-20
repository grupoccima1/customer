<?php
    require_once("../config/conexion.php");
    require_once("../models/Ticket.php");
    
    $ticket = new Ticket();


    switch($_GET["op"]){
        case "guardaryeditar":
            try {
                $ticket->insert_ticket($_POST["usu_id"],$_POST["cat_id"],$_POST["subcat_id"], $_POST["tick_titulo"],$_POST["tick_descrip"]);
                $response = array('success' => true);
                echo json_encode($response);
            }
            catch (exception $e) {
                $response = array('success' => false);
                echo json_encode($response);
            }
           
        break;

        case "listar_x_usu":
            $datos=$ticket->listar_ticket_x_usu($_POST["usu_id"]);
            $data= Array();
            foreach($datos as $row){
                $sub_array = array();
                $sub_array[] = '<a href="" id="'.$row["tick_id"].'" onClick="ver('.$row["tick_id"].');">'.$row["tick_id"].'</a>';
                $sub_array[] = $row["tick_descrip"];
                $sub_array[] = $row["tick_titulo"];//evidencia
                $sub_array[] = $row["resolutor"];
                $sub_array[] = $row["mesa"];
                if ($row["tick_estado"] == "Abierto") {
                    $sub_array[] = '<span class="label label-pill label-success">Abierto</span>';
                } else {
                    $sub_array[] = '<span class="label label-pill label-danger">Cerrado</span>';
                } 
                /* $sub_array[] = date_format($row["fech_crea"],'d-m-Y H:i:s'); */
                $sub_array[] = date("d/m/Y H:i:s", strtotime($row["fech_crea"]));
                $sub_array[] = '<input type="button" id="btnEditar" value="Modificar" onClick="edit('.$row["tick_id"].');"  data-target="miModal2" class="btn btn-inline btn-primary btn-sm ladda-button">';
                $sub_array[] = '<button type="button" onClick="eliminar('.$row["tick_id"].');"  id="'.$row["tick_id"].'" value="Borrar" class="btn btn-danger btn-danger btn-sm ladda-button"><div><i class="">Eliminar</i></div></button>';
                $data [] = $sub_array;
            }

            /* href="eliminar.php?id=<?php echo $row["tick_id"];?>" */

            $results = array(
                "sEcho"=>1,
                "iTotalRecords"=>count($data),
                "iTotalDisplayRecords"=>count($data),
                "aaData"=>$data);
                echo json_encode($results);
        break;

        case "listar":
            $datos=$ticket->listar_ticket();
            $data= Array();
            foreach($datos as $row){
                $sub_array = array();
                $sub_array[] = '<a href="../DetalleTicket/index.php">'.$row["tick_id"].'</a>';
                $sub_array[] = $row["tick_descrip"];
                $sub_array[] = $row["tick_titulo"];//evidencia
                $sub_array[] = $row["resolutor"];
                $sub_array[] = $row["mesa"];
                if ($row["tick_estado"] == "Abierto") {
                    $sub_array[] = '<span class="label label-pill label-success">Abierto</span>';
                } else {
                    $sub_array[] = '<span class="label label-pill label-danger">Cerrado</span>';
                } 
                /* $sub_array[] = date_format($row["fech_crea"],'d-m-Y H:i:s'); */
                $sub_array[] = date("d/m/Y H:i:s", strtotime($row["fech_crea"]));
                $sub_array[] = '<input type="button" id="btnEditar" value="Modificar" onClick="edit('.$row["tick_id"].');"  data-target="miModal2" class="btn btn-inline btn-primary btn-sm ladda-button">';
                $sub_array[] = '<button type="button" onClick="eliminar('.$row["tick_id"].');"  id="'.$row["tick_id"].'" value="Borrar" class="btn btn-danger btn-danger btn-sm ladda-button"><div><i class="">Eliminar</i></div></button>';
                $data [] = $sub_array;
            }

            $results = array(
                "sEcho"=>1,
                "iTotalRecords"=>count($data),
                "iTotalDisplayRecords"=>count($data),
                "aaData"=>$data);
                echo json_encode($results);
        break;

        case "listardetalle":
            $datos=$ticket->listar_ticketdetalle_x_ticket($_POST["tick_id"]);
            ?>
                <?php
                    foreach($datos as $row){
                        ?>
                            <article class="activity-line-item box-typical">
                                    <div class="activity-line-date">
                                        <?php echo date("d/m/Y", strtotime($row["fech_crea"]));?>
                                    </div>
                                    <header class="activity-line-item-header">
                                        <div class="activity-line-item-user">
                                            <div class="activity-line-item-user-photo">
                                                <a href="#">
                                                    <img src="../../public/img/photo-64-2.jpg" alt="">
                                                </a>
                                            </div>
                                            <div class="activity-line-item-user-name"><?php echo $row['usu_nom'].' '.$row['usu_ape']?></div>
                                            <div class="activity-line-item-user-status">
                                                <?php 
                                                    if ($row['rol_id']==1) {
                                                        echo 'Usuario';
                                                    } else {
                                                        echo 'Soporte';
                                                    }
                                                    
                                                ?>
                                            </div>
                                        </div>
                                    </header>
                                    <div class="activity-line-action-list">
                                        <section class="activity-line-action">
                                            <div class="time"><?php echo date("H:i:s", strtotime($row["fech_crea"]));?></div>
                                            <div class="cont">
                                                <div class="cont-in">
                                                    <p>
                                                         <?php echo $row["tickd_descrip"];?>
                                                    </p>
                                                </div>
                                            </div>
                                        </section>

                                    </div>
                            </article>
                        <?php
                    }
                ?>
            <?php
        break;

        case "mostrar":
            $datos=$ticket->listar_ticket_x_id($_POST["tick_id"]);
            if(is_array($datos)==true and count($datos)>0){
                foreach($datos as $row)
                {
                    $output["tick_id"] = $row["tick_id"];
                    $output["usu_id"] = $row["usu_id"];
                    $output["cat_id"] = $row["cat_id"];
                    $output["tick_titulo"] = $row["tick_titulo"];
                    $output["tick_descrip"] = $row["tick_descrip"];
                    if ($row["tick_estado"] == "Abierto") {
                        $output["tick_estado"] = '<span class="label label-pill label-success">Abierto</span>';
                    } else {
                        $output["tick_estado"] = '<span class="label label-pill label-danger">Cerrado</span>';
                    }

                    $output["fech_crea"] = date("d/m/Y H:i:s", strtotime($row["fech_crea"]));
                    $output["usu_nom"] = $row["usu_nom"];
                    $output["usu_ape"] = $row["usu_ape"];
                    $output["cat_nom"] = $row["cat_nom"];
                    $output["subcat_nom"] = $row["subcat_nom"];
                }
                echo json_encode($output);
            }
        break;



        case "modificar":
            try {
                $tick_estado = 'Abierto';
                $tick_resolutor = 'Katia Aguilar';

                if(isset($_POST['tick_estado'])){
                    $tick_estado = $_POST['tick_estado'];
                }
                if(isset($_POST['tick_resolutor'])){
                    $tick_resolutor = $_POST['tick_resolutor']; 
                }
                $ticket->edit_ticket($_POST["tick_id"], $_POST["cat_id"],$_POST["tick_titulo"],$_POST["tick_descrip"], $tick_estado, $tick_resolutor);
                $response = array('success' => true);
                echo json_encode($response);
            }
            catch (exception $e) {
                $response = array('success' => false);
                echo json_encode($response);
            }
        break;

        case "eliminar":
            $ticket->delete_ticket($_POST["tick_id"]);
        break;

        case "insert":
            $ticket->insert_ticket_detalle($_POST["tick_id"],$_POST["usu_id"],$_POST["tickd_descrip"]);
            
        break;
    }

?>
