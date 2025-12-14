# Snowflake Database Connection

## Default Role: READONLY_PROD

When connecting to Snowflake, always use the `READONLY_PROD` role unless explicitly instructed otherwise. This prevents accidental data modifications.

## Connection: Key Pair Authentication

Use key pair authentication with credentials from the `.env` file in `ddx-data-pipeline`:

### Required Environment Variables
- `DB_ACCOUNT`: Snowflake account (e.g., `ka67899.us-east-1.privatelink`)
- `DB_USERNAME`: User account (e.g., `ecogsdill`)
- `DB_PRIVATE_KEY`: PEM-encoded private key with escaped newlines

### Connection Pattern

```python
import snowflake.connector
from cryptography.hazmat.primitives import serialization
import os

def load_private_key(pem_string):
    """Load private key from PEM string with escaped newlines."""
    pem_content = pem_string.replace('\\n', '\n')
    return serialization.load_pem_private_key(pem_content.encode('utf-8'), password=None)

# Load credentials
account = os.environ['DB_ACCOUNT']
username = os.environ['DB_USERNAME']
private_key = load_private_key(os.environ['DB_PRIVATE_KEY'])

# Connect - always use READONLY_PROD
conn = snowflake.connector.connect(
    user=username,
    account=account,
    host=f'{account}.snowflakecomputing.com',
    private_key=private_key,
    authenticator='SNOWFLAKE_JWT',
    warehouse='DBT_USER_PROD',
    database='EXCHANGE_PRODUCTION',
    role='READONLY_PROD',
)

# Verify connection
cur = conn.cursor()
cur.execute('SELECT CURRENT_USER(), CURRENT_ROLE(), CURRENT_DATABASE()')
print(cur.fetchone())
conn.close()
```

### Running with pipenv (ddx-data-pipeline)

```bash
cd /path/to/ddx-data-pipeline
source .env && pipenv run python3 -c "YOUR_CODE_HERE"

# Or with heredoc for longer scripts:
source .env && pipenv run python3 << 'PYEOF'
# Python code here
PYEOF
```

## Role Reference

| Role | Access | Use Case |
|------|--------|----------|
| `READONLY_PROD` | Read-only | Discovery, analysis, verification |
| `CORE_MIGRATOR_PROD` | Write | Approved production migrations only |

## Best Practices

- Verify connected role with `SELECT CURRENT_ROLE()` after connecting.
- Use `IF EXISTS` in DROP statements.
- Run discovery queries before production scripts.
- Get PR approval before running production write operations.
- Store SQL scripts in snowflake-queries repo, not ddx-data-pipeline.
