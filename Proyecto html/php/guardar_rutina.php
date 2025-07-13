<?php
$conn = new mysqli("localhost", "root", "", "smart_train");
if ($conn->connect_error) { die("Error de conexión: " . $conn->connect_error); }
$data = json_decode(file_get_contents("php://input"), true);
$id_cliente = intval($data['id_cliente']);
$id_plantilla = intval($data['id_plantilla']);
$id_entrenador = intval($data['id_entrenador']);
$fecha = date('Y-m-d');

// 1. Insertar en Rutinas_Asignadas
$conn->query("INSERT INTO Rutinas_Asignadas (id_cliente, id_plantilla_origen, id_entrenador_asignador, fecha_asignacion, activa) VALUES ($id_cliente, $id_plantilla, $id_entrenador, '$fecha', 1)");
$id_rutina = $conn->insert_id;

// 2. Insertar ejercicios personalizados
foreach($data['ejercicios'] as $ej) {
    $id_ejercicio = intval($ej['id_ejercicio']);
    $series = $conn->real_escape_string($ej['series']);
    $reps = $conn->real_escape_string($ej['repeticiones']);
    $descanso = intval($ej['descanso']);
    $peso = floatval($ej['peso']);
    $orden = intval($ej['orden']);
    $dia = $conn->real_escape_string($ej['dia']);
    $conn->query("INSERT INTO Asignacion_Ejercicios (id_rutina_asignada, id_ejercicio, series, repeticiones, tiempo_descanso_seg, peso_recomendado_kg, orden, dia) VALUES ($id_rutina, $id_ejercicio, '$series', '$reps', $descanso, $peso, $orden, '$dia')");
}
echo json_encode(['ok'=>true]);
?>