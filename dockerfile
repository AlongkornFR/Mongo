FROM mongo:8.2.7

COPY Nosqlfile.js /docker-entrypoint-initdb.d/

USER mongodb

EXPOSE 27017