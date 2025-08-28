-- -----------------------------------------------------------------
-- --- SCRIPT DE INICIALIZACIÓN PARA LA BASE DE DATOS cotizador_db ---
-- -----------------------------------------------------------------

-- Borramos las tablas si ya existen para empezar desde cero.
DROP TABLE IF EXISTS tarifas;
DROP TABLE IF EXISTS tipos_apartamento;
DROP TABLE IF EXISTS edificios;
DROP TABLE IF EXISTS fichas;

-- --- ESTRUCTURA DE TABLAS ---

-- Tabla para los edificios
CREATE TABLE edificios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) UNIQUE NOT NULL,
    ciudad VARCHAR(100) NOT NULL
);

-- Tabla para los tipos de apartamento, vinculada a un edificio
CREATE TABLE tipos_apartamento (
    id SERIAL PRIMARY KEY,
    edificio_id INTEGER NOT NULL REFERENCES edificios(id),
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT
);

-- Tabla para las tarifas, vinculada a un tipo de apartamento
CREATE TABLE tarifas (
    id SERIAL PRIMARY KEY,
    tipo_apartamento_id INTEGER NOT NULL REFERENCES tipos_apartamento(id),
    personas INTEGER NOT NULL,
    precio INTEGER NOT NULL
);

-- Tabla para guardar las fichas de cotización generadas
CREATE TABLE fichas (
    id SERIAL PRIMARY KEY,
    cliente VARCHAR(255),
    edificio VARCHAR(255),
    tipo_apartamento VARCHAR(255),
    personas INTEGER,
    dias INTEGER,
    total NUMERIC,
    descripcion TEXT,
    fecha_creacion TIMESTAMPTZ DEFAULT NOW()
);

-- --- INSERCIÓN DE DATOS INICIALES ---

-- Insertar Edificios
INSERT INTO edificios (nombre, ciudad) VALUES
('Obelisco Apartamentos', 'Bogotá'),
('Fontana Plaza', 'Bogotá'),
('Condominio Plenitud', 'Bogotá'),
('Castellón de Juanambú', 'Cali'),
('Orange Suites Medellín', 'Medellín'),
('Rioverde Living Suites', 'Rionegro'),
('Orange Cartagena', 'Cartagena'),
('Terrazas Tayrona', 'Santa Marta');

-- Insertar Tipos de Apartamento (COMPLETO)
INSERT INTO tipos_apartamento (edificio_id, nombre, descripcion) VALUES
((SELECT id FROM edificios WHERE nombre = 'Obelisco Apartamentos'), '1 Habitación', 'Habitación con cama king o 2 camas sencillas, closet y baño con tina, Sala, Cocina equipada.'),
((SELECT id FROM edificios WHERE nombre = 'Obelisco Apartamentos'), '2 Habitaciones', 'Habitación con cama king o dos camas sencillas, closet y baño con tina. Segunda habitación con cama king o dos camas sencillas y baño, Sala – Comedor, Cocina equipada.'),
((SELECT id FROM edificios WHERE nombre = 'Fontana Plaza'), '1 Habitación', 'Habitación con cama king o dos camas sencillas, vestier y baño, Sala y cocina americana equipada.'),
((SELECT id FROM edificios WHERE nombre = 'Fontana Plaza'), '2 Habitaciones', 'Habitación con cama king o dos camas sencillas, vestier y baño. Habitación auxiliar con cama king o 2 camas sencillas, Baño auxiliar completo, Sala- comedor y Cocina americana equipada.'),
((SELECT id FROM edificios WHERE nombre = 'Condominio Plenitud'), '1 Habitación', 'Habitación con cama king o dos camas sencillas, walking closet y baño, Sala – comedor y Cocina equipada.'),
((SELECT id FROM edificios WHERE nombre = 'Condominio Plenitud'), '2 Habitaciones', 'Habitación con cama king o dos camas sencillas, walking closet y baño. Segunda habitación con 1 o 2 camas sencillas y baño, Sala – comedor y Cocina equipada.'),
((SELECT id FROM edificios WHERE nombre = 'Castellón de Juanambú'), 'Junior', 'Suite un solo ambiente. Cama Doble, Baño con tina, Sala – comedor y Cocina equipada.'),
((SELECT id FROM edificios WHERE nombre = 'Castellón de Juanambú'), 'Junior Suite', 'Suite de dos ambientes. Habitación con 2 camas dobles y baño con tina, Sala con sofá cama, Comedor, Cocina equipada y Baño auxiliar completo.'),
((SELECT id FROM edificios WHERE nombre = 'Orange Suites Medellín'), 'Orange', 'Habitación principal con cama king o dos camas sencillas y baño interno, cocina abierta con barra y balcón.'),
((SELECT id FROM edificios WHERE nombre = 'Orange Suites Medellín'), 'Orange Suites', 'Apartamento de dos ambientes. Habitación con cama king o dos camas sencillas, baño - vestier, sala con sofá cama sencillo, cocina abierta con barra, baño exterior y balcón.'),
((SELECT id FROM edificios WHERE nombre = 'Orange Suites Medellín'), 'Duplex Pequeño', 'Apartamento de dos pisos. 1° piso sala con sofá cama sencillo, cocina abierta con barra, baño exterior y balcón. 2° piso habitación con cama king o dos camas sencillas, baño - vestier y balcón.'),
((SELECT id FROM edificios WHERE nombre = 'Orange Suites Medellín'), 'Duplex Grande', 'Apartamento de dos pisos. 1° piso sala con sofá cama extradoble, comedor, cocina americana, baño exterior y balcón. 2° piso habitación con dos camas sencillas o cama King, baño - vestier y balcón.'),
((SELECT id FROM edificios WHERE nombre = 'Rioverde Living Suites'), 'Junior', 'Aparta Suite de un solo ambiente con cama king o 2 camas sencillas, baño, closet con cajilla de seguridad, sala (sofá cama sencillo), cocina abierta equipada y balcón.'),
((SELECT id FROM edificios WHERE nombre = 'Rioverde Living Suites'), 'Junior Suite', 'Apartamento de una habitación con cama king o dos camas sencillas, baño - vestier con cajilla de seguridad, sala (sofá cama doble), comedor, cocina abierta equipada y balcón.'),
((SELECT id FROM edificios WHERE nombre = 'Rioverde Living Suites'), 'Suite', 'Apartamento de dos habitaciones: Habitación Principal con cama king o dos camas sencillas y baño - vestier con cajilla de seguridad. Habitación Auxiliar con cama king o dos camas sencillas, baño auxiliar completo, sala (sofa cama doble), comedor, cocina abierta equipada y balcón.'),
((SELECT id FROM edificios WHERE nombre = 'Orange Cartagena'), 'Orange', 'Habitación principal con cama doble y baño interno. Segunda habitación con dos camas sencillas, Cocina equipada, Sala – comedor con balcón y segundo baño en el corredor.'),
((SELECT id FROM edificios WHERE nombre = 'Orange Cartagena'), 'Orange Suite', 'Habitación principal con cama king y baño interno con vestier. Segunda habitación con cama doble. Cocina equipada. Sala – comedor con balcón. Segundo baño en el corredor.'),
((SELECT id FROM edificios WHERE nombre = 'Orange Cartagena'), 'Orange Suite Superior', 'Habitación principal con cama king y baño interno con vestier. Segunda habitación con dos camas sencillas. Tercera habitación con un camarote y baño interno. Cocina equipada. Sala – comedor con balcón. Tercer baño en el corredor.'),
((SELECT id FROM edificios WHERE nombre = 'Orange Cartagena'), 'Deluxe', 'Habitación principal con cama king y baño interno con vestier. Segunda habitación con dos camas sencillas. Tercera habitación con un camarote y baño interno. Cocina equipada. Sala con sofá cama y comedor con balcón. Tercer baño en el corredor.'),
((SELECT id FROM edificios WHERE nombre = 'Terrazas Tayrona'), 'Suite', 'Habitación con cama doble y balcón.Sala con sofá cama doble y balcón.Cocina abierta equipada y barra tipo americana.Baño en el área social.'),
((SELECT id FROM edificios WHERE nombre = 'Terrazas Tayrona'), 'Estándar', 'Habitación con cama doble, baño y balcón.Sala con sofá cama doble y balcón.Cocina abierta equipada y barra tipo americano.Un baño en el área social.'),
((SELECT id FROM edificios WHERE nombre = 'Terrazas Tayrona'), 'Apartasuite', 'Habitación principal con cama doble, baño y balcón.Habitación auxiliar con dos camas sencillas o cama King y balcón.  Sala  - comedor con sofá cama doble y balcón.Cocina abierta equipada y barra tipo americano. Segundo baño en el área social.'),
((SELECT id FROM edificios WHERE nombre = 'Terrazas Tayrona'), 'Family', 'Habitación principal con cama doble, baño y balcón.Habitación auxiliar con dos camas sencillas o una cama king, baño y balcón.Sala-comedor con sofá cama doble y balcón.  Cocina abierta equipada y barra tipo americano.Segundo baño en el área social.');

-- Insertar Tarifas (COMPLETO)
INSERT INTO tarifas (tipo_apartamento_id, personas, precio) VALUES
-- Obelisco
((SELECT id FROM tipos_apartamento WHERE nombre = '1 Habitación' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Obelisco Apartamentos')), 1, 266000),
((SELECT id FROM tipos_apartamento WHERE nombre = '1 Habitación' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Obelisco Apartamentos')), 2, 277000),
((SELECT id FROM tipos_apartamento WHERE nombre = '2 Habitaciones' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Obelisco Apartamentos')), 2, 367000),
((SELECT id FROM tipos_apartamento WHERE nombre = '2 Habitaciones' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Obelisco Apartamentos')), 3, 377000),
((SELECT id FROM tipos_apartamento WHERE nombre = '2 Habitaciones' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Obelisco Apartamentos')), 4, 387000),
-- Fontana
((SELECT id FROM tipos_apartamento WHERE nombre = '1 Habitación' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Fontana Plaza')), 1, 285000),
((SELECT id FROM tipos_apartamento WHERE nombre = '1 Habitación' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Fontana Plaza')), 2, 297000),
((SELECT id FROM tipos_apartamento WHERE nombre = '2 Habitaciones' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Fontana Plaza')), 2, 385000),
((SELECT id FROM tipos_apartamento WHERE nombre = '2 Habitaciones' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Fontana Plaza')), 3, 396000),
((SELECT id FROM tipos_apartamento WHERE nombre = '2 Habitaciones' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Fontana Plaza')), 4, 407000),
-- Plenitud
((SELECT id FROM tipos_apartamento WHERE nombre = '1 Habitación' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Condominio Plenitud')), 1, 310000),
((SELECT id FROM tipos_apartamento WHERE nombre = '1 Habitación' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Condominio Plenitud')), 2, 321000),
((SELECT id FROM tipos_apartamento WHERE nombre = '2 Habitaciones' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Condominio Plenitud')), 2, 409000),
((SELECT id FROM tipos_apartamento WHERE nombre = '2 Habitaciones' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Condominio Plenitud')), 3, 420000),
((SELECT id FROM tipos_apartamento WHERE nombre = '2 Habitaciones' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Condominio Plenitud')), 4, 431000),
-- Juanambú
((SELECT id FROM tipos_apartamento WHERE nombre = 'Junior' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Castellón de Juanambú')), 1, 170000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Junior' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Castellón de Juanambú')), 2, 170000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Junior Suite' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Castellón de Juanambú')), 2, 210000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Junior Suite' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Castellón de Juanambú')), 3, 210000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Junior Suite' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Castellón de Juanambú')), 4, 210000),
-- Orange Medellín
((SELECT id FROM tipos_apartamento WHERE nombre = 'Orange' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Suites Medellín')), 1, 270000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Orange' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Suites Medellín')), 2, 310000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Orange Suites' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Suites Medellín')), 1, 300000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Orange Suites' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Suites Medellín')), 2, 340000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Duplex Pequeño' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Suites Medellín')), 1, 350000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Duplex Pequeño' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Suites Medellín')), 2, 390000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Duplex Pequeño' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Suites Medellín')), 3, 430000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Duplex Grande' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Suites Medellín')), 1, 400000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Duplex Grande' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Suites Medellín')), 2, 440000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Duplex Grande' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Suites Medellín')), 3, 480000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Duplex Grande' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Suites Medellín')), 4, 520000),
-- Rioverde
((SELECT id FROM tipos_apartamento WHERE nombre = 'Junior' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Rioverde Living Suites')), 1, 298000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Junior' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Rioverde Living Suites')), 2, 346000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Junior Suite' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Rioverde Living Suites')), 1, 338000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Junior Suite' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Rioverde Living Suites')), 2, 386000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Junior Suite' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Rioverde Living Suites')), 3, 434000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Suite' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Rioverde Living Suites')), 1, 388000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Suite' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Rioverde Living Suites')), 2, 436000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Suite' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Rioverde Living Suites')), 3, 484000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Suite' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Rioverde Living Suites')), 4, 532000),
-- Orange Cartagena
((SELECT id FROM tipos_apartamento WHERE nombre = 'Orange' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Cartagena')), 1, 340000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Orange' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Cartagena')), 2, 390000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Orange' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Cartagena')), 3, 440000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Orange' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Cartagena')), 4, 490000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Orange Suite' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Cartagena')), 1, 360000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Orange Suite' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Cartagena')), 2, 410000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Orange Suite' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Cartagena')), 3, 460000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Orange Suite' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Cartagena')), 4, 510000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Orange Suite Superior' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Cartagena')), 1, 380000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Orange Suite Superior' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Cartagena')), 2, 430000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Orange Suite Superior' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Cartagena')), 3, 480000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Orange Suite Superior' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Cartagena')), 4, 530000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Orange Suite Superior' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Cartagena')), 5, 580000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Orange Suite Superior' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Cartagena')), 6, 630000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Deluxe' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Cartagena')), 1, 400000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Deluxe' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Cartagena')), 2, 450000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Deluxe' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Cartagena')), 3, 500000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Deluxe' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Cartagena')), 4, 550000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Deluxe' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Cartagena')), 5, 600000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Deluxe' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Orange Cartagena')), 6, 650000),
-- Terrazas Tayrona
((SELECT id FROM tipos_apartamento WHERE nombre = 'Suite' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Terrazas Tayrona')), 1, 220000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Suite' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Terrazas Tayrona')), 2, 270000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Estándar' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Terrazas Tayrona')), 1, 240000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Estándar' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Terrazas Tayrona')), 2, 290000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Apartasuite' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Terrazas Tayrona')), 2, 310000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Apartasuite' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Terrazas Tayrona')), 3, 360000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Apartasuite' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Terrazas Tayrona')), 4, 410000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Family' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Terrazas Tayrona')), 2, 330000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Family' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Terrazas Tayrona')), 3, 380000),
((SELECT id FROM tipos_apartamento WHERE nombre = 'Family' AND edificio_id = (SELECT id FROM edificios WHERE nombre = 'Terrazas Tayrona')), 4, 430000);

-- Mensaje de finalización
\echo '>>> Base de datos inicializada con éxito! <<<'
