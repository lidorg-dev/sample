FROM 127.0.0.1:8082/node
WORKDIR /src/app


COPY sample-app/ .
RUN npm install
EXPOSE 3000

CMD ["node","index.js"]
