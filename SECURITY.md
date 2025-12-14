# Security Rules

## Secrets Management

- Use environment variables for all sensitive configuration.
- Never hardcode API keys, tokens, passwords, or credentials in any file.
- Check files for accidental secret inclusion before commits.
- Verify .gitignore includes: .env*, *.pem, *.key, credentials.json, secrets.*.

## Input Handling

- Validate all user inputs at system boundaries.
- Sanitize data before rendering to prevent XSS.
- Use parameterized queries for all database operations.
- Implement proper authentication and authorization checks.

## Dependencies

- Prefer standard library solutions over external dependencies.
- Justify and document dependency additions.
- Be aware of supply chain risks with new packages.

## Code Patterns

- Use absolute paths to prevent path traversal.
- Implement defense in depth for critical operations.
- Log errors with context but never log sensitive data.
- Follow OWASP guidelines for web applications.
