FROM node:23-alpine AS build

RUN corepack enable pnpm

COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

COPY . .
RUN pnpm build

FROM rtsp/lighttpd AS prod

COPY --from=build ./dist /var/www/html