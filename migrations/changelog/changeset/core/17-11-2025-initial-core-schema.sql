-- changeset product-service:1
CREATE TABLE IF NOT EXISTS bank_products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    bank_id UUID NOT NULL REFERENCES banks(id),
    product_id VARCHAR(100) NOT NULL,  -- ID продукта от банка
    product_type VARCHAR(50) NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    description TEXT,
    interest_rate DECIMAL(8,2),
    min_amount DECIMAL(15,2),
    max_amount DECIMAL(15,2),
    term_months INTEGER,
    is_active BOOLEAN DEFAULT TRUE,
    last_synced_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- changeset product-service:2
CREATE TABLE IF NOT EXISTS product_applications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id),
    product_id VARCHAR(100) NOT NULL,
    bank_id UUID NOT NULL REFERENCES banks(id),
    payload JSONB,
    status VARCHAR(50) DEFAULT 'NEW',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP,
    delivered_at TIMESTAMP
);

-- changeset product-service:3
CREATE TABLE IF NOT EXISTS bank_webhooks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    bank_id UUID NOT NULL REFERENCES banks(id),
    webhook_url VARCHAR(500) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- changeset product-service:4
CREATE TABLE IF NOT EXISTS user_recommendations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id),
    recommendations JSONB NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE INDEX idx_bank_products_active ON bank_products(is_active);
CREATE INDEX idx_bank_products_bank_active ON bank_products(bank_id, is_active);
CREATE UNIQUE INDEX idx_bank_products_bank_id ON bank_products(bank_id, product_id);