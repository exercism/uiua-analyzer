# Exercism Uiua analyzer

The Docker image to automatically run tests on Uiua solutions submitted to [Exercism].

## Getting started

Build the analyzer, conforming to the [analyzer interface specification](https://github.com/exercism/docs/blob/main/building/tooling/analyzers/interface.md).
Update the files to match your track's needs.
At the very least, you'll need to update `bin/run.sh`, `Dockerfile` and the test solutions in the `tests` directory

- Tip: look for `TODO:` comments to point you towards code that need updating
- Tip: look for `OPTIONAL:` comments to point you towards code that _could_ be useful

## Run the analyzer

To analyze an arbitrary exercise, do the following:

1. Open a terminal in the project's root
2. Run `./bin/run.sh <exercise-slug> <solution-dir> <output-dir>`

Once the analyzer has finished, its results will be written to `<output-dir>/analysis.json`.

## Run the analyzer on an exercise using Docker

_This script is provided for testing purposes, as it mimics how analyzers run in Exercism's production environment._

To analyze an arbitrary exercise using the Docker image, do the following:

1. Open a terminal in the project's root
2. Run `./bin/run-in-docker.sh <exercise-slug> <solution-dir> <output-dir>`

Once the analyzer has finished, its results will be written to `<output-dir>/analysis.json`.

## Run the tests

To run the tests to verify the behavior of the analyzer, do the following:

1. Open a terminal in the project's root
2. Run `./bin/run-tests.sh`

These are [golden tests][golden] that compare the `analysis.json` generated by running the current state of the code against the "known good" `tests/<test-name>/expected_analysis.json`. All files created during the test run itself are discarded.

When you've made modifications to the code that will result in a new "golden" state, you'll need to generate and commit a new `tests/<test-name>/expected_analysis.json` file.

## Run the tests using Docker

_This script is provided for testing purposes, as it mimics how analyzers run in Exercism's production environment._

To run the tests to verify the behavior of the analyzer using the Docker image, do the following:

1. Open a terminal in the project's root
2. Run `./bin/run-tests-in-docker.sh`

These are [golden tests][golden] that compare the `analysis.json` generated by running the current state of the code against the "known good" `tests/<test-name>/expected_analysis.json`. All files created during the test run itself are discarded.

When you've made modifications to the code that will result in a new "golden" state, you'll need to generate and commit a new `tests/<test-name>/expected_analysis.json` file.

## Benchmarking

There are two scripts you can use to benchmark the analyzer:

1. `./bin/benchmark.sh`: benchmark the analyzer code
2. `./bin/benchmark-in-docker.sh`: benchmark the Docker image

These scripts can give a rough estimation of the analyzer's performance.
Bear in mind though that the performance on Exercism's production servers is often lower.

[analyzers]: https://github.com/exercism/docs/tree/main/building/tooling/analyzers
[golden]: https://ro-che.info/articles/2017-12-04-golden-tests
[exercism]: https://exercism.io
