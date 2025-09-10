FastAPI with Nginx Proxy and Let's Encrypt (Docker Compose Setup)

This repository provides a ready-to-use Docker Compose setup for deploying a FastAPI application with:

Nginx Proxy – Automatically routes requests based on domain names.

Let's Encrypt Companion – Provides free SSL certificates.

FastAPI Application – Your backend service exposed securely over HTTPS.

📌 Services Overview
1. nginx-proxy

Acts as a reverse proxy.

Automatically detects containers with VIRTUAL_HOST and routes traffic.

Listens on ports 80 and 443.

Works together with the Let's Encrypt companion to serve SSL certificates.

2. letsencrypt (acme-companion)

Issues and renews SSL/TLS certificates automatically from Let's Encrypt.

Requires an email address for certificate registration.

Communicates with nginx-proxy to handle HTTPS traffic securely.

3. fastapi-app

Your main FastAPI application running inside a container.

Exposed internally on port 8000.

Accessible via the domain name you configure (VIRTUAL_HOST).

Securely served via HTTPS thanks to nginx-proxy and letsencrypt.

📂 File Structure

```
.
├── Dockerfile # Defines how the FastAPI app is built
├── docker-compose.yml # Main Docker Compose configuration
└── app/ # Your FastAPI application code
```

🚀 Usage
1. Clone the repository

```
git clone https://github.com/rz-k/nginx-service

cd your-repo
```

2. Configure your domain

Update the environment variables in docker-compose.yml under the fastapi-app service:

```
environment:

VIRTUAL_HOST=your-domain.com

LETSENCRYPT_HOST=your-domain.com

LETSENCRYPT_EMAIL=your-email@example.com

VIRTUAL_PORT=8000
```

3. Build and run the containers

```
docker-compose up -d --build
```

4. Access your application

HTTP: http://your-domain.com

HTTPS: https://your-domain.com (auto-configured by Let's Encrypt)

⚙️ Environment Variables Explained
🔹 For fastapi-app

VIRTUAL_HOST
The domain name that routes to this service (e.g., api.example.com).

LETSENCRYPT_HOST
The domain name for which an SSL certificate will be issued. Usually the same as VIRTUAL_HOST.

LETSENCRYPT_EMAIL
Email address used for Let's Encrypt registration and notifications.

VIRTUAL_PORT
The port where your app runs inside the container (default: 8000 for FastAPI).

🔹 For letsencrypt

DEFAULT_EMAIL
Default email address used when no LETSENCRYPT_EMAIL is provided by a service.

ACME_CA_URI (optional)
Used for testing with Let's Encrypt staging environment to avoid rate limits. Uncomment in docker-compose.yml if needed.

🔐 SSL Certificates

Certificates are stored inside the certs Docker volume.

Renewal is automatic and handled by the Let's Encrypt companion.

🛠️ Troubleshooting

If certificates fail, check logs with:
```
docker logs nginx-proxy-letsencrypt
```

Ensure your domain DNS records point to your server's IP.

For debugging, you can use Let's Encrypt staging server by uncommenting:
```

ACME_CA_URI=https://acme-staging-v02.api.letsencrypt.org/directory

```

📜 License

This project is licensed under the MIT License.