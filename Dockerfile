FROM postgres:15
LABEL MAINTAINER Jojo1542 <admin@jojo1542.es>

# Prepare the build requirements for the rdkit compilation:
RUN apt-get update && apt-get install -y curl

# Install pg_cron:
RUN apt-get -y install postgresql-15-cron

# Configure pg_cron
RUN echo "shared_preload_libraries='pg_cron'" >> /usr/share/postgresql/postgresql.conf.sample
RUN echo "cron.database_name='your_db_name'" >> /usr/share/postgresql/postgresql.conf.sample

COPY ./docker-entrypoint.sh /usr/local/bin/

RUN chmod a+x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]