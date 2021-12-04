#!/bin/bash

SBATCH -N 4                        # number of compute nodes
SBATCH -n 1                        # number of tasks your job will spawn
SBATCH --mem=64G                    # amount of RAM requested in GiB (2^40)
SBATCH -p publicgpu                      # Use gpu partition
SBATCH -q publicgpu                 # Run job under wildfire QOS queue
SBATCH --gres=gpu:1                # Request two GPUs
SBATCH -t 0-100:00                  # wall time (D-HH:MM)
SBATCH -o slurm.%j.out             # STDOUT (%j = JobId)
SBATCH -e slurm.%j.err             # STDERR (%j = JobId)
SBATCH --mail-type=ALL             # Send a notification when a job starts, stops, or fails
SBATCH --mail-user=slakhanp@asu.edu # send-to address

module purge
module load anaconda/py3
source activate tf1.12  # tf2.4.1-gpu, tf2.4.0-gpu
python3 run_summarization.py --mode=decode --data_path=/home/slakhanp/main_data/Datasets/finished_files/chunked/test_* --vocab_path=/home/slakhanp/main_data/Datasets/finished_files/vocab --log_root=/home/slakhanp/main_data/Datasets/  --exp_name=pretrained_model --max_enc_steps=400 --max_dec_steps=120 --coverage=1 --single_pass=1

