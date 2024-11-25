# Terraforms

This repository is a collection of Terraform modules and actual configuration values used by the Planetarium organization. 

## Structure

- **`modules/`**: Contains reusable Terraform modules. These modules are open for anyone to use. However, they are not published as standalone packages, so it is recommended to include them as Git submodules in your projects.

- **Other folders**: Represent actual Terraform configurations used by specific teams. These are provided for reference purposes. Please review them as needed, but note that they are tailored to specific use cases.

## Development

### Setup Git hooks

```
git config core.hooksPath hooks
```

Since the `pre-commit` hook validates Terraform styles, syntax at all, you may want to bypass it sometimes.

```sh
git --no-verify commit
```
