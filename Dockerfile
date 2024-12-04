FROM python:3.11-slim 
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    g++ \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy the requirements file first for caching
COPY pyproject.toml poetry.lock ./

# Install Poetry
RUN pip install --no-cache-dir poetry

# Install project dependencies with Poetry
RUN poetry config virtualenvs.create false && poetry install --no-dev --no-root

# Copy the rest of the application code
COPY . .

# Command to run your application (replace 'app.py' with your entry point script)
CMD ["python", "app.py"]
