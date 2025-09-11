FastAPI with nginx-proxy & Let's Encrypt

This project uses nginx-proxy and acme-companion to manage domain routing and automatic SSL certificates.
The FastAPI service runs directly on the host machine, while nginx-proxy handles reverse proxying and SSL termination.

Steps to Run
1. Run FastAPI on the Host

Make sure your FastAPI app (main.py) is ready.
Start it with:

```
uvicorn main:app --host 0.0.0.0 --port 8000
```

2. Start Docker Compose

Run the following command to bring up nginx-proxy and acme-companion:

```
docker compose up -d
```

3. Make the Fix Script Executable

There is a helper script fixupstream.sh that ensures nginx-proxy uses the correct host IP instead of the dummy container IP.

Give it execution permission:

```
chmod +x fixupstream.sh
```

4. Run the Fix Script

Execute the script to patch nginx-proxy’s upstream config and reload nginx:

```
./fixupstream.sh
```

Notes

The script automatically finds the host gateway IP from inside the nginx-proxy container.

It updates /etc/nginx/conf.d/default.conf inside the container.

After applying the fix, nginx is reloaded without restarting the container.