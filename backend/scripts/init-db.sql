-- Initialize PostgreSQL database with pgvector extension
-- This script is run when the PostgreSQL container starts

-- Create the pgvector extension
CREATE EXTENSION IF NOT EXISTS vector;

-- Create a test table to verify the extension works
CREATE TABLE IF NOT EXISTS test_vectors (
    id SERIAL PRIMARY KEY,
    embedding vector(1536)
);

-- Insert a test vector
INSERT INTO test_vectors (embedding) VALUES ('[0.1, 0.2, 0.3]'::vector);

-- Clean up test data
DELETE FROM test_vectors;

-- Log successful initialization
DO $$
BEGIN
    RAISE NOTICE 'Database initialized successfully with pgvector extension';
END $$;
