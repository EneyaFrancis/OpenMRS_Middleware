# 🧑‍💻 Developer Onboarding – OpenMRS Middleware (Ruby on Rails)

Welcome! This repository hosts a Ruby on Rails middleware that acts as a gateway between frontend clients and the OpenMRS EMR system. This onboarding guide will help you set up the project locally, understand the architecture, and contribute effectively.

---

## 📦 Project Overview

This middleware:
- Refines and secures access to OpenMRS APIs.
- Supports plugin-based health program logic (e.g. Eye Care).
- Enables rule-based diagnosis using YAML.
- Integrates JWT authentication via Keycloak.
- Uses Redis and PostgreSQL with replication.

---

## 🖥️ 1. Prerequisites

Make sure the following are installed:

- [Ruby (>= 3.1)](https://www.ruby-lang.org)
- [Rails (>= 7)](https://rubyonrails.org/)
- [PostgreSQL](https://www.postgresql.org/)
- [Redis](https://redis.io/)
- [Docker](https://www.docker.com/)
- [Keycloak (via Docker)](https://www.keycloak.org/)
- [Node.js & Yarn](https://classic.yarnpkg.com)

---

## ⚙️ 2. Local Setup

### 🔄 Clone the Repo

```bash
git clone https://github.com/your-org/openmrs-middleware.git
cd openmrs-middleware
```

### 🛠 Install Dependencies

```bash
bundle install
yarn install
```

### 🧱 Setup the Database

```bash
rails db:create
rails db:migrate
rails db:seed
```

### 🚀 Start Development Server

```bash
rails server
```

Visit `http://localhost:3000`.

---

## 🧪 3. Running Tests

```bash
bundle exec rspec
```

---

## 🔐 4. Authentication (Keycloak)

The app uses JWTs issued by Keycloak.

1. Start Keycloak using Docker Compose:
   ```bash
   docker-compose up keycloak
   ```
2. Access Keycloak admin panel at `http://localhost:8080`.
3. Import provided realm configuration from `docs/keycloak-realm.json`.

---

## 🧠 5. Code Structure

| Folder             | Purpose                                  |
|--------------------|-------------------------------------------|
| `app/controllers`  | API endpoints                             |
| `app/models`       | Domain models (Patient, Diagnosis, etc.)  |
| `app/jobs`         | Background jobs (e.g., data syncs)        |
| `engines/`         | Health program plugins (e.g., EyeCare)    |
| `lib/rules`        | YAML-based diagnosis rules                |
| `config/initializers` | Custom middleware & API wrappers      |

---

## 🔌 6. Plugin Development

You can add health programs as Rails engines:

```bash
rails plugin new engines/eye_care --mountable
```

Register plugins in `config/plugins.yml`:

```yaml
plugins:
  - name: eye_care
    depends_on: [concept_mapper]
```

---

## 📤 7. API Examples

### Get Patients

```bash
curl -H "Authorization: Bearer <token>" http://localhost:3000/api/patients
```

### Submit Diagnosis

```bash
POST /api/diagnoses
Content-Type: application/json
Authorization: Bearer <token>

{
  "patient_id": "abc123",
  "symptoms": ["fever", "headache"]
}
```

---

## 📋 8. Contribution Workflow

1. **Create a new branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make changes, commit, and push**
   ```bash
   git add .
   git commit -m "Add: New feature"
   git push origin feature/your-feature-name
   ```

3. **Open a Pull Request**

---

## 🛡 9. Security Checklist

- Use `jwt` gem for decoding JWTs from Keycloak.
- Validate requests using middleware in `app/middleware`.
- Store secrets using Rails credentials.

---

## 🧰 10. Developer Tools

| Tool      | Use                           |
|-----------|-------------------------------|
| Lograge   | Structured API logging        |
| Faraday   | HTTP client with retry logic  |
| Sidekiq   | Background job processing     |
| RuboCop   | Code linting                  |

---

## 🧯 11. Troubleshooting

- PG errors? Ensure PostgreSQL is running: `sudo service postgresql start`
- Redis connection failed? Run `redis-server`
- JWT auth failing? Check Keycloak token config and client secret.

---

## 📘 Resources

- [OpenMRS FHIR](https://wiki.openmrs.org/display/projects/FHIR+Module)
- [Rails Engines Guide](https://guides.rubyonrails.org/engines.html)
- [Sidekiq Docs](https://sidekiq.org/)
- [Keycloak Admin Console](http://localhost:8080)

---


