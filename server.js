// -----------------------------------------------------------------------------
// --- SERVIDOR BACKEND PARA COTIZADOR TRAVELERS (CONECTADO A POSTGRESQL) ---
// -----------------------------------------------------------------------------

// --- 1. IMPORTACIONES ---
const express = require('express');
const cors = require('cors');
const { Pool } = require('pg'); // Importamos el cliente de PostgreSQL

// --- 2. INICIALIZACIÓN ---
const app = express();
const PORT = 3000;

// --- 3. CONFIGURACIÓN DE LA BASE DE DATOS ---
const pool = new Pool({
    user: 'cotizador_user',
    host: 'localhost',
    database: 'cotizador_db',
    // IMPORTANTE: Reemplaza 'una_contraseña_segura' con la contraseña que creaste.
    password: 'una_contraseña_segura',
    port: 5432,
});

// --- 4. MIDDLEWARE ---
app.use(cors());
app.use(express.json());
app.use(express.static(__dirname)); // Sirve los archivos HTML (cotizador.html, etc.)

// --- 5. RUTAS DE LA API (AHORA CONECTADAS A LA DB) ---

/**
 * @route   GET /api/tarifario
 * @desc    Obtiene las tarifas desde la base de datos PostgreSQL.
 */
app.get('/api/tarifario', async (req, res) => {
    try {
        const query = `
            SELECT
                e.nombre AS edificio,
                e.ciudad,
                ta.nombre AS tipo_apartamento,
                ta.descripcion,
                t.personas,
                t.precio
            FROM tarifas t
            JOIN tipos_apartamento ta ON t.tipo_apartamento_id = ta.id
            JOIN edificios e ON ta.edificio_id = e.id;
        `;
        const { rows } = await pool.query(query);

        const tarifarioJSON = {};
        rows.forEach(row => {
            if (!tarifarioJSON[row.edificio]) {
                tarifarioJSON[row.edificio] = {
                    ciudad: row.ciudad,
                    tipos: {}
                };
            }
            if (!tarifarioJSON[row.edificio].tipos[row.tipo_apartamento]) {
                tarifarioJSON[row.edificio].tipos[row.tipo_apartamento] = {
                    descripcion: row.descripcion,
                    pax: {}
                };
            }
            tarifarioJSON[row.edificio].tipos[row.tipo_apartamento].pax[row.personas] = parseInt(row.precio);
        });
        
        // Mensaje de depuración para ver qué se está enviando
        console.log(`Se han cargado ${rows.length} tarifas desde la base de datos.`);

        res.json(tarifarioJSON);
    } catch (error) {
        console.error('Error al obtener el tarifario:', error);
        res.status(500).json({ message: 'Error interno del servidor.' });
    }
});

/**
 * @route   POST /api/fichas
 * @desc    Guarda una nueva ficha en la base de datos.
 */
app.post('/api/fichas', async (req, res) => {
    try {
        const { cliente, edificio, tipo, personas, dias, total, descripcionApto } = req.body;
        
        const query = `
            INSERT INTO fichas (cliente, edificio, tipo_apartamento, personas, dias, total, descripcion)
            VALUES ($1, $2, $3, $4, $5, $6, $7)
            RETURNING id;
        `;
        const values = [cliente, edificio, tipo, personas, dias, total, descripcionApto];
        
        const result = await pool.query(query, values);
        const nuevaFichaId = result.rows[0].id;

        res.status(201).json({ id: nuevaFichaId, ...req.body });

    } catch (error) {
        console.error('Error al guardar la ficha:', error);
        res.status(500).json({ message: 'Error interno del servidor.' });
    }
});

/**
 * @route   GET /api/fichas/:id
 * @desc    Obtiene una ficha específica desde la base de datos.
 */
app.get('/api/fichas/:id', async (req, res) => {
    try {
        // --- CORRECCIÓN DEL BUG ---
        // Convertimos el ID de la URL (que es un texto) a un número entero.
        const fichaId = parseInt(req.params.id, 10);
        if (isNaN(fichaId)) {
            return res.status(400).json({ message: 'ID de ficha inválido.' });
        }

        const query = 'SELECT * FROM fichas WHERE id = $1;';
        const { rows } = await pool.query(query, [fichaId]); // Usamos el ID numérico

        if (rows.length > 0) {
            const ficha = rows[0];
            const fichaFormateada = {
                cliente: ficha.cliente,
                edificio: ficha.edificio,
                tipo: ficha.tipo_apartamento,
                personas: ficha.personas,
                dias: ficha.dias,
                total: parseFloat(ficha.total),
                descripcionApto: ficha.descripcion
            };
            res.json(fichaFormateada);
        } else {
            res.status(404).json({ message: 'Ficha no encontrada.' });
        }
    } catch (error) {
        console.error('Error al obtener la ficha:', error);
        res.status(500).json({ message: 'Error interno del servidor.' });
    }
});


// --- 6. ARRANQUE DEL SERVIDOR ---
app.listen(PORT, () => {
    console.log(`🚀 Servidor backend iniciado y escuchando en http://localhost:${PORT}`);
});
