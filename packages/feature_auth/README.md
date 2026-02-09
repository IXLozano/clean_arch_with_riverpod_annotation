# feature_auth

Auth feature package with Clean Architecture layers.

**Layers**
1. `data` - datasources, models, repository implementation.
2. `domain` - entities, repositories, use cases.
3. `presentation` - Bloc and UI pages.

**Depends on**
1. `core`

**Notes**
1. Currently uses Bloc and GetIt (migration to Riverpod planned).
