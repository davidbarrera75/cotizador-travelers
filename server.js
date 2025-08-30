// -----------------------------------------------------------------
// --- SERVIDOR BACKEND PARA COTIZADOR TRAVELERS (CON LOGIN) ---
// -----------------------------------------------------------------

// --- 1. IMPORTACIONES DE LIBRERÍAS ---
const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');
const path = require('path');
const session = require('express-session');
const bcrypt = require('bcryptjs');

// --- 2. CONFIGURACIÓN INICIAL ---
const app = express();
const port = 3000;

// --- 3. CONFIGURACIÓN DE LA BASE DE DATOS ---
const pool = new Pool({
  user: 'cotizador_user',
  host: 'localhost',
  database: 'cotizador_db',
  password: '1234',
  port: 5432,
});

// --- 4. MIDDLEWARE ---
app.use(
  cors({
    origin: true,
    credentials: true,
  })
);
app.use(express.json());

// Configuración de sesiones
app.use(
  session({
    secret: 'cotizador-travelers-secret-2025-' + Math.random(),
    resave: false,
    saveUninitialized: false,
    cookie: {
      secure: false, // Cambiar a true cuando uses HTTPS
      httpOnly: true,
      maxAge: 1000 * 60 * 60 * 24, // 24 horas
    },
  })
);

// --- 5. INICIALIZACIÓN DE LA TABLA DE USUARIOS ---
async function initializeDatabase() {
  try {
    // Crear tabla de usuarios si no existe
    await pool.query(`
      CREATE TABLE IF NOT EXISTS users (
        id SERIAL PRIMARY KEY,
        username VARCHAR(50) UNIQUE NOT NULL,
        password VARCHAR(255) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );
    `);

    // Verificar si existe el usuario admin
    const result = await pool.query('SELECT * FROM users WHERE username = $1', [
      'admin',
    ]);

    if (result.rows.length === 0) {
      // Crear usuario admin por defecto
      const hashedPassword = await bcrypt.hash('admin123', 10);
      await pool.query(
        'INSERT INTO users (username, password) VALUES ($1, $2)',
        ['admin', hashedPassword]
      );
      console.log(
        '✅ Usuario admin creado (usuario: admin, contraseña: admin123)'
      );
    }
  } catch (err) {
    console.error('Error inicializando base de datos:', err);
  }
}

// Llamar a la inicialización
initializeDatabase();

// --- 6. MIDDLEWARE DE AUTENTICACIÓN ---
const requireAuth = (req, res, next) => {
  if (!req.session.userId) {
    return res
      .status(401)
      .json({ error: 'No autorizado. Por favor inicia sesión.' });
  }
  next();
};

// --- 7. RUTAS DE AUTENTICACIÓN ---

// Ruta de login
app.post('/api/login', async (req, res) => {
  try {
    const { username, password } = req.body;

    if (!username || !password) {
      return res
        .status(400)
        .json({ error: 'Usuario y contraseña son requeridos' });
    }

    const result = await pool.query('SELECT * FROM users WHERE username = $1', [
      username,
    ]);

    if (result.rows.length === 0) {
      return res
        .status(401)
        .json({ error: 'Usuario o contraseña incorrectos' });
    }

    const user = result.rows[0];
    const validPassword = await bcrypt.compare(password, user.password);

    if (!validPassword) {
      return res
        .status(401)
        .json({ error: 'Usuario o contraseña incorrectos' });
    }

    req.session.userId = user.id;
    req.session.username = user.username;
    res.json({ success: true, username: user.username });
  } catch (err) {
    console.error('Error en login:', err);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
});

// Ruta para verificar sesión
app.get('/api/check-auth', (req, res) => {
  if (req.session.userId) {
    res.json({ authenticated: true, username: req.session.username });
  } else {
    res.json({ authenticated: false });
  }
});

// Ruta de logout
app.post('/api/logout', (req, res) => {
  req.session.destroy((err) => {
    if (err) {
      return res.status(500).json({ error: 'Error al cerrar sesión' });
    }
    res.json({ success: true });
  });
});

// --- 8. RUTAS PÚBLICAS (Para el Cotizador) ---

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
      FROM edificios e
      JOIN tipos_apartamento ta ON e.id = ta.edificio_id
      JOIN tarifas t ON ta.id = t.tipo_apartamento_id
      ORDER BY e.nombre, ta.nombre, t.personas;
    `;
    const { rows } = await pool.query(query);

    const tarifario = {};
    rows.forEach((row) => {
      if (!tarifario[row.edificio]) {
        tarifario[row.edificio] = {
          ciudad: row.ciudad,
          tipos: {},
        };
      }
      if (!tarifario[row.edificio].tipos[row.tipo_apartamento]) {
        tarifario[row.edificio].tipos[row.tipo_apartamento] = {
          descripcion: row.descripcion,
          pax: {},
        };
      }
      tarifario[row.edificio].tipos[row.tipo_apartamento].pax[row.personas] =
        row.precio;
    });

    res.json(tarifario);
  } catch (err) {
    console.error('Error al obtener el tarifario:', err);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
});

app.post('/api/fichas', async (req, res) => {
  try {
    const { cliente, edificio, tipo, personas, dias, total, descripcionApto } =
      req.body;
    const query = `
      INSERT INTO fichas (cliente, edificio, tipo_apartamento, personas, dias, total, descripcion)
      VALUES ($1, $2, $3, $4, $5, $6, $7)
      RETURNING id;
    `;
    const values = [
      cliente,
      edificio,
      tipo,
      personas,
      dias,
      total,
      descripcionApto,
    ];
    const result = await pool.query(query, values);
    res.status(201).json({ id: result.rows[0].id });
  } catch (err) {
    console.error('Error al guardar la ficha:', err);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
});

app.get('/api/fichas/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const query = 'SELECT * FROM fichas WHERE id = $1';
    const { rows } = await pool.query(query, [id]);

    if (rows.length === 0) {
      return res.status(404).json({ error: 'Ficha no encontrada' });
    }
    res.json(rows[0]);
  } catch (err) {
    console.error('Error al obtener la ficha:', err);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
});

// --- 9. RUTAS DE ADMINISTRACIÓN PROTEGIDAS ---

// Obtener todas las tarifas (PROTEGIDA)
app.get('/api/admin/tarifas', requireAuth, async (req, res) => {
  try {
    const query = `
      SELECT 
        t.id,
        e.nombre AS edificio,
        ta.nombre AS tipo_apartamento,
        t.personas,
        t.precio
      FROM tarifas t
      JOIN tipos_apartamento ta ON t.tipo_apartamento_id = ta.id
      JOIN edificios e ON ta.edificio_id = e.id
      ORDER BY e.nombre, ta.nombre, t.personas;
    `;
    const { rows } = await pool.query(query);
    res.json(rows);
  } catch (err) {
    console.error('Error al obtener tarifas para admin:', err);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
});

// Actualizar una tarifa (PROTEGIDA)
app.put('/api/admin/tarifas/:id', requireAuth, async (req, res) => {
  try {
    const { id } = req.params;
    const { precio } = req.body;

    if (!precio || isNaN(precio)) {
      return res
        .status(400)
        .json({ error: 'El precio proporcionado no es válido.' });
    }

    const query = `
      UPDATE tarifas
      SET precio = $1
      WHERE id = $2
      RETURNING *;
    `;
    const { rows } = await pool.query(query, [precio, id]);

    if (rows.length === 0) {
      return res.status(404).json({ error: 'Tarifa no encontrada.' });
    }

    res.json({ message: 'Tarifa actualizada con éxito', tarifa: rows[0] });
  } catch (err) {
    console.error('Error al actualizar la tarifa:', err);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
});

// --- 10. CAMBIAR CONTRASEÑA (RUTA PROTEGIDA) ---
app.post('/api/change-password', requireAuth, async (req, res) => {
  try {
    const { currentPassword, newPassword } = req.body;
    const userId = req.session.userId;

    // Verificar contraseña actual
    const result = await pool.query('SELECT * FROM users WHERE id = $1', [
      userId,
    ]);
    const user = result.rows[0];

    const validPassword = await bcrypt.compare(currentPassword, user.password);
    if (!validPassword) {
      return res.status(401).json({ error: 'Contraseña actual incorrecta' });
    }

    // Actualizar contraseña
    const hashedPassword = await bcrypt.hash(newPassword, 10);
    await pool.query('UPDATE users SET password = $1 WHERE id = $2', [
      hashedPassword,
      userId,
    ]);

    res.json({ success: true, message: 'Contraseña actualizada exitosamente' });
  } catch (err) {
    console.error('Error al cambiar contraseña:', err);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
});

// --- 11. INICIO DEL SERVIDOR ---
app.listen(port, () => {
  console.log(
    `🚀 Servidor backend iniciado y escuchando en http://localhost:${port}`
  );
  console.log('📝 Usuario por defecto: admin / admin123');
});
