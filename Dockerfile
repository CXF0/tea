FROM node:24-bookworm-slim AS build
WORKDIR /app
COPY package.json package-lock.json ./
COPY frontend/package.json frontend/package.json
COPY backend/package.json backend/package.json
RUN npm ci --no-audit --no-fund --registry=https://registry.npmjs.org
COPY . .
RUN npm run typecheck && npm run build

FROM node:24-bookworm-slim
ENV NODE_ENV=production HOST=0.0.0.0 PORT=3101 SQLITE_PATH=/app/backend/data/menghua.sqlite
WORKDIR /app
COPY --from=build --chown=node:node /app /app
USER node
EXPOSE 3101
CMD ["npm", "run", "demo"]
