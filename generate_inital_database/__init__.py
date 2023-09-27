import os
import logging
import sqlparse
import azure.functions as func

from pathlib import Path
from sqlalchemy import create_engine, text


SQL_SCRIPT_FILENAME = 'generate_db.sql'


def main(req: func.HttpRequest) -> func.HttpResponse:
    # Check existence of all environment variables
    if any([x not in os.environ for x in ['DB_HOST', 'DB_DATABASE', 'DB_USERNAME', 'DB_PASSWORD']]):
        message = f"At least one of the mandatory environment variables ('DB_HOST', 'DB_DATABASE', 'DB_USERNAME', " \
                  f"'DB_PASSWORD') is not set. Please set them and try again."
        logging.error(message)

        return func.HttpResponse(
            message,
            status_code=400
        )
    else:
        db_host = os.environ.get('DB_HOST')
        db_database = os.environ.get('DB_DATABASE')
        db_username = os.environ.get('DB_USERNAME')         # create table permission only
        db_password = os.environ.get('DB_PASSWORD')

    path_to_sql = Path(__file__).parent.resolve() / SQL_SCRIPT_FILENAME

    # Check if file with SQL script exists
    if path_to_sql.exists():
        with path_to_sql.open(mode='r') as f:
            query = f.read()
    else:
        message = f'Could not find file with SQL script ({SQL_SCRIPT_FILENAME}). ' \
                  f'Please add it to the folder with current function'
        logging.error(message)

        return func.HttpResponse(
            message,
            status_code=400
        )

    # Verify DB connection
    try:
        engine = create_engine(f'mysql+pymysql://{db_username}:{db_password}@{db_host}/{db_database}')

        with engine.connect() as _:
            logging.info('Successfully connected to the DB')
    except Exception as e:
        logging.error(f'Error while connecting to the DB: {e}')

        return func.HttpResponse(
            'Error while connecting to the DB. Please check provided credentials.',
            status_code=400
        )

    # Parse SQL script file to commands
    parsed_commands = [sqlparse.format(x, strip_comments=True).strip() for x in sqlparse.split(query)]
    parsed_commands = [x for x in parsed_commands if x.split()[0].upper() in ['USE', 'DROP', 'CREATE', 'INSERT']]
    num_of_commands = len(parsed_commands)

    # Execute commands one by one
    with engine.connect() as conn:
        try:
            for i, command in enumerate(parsed_commands, start=1):
                conn.execute(text(command))
                logging.info(f'Statement {i}/{num_of_commands} executed')
            conn.commit()

            return func.HttpResponse(
                'Database successfully created',
                status_code=200
            )
        except Exception as e:
            logging.error(f'Error while executing query: {e}')

            conn.rollback()

            return func.HttpResponse(
                'Error while executing query',
                status_code=500
            )
