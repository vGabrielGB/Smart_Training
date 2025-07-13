-- 1. REGISTROS PARA LA TABLA: Grupos_Musculares
-- Se insertan los principales grupos musculares que se trabajan en un gimnasio.
INSERT INTO Grupos_Musculares (nombre_grupo) VALUES
('Pecho'),
('Espalda'),
('Hombros'),
('Bíceps'),
('Tríceps'),
('Piernas (Cuádriceps)'),
('Piernas (Isquiotibiales)'),
('Glúteos'),
('Pantorrillas'),
('Abdomen'),
('Cardio'); 
-- ejercicios cardiovasculares


-- 2. REGISTROS PARA LA TABLA: Tipos_Equipamiento
-- Se insertan los tipos de equipamiento más comunes.
INSERT INTO Tipos_Equipamiento (nombre_equipamiento) VALUES
('Máquina'),
('Barra'),
('Mancuerna'),
('Polea / Cable'),
('Peso Corporal'),
('Kettlebell (Pesa Rusa)'),
('Banda de Resistencia'),
('Balón Medicinal'),
('Cardio (Cinta, Bici, etc.)');


-- Inserción de Datos para la Tabla de Membresias
-- Estos registros definen los planes estándar que ofrece el gimnasio.

INSERT INTO Membresias (nombre_plan, descripcion, duracion_cantidad, duracion_unidad, precio, activa) VALUES
('Plan Mensual', 'Acceso ilimitado por un mes calendario. Se renueva el mismo día de cada mes.', 1, 'MES', 25.00, TRUE),
('Plan Mensual con Entrenador', 'Igual al plan mensual, pero con sesiones de entrenamiento personalizadas.', 1, 'MES', 25.00, TRUE),
('Plan Trimestral', 'Acceso ilimitado por tres meses calendario con un pequeño descuento.', 3, 'MES', 65.00, TRUE),
('Plan Anual', 'La mejor oferta. Acceso ilimitado por un año completo.', 1, 'AÑO', 250.00, TRUE),
('Pase Diario', 'Acceso por un solo día, ideal para visitantes o pruebas.', 1, 'DIA', 5.00, TRUE),
('Plan Semestral', 'Acceso ilimitado por seis meses, con una tarifa preferencial.', 6, 'MES', 125.00, TRUE);


-- Inserción de registros de ejemplo para Tipos_Rutina
INSERT INTO Tipos_Rutina (nombre_tipo, descripcion) VALUES
('Hipertrofia', 'Rutinas enfocadas en el aumento de la masa muscular.'),
('Fuerza', 'Rutinas diseñadas para incrementar la fuerza máxima.'),
('Resistencia', 'Rutinas con más repeticiones y menos descanso para mejorar la resistencia muscular.'),
('Pérdida de Peso', 'Combinación de cardio y pesas para maximizar la quema de calorías.'),
('Funcional', 'Ejercicios que imitan movimientos de la vida diaria para mejorar la condición física general.');

-- Inserción de registros de ejemplo para Metodos_Pago (Contexto Venezuela)
INSERT INTO Metodos_Pago (nombre_metodo) VALUES
('Efectivo (Bs.)'),
('Efectivo (Divisa)'),
('Pago Móvil'),
('Zelle'),
('Transferencia Bancaria'),
('Tarjeta de Débito'),
('Tarjeta de Crédito');

-- =================================================================
-- Script de Inserción para la Tabla Maestra de Ejercicios
-- Asume que los IDs de Grupos_Musculares y Tipos_Equipamiento
-- fueron generados en el orden de los scripts anteriores.
-- =================================================================

-- PECHO (10 Registros)
-- ID Grupo Muscular: 1
-- -----------------------------------------------------------------
INSERT INTO Ejercicios (nombre_ejercicio, id_grupo_principal, musculos_secundarios, id_equipamiento_requerido, descripcion) VALUES
('Press de Banca con Barra', 1, 'Hombros, Tríceps', 2, 'Acuéstese en un banco plano, agarre la barra con las manos un poco más anchas que los hombros y bájela hasta el pecho antes de volver a subir.'),
('Press de Banca Inclinado con Barra', 1, 'Hombros (Deltoide Anterior), Tríceps', 2, 'Similar al press de banca plano, pero en un banco inclinado a 30-45 grados para enfocar la parte superior del pecho.'),
('Press de Banca Declinado con Barra', 1, 'Hombros, Tríceps', 2, 'Realizado en un banco declinado para enfocar la parte inferior del pecho.'),
('Press de Banca con Mancuernas', 1, 'Hombros, Tríceps', 3, 'Permite un mayor rango de movimiento y estabilización que la barra.'),
('Press Inclinado con Mancuernas', 1, 'Hombros (Deltoide Anterior), Tríceps', 3, 'Versión con mancuernas del press inclinado, ideal para el desarrollo simétrico.'),
('Aperturas con Mancuernas', 1, 'Hombros', 3, 'Movimiento de aislamiento que estira y trabaja las fibras pectorales.'),
('Cruce de Poleas (Crossovers)', 1, 'Hombros', 4, 'Ejercicio de aislamiento que proporciona tensión constante en el pecho.'),
('Fondos en Paralelas (Dips)', 1, 'Tríceps, Hombros', 5, 'Inclinando el torso hacia adelante se enfoca más el trabajo en el pecho.'),
('Flexiones (Push-ups)', 1, 'Tríceps, Hombros, Abdomen', 5, 'Ejercicio fundamental de peso corporal para el desarrollo del pectoral.'),
('Press en Máquina (Chest Press)', 1, 'Hombros, Tríceps', 1, 'Alternativa guiada y segura al press de banca libre.');

-- ESPALDA (10 Registros)
-- ID Grupo Muscular: 2
-- -----------------------------------------------------------------
INSERT INTO Ejercicios (nombre_ejercicio, id_grupo_principal, musculos_secundarios, id_equipamiento_requerido, descripcion) VALUES
('Dominadas (Pull-ups)', 2, 'Bíceps, Hombros', 5, 'Ejercicio de peso corporal para desarrollar la amplitud de la espalda (dorsales).'),
('Remo con Barra', 2, 'Bíceps, Hombros', 2, 'Ejercicio compuesto fundamental para dar densidad y grosor a la espalda.'),
('Peso Muerto Convencional', 2, 'Isquiotibiales, Glúteos, Cuádriceps', 2, 'Ejercicio de cuerpo completo con gran énfasis en la espalda baja y alta.'),
('Jalón al Pecho (Lat Pulldown)', 2, 'Bíceps, Hombros', 4, 'Alternativa al dominadas, permite ajustar el peso y enfocar los dorsales.'),
('Remo en Polea Baja (Sentado)', 2, 'Bíceps', 4, 'Ejercicio para trabajar la parte media de la espalda.'),
('Remo con Mancuerna a una mano', 2, 'Bíceps', 3, 'Permite un gran estiramiento y contracción del dorsal de forma unilateral.'),
('Remo en Máquina (T-Bar Row)', 2, 'Bíceps', 1, 'Variación de remo que permite levantar mucho peso de forma controlada.'),
('Hiperextensiones', 2, 'Glúteos, Isquiotibiales', 5, 'Enfocado en fortalecer la zona lumbar.'),
('Encogimientos con Barra (Shrugs)', 2, 'Trapecios', 2, 'Ejercicio específico para el desarrollo de los trapecios.'),
('Pull-over con Mancuerna', 2, 'Pecho, Tríceps', 3, 'Ejercicio que estira los dorsales y el serrato anterior.');

-- PIERNAS (CUÁDRICEPS) (10 Registros)
-- ID Grupo Muscular: 6
-- -----------------------------------------------------------------
INSERT INTO Ejercicios (nombre_ejercicio, id_grupo_principal, musculos_secundarios, id_equipamiento_requerido, descripcion) VALUES
('Sentadilla con Barra (Back Squat)', 6, 'Glúteos, Isquiotibiales, Abdomen', 2, 'El rey de los ejercicios de pierna. Trabaja todo el tren inferior.'),
('Sentadilla Frontal (Front Squat)', 6, 'Glúteos, Abdomen', 2, 'Variación que pone más énfasis en los cuádriceps y requiere más estabilidad del core.'),
('Prensa de Piernas (Leg Press)', 6, 'Glúteos, Isquiotibiales', 1, 'Permite mover mucho peso de forma segura, aislando las piernas.'),
('Zancadas (Lunges) con Mancuernas', 6, 'Glúteos, Isquiotibiales', 3, 'Excelente para el trabajo unilateral, equilibrio y desarrollo de glúteos y cuádriceps.'),
('Extensiones de Cuádriceps en Máquina', 6, 'Ninguno', 1, 'Ejercicio de aislamiento puro para los cuádriceps.'),
('Sentadilla Búlgara con Mancuerna', 6, 'Glúteos', 3, 'Variación de zancada con el pie trasero elevado para mayor dificultad.'),
('Sentadilla Hack en Máquina', 6, 'Glúteos', 1, 'Variación de sentadilla guiada que reduce la tensión en la espalda baja.'),
('Sentadilla Sissy', 6, 'Abdomen', 5, 'Ejercicio de peso corporal avanzado para aislar los cuádriceps.'),
('Subidas al Cajón (Box Step-ups)', 6, 'Glúteos', 3, 'Ejercicio funcional que trabaja la fuerza y estabilidad de cada pierna.'),
('Sentadilla Goblet con Kettlebell', 6, 'Glúteos, Hombros', 6, 'Variación de sentadilla ideal para aprender la técnica correcta.');

-- PIERNAS (ISQUIOTIBIALES) (10 Registros)
-- ID Grupo Muscular: 7
-- -----------------------------------------------------------------
INSERT INTO Ejercicios (nombre_ejercicio, id_grupo_principal, musculos_secundarios, id_equipamiento_requerido, descripcion) VALUES
('Peso Muerto Rumano con Barra', 7, 'Glúteos, Espalda Baja', 2, 'Ejercicio clave para desarrollar la parte posterior de la pierna.'),
('Peso Muerto Rumano con Mancuernas', 7, 'Glúteos, Espalda Baja', 3, 'Versión con mancuernas que permite un movimiento más natural.'),
('Curl Femoral Acostado en Máquina', 7, 'Ninguno', 1, 'Ejercicio de aislamiento para los isquiotibiales.'),
('Curl Femoral Sentado en Máquina', 7, 'Ninguno', 1, 'Variación del curl femoral que trabaja el músculo desde un ángulo diferente.'),
('Buenos Días (Good Mornings)', 7, 'Glúteos, Espalda Baja', 2, 'Ejercicio de bisagra de cadera para fortalecer toda la cadena posterior.'),
('Elevación de Cadera con Barra (Hip Thrust)', 8, 'Isquiotibiales', 2, 'Aunque enfocado en glúteos, tiene una gran activación de isquiotibiales.'),
('Peso Muerto a una Pierna', 7, 'Glúteos, Equilibrio', 3, 'Ejercicio avanzado para fuerza, estabilidad y desarrollo unilateral.'),
('Curl Nórdico', 7, 'Glúteos', 5, 'Ejercicio de peso corporal muy intenso y efectivo para los isquiotibiales.'),
('Swing con Kettlebell', 7, 'Glúteos, Espalda Baja, Hombros', 6, 'Movimiento balístico que desarrolla potencia en la cadena posterior.'),
('Puente de Glúteos', 8, 'Isquiotibiales', 5, 'Ejercicio básico para activar glúteos e isquiotibiales.');

-- REGISTROS RESTANTES (5 por grupo)
-- -----------------------------------------------------------------

-- Hombros (ID: 3)
INSERT INTO Ejercicios (nombre_ejercicio, id_grupo_principal, musculos_secundarios, id_equipamiento_requerido, descripcion) VALUES
('Press Militar con Barra', 3, 'Tríceps', 2, 'Ejercicio compuesto fundamental para el desarrollo de los hombros.'),
('Press Arnold con Mancuernas', 3, 'Tríceps', 3, 'Variación popularizada por Arnold Schwarzenegger que trabaja las tres cabezas del deltoide.'),
('Elevaciones Laterales con Mancuernas', 3, 'Trapecios', 3, 'Ejercicio de aislamiento para dar amplitud a los hombros (cabeza media).'),
('Elevaciones Frontales con Mancuernas', 3, 'Pecho Superior', 3, 'Aísla la cabeza anterior del deltoide.'),
('Pájaros (Bent-Over Dumbbell Raise)', 3, 'Espalda Alta', 3, 'Enfocado en la cabeza posterior del deltoide, crucial para una buena postura.');

-- Bíceps (ID: 4)
INSERT INTO Ejercicios (nombre_ejercicio, id_grupo_principal, musculos_secundarios, id_equipamiento_requerido, descripcion) VALUES
('Curl de Bíceps con Barra', 4, 'Antebrazo', 2, 'El constructor de masa principal para los bíceps.'),
('Curl de Bíceps con Mancuernas (Alterno)', 4, 'Antebrazo', 3, 'Permite concentrarse en cada brazo por separado y supinar la muñeca.'),
('Curl Martillo (Hammer Curl)', 4, 'Antebrazo (Braquial)', 3, 'Trabaja el músculo braquial, dando más grosor al brazo.'),
('Curl en Banco Scott (Predicador)', 4, 'Ninguno', 2, 'Aísla el bíceps al evitar que el cuerpo ayude en el levantamiento.'),
('Curl de Concentración', 4, 'Ninguno', 3, 'Ejercicio de aislamiento estricto para buscar el "pico" del bíceps.');

-- Tríceps (ID: 5)
INSERT INTO Ejercicios (nombre_ejercicio, id_grupo_principal, musculos_secundarios, id_equipamiento_requerido, descripcion) VALUES
('Press Francés con Barra Z', 5, 'Ninguno', 2, 'Excelente para trabajar la cabeza larga del tríceps.'),
('Extensiones de Tríceps en Polea Alta', 5, 'Ninguno', 4, 'Ejercicio de aislamiento muy popular que permite tensión constante.'),
('Fondos entre Bancos', 5, 'Pecho, Hombros', 5, 'Ejercicio de peso corporal que se puede lastrar para mayor intensidad.'),
('Patada de Tríceps (Tricep Kickback)', 5, 'Ninguno', 3, 'Ejercicio de aislamiento para la contracción final del tríceps.'),
('Press de Banca con Agarre Cerrado', 5, 'Pecho, Hombros', 2, 'Variación del press de banca que pone un gran énfasis en los tríceps.');

-- Abdomen (ID: 10)
INSERT INTO Ejercicios (nombre_ejercicio, id_grupo_principal, musculos_secundarios, id_equipamiento_requerido, descripcion) VALUES
('Encogimientos (Crunches)', 10, 'Ninguno', 5, 'Ejercicio básico para la parte superior del abdomen.'),
('Elevación de Piernas Colgado', 10, 'Flexores de cadera', 5, 'Excelente para trabajar la parte inferior del abdomen.'),
('Plancha Abdominal (Plank)', 10, 'Todo el core, Hombros', 5, 'Ejercicio isométrico para la estabilidad de todo el core.'),
('Rueda Abdominal (Ab Wheel)', 10, 'Espalda Baja, Hombros', 1, 'Ejercicio avanzado para la fuerza y estabilidad del core.'),
('Leñador con Polea (Woodchoppers)', 10, 'Oblicuos', 4, 'Ejercicio rotacional para trabajar los oblicuos y el core.');

-- =================================================================
-- Script de Inserción para Plantillas de Rutinas Generales
-- Este script crea 4 rutinas completas (2 de 5 días y 2 de 4 días).
-- Asume que los IDs de los ejercicios y entrenadores ya existen.
-- =================================================================

-- 1. CREACIÓN DE LAS CABECERAS DE LAS PLANTILLAS DE RUTINA
-- -----------------------------------------------------------------
INSERT INTO Rutinas_Plantillas (id_plantilla, nombre_plantilla, descripcion, id_entrenador_creador, id_tipo_rutina) VALUES
(1, 'Rutina de 5 Días - Frecuencia 2 Superior', 'Un split de 5 días con enfoque en hipertrofia, trabajando los grupos musculares del tren superior dos veces por semana.', 1, 1),
(2, 'Rutina de 4 Días - Torso/Pierna Clásica', 'Un split de 4 días que divide el cuerpo en tren superior y tren inferior, ideal para fuerza e hipertrofia.', 1, 1),
(3, 'Rutina de 5 Días - Énfasis en Pecho y Espalda', 'Split de 5 días diseñado para dar prioridad y volumen de entrenamiento al pecho y la espalda.', 1, 1),
(4, 'Rutina de 4 Días - Énfasis en Hombros y Brazos', 'Split de 4 días enfocado en el desarrollo estético de hombros, bíceps y tríceps.', 1, 1);


-- 2. DETALLE DE EJERCICIOS PARA CADA PLANTILLA
-- =================================================================

-- == PLANTILLA 1: Rutina de 5 Días - Frecuencia 2 Superior ==
-- -----------------------------------------------------------------
-- Día 1: Empuje (Pecho, Hombros, Tríceps) - Lunes
INSERT INTO Plantilla_Ejercicios (id_plantilla, id_ejercicio, dia, series, repeticiones, tiempo_descanso_seg, orden) VALUES
(1, 1, 'Lunes', '4', '8-10', 90, 1),
(1, 5, 'Lunes', '3', '10-12', 60, 2),
(1, 41, 'Lunes', '3', '10-12', 60, 3),
(1, 43, 'Lunes', '4', '12-15', 45, 4),
(1, 52, 'Lunes', '3', '10-12', 60, 5);

-- Día 2: Tirón (Espalda, Bíceps) - Martes
INSERT INTO Plantilla_Ejercicios (id_plantilla, id_ejercicio, dia, series, repeticiones, tiempo_descanso_seg, orden) VALUES
(1, 11, 'Martes', '4', '8', 90, 1),
(1, 12, 'Martes', '4', '8-10', 90, 2),
(1, 14, 'Martes', '3', '10-12', 60, 3),
(1, 15, 'Martes', '3', '10-12', 60, 4),
(1, 46, 'Martes', '4', '10-12', 60, 5);

-- Día 3: Pierna - Miércoles
INSERT INTO Plantilla_Ejercicios (id_plantilla, id_ejercicio, dia, series, repeticiones, tiempo_descanso_seg, orden) VALUES
(1, 21, 'Miércoles', '4', '8-10', 120, 1),
(1, 31, 'Miércoles', '4', '8-10', 90, 2),
(1, 24, 'Miércoles', '3', '10-12', 60, 3),
(1, 25, 'Miércoles', '3', '12-15', 60, 4),
(1, 33, 'Miércoles', '3', '12-15', 60, 5);

-- Día 4: Empuje (Énfasis Hombros) - Jueves
INSERT INTO Plantilla_Ejercicios (id_plantilla, id_ejercicio, dia, series, repeticiones, tiempo_descanso_seg, orden) VALUES
(1, 42, 'Jueves', '4', '8-10', 90, 1),
(1, 4, 'Jueves', '3', '10-12', 60, 2),
(1, 7, 'Jueves', '3', '12-15', 60, 3),
(1, 55, 'Jueves', '4', '8-10', 60, 4),
(1, 54, 'Jueves', '3', '12-15', 45, 5);

-- Día 5: Tirón (Énfasis Espalda) - Viernes
INSERT INTO Plantilla_Ejercicios (id_plantilla, id_ejercicio, dia, series, repeticiones, tiempo_descanso_seg, orden) VALUES
(1, 13, 'Viernes', '4', '5-8', 120, 1),
(1, 16, 'Viernes', '4', '8-10', 90, 2),
(1, 17, 'Viernes', '3', '10-12', 60, 3),
(1, 47, 'Viernes', '3', '10-12', 60, 4),
(1, 49, 'Viernes', '3', '12-15', 45, 5);

-- == PLANTILLA 2: Rutina de 4 Días - Torso/Pierna Clásica ==
-- Día 1: Torso (Fuerza) - Lunes
INSERT INTO Plantilla_Ejercicios (id_plantilla, id_ejercicio, dia, series, repeticiones, tiempo_descanso_seg, orden) VALUES
(2, 1, 'Lunes', '4', '5-8', 120, 1),
(2, 12, 'Lunes', '4', '5-8', 120, 2),
(2, 41, 'Lunes', '3', '6-8', 90, 3),
(2, 11, 'Lunes', '3', 'Al fallo', 90, 4),
(2, 53, 'Lunes', '3', '8-10', 60, 5);

-- Día 2: Pierna (Fuerza) - Martes
INSERT INTO Plantilla_Ejercicios (id_plantilla, id_ejercicio, dia, series, repeticiones, tiempo_descanso_seg, orden) VALUES
(2, 21, 'Martes', '4', '5-8', 120, 1),
(2, 31, 'Martes', '4', '6-8', 90, 2),
(2, 23, 'Martes', '3', '8-10', 90, 3),
(2, 33, 'Martes', '3', '10-12', 60, 4),
(2, 58, 'Martes', '4', '15-20', 45, 5);

-- Día 3: Torso (Hipertrofia) - Jueves
INSERT INTO Plantilla_Ejercicios (id_plantilla, id_ejercicio, dia, series, repeticiones, tiempo_descanso_seg, orden) VALUES
(2, 5, 'Jueves', '4', '10-12', 60, 1),
(2, 14, 'Jueves', '4', '10-12', 60, 2),
(2, 43, 'Jueves', '4', '12-15', 45, 3),
(2, 47, 'Jueves', '3', '10-12', 60, 4),
(2, 52, 'Jueves', '3', '10-12', 60, 5);

-- Día 4: Pierna (Hipertrofia) - Viernes
INSERT INTO Plantilla_Ejercicios (id_plantilla, id_ejercicio, dia, series, repeticiones, tiempo_descanso_seg, orden) VALUES
(2, 24, 'Viernes', '4', '10-12', 60, 1),
(2, 36, 'Viernes', '4', '10-12', 60, 2),
(2, 25, 'Viernes', '3', '12-15', 45, 3),
(2, 34, 'Viernes', '3', '12-15', 45, 4),
(2, 57, 'Viernes', '3', '15-20', 45, 5);

-- == PLANTILLA 3: Rutina de 5 Días - Énfasis en Pecho y Espalda ==
-- Día 1: Pecho y Hombros - Lunes
INSERT INTO Plantilla_Ejercicios (id_plantilla, id_ejercicio, dia, series, repeticiones, tiempo_descanso_seg, orden) VALUES
(3, 1, 'Lunes', '4', '8-10', 90, 1),
(3, 5, 'Lunes', '4', '10-12', 60, 2),
(3, 7, 'Lunes', '3', '12-15', 60, 3),
(3, 43, 'Lunes', '4', '12-15', 45, 4),
(3, 44, 'Lunes', '3', '12-15', 45, 5);

-- Día 2: Espalda - Martes
INSERT INTO Plantilla_Ejercicios (id_plantilla, id_ejercicio, dia, series, repeticiones, tiempo_descanso_seg, orden) VALUES
(3, 13, 'Martes', '4', '5', 120, 1),
(3, 11, 'Martes', '4', 'Al fallo', 90, 2),
(3, 12, 'Martes', '3', '8-10', 90, 3),
(3, 15, 'Martes', '3', '10-12', 60, 4);

-- Día 3: Piernas - Miércoles
INSERT INTO Plantilla_Ejercicios (id_plantilla, id_ejercicio, dia, series, repeticiones, tiempo_descanso_seg, orden) VALUES
(3, 21, 'Miércoles', '4', '8-10', 120, 1),
(3, 31, 'Miércoles', '4', '8-10', 90, 2),
(3, 23, 'Miércoles', '3', '10-12', 90, 3),
(3, 25, 'Miércoles', '3', '15', 60, 4),
(3, 33, 'Miércoles', '3', '15', 60, 5);

-- Día 4: Pecho y Tríceps - Jueves
INSERT INTO Plantilla_Ejercicios (id_plantilla, id_ejercicio, dia, series, repeticiones, tiempo_descanso_seg, orden) VALUES
(3, 4, 'Jueves', '4', '8-10', 90, 1),
(3, 2, 'Jueves', '4', '10-12', 60, 2),
(3, 8, 'Jueves', '3', '10-12', 60, 3),
(3, 51, 'Jueves', '4', '10-12', 60, 4),
(3, 52, 'Jueves', '4', '10-12', 60, 5);

-- Día 5: Espalda y Bíceps - Viernes
INSERT INTO Plantilla_Ejercicios (id_plantilla, id_ejercicio, dia, series, repeticiones, tiempo_descanso_seg, orden) VALUES
(3, 14, 'Viernes', '4', '8-10', 90, 1),
(3, 16, 'Viernes', '4', '10-12', 60, 2),
(3, 17, 'Viernes', '3', '10-12', 60, 3),
(3, 46, 'Viernes', '4', '8-10', 60, 4),
(3, 48, 'Viernes', '4', '10-12', 60, 5);

-- == PLANTILLA 4: Rutina de 4 Días - Énfasis en Hombros y Brazos ==
-- Día 1: Pecho y Tríceps - Lunes
INSERT INTO Plantilla_Ejercicios (id_plantilla, id_ejercicio, dia, series, repeticiones, tiempo_descanso_seg, orden) VALUES
(4, 1, 'Lunes', '4', '8-12', 90, 1),
(4, 5, 'Lunes', '4', '10-12', 60, 2),
(4, 55, 'Lunes', '3', '8-10', 90, 3),
(4, 52, 'Lunes', '3', '12-15', 60, 4),
(4, 51, 'Lunes', '3', '12-15', 60, 5);

-- Día 2: Espalda y Bíceps - Martes
INSERT INTO Plantilla_Ejercicios (id_plantilla, id_ejercicio, dia, series, repeticiones, tiempo_descanso_seg, orden) VALUES
(4, 11, 'Martes', '4', 'Al fallo', 90, 1),
(4, 12, 'Martes', '4', '8-12', 90, 2),
(4, 15, 'Martes', '3', '10-12', 60, 3),
(4, 46, 'Martes', '3', '8-10', 60, 4),
(4, 48, 'Martes', '3', '12-15', 60, 5);

-- Día 3: Piernas - Jueves
INSERT INTO Plantilla_Ejercicios (id_plantilla, id_ejercicio, dia, series, repeticiones, tiempo_descanso_seg, orden) VALUES
(4, 21, 'Jueves', '4', '10-12', 90, 1),
(4, 24, 'Jueves', '4', '12-15', 60, 2),
(4, 31, 'Jueves', '3', '10-12', 90, 3),
(4, 33, 'Jueves', '3', '15', 60, 4);

-- Día 4: Hombros y Brazos (Bíceps/Tríceps) - Viernes
INSERT INTO Plantilla_Ejercicios (id_plantilla, id_ejercicio, dia, series, repeticiones, tiempo_descanso_seg, orden) VALUES
(4, 41, 'Viernes', '4', '8-10', 90, 1),
(4, 43, 'Viernes', '4', '12-15', 45, 2),
(4, 45, 'Viernes', '3', '12-15', 45, 3),
(4, 49, 'Viernes', '3', '10-12', 60, 4),
(4, 54, 'Viernes', '3', '12-15', 45, 5);