-- init.sql

-- First, connect to the correct database
\c recipe;

-- Create the recipes table first
CREATE TABLE IF NOT EXISTS recipes (
    id SERIAL PRIMARY KEY,
    name VARCHAR,
    minutes INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    steps TEXT[],
    description TEXT,
    ingredients TEXT[]
);

-- Create the staging table
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

-- Load the CSV data
COPY staging_recipes
FROM '/db/recipes.csv'
CSV HEADER;

-- Insert the data with better array handling
INSERT INTO recipes (name, minutes, steps, description, ingredients)
SELECT
    name,
    CAST(minutes AS integer),
    string_to_array(
        trim(both '[]' from replace(replace(steps, '"', ''''), '''', '"')),
        '", "'
    ),
    description,
    string_to_array(
        trim(both '[]' from replace(replace(ingredients, '"', ''''), '''', '"')),
        '", "'
    )
FROM staging_recipes;
