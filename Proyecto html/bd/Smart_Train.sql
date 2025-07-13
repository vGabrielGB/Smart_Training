-- =================================================================
-- Script SQL para Gestión de Usuarios y Membresías (Modelo Profesional)
-- =================================================================

-- 1. TABLA CENTRAL: Usuarios
-- No cambia. Sigue siendo la base con los datos comunes.
-- -----------------------------------------------------------------
CREATE TABLE Usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    cedula VARCHAR(15) UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    rol ENUM('CLIENTE', 'ENTRENADOR', 'ADMIN') NOT NULL
);

-- 2. TABLA DE ESPECIALIZACIÓN: Entrenadores_Detalles
-- No cambia. Sigue guardando los datos específicos de los entrenadores.
-- -----------------------------------------------------------------
CREATE TABLE Entrenadores_Detalles (
    usuario_id INT PRIMARY KEY,
    especialidad VARCHAR(100),
    biografia TEXT,
    numero_certificado VARCHAR(50),
    fecha_contratacion DATE,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE
);

-- 3. NUEVA TABLA: Membresias
-- Aquí se definen todos los planes que ofrece el gimnasio.
-- Es el catálogo de lo que los clientes pueden comprar.
-- La duración ahora se maneja con una cantidad y una unidad (mes/año).
-- -----------------------------------------------------------------
CREATE TABLE Membresias (
    id_membresia INT PRIMARY KEY AUTO_INCREMENT,
    nombre_plan VARCHAR(100) NOT NULL,
    descripcion TEXT,
    duracion_cantidad INT NOT NULL, -- Ej: 1, 3, 12
    duracion_unidad ENUM('DIA', 'MES', 'AÑO') NOT NULL, -- Ej: 'MES' para un plan mensual
    precio DECIMAL(10, 2) NOT NULL,
    activa BOOLEAN DEFAULT TRUE -- Para poder desactivar planes antiguos sin borrarlos
);

-- 4. TABLA MODIFICADA: Clientes_Detalles
-- Ahora esta tabla solo contiene datos físicos del cliente.
-- La información sobre su membresía activa se gestionará en la tabla de historial.
-- -----------------------------------------------------------------
CREATE TABLE Clientes_Detalles (
    usuario_id INT PRIMARY KEY,
    estatura_cm DECIMAL(5, 2),
    peso_kg DECIMAL(5, 2),
    objetivos TEXT,
    condiciones_medicas TEXT,
    nivel_cliente ENUM('PRINCIPIANTE', 'AVANZADO') DEFAULT 'PRINCIPIANTE',
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE
);


-- 1. TABLA: Tipos_Rutina
-- Para categorizar las plantillas de rutinas y facilitar su búsqueda y asignación.
-- -----------------------------------------------------------------
CREATE TABLE Tipos_Rutina (
    id_tipo_rutina INT PRIMARY KEY AUTO_INCREMENT,
    nombre_tipo VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT
);

-- 2. TABLA: Metodos_Pago
-- Para estandarizar los métodos de pago aceptados y llevar un registro contable limpio.
-- -----------------------------------------------------------------
CREATE TABLE Metodos_Pago (
    id_metodo_pago INT PRIMARY KEY AUTO_INCREMENT,
    nombre_metodo VARCHAR(100) NOT NULL UNIQUE
);


-- 5. NUEVA TABLA DE REGISTRO: Historial_Pagos
-- ¡Esta es la tabla clave! Registra cada compra de membresía.
-- Permite saber qué plan tiene activo un cliente y cuándo expira.
-- -----------------------------------------------------------------

CREATE TABLE Historial_Pagos (
    id_pago INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    id_membresia INT NOT NULL,
    fecha_pago DATE NOT NULL,
    monto_pagado DECIMAL(10, 2) NOT NULL,
    fecha_expiracion DATE NOT NULL,
    id_metodo_pago INT,
    
    -- CAMPOS AÑADIDOS PARA LA CONFIRMACIÓN
    estado_pago ENUM('Pendiente', 'Confirmado', 'Rechazado') NOT NULL DEFAULT 'Pendiente',
    id_usuario_confirmador INT, -- Se llena cuando se confirma o rechaza
    fecha_confirmacion DATETIME, -- Se llena cuando se confirma o rechaza

    -- Se establecen las relaciones con las tablas correspondientes
    FOREIGN KEY (id_cliente) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_membresia) REFERENCES Membresias(id_membresia),
    FOREIGN KEY (id_metodo_pago) REFERENCES Metodos_Pago(id_metodo_pago),
    FOREIGN KEY (id_usuario_confirmador) REFERENCES Usuarios(id_usuario) -- Enlaza con el admin/entrenador que confirmó
);

-- Con esta estructura, para saber si un cliente está activo, solo tienes que
-- buscar en `Historial_Pagos` su último pago y comprobar si la `fecha_expiracion`
-- es posterior a la fecha actual.


-- =================================================================
-- Script SQL para la Creación del Módulo de Gestión de Rutinas
-- Modelo: Flexible con Plantillas e Instancias Personales
-- =================================================================

-- 1. TABLAS DE CATÁLOGO (La Biblioteca de Ejercicios)
-- Estas tablas organizan y definen los componentes básicos.
-- -----------------------------------------------------------------

-- Tabla para definir los grandes grupos musculares.
CREATE TABLE Grupos_Musculares (
    id_grupo_muscular INT PRIMARY KEY AUTO_INCREMENT,
    nombre_grupo VARCHAR(50) NOT NULL UNIQUE
);

-- Tabla para definir los tipos de equipamiento necesarios.
CREATE TABLE Tipos_Equipamiento (
    id_equipamiento INT PRIMARY KEY AUTO_INCREMENT,
    nombre_equipamiento VARCHAR(50) NOT NULL UNIQUE
);

-- La tabla maestra de todos los ejercicios disponibles en el gimnasio.
CREATE TABLE Ejercicios (
    id_ejercicio INT PRIMARY KEY AUTO_INCREMENT,
    nombre_ejercicio VARCHAR(100) NOT NULL,
    id_grupo_principal INT NOT NULL,
    musculos_secundarios VARCHAR(255), -- CAMBIO: Campo añadido para músculos secundarios.
    id_equipamiento_requerido INT NOT NULL,
    descripcion TEXT,
    url_video VARCHAR(255),
    FOREIGN KEY (id_grupo_principal) REFERENCES Grupos_Musculares(id_grupo_muscular),
    FOREIGN KEY (id_equipamiento_requerido) REFERENCES Tipos_Equipamiento(id_equipamiento)
);


-- 2. TABLAS DE PLANTILLAS (El "Molde" del Entrenador)
-- Estas tablas permiten a los entrenadores crear rutinas estándar.
-- -----------------------------------------------------------------

-- Define la cabecera de una rutina plantilla.
CREATE TABLE Rutinas_Plantillas (
    id_plantilla INT PRIMARY KEY AUTO_INCREMENT,
    id_tipo_rutina INT, -- <-- CAMPO AÑADIDO
    nombre_plantilla VARCHAR(100) NOT NULL,
    descripcion TEXT,
    id_entrenador_creador INT NOT NULL,
    FOREIGN KEY (id_tipo_rutina) REFERENCES Tipos_Rutina(id_tipo_rutina), -- <-- RELACIÓN ESTABLECIDA
    FOREIGN KEY (id_entrenador_creador) REFERENCES Usuarios(id_usuario)
);

-- Tabla de unión que detalla qué ejercicios componen cada plantilla.
CREATE TABLE Plantilla_Ejercicios (
    id_plantilla_ejercicio INT PRIMARY KEY AUTO_INCREMENT,
    id_plantilla INT NOT NULL,
    id_ejercicio INT NOT NULL,
    dia VARCHAR(20) NOT NULL, -- Ej: 'Lunes', 'Martes'
    series VARCHAR(10), -- Ej: '4'
    repeticiones VARCHAR(20), -- Ej: '10-12' o 'Al fallo'
    tiempo_descanso_seg INT, -- Ej: 60
    orden INT, -- Para definir la secuencia de los ejercicios (1, 2, 3...)
    FOREIGN KEY (id_plantilla) REFERENCES Rutinas_Plantillas(id_plantilla) ON DELETE CASCADE,
    FOREIGN KEY (id_ejercicio) REFERENCES Ejercicios(id_ejercicio)
);


-- 3. TABLAS DE ASIGNACIÓN (La Rutina Personal del Cliente)
-- Estas tablas convierten una plantilla en una rutina personalizada para un cliente.
-- -----------------------------------------------------------------

-- Registra el acto de asignar una rutina a un cliente.
CREATE TABLE Rutinas_Asignadas (
    id_rutina_asignada INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    id_plantilla_origen INT, -- Puede ser NULL si la rutina es 100% personalizada desde cero
    id_entrenador_asignador INT NOT NULL,
    fecha_asignacion DATE NOT NULL,
    activa BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_cliente) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_plantilla_origen) REFERENCES Rutinas_Plantillas(id_plantilla),
    FOREIGN KEY (id_entrenador_asignador) REFERENCES Usuarios(id_usuario)
);

-- ¡La tabla clave! Es la copia personal de la rutina para el cliente,
-- donde se pueden hacer modificaciones sin alterar la plantilla original.
CREATE TABLE Asignacion_Ejercicios (
    id_asignacion_ejercicio INT PRIMARY KEY AUTO_INCREMENT,
    id_rutina_asignada INT NOT NULL,
    id_ejercicio INT NOT NULL,
    series VARCHAR(10),
    repeticiones VARCHAR(20),
    tiempo_descanso_seg INT,
    peso_recomendado_kg DECIMAL(6, 2), -- ¡Aquí se personaliza el peso!
    orden INT,
    notas_cliente TEXT, -- Ej: "Hacer con agarre cerrado", "Bajar lento"
    FOREIGN KEY (id_rutina_asignada) REFERENCES Rutinas_Asignadas(id_rutina_asignada) ON DELETE CASCADE,
    FOREIGN KEY (id_ejercicio) REFERENCES Ejercicios(id_ejercicio)
);

-- Script para la Creación y Población de Tablas de Catálogo
-- Tablas: Tipos_Rutina y Metodos_Pago
-- =================================================================

CREATE TABLE Entrenador_Clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_entrenador INT NOT NULL,
    id_cliente INT NOT NULL,
    fecha_asignacion DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (id_entrenador) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_cliente) REFERENCES Usuarios(id_usuario),
    UNIQUE (id_entrenador, id_cliente) -- Evita duplicados
);


