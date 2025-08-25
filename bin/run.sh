#!/usr/bin/env sh 

# Synopsis:
# Run the analyzer on a solution.

# Arguments:
# $1: exercise slug
# $2: path to solution folder
# $3: path to output directory

# Output:
# Writes the analysis results to an analysis.json file in the passed-in output directory.
# The analysis results are formatted according to the specifications at https://github.com/exercism/docs/blob/main/building/tooling/analyzers/interface.md

# Example:
# ./bin/run.sh two-fer path/to/solution/folder/ path/to/output/directory/

# If any required arguments is missing, print the usage and exit
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    echo "usage: ./bin/run.sh exercise-slug path/to/solution/folder/ path/to/output/directory/"
    exit 1
fi

analyze_files() {
    TEMP1=$(mktemp)
    for file in "$1"/*.ua; do
        # Only process files that exist (avoid globbing issues)
        [ -e "$file" ] || continue
        uiua run "$file" >> "$TEMP1"
    done

    RESULT=$(cat "$TEMP1")

    jq -n --arg in "$RESULT" '
      {
        comments: (
          $in
          | split("─")
          | map(gsub("^\\s+|\\s+$"; ""))
          | debug
          | map(gsub("(?s)\\n\\s+at.+?\\|"; "\n"))
          | map(select(test("^(Warning|Advice|Style):")))
          | map({
              comment: "uiua.general.generic_message",
              params: { comment: . }
            })
        )
      }
    '
}

slug="$1"
solution_dir=$(realpath "${2%/}")
output_dir=$(realpath "${3%/}")
analysis_file="${output_dir}/analysis.json"
tags_file="${output_dir}/tags.json"

# Create the output directory if it doesn't exist
mkdir -p "${output_dir}"

echo "${slug}: analyzing..."

# Analyze the solution
# TODO: replace the below command with your own command(s)
# to analyze the solution and output the analysis.json and
# tags.json files
analyze_files $2 > "${analysis_file}"
echo '{"tags": []}' > "${tags_file}"

echo "${slug}: done"
