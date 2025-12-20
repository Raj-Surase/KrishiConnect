# Farmer Platform Database Schema and Project Structure

## 1. Database Schema (MySQL)

The application requires six main tables to manage users, content, and utilities.

### 1.1. `users`
| Column Name | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `id` | INT | PRIMARY KEY, AUTO_INCREMENT | Unique user identifier. |
| `username` | VARCHAR(255) | UNIQUE, NOT NULL | User login name (e.g., email or phone number). |
| `hashed_password` | VARCHAR(255) | NOT NULL | Hashed password for security. |
| `role` | ENUM('farmer', 'admin') | NOT NULL | User role for authorization. |
| `is_active` | BOOLEAN | DEFAULT TRUE | Account status. |
| `created_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Record creation timestamp. |

### 1.2. `crops`
| Column Name | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `id` | INT | PRIMARY KEY, AUTO_INCREMENT | Unique crop identifier. |
| `name` | VARCHAR(255) | UNIQUE, NOT NULL | Common name of the crop (e.g., "Wheat", "Jowar"). |
| `image_url` | VARCHAR(512) | NULLABLE | URL to an image of the crop. |
| `details` | TEXT | NULLABLE | General details about the crop. |
| `context` | TEXT | NULLABLE | Specific context/prompting information for the AI advisory. |

### 1.3. `government_schemes`
| Column Name | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `id` | INT | PRIMARY KEY, AUTO_INCREMENT | Unique scheme identifier. |
| `title` | VARCHAR(512) | NOT NULL | Title of the government scheme. |
| `link` | VARCHAR(512) | NOT NULL | Official link to the scheme details. |
| `image_url` | VARCHAR(512) | NULLABLE | Thumbnail or promotional image URL. |
| `description` | TEXT | NULLABLE | Detailed description of the scheme. |
| `region` | VARCHAR(255) | DEFAULT 'Maharashtra' | Specific region/district applicability. |
| `created_by_id` | INT | FOREIGN KEY (`users.id`) | Admin who created the record. |
| `created_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Record creation timestamp. |

### 1.4. `market_rates`
| Column Name | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `id` | INT | PRIMARY KEY, AUTO_INCREMENT | Unique rate identifier. |
| `crop_id` | INT | FOREIGN KEY (`crops.id`), NOT NULL | The crop the rate is for. |
| `location` | VARCHAR(255) | NOT NULL | Local market unit (APMC). |
| `date` | DATE | NOT NULL | Date of the market rate. |
| `min_price` | DECIMAL(10, 2) | NOT NULL | Minimum price (per unit). |
| `max_price` | DECIMAL(10, 2) | NOT NULL | Maximum price (per unit). |
| `expected_price` | DECIMAL(10, 2) | NULLABLE | Expected future price. |
| `unit` | VARCHAR(50) | DEFAULT 'Quintal' | Unit of measurement (e.g., Quintal, Kg). |
| `created_by_id` | INT | FOREIGN KEY (`users.id`) | Admin who created the record. |
| `created_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Record creation timestamp. |

### 1.5. `chatbot_history`
| Column Name | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `id` | INT | PRIMARY KEY, AUTO_INCREMENT | Unique message identifier. |
| `user_id` | INT | FOREIGN KEY (`users.id`), NOT NULL | The farmer user involved in the conversation. |
| `session_id` | VARCHAR(255) | NOT NULL | Identifier to group messages into a single conversation session. |
| `message_type` | ENUM('user', 'ai') | NOT NULL | Indicates who sent the message. |
| `message_content` | TEXT | NOT NULL | The content of the message. |
| `timestamp` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Time the message was recorded. |

### 1.6. `api_keys`
| Column Name | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `id` | INT | PRIMARY KEY, AUTO_INCREMENT | Unique key identifier. |
| `service_name` | VARCHAR(255) | UNIQUE, NOT NULL | Name of the external service (e.g., 'GEMINI_API_KEY', 'WEATHER_API_KEY'). |
| `api_key_value` | TEXT | NOT NULL | The actual API key value. |
| `is_active` | BOOLEAN | DEFAULT TRUE | Status of the key. |
| `updated_by_id` | INT | FOREIGN KEY (`users.id`) | Admin who last updated the key. |
| `updated_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Last update timestamp. |

## 2. Project Structure

```
/farmer_platform
├── Dockerfile
├── docker-compose.yml
├── requirements.txt
├── README.md
├── app/
│   ├── __init__.py
│   ├── main.py             # FastAPI application entry point
│   ├── core/
│   │   ├── config.py       # Settings and environment variables
│   │   ├── security.py     # JWT functions and password hashing
│   │   └── database.py     # DB session and engine setup
│   ├── db/
│   │   ├── base.py         # Base for all models
│   │   ├── models.py       # SQLAlchemy models (ORM)
│   │   └── migrations/     # Alembic migration scripts
│   ├── api/
│   │   ├── __init__.py
│   │   ├── v1/
│   │   │   ├── endpoints/
│   │   │   │   ├── auth.py
│   │   │   │   ├── admin.py
│   │   │   │   ├── farmer.py
│   │   │   │   └── utils.py # For API key management
│   │   │   └── schemas/    # Pydantic schemas
│   │   └── routers.py      # API router inclusion
│   ├── services/
│   │   ├── auth_service.py
│   │   ├── content_service.py # CRUD for schemes, rates, crops
│   │   └── ai_service.py      # Gemini integration
│   └── utils/
│       └── dependencies.py # Dependency injection for DB, roles, etc.
└── alembic.ini             # Alembic configuration
```
