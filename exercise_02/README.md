# ETHZ DMDB2021: SQL I Environment Setup

If you prefer to run queries on your local machine, you can instead refer to the steps and scripts in this repository for the katacoda scenario which will help you set up a Postgres server Docker container.

1. Install Docker on your local machine.
2. Run `foreground.sh` to create a Docker container.
3. Follow the instructions given in `step1.md`: `pgcli.sh` and `psql.sh` refer to the scripts with the same name in the `assets` directory.
4. Download `assets/datasets.zip`.
5. Run `populate.sh`, replacing the path `/tmp/datasets.zip` on line 3 with the path to `datasets.zip` on your local machine.
6. Follow the rest of the instructions in `step2.md` and `step3.md`.


If you have already installed Postgres on your local machine, simply download `assets/datasets.zip` and for each directory:
1. Create a Postgres database with the same name as the directory.
2. Open a Postgres client and run the commands in `schema.sql`.
3. Import the table data for each `.tbl` file in the `data` subdirectory using the SQL statement `COPY {table_name} FROM '{PATH_TO_TBL_FILE}' WITH delimiter AS '|';`.