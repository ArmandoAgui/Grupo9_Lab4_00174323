
INSERT INTO roles (name) VALUES
('ADMIN'),
('USER')
ON CONFLICT (name) DO NOTHING;

INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM roles r
CROSS JOIN permissions p
WHERE r.name = 'ADMIN'
ON CONFLICT DO NOTHING;

INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM roles r
CROSS JOIN permissions p
WHERE r.name = 'USER'
  AND (
    p.method = 'GET'
    OR (p.method = 'PUT' AND p.path IN ('/api/auth/update/profile', '/api/auth/update/password'))
    OR (p.method = 'POST' AND p.path LIKE '/api/finanzas/%')
  )
ON CONFLICT DO NOTHING;

INSERT INTO categorias (nombre, tipo)
SELECT 'TRANSFERENCIA', 'INGRESO'
WHERE NOT EXISTS (
    SELECT 1 FROM categorias WHERE nombre = 'TRANSFERENCIA' AND tipo = 'INGRESO'
);

INSERT INTO categorias (nombre, tipo)
SELECT 'TRANSFERENCIA', 'EGRESO'
WHERE NOT EXISTS (
    SELECT 1 FROM categorias WHERE nombre = 'TRANSFERENCIA' AND tipo = 'EGRESO'
);

INSERT INTO categorias (nombre, tipo)
SELECT 'GENERAL', 'INGRESO'
WHERE NOT EXISTS (
    SELECT 1 FROM categorias WHERE nombre = 'GENERAL' AND tipo = 'INGRESO'
);

INSERT INTO categorias (nombre, tipo)
SELECT 'GENERAL', 'EGRESO'
WHERE NOT EXISTS (
    SELECT 1 FROM categorias WHERE nombre = 'GENERAL' AND tipo = 'EGRESO'
);
