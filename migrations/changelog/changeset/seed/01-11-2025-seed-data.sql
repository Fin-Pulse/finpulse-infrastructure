-- Начальные данные
INSERT INTO banks (id, name, code, base_url) VALUES
(gen_random_uuid(), 'Virtual Bank', 'VBANK', 'https://vbank.open.bankingapi.ru'),
(gen_random_uuid(), 'Awesome Bank', 'ABANK', 'https://abank.open.bankingapi.ru/docs'),
(gen_random_uuid(), 'Smart Bank', 'SBANK', 'https://sbank.open.bankingapi.ru/docs');

-- Системные категории
INSERT INTO categories (id, name, color, icon, is_system, created_at) VALUES
(gen_random_uuid(), 'Возврат', '#F08C67', 'refund', true, NOW()),
(gen_random_uuid(), 'Перевод', '#8067F0', 'transfer', true, NOW()),
(gen_random_uuid(), 'ЖКХ/Аренда', '#A9F067', 'utilities', true, NOW()),
(gen_random_uuid(), 'Подработка/Бонус', '#DFED32', 'bonus', true, NOW()),
(gen_random_uuid(), 'Продукты', '#4CAF50', 'shopping_cart', true, NOW()),
(gen_random_uuid(), 'Транспорт', '#2196F3', 'directions_car', true, NOW()),
(gen_random_uuid(), 'Развлечения/Покупки', '#9C27B0', 'movie', true, NOW()),
(gen_random_uuid(), 'Зарплата', '#4CAF50', 'work', true, NOW());
