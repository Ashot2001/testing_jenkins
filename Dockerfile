# Первый этап: сборка и тестирование
FROM node:alpine AS build

WORKDIR /app

COPY package.json package-lock.json /app/

# Установка всех зависимостей (включая devDependencies)
RUN npm install

# Копируем остальной код
COPY . .

# Запуск тестов
RUN npm test

# Второй этап: создание продакшн-образа
FROM node:alpine AS prod

WORKDIR /app

# Копируем только необходимые файлы и prod-зависимости
COPY package.json package-lock.json /app/
RUN npm install --only=production

# Копируем остальные файлы из первого этапа
COPY --from=build /app /app

EXPOSE 3000

CMD ["node", "server.js"]
