# Assignment

## Installation

Install [Docker Desktop 18+](https://www.docker.com/products/docker-desktop)

Install [Hasura CLI](https://hasura.io/docs/latest/hasura-cli/install-hasura-cli/)

Clone this repository.

Build the local Docker images for this repo:

```bash
docker-compose up -d
```

Add/Deploy Hasura migrations and run the Hasura console:

```bash
hasura deploy --endpoint http://localhost:8080
```

```bash
hasura console
```

Run the svelte app(frontend) :

```bash
npm run dev
```
