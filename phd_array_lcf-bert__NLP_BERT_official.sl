#!/bin/bash 
#SBATCH --job-name=LCF_BERT_EXEC_10
#SBATCH --exclusive=user
#SBATCH --partition=public
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --array=0-3
#SBATCH --cpus-per-task=8
#SBATCH --mem=30G
#SBATCH --time=unlimited
#SBATCH --mail-user=dionis@uo.edu.cu
#SBATCH --mail-type=END
#SBATCH --output=array_lcf_%A_%a.out # STDOUT
#SBATCH --error=array_lcf_%A_%a.err  # STDERR



case $SLURM_ARRAY_TASK_ID in
0) ARGS="--model_name lcf_bert --approach ar1 --dataset all_multidomain --batch_size 64 --nepochs 10 --measure recall" ;;
1) ARGS="--model_name lcf_bert --approach ewc --dataset all_multidomain --batch_size 64 --nepochs 10 --measure recall" ;;
2) ARGS="--model_name lcf_bert --approach lwf --dataset all_multidomain --batch_size 64 --nepochs 10 --measure recall" ;;
3) ARGS="--model_name lcf_bert --approach si  --dataset all_multidomain --batch_size 64 --nepochs 10 --measure recall" ;;

esac

module load Python/3.7.0-foss-2018b

cd  $SLURM_SUBMIT_DIR

python3 -u train.py  $ARGS > lcf_output-$SLURM_ARRAY_TASK_ID.txt

