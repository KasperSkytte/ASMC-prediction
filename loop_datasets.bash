#!/usr/bin/env bash
set -u
datasets_folder=data/datasets
datasets=$(find $datasets_folder/* -maxdepth 0 -type d -exec echo -n '"{}" ' \;)

find ${datasets_folder}/* -maxdepth 0 -type d |\
  while read -r f;
  do
    cat << EOF > config.json
{
    "abund_file": "$f/ASVtable.csv",
    "taxonomy_file": "$f/taxonomy.csv",
    "metadata_file": "data/metadata.csv",
    "results_dir": "results",
    "metadata_date_col": "Date",
    "tax_level": "OTU",
    "tax_add": ["Species", "Genus"],
    "functions": [
        "AOB",
        "NOB",
        "PAO",
        "GAO",
        "Filamentous"
    ],
    "only_pos_func": false,
    "pseudo_zero": 0.01,
    "max_zeros_pct": 0.60,
    "top_n_taxa": 200,
    "num_features": 10,
    "iterations": 10,
    "max_epochs_lstm": 2000,
    "window_size": 10,
    "num_clusters_idec": 5,
    "tolerance_idec": 0.001,
    "smoothing_factor": 4,
    "splits": [
        0.85,
        0.0,
        0.15
    ]
}
EOF
    bash run.bash
  done
