-- Enable pgvector extension for vector operations
CREATE EXTENSION IF NOT EXISTS vector;

-- Create table for n8n pgvector store
CREATE TABLE IF NOT EXISTS documents_pg (
    id SERIAL PRIMARY KEY,
    content TEXT NOT NULL,
    metadata JSONB,
    embedding vector(1536),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create index for vector similarity search
CREATE INDEX IF NOT EXISTS documents_pg_embedding_idx ON documents_pg 
USING ivfflat (embedding vector_cosine_ops) WITH (lists = 100);