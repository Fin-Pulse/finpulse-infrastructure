-- Начальные данные
INSERT INTO banks (id, name, code, base_url) VALUES
(gen_random_uuid(), 'Virtual Bank', 'VBANK', 'https://vbank.open.bankingapi.ru'),
(gen_random_uuid(), 'Awesome Bank', 'ABANK', 'https://abank.open.bankingapi.ru'),
(gen_random_uuid(), 'Smart Bank', 'SBANK', 'https://sbank.open.bankingapi.ru');

-- Системные категории
INSERT INTO categories (id, name, color, icon, is_system) VALUES
(gen_random_uuid(), 'Income', '#4CAF50', '💰', true),
(gen_random_uuid(), 'Transport', '#2196F3', '🚗', true),
(gen_random_uuid(), 'Groceries', '#8BC34A', '🛒', true),
(gen_random_uuid(), 'Dining', '#FF9800', '🍽️', true),
(gen_random_uuid(), 'Coffee', '#795548', '☕', true),
(gen_random_uuid(), 'Shopping', '#FFC107', '🛍️', true),
(gen_random_uuid(), 'Entertainment', '#9C27B0', '🎬', true),
(gen_random_uuid(), 'Other', '#757575', '❓', true)
ON CONFLICT (name) DO NOTHING;
