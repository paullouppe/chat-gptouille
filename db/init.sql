-- init.sql

-- 1. Create a temporary staging table to load the CSV data.
--    (The staging table has all columns as text so we can transform them as needed.)
CREATE TEMP TABLE staging_recipes (
    dummy text,
    name text,
    csv_id text,
    minutes text,
    contributor_id text,
    submitted text,
    tags text,
    nutrition text,
    n_steps text,
    steps text,
    description text,
    ingredients text,
    n_ingredients text
);

-- 2. Load the CSV file into the staging table.
--    Adjust the file path below to the location of your CSV file.
--    If running from psql locally, you might use \copy instead.
COPY staging_recipes
FROM './db/recipes.csv'
CSV HEADER;

-- 3. Insert data into the recipes table with necessary transformations.
--    We convert the steps and ingredients strings into PostgreSQL array literals.
INSERT INTO recipes (name, minutes, steps, description, ingredients)
SELECT
    name,
    CAST(minutes AS integer),
    REPLACE(
      REPLACE(
        REPLACE(steps, '[', '{'),
      ']', '}'),
    '''', '"'
    )::text[],
    description,
    REPLACE(
      REPLACE(
        REPLACE(ingredients, '[', '{'),
      ']', '}'),
    '''', '"'
    )::text[]
FROM staging_recipes;
