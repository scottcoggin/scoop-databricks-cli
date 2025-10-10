## Scoop bucket for Databricks CLI

This repository contains the Scoop bucket for the Databricks CLI.

## Installation

To install the Databricks CLI using Scoop, first ensure you have Scoop installed. Then, create the Databricks config file, add this bucket to your Scoop configuration, and install the Databricks CLI:

```sh
touch .databrickscfg
scoop bucket add databricks-cli https://github.com/scottcoggin/databricks-cli.git
scoop install databricks
```

## Usage

After installation, you can use the Databricks CLI by running:

```sh
databricks
```

For more information on how to use the Databricks CLI, refer to the [official documentation](https://github.com/databricks/cli).

## Updating

To update the Databricks CLI to the latest version, run:

```sh
scoop update databricks-cli
```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request with your changes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
