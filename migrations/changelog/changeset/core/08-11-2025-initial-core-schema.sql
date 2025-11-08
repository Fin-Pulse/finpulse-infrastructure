-- changeset finpulse:18
CREATE TABLE IF NOT EXISTS user_forecasts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,

    -- Основные метрики прогноза
    forecast_amount DECIMAL(15,2) NOT NULL,
    confidence_min DECIMAL(15,2),
    confidence_max DECIMAL(15,2),
    change_percentage DECIMAL(5,2),
    last_week_amount DECIMAL(15,2),
    forecast_method VARCHAR(50),

    -- Временные метки
    forecast_week_start DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Полные данные ML модели
    full_forecast_data JSONB NOT NULL
);

-- changeset finpulse:19
CREATE INDEX IF NOT EXISTS idx_user_forecasts_user_id ON user_forecasts(user_id);
CREATE INDEX IF NOT EXISTS idx_user_forecasts_week_start ON user_forecasts(forecast_week_start);
CREATE INDEX IF NOT EXISTS idx_user_forecasts_created_at ON user_forecasts(created_at);
CREATE UNIQUE INDEX IF NOT EXISTS idx_user_forecasts_user_week_unique ON user_forecasts(user_id, forecast_week_start);

-- changeset finpulse:20
ALTER TABLE user_forecasts ADD FOREIGN KEY (user_id) REFERENCES users(id);

-- changeset finpulse:21
COMMENT ON TABLE user_forecasts IS 'Таблица для хранения недельных финансовых прогнозов пользователей';
COMMENT ON COLUMN user_forecasts.forecast_amount IS 'Прогнозируемая сумма расходов на следующую неделю';
COMMENT ON COLUMN user_forecasts.confidence_min IS 'Нижняя граница доверительного интервала';
COMMENT ON COLUMN user_forecasts.confidence_max IS 'Верхняя граница доверительного интервала';
COMMENT ON COLUMN user_forecasts.change_percentage IS 'Изменение в процентах относительно прошлой недели';
COMMENT ON COLUMN user_forecasts.last_week_amount IS 'Фактические расходы прошлой недели';
COMMENT ON COLUMN user_forecasts.forecast_method IS 'Метод прогнозирования (prophet/moving_average)';
COMMENT ON COLUMN user_forecasts.forecast_week_start IS 'Дата начала недели, для которой сделан прогноз (понедельник)';
COMMENT ON COLUMN user_forecasts.full_forecast_data IS 'Полный JSON ответ от ML модели со всей аналитикой';