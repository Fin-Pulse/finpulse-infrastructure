-- Начальные данные
INSERT INTO banks (id, name, code, base_url) VALUES
(gen_random_uuid(), 'Virtual Bank', 'VBANK', 'https://vbank.open.bankingapi.ru'),
(gen_random_uuid(), 'Awesome Bank', 'ABANK', 'https://abank.open.bankingapi.ru'),
(gen_random_uuid(), 'Smart Bank', 'SBANK', 'https://sbank.open.bankingapi.ru');